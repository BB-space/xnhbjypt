/**
 * 
 */
package com.sykj.app.service.reportForm;

import java.util.List;
import java.util.Map;

import com.sykj.app.model.reportForm.ChouJiangM;
import com.sykj.app.model.reportForm.GSQCardM;
import com.sykj.app.model.reportForm.RoseBuyM;
import com.sykj.app.model.reportForm.RoseCardM;
import com.sykj.app.model.reportForm.RoseSendM;
import com.sykj.app.model.reportForm.TwelveM;
import com.sykj.app.model.reportForm.ZZFCardM;
import com.sykj.app.service.BaseService;

/**
 * @author wjl 2016年1月9日 下午3:03:40
 */
public interface GSQCardService extends BaseService{
	
	/**
	 * 广深琼一卡通数据报表
	 * @param endTime
	 * @param strList
	 * @return
	 */
	public Map<String,List<GSQCardM>> makeForm(String endTime,List<String> strList);
	
	/**
	 * 珠中佛一卡通数据报表
	 * @param endTime
	 * @param strList
	 * @return
	 */
	public Map<String,List<ZZFCardM>> zzfForm(String endTime,List<String> strList);
	
	/**
	 * 珠中佛一卡通数据报表
	 * @param endTime
	 * @param strList
	 * @return
	 */
	public Map<String,List<RoseCardM>> roseForm(String beginTime,String endTime,List<String> strList);
	
	/**
	 * 北天上西成渝一卡通数据报表
	 * @param endTime
	 * @param strList
	 * @return
	 */
	public Map<String,List<GSQCardM>> btsxcyForm(String endTime,List<String> strList);
	
	/**
	 * 69购买数据报表
	 * @return
	 */
	public List<RoseBuyM> roseBuy();
	
	/**
	 * 69增券数据
	 * @return
	 */
	public List<RoseSendM> roseSend();
	
	/**
	 * 198购买数据
	 * @return
	 */
	public List<RoseBuyM> roseBuy_198();
	
	/**
	 * 198赠券数据
	 * @return
	 */
	public List<RoseBuyM> roseSend_198();
	
	/**
	 * 抽奖人数报表
	 * @return
	 */
	public List<ChouJiangM> chouJiang();
	
	/**
	 * 绑定人数报表
	 * @return
	 */
	public List<TwelveM> twelve();
	
	/**
	 * 98购买数据
	 * @return
	 */
	public List<RoseBuyM> buy_98();
	
	/**
	 * 98赠券数据
	 * @return
	 */
	public List<RoseBuyM> send_98();
}
