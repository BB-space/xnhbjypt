package com.sykj.app.entity.user;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 用户金融账号表
 * @author swh
 *
 */
public class UserPay implements java.io.Serializable{

	private String id;//主键
	private String payName;//金融账号
	private String payPassword;//金融密码
	private Date createDateTime;//创建时间
	private BigDecimal nowMoney;//当前余额
	private String nickName;//昵称
	private String mobile;//手机
	private BigDecimal totalMoney;//总充值金额
	private BigDecimal oldMoney;//原有金额
	private BigDecimal giftAmount;//赠送金额
	private BigDecimal rechargeAmount;//充值金额
	private String userId;//对应会员
	
	public UserPay(){
		
	}
	
	public UserPay(String id, String payName, String payPassword,
			Date createDateTime, BigDecimal nowMoney, String nickName,
			String mobile, BigDecimal totalMoney, BigDecimal oldMoney,
			String userId) {
		super();
		this.id = id;
		this.payName = payName;
		this.payPassword = payPassword;
		this.createDateTime = createDateTime;
		this.nowMoney = nowMoney;
		this.nickName = nickName;
		this.mobile = mobile;
		this.totalMoney = totalMoney;
		this.oldMoney = oldMoney;
		this.userId = userId;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPayName() {
		return payName;
	}
	public void setPayName(String payName) {
		this.payName = payName;
	}
	public String getPayPassword() {
		return payPassword;
	}
	public void setPayPassword(String payPassword) {
		this.payPassword = payPassword;
	}
	public Date getCreateDateTime() {
		return createDateTime;
	}
	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
	public BigDecimal getNowMoney() {
		return nowMoney;
	}
	public void setNowMoney(BigDecimal nowMoney) {
		this.nowMoney = nowMoney;
	}
	
	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public BigDecimal getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(BigDecimal totalMoney) {
		this.totalMoney = totalMoney;
	}
	public BigDecimal getOldMoney() {
		return oldMoney;
	}
	public void setOldMoney(BigDecimal oldMoney) {
		this.oldMoney = oldMoney;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public BigDecimal getGiftAmount() {
		return giftAmount;
	}

	public void setGiftAmount(BigDecimal giftAmount) {
		this.giftAmount = giftAmount;
	}

	public BigDecimal getRechargeAmount() {
		return rechargeAmount;
	}

	public void setRechargeAmount(BigDecimal rechargeAmount) {
		this.rechargeAmount = rechargeAmount;
	}
	
}
