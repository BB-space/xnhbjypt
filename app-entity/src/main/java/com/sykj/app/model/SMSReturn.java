package com.sykj.app.model;

/**
 * 短信验证返回参数
 * @author swh
 *
 */
public class SMSReturn {

	private String stat;//状态码
	private String message;//返回消息
	
	public SMSReturn(){
		
	}
	public SMSReturn(String stat, String message) {
		super();
		this.stat = stat;
		this.message = message;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
}
