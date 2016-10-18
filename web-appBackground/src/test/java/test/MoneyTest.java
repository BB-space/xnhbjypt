package test;

import java.util.HashMap;
import java.util.Map;

import com.sykj.app.util.ConfigUtil;
import com.sykj.app.wx.wxUtil.MoneyUtils;

public class MoneyTest {
	final static  String url = "https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack";
	public static void main(String[] args) {
		String orderNNo =  MoneyUtils.getOrderNo() ; 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nonce_str", MoneyUtils.buildRandom());//随机字符串
		map.put("mch_billno", orderNNo);//商户订单
		map.put("mch_id", ConfigUtil.COMPAMY_MCH_ID);//商户号
		map.put("wxappid", ConfigUtil.COMPAMY_REDPACKET_APPID);//商户appid
//		map.put("nick_name", "自由数字科技");//提供方名称
		map.put("send_name", "丝域科技");//用户名
		map.put("re_openid", "oXY__v3aK6JMrz-VaVpoWjhqGXpg");//用户openid ojER0t_ul72T38iOKqlurjKLkc5A
		map.put("total_amount", 100);//付款金额
		//map.put("agentid", 2);
//		map.put("min_value", 1);//最小红包
//		map.put("max_value", 1);//最大红包
		map.put("total_num", 1);//红包发送总人数
		map.put("wishing", "新年快乐");//红包祝福语
		map.put("client_ip", "127.0.0.1");//ip地址
		map.put("act_name", "过年红包");//活动名称
		map.put("remark", "新年新气象");//备注
		map.put("sign", MoneyUtils.createSign(map));//签名
		
		String result = "";
		try {
			result = MoneyUtils.doSendMoney(url, MoneyUtils.createXML(map));
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("result:"+result);
	}
}
