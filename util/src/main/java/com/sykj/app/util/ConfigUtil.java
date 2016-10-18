package com.sykj.app.util;

public class ConfigUtil {
	/**
	 * 服务号相关信息
	 */
//	 public final static String APPID = "wxbd868bc05fc9d090";//科技服务号的应用号
//	 public final static String APP_SECRECT = "3ffaae6fecded92ad61fd7e526e2d72b";//科技服务号的应用密码
	 
//	 public final static String APPID = "wx2db2bafc6199fcbb";//爱头发服务号的应用号
//	 public final static String APP_SECRECT = "fa6cc8ea0e5599411161ade469a1defe";//爱头发服务号的应用密码
	 
	 public final static String APPID = "wxe3b97a3a2eb72f35";//总部服务号的应用号
	 public final static String APP_SECRECT = "c8c60db22063f7d5bec1630a3e09f65e";//总部服务号的应用密码

	 public final static String COMPAMY_APPID = "wxcaa5198d120e55aa";//企业号的应用号
	 public final static String COMPAMY_REDPACKET_APPID = "wxf452e8692617e55f";//企业号的发红包应用号
	 public final static String COMPAMY_KF_SECRECT = "OdWK01Zv_WRaX-nIn6t-Q4lR87Zqv7tUijx_5CeGF_BmNrYSTFpdbdo4cfNxkJ9p";//企业号开发组应用密码
	 public final static String COMPAMY_ENCODINGAESKEY = "tdfDxO7m4E88Xzsi95oNe0kG56ihotNP9KxcQVlQL3A";//企业号接口验证秘钥
	 public final static String PAY_APPID = "wx2db2bafc6199fcbb";//爱头发服务号的应用号
	 public final static String PAY_APP_SECRECT = "fa6cc8ea0e5599411161ade469a1defe";//爱头发服务号的应用密码
//	 
//	 public final static String PAY_APPID = "wxbd868bc05fc9d090";//科技服务号支付APPID
//	 public final static String PAY_APP_SECRECT = "3ffaae6fecded92ad61fd7e526e2d72b";//科技服务号支付应用密码
	 
	 public final static String BACKGROUND_APPID = "wx100e8ffec08db0c7";//开放平台头发专家应用号
	 public final static String BACKGROUND_APP_SECRECT = "d02c006b0ffbe205484ac0354d015284";//开放平台头发专家应用密码
	 
	 public final static String TOKEN = "weixinCourse";//服务号的配置token

//	 public final static String MCH_ID = "1250309301";//科技商户号
	 public final static String COMPAMY_MCH_ID = "1314812001";//科技企业号的商户号
	 public final static String COMPAMY_CERT_PATH = "E:/cert/sykjcompamy/apiclient_cert.p12";//科技企业号的商户号证书存放路径
//	 public final static String KEYSTORE_FILE = "apiclient_cert_kj.p12";//科技服务号的商户号证书名
	 public final static String KEYSTORE_FILE = "apiclient_cert_zb.p12";//总部服务号的商户号证书名
	 
	 public final static String MCH_ID_ZB = "1220041201";//总部商户号
	 public final static String MCH_ID = "1260765201";//总部商户号（爱头发）

	 public final static String API_KEY = "rUJ1FzTeilUQav7NwLQ6Lm7eJ4tuoyw6";//API密钥
	 public final static String PAY_API_KEY = "6805cDCTchDV7n4qDdJTTcZg4P1iR5uM";//API密钥
	 public final static String PAY_API_KEY_ZB = "cb0702c7d42a8af9bf63c859a95bd6a4";//总部API密钥
	 public final static String COMPAMY_PAY_API_KEY = "HwIZy0d8DyMWUKofgW1Swzl0OHMABThH";//API密钥(科技企业号)
	 
	 public final static String SIGN_TYPE = "MD5";//签名加密方式
	 public final static String CERT_PATH = "E:/cert/sykjfuwuhao/apiclient_cert.p12";//微信支付证书存放路径地址
	//微信支付统一接口的回调action
//	 public final static String NOTIFY_URL = "http://www.siyuhome.com/wx/pay/payServlet/mallOrderToPayFinalSuccess.do";
//	//微信支付成功支付后跳转的地址
//	 public final static String SUCCESS_URL = "http://www.siyuhome.com/wx/pay/payServlet/mallOrderToPayFinalSuccess.do";
	 //oauth2授权时回调action
	 public final static String REDIRECT_URI = "http://14.117.25.80:8016/GoMyTrip/a.jsp?port=8016";
	/**
	 * 微信基础接口地址
	 */
	 
	 //获取token接口(GET)
	 public final static String TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
	 //oauth2授权接口(GET)
	 public final static String OAUTH2_URL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE#wechat_redirect";
	 //刷新access_token接口（GET）
	 public final static String REFRESH_TOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=APPID&grant_type=refresh_token&refresh_token=REFRESH_TOKEN";
	// 菜单创建接口（POST）
	 public final static String MENU_CREATE_URL = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
	// 菜单查询（GET）
	 public final static String MENU_GET_URL = "https://api.weixin.qq.com/cgi-bin/menu/get?access_token=ACCESS_TOKEN";
	// 菜单删除（GET）
	public final static String MENU_DELETE_URL = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN";
	/**
	 * 微信支付接口地址
	 */
	//微信支付统一接口(POST)
	public final static String UNIFIED_ORDER_URL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
	//微信退款接口(POST)
	public final static String REFUND_URL = "https://api.mch.weixin.qq.com/secapi/pay/refund";
	//订单查询接口(POST)
	public final static String CHECK_ORDER_URL = "https://api.mch.weixin.qq.com/pay/orderquery";
	//关闭订单接口(POST)
	public final static String CLOSE_ORDER_URL = "https://api.mch.weixin.qq.com/pay/closeorder";
	//退款查询接口(POST)
	public final static String CHECK_REFUND_URL = "https://api.mch.weixin.qq.com/pay/refundquery";
	//对账单接口(POST)
	public final static String DOWNLOAD_BILL_URL = "https://api.mch.weixin.qq.com/pay/downloadbill";
	//短链接转换接口(POST)
	public final static String SHORT_URL = "https://api.mch.weixin.qq.com/tools/shorturl";
	//红包发放接口
	public final static String REDPACKET_URL = "https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack";
	//接口调用上报接口(POST)
	public final static String REPORT_URL = "https://api.mch.weixin.qq.com/payitil/report";
	//企业号获取token的url
	public final static String COMPAMY_TOKEN_URL = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=ID&corpsecret=SECRECT";
	//企业号获取网页授权用户信息url
	public final static String COMPAMY_AUTH_GETUSERINFO_URL = "https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo?access_token=ACCESS_TOKEN&code=CODE";
	//企业号userid转openid
	public final static String COMPAMY_CONVERT_TO_OPENID_URL = "https://qyapi.weixin.qq.com/cgi-bin/user/convert_to_openid?access_token=ACCESS_TOKEN";
	//企业号openid转userid
	public final static String COMPAMY_CONVERT_TO_USERID_URL = "https://qyapi.weixin.qq.com/cgi-bin/user/convert_to_userid?access_token=ACCESS_TOKEN";
	//测试token有效性
	public final static String COMPAMY_GETCALLBACKIP_URL = "https://qyapi.weixin.qq.com/cgi-bin/getcallbackip?access_token=ACCESS_TOKEN";
	//发放红包url
	public final static String URL = "https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack";
	//查询企业红包url
	public final static String SEND_URL = "https://api.mch.weixin.qq.com/mmpaymkttransfers/gethbinfo";
	//域名
	public final static String DOMAIN_URL = "http://www.haircentre.cn";
//	public final static String DOMAIN_URL = "http://www.siyuhome.com";
	//支付域名
	public final static String PAY_URL = "http://www.haircentre.cn";
//	public final static String PAY_URL = "http://www.siyuhome.com";
	public final static String domain_ip = "http://120.25.69.167";
//	public final static String domain_ip = "http://192.168.4.10";
	public final static String DOMAIN_URL_SHORT="haircentre.cn";
//	public final static String DOMAIN_URL_SHORT="siyuhome.com";
    
	public final static String CLIENT_ID = "23412385";     //等同于APPID
	public final static String CLIENT_SECRET = "10aef5bff69e4ff125360318f82ec1b7"; //等同于APPSECRET
}
