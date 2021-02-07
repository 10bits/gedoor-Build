package io.legado.app.help

import android.net.Uri
import android.util.Base64
import androidx.annotation.Keep
import io.legado.app.App
import io.legado.app.constant.AppConst.dateFormat
import io.legado.app.help.http.CookieStore
import io.legado.app.help.http.SSLHelper
import io.legado.app.model.Debug
import io.legado.app.model.analyzeRule.AnalyzeUrl
import io.legado.app.model.analyzeRule.QueryTTF
import io.legado.app.utils.*
import kotlinx.coroutines.runBlocking
import org.jsoup.Connection
import org.jsoup.Jsoup
import rxhttp.wrapper.param.RxHttp
import rxhttp.wrapper.param.toByteArray
import java.io.*
import java.net.URL
import java.net.URLEncoder
import java.util.*

@Keep
@Suppress("unused")
interface JsExtensions {

    /**
     * 访问网络,返回String
     */
    fun ajax(urlStr: String): String? {
        return runBlocking {
            kotlin.runCatching {
                val analyzeUrl = AnalyzeUrl(urlStr)
                analyzeUrl.getStrResponse(urlStr).body
            }.onFailure {
                it.printStackTrace()
            }.getOrElse {
                it.msg
            }
        }
    }

    fun ajaxCacheGet(url: String, saveTime: Int = 0): String {
        return runBlocking {
            var x = CacheManager.get(url)
            if (x == null) {
                x = RxHttp.get(url).toString()
                x.let {
                    CacheManager.put(url, saveTime)
                }
            }
            return@runBlocking x
        }
    }
    
    /**
     * 访问网络,返回Response<String>
     */
    fun connect(urlStr: String): Any {
        return runBlocking {
            kotlin.runCatching {
                val analyzeUrl = AnalyzeUrl(urlStr)
                analyzeUrl.getStrResponse(urlStr)
            }.onFailure {
                it.printStackTrace()
            }.getOrElse {
                it.msg
            }
        }
    }


    /**
     * js实现重定向拦截,网络访问get
     */
    fun get(urlStr: String, headers: Map<String, String>): Connection.Response {
        return Jsoup.connect(urlStr)
            .sslSocketFactory(SSLHelper.unsafeSSLSocketFactory)
            .ignoreContentType(true)
            .followRedirects(false)
            .headers(headers)
            .method(Connection.Method.GET)
            .execute()
    }

    /**
     * 网络访问post
     */
    fun post(urlStr: String, body: String, headers: Map<String, String>): Connection.Response {
        return Jsoup.connect(urlStr)
            .sslSocketFactory(SSLHelper.unsafeSSLSocketFactory)
            .ignoreContentType(true)
            .followRedirects(false)
            .requestBody(body)
            .headers(headers)
            .method(Connection.Method.POST)
            .execute()
    }

    /**
     *js实现读取cookie
     */
    fun getCookie(tag: String, key: String? = null): String {
        val cookie = CookieStore.getCookie(tag)
        val cookieMap = CookieStore.cookieToMap(cookie)
        return if (key != null) {
            cookieMap[key] ?: ""
        } else {
            cookie
        }
    }

    /**
     * js实现解码,不能删
     */
    fun base64Decode(str: String): String {
        return EncoderUtils.base64Decode(str, Base64.NO_WRAP)
    }

    fun base64Decode(str: String, flags: Int): String {
        return EncoderUtils.base64Decode(str, flags)
    }

    fun base64DecodeToByteArray(str: String?): ByteArray? {
        if (str.isNullOrBlank()) {
            return null
        }
        return Base64.decode(str, Base64.DEFAULT)
    }

    fun base64DecodeToByteArray(str: String?, flags: Int): ByteArray? {
        if (str.isNullOrBlank()) {
            return null
        }
        return Base64.decode(str, flags)
    }

    fun base64Encode(str: String): String? {
        return EncoderUtils.base64Encode(str, Base64.NO_WRAP)
    }

    fun base64Encode(str: String, flags: Int): String? {
        return EncoderUtils.base64Encode(str, flags)
    }

    fun md5Encode(str: String): String {
        return MD5Utils.md5Encode(str)
    }

    fun md5Encode16(str: String): String {
        return MD5Utils.md5Encode16(str)
    }

    /**
     * 时间格式化
     */
    fun timeFormat(time: Long): String {
        return dateFormat.format(Date(time))
    }

    /**
     * utf8编码转gbk编码
     */
    fun utf8ToGbk(str: String): String {
        val utf8 = String(str.toByteArray(charset("UTF-8")))
        val unicode = String(utf8.toByteArray(), charset("UTF-8"))
        return String(unicode.toByteArray(charset("GBK")))
    }

    fun getAbsUrl(baseUrl: String, src: String): String {
        return if (src.startsWith("http://") || src.startsWith("https://")) {
            src
        } else {
            val aURL = URL(baseUrl)
            val url = when (aURL.port) {
                -1, 80 -> aURL.protocol + "://" + aURL.host
                else -> aURL.protocol + "://" + aURL.host + ":" + aURL.port
            }
            url + src
        }
    }

    fun getUniqList(list: List<String>): List<String> {
        return list.distinct()
    }
    
    fun compress(primStr: String?): String? {
        if (primStr == null || primStr.isEmpty()) {
            return primStr
        }
        val out = ByteArrayOutputStream()
        var gzip: GZIPOutputStream? = null
        try {
            gzip = GZIPOutputStream(out)
            gzip.write(primStr.toByteArray())
        } catch (e: IOException) {
            e.printStackTrace()
        } finally {
            if (gzip != null) {
                try {
                    gzip.close()
                } catch (e: IOException) {
                    e.printStackTrace()
                }
            }
        }
        return Base64.encodeToString(out.toByteArray(), Base64.NO_WRAP)
    }

    fun uncompress(compressedStr: String?): String? {
        if (compressedStr == null) {
            return null
        }
        val out = ByteArrayOutputStream()
        var input: ByteArrayInputStream? = null
        var ginzip: GZIPInputStream? = null
        var compressed: ByteArray? = null
        var decompressed: String? = null
        try {
            compressed = Base64.decode(compressedStr, Base64.NO_WRAP)
            input = ByteArrayInputStream(compressed)
            ginzip = GZIPInputStream(input)
            val buffer = ByteArray(1024)
            var offset = -1
            while (ginzip.read(buffer).also { offset = it } != -1) {
                out.write(buffer, 0, offset)
            }
            decompressed = out.toString()
        } catch (e: IOException) {
            e.printStackTrace()
        } finally {
            if (ginzip != null) {
                try {
                    ginzip.close()
                } catch (e: IOException) {
                }
            }
            if (input != null) {
                try {
                    input.close()
                } catch (e: IOException) {
                }
            }
            try {
                out.close()
            } catch (e: IOException) {
            }
        }
        return decompressed
    }
    
    fun encodeURI(str: String): String {
        return try {
            URLEncoder.encode(str, "UTF-8")
        } catch (e: Exception) {
            ""
        }
    }

    fun encodeURI(str: String, enc: String): String {
        return try {
            URLEncoder.encode(str, enc)
        } catch (e: Exception) {
            ""
        }
    }

    fun htmlFormat(str: String): String {
        return str.htmlFormat()
    }


    /**
     * 解析字体,返回字体解析类
     */
    fun queryBase64TTF(base64: String?): QueryTTF? {
        base64DecodeToByteArray(base64)?.let {
            return QueryTTF(it)
        }
        return null
    }

    fun queryTTF(str: String?): QueryTTF? {
        str ?: return null
        val key = md5Encode16(str)
        var qTTF = CacheManager.getQueryTTF(key)
        if (qTTF != null) return qTTF
        val font: ByteArray? = when {
            str.isAbsUrl() -> runBlocking {
                var x = CacheManager.getByteArray(key)
                if (x == null) {
                    x = RxHttp.get(str).toByteArray().await()
                    x.let {
                        CacheManager.put(key, it)
                    }
                }
                return@runBlocking x
            }
            str.isContentScheme() -> Uri.parse(str).readBytes(App.INSTANCE)
            str.startsWith("/storage") -> File(str).readBytes()
            else -> base64DecodeToByteArray(str)
        }
        font ?: return null
        qTTF = QueryTTF(font)
        CacheManager.put(key, qTTF)
        return qTTF
    }

    fun replaceFont(
        text: String,
        font1: QueryTTF?,
        font2: QueryTTF?
    ): String {
        if (font1 == null || font2 == null) return text
        val contentArray = text.toCharArray()
        contentArray.forEachIndexed { index, s ->
            val oldCode = s.toInt()
            if (font1.inLimit(s)) {
                val code = font2.getCodeByGlyf(font1.getGlyfByCode(oldCode))
                if (code != 0) contentArray[index] = code.toChar()
            }
        }
        return contentArray.joinToString("")
    }

    /**
     * 输出调试日志
     */
    fun log(msg: String) {
        Debug.log(msg)
    }
}
