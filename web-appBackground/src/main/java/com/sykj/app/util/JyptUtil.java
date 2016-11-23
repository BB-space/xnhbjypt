package com.sykj.app.util;

import net.sf.json.JSONObject;
/**
 * 交易平台工具类
 * @author think
 *
 */
public class JyptUtil {

	/**
	 * 获取交易平台交易行情
	 * @param url
	 * @return
	 */
	public static JSONObject getJypthq(String url){
		
		return HttpRequestUtils.httpGet(url);
	}
	
    public static void main(String[] args) {
        //发送 GET 请求
    	JSONObject s=JyptUtil.getJypthq(Jypt.btc_jyhq_uql);
    	JSONObject jsonObject = JSONObject.fromObject(s);
        System.out.println(jsonObject.getDouble("high")+"**"+jsonObject.getDouble("low")+"**"+jsonObject.getDouble("buy")+"**"
        +jsonObject.getDouble("sell")+"**"+jsonObject.getDouble("last")+"**"+jsonObject.getDouble("vol")+"**"+jsonObject.getLong("time"));
        //high: 最高价
        //low: 最低价
       // buy: 买一价
        //sell: 卖一价
       // last: 最新成交价
        //vol: 成交量(最近的24小时)
        //time: 返回数据时服务器时间
    }
	
}
