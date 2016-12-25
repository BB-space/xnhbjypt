<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html style="background:#f1f6f9;">
<head>
<link href="<%=request.getContextPath()%>/resources/css/test/style1.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=request.getContextPath()%>/resources/css/test/style4.css" rel="stylesheet" type="text/css" media="all"/>
<jsp:include page="../test/head.jsp"></jsp:include>
<script type="text/javascript">

$(function(){
	if("${sessionScope.frontUserM}"){
		if("${sessionScope.frontUserM.googleCheckCode}" != ""){
			$("#googleDiv").addClass("safe_itemhover");	
			$("#google_btn").text("查看");	
		}
		
		if("${sessionScope.frontUserM.mobileStatus}" == "true"){
			$("#msgDiv2").html('<span>手机号码：  </span><span style="color:#66b2e3">${sessionScope.frontUserM.mobile}</span>&nbsp;&nbsp;<span>提现，修改密码，及安全设置时用以收取验证短信</span>');	
			$("#msgDiv").addClass("safe_itemhover");	
			$("#msg_btn").text("重置");	
		}
		
		if("${sessionScope.frontUserM.emailStatus}" == "true"){
			$("#emailDiv2").html('<span>邮箱地址： </span><span style="color:#66b2e3">${sessionScope.frontUserM.email}</span>&nbsp;&nbsp;<span>用于登录和找回密码</span>');	
			$("#emailDiv").addClass("safe_itemhover");	
			$("#email_btn").hide();
		}
		
		if(("${sessionScope.frontUserM.googleCheckCode}" != "") || ("${sessionScope.frontUserM.mobileStatus}" == "true")){
			$("#loginPasswordDiv").addClass("safe_itemhover");	
			$("#loginPassword_btn").text("重置");
			
			if("${sessionScope.frontUserM.googleCheckCode}" != ""){
				$("#tradePasswordDiv").addClass("safe_itemhover");	
				$("#tradePassword_btn").text("重置");	
			}
		}
		
	}
	
	//修改菜单头图片
	$("#index").attr('src', "<%=request.getContextPath()%>/resources/img/test/navHome.png"); 
	$("#trade").attr('src', "<%=request.getContextPath()%>/resources/img/test/navTrade.png"); 
	$("#finance").attr('src', "<%=request.getContextPath()%>/resources/img/test/navFinance.png"); 
	$("#safe").attr('src', "<%=request.getContextPath()%>/resources/img/test/navSafe2.png"); 
	$("#news").attr('src', "<%=request.getContextPath()%>/resources/img/test/navNews.png"); 
});

//绑定手机
function validatePhone(){
	$("#alert_flog").show();
	if($("#msg_btn").text() == '立即验证'){
		$("#mobile_bound").show();
		$("#mobile_bound_span").click();
		
	}else {
		$("#mobile_unbound").show();
		$("#mobile_unbound_span").click();
	}
};


//绑定手机
function mobileBound(){
	//校验绑定手机
	var mobile = trim($("#bound_mobile").val());
	if(mobile == ''){
		$('#err_bound_mobile').html("请填写信息！").addClass("Validform_checktip Validform_wrong");
		return;
	}else if(!checkMobile(mobile)){
		$('#err_bound_mobile').html("请输入手机号！").addClass("Validform_checktip Validform_wrong");
		return;
	}else{
		var dataPara = {mobile:mobile};
		//校验号码是否已经注册
		$.ajax({
			url : '${pageContext.request.contextPath}/safe.do?checkBoundMobile',
			type : 'post',
			data : dataPara,
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success == true) {
					$('#err_bound_mobile').html("手机号已存在！").addClass("Validform_checktip Validform_wrong");
					return;
				}else {
					$('#err_bound_mobile').html("通过信息验证！").removeClass("Validform_checktip Validform_wrong")
						.addClass("Validform_checktip Validform_right");
				}
			}
		});
	}
	
	//校验验证码
	var mobileCheckCode = trim($("#bound_mobileCheckCode").val());
	if(mobileCheckCode == ''){
		$('#err_bound_mobileCheckCode').html("请填写信息！").addClass("Validform_checktip Validform_wrong");
		return;
	}else if(!checkMobileCheckCode(mobileCheckCode)){
		$('#err_bound_mobileCheckCode').html("请输入6位验证码！").addClass("Validform_checktip Validform_wrong");
		return;
	}else{
		$('#err_bound_mobileCheckCode').html("通过信息验证！").removeClass("Validform_checktip Validform_wrong")
			.addClass("Validform_checktip Validform_right");
	}
	
	var dataPara = $('#mobileBoundForm').serializeArray();
	$.ajax({
		url : '${pageContext.request.contextPath}/safe.do?mobileBound',
		type : 'post',
		data : dataPara,
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success == true) {
				alert("绑定成功");
				$("#alert_flog").hide();
				$("#mobile_bound").hide();
				$('#mobileBoundForm')[0].reset();
				$("#msgDiv2").html('<span>手机号码：  </span><span style="color:#66b2e3">'+d.obj.mobile+'</span>&nbsp;&nbsp;<span>提现，修改密码，及安全设置时用以收取验证短信</span>');	
				$("#msgDiv").addClass("safe_itemhover");	
				$("#msg_btn").text("重置");	
				$("#loginPasswordDiv").addClass("safe_itemhover");
				$("#loginPassword_btn").text("重置");
				if((d.obj.tradePassword != null) && (d.obj.tradePassword != "")){
					$("#tradePasswordDiv").addClass("safe_itemhover");	
					$("#tradePassword_btn").text("重置");	
				}
				
			}else {
				alert("手机绑定失败！");
			}
		}
	});
}

//解绑手机
function mobileUnbound(){
	
	var mobileCheckCode = trim($("#unbound_mobileCheckCode").val());
	if(mobileCheckCode == ''){
		$('#err_unbound_mobileCheckCode').html("请填写信息！").addClass("Validform_checktip Validform_wrong");
		return;
	}else if(!checkMobileCheckCode(mobileCheckCode)){
		$('#err_unbound_mobileCheckCode').html("请输入6位验证码！").addClass("Validform_checktip Validform_wrong");
		return;
	}else{
		$('#err_unbound_mobileCheckCode').html("通过信息验证！").removeClass("Validform_checktip Validform_wrong")
			.addClass("Validform_checktip Validform_right");
	}
	
	var dataPara = $('#mobileUnboundForm').serializeArray();
	$.ajax({
		url : '${pageContext.request.contextPath}/safe.do?mobileUnbound',
		type : 'post',
		data : dataPara,
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success == true) {
				$("#msgDiv2").html('<span>提现，修改密码，及安全设置时用以收取验证短信</span>');	
				$("#msgDiv").removeClass("safe_itemhover");	
				$("#msg_btn").text("立即验证");	
				
				if((d.obj.googleCheckCode == null) || (d.obj.googleCheckCode == "")){
					$("#loginPasswordDiv").removeClass("safe_itemhover");	
					$("#loginPassword_btn").text("立即验证");	
					$("#tradePasswordDiv").removeClass("safe_itemhover");	
					$("#tradePassword_btn").text("立即验证");	
				}
				$("#alert_flog").hide();
				$("#mobile_unbound").hide();
				$('#mobileUnboundForm')[0].reset();
			} else {
				if(d.msg = '1'){	//验证码不正确
					$('#err_unbound_mobileCheckCode').html("验证码不正确！").addClass("Validform_checktip Validform_wrong");
				}
			}
		}
	});
}

//绑定邮箱
function validateEmail(){
	$("#alert_flog").show();
	$("#email_bound").show();
	$("#email_bound_span").click();
};

//绑定邮箱
function emailBound(){
	
	var email = trim($("#bound_email").val());
	if(email == ''){
		$('#err_bound_email').html("请填写信息！").addClass("Validform_checktip Validform_wrong");
		return;
	}else if(!checkEmail(email)){
		$('#err_bound_email').html("请输入邮箱！").addClass("Validform_checktip Validform_wrong");
		return;
	}else{
		var dataPara = {email:email};
		//校验号码是否已经注册
		$.ajax({
			url : '${pageContext.request.contextPath}/safe.do?checkBoundEmail',
			type : 'post',
			data : dataPara,
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success == true) {
					$('#err_bound_email').html("邮箱已存在！").addClass("Validform_checktip Validform_wrong");
					return;
				}else {
					$('#err_bound_email').html("通过信息验证！").removeClass("Validform_checktip Validform_wrong")
						.addClass("Validform_checktip Validform_right");
				}
			}
		});
	}
	
	var dataPara = $('#emailBoundForm').serializeArray();
	$.ajax({
		url : '${pageContext.request.contextPath}/safe.do?emailBound',
		type : 'post',
		data : dataPara,
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success == true) {
				alert("邮件已发送到您刚绑定的邮箱，请登录邮箱验证。");
				$("#alert_flog").hide();
				$("#email_bound").hide();
				$('#emailBoundForm')[0].reset();
			} else if(d.msg == '1'){
				alert("您已经绑定邮箱，请刷新页面。");
			}else {
				alert("邮件发送失败！");
			}
		}
	});
}

//显示修改登陆密码弹出框
function validateLoginPassword(){
	if($("#loginPassword_btn").text() == '重置'){
		$("#alert_flog").show();
		$("#chg_login_password").show();
		$("#chg_login_password_span").click();
	}
};

//修改登录密码
function changePassword(){
	
	//旧密码
	var password = $("#chg_oldPassword").val();
	if(password == ''){
		$('#err_chg_oldPassword').html("请填写信息！").addClass("Validform_checktip Validform_wrong");
		return;
	}else if((password.length < 6) || (password.length > 16)){
		$('#err_chg_oldPassword').html("请输入6-16位密码！").addClass("Validform_checktip Validform_wrong");
		return;
	}else{
		var dataPara = {password:password};
		//校验号码是否已经注册
		$.ajax({
			url : '${pageContext.request.contextPath}/safe.do?checkPassword',
			type : 'post',
			data : dataPara,
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success == false) {
					$('#err_chg_oldPassword').html("原密码不正确！").addClass("Validform_checktip Validform_wrong");
					return;
				}else {
					$('#err_chg_oldPassword').html("通过信息验证！").removeClass("Validform_checktip Validform_wrong")
						.addClass("Validform_checktip Validform_right");
				}
			}
		});
	}
	
	//新密码
	var password = $("#chg_password").val();
	if(password == ''){
		$('#err_chg_password').html("请填写信息！").addClass("Validform_checktip Validform_wrong");
		return;
	}else if((password.length < 6) || (password.length > 16)){
		$('#err_chg_password').html("请输入6-16位密码！").addClass("Validform_checktip Validform_wrong");
		return;
	}else{
		$('#err_chg_password').html("通过信息验证！").removeClass("Validform_checktip Validform_wrong")
			.addClass("Validform_checktip Validform_right");
	}
	
	//再次输入新密码
	var password = $("#chg_password").val();
	var repassword = $("#chg_repassword").val();
	if(repassword != password){
		$('#err_chg_repassword').html("两次输入密码不一至").addClass("Validform_checktip Validform_wrong");
		return;
	}else{
		$('#err_chg_repassword').html("通过信息验证！").removeClass("Validform_checktip Validform_wrong")
			.addClass("Validform_checktip Validform_right");
	}
	
	//输入校验码
	var mobileCheckCode = trim($("#chg_mobileCheckCode").val());
	if(mobileCheckCode == ''){
		$('#err_chg_mobileCheckCode').html("请填写信息！").addClass("Validform_checktip Validform_wrong");
		return;
	}else if(!checkMobileCheckCode(mobileCheckCode)){
		$('#err_chg_mobileCheckCode').html("请输入6位验证码！").addClass("Validform_checktip Validform_wrong");
		return;
	}else{
		$('#err_chg_mobileCheckCode').html("通过信息验证！").removeClass("Validform_checktip Validform_wrong")
			.addClass("Validform_checktip Validform_right");
	}
	
	
	var dataPara = $('#chgPasswordForm').serializeArray();
	$.ajax({
		url : '${pageContext.request.contextPath}/safe.do?changePassword',
		type : 'post',
		data : dataPara,
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success == true) {
				$("#alert_flog").hide();
				$("#chg_login_password").hide();
			}
		}
	});
}

//显示修改交易密码弹出框
function validateTradePassword(){
	if($("#tradePassword_btn").text() == '重置'){
		$("#alert_flog").show();
		$("#trade_password").show();
		$("#trade_password_span").click();
	}else if(($("#google_btn").text() == "查看") || ($("#msg_btn").text() == "重置")){
		$("#alert_flog").show();
		$("#trade_password").show();
		$("#trade_password_span").click();
		$("#trade_passwrod_line25").hide();
		$("#trade_passwrod_old_div").hide();
	}
};

//修改交易密码
function changeTradePassword(){
	
	
	var dataPara = $('#chgTradePasswordForm').serializeArray();
	$.ajax({
		url : '${pageContext.request.contextPath}/safe.do?changeTradePassword',
		type : 'post',
		data : dataPara,
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success == true) {
				
			}
		}
	});
}

</script>
</head>
<body style="background:#f1f6f9;">

<div class="ad_main">
	
	<div class="safe_tip">
		<span>重要提示：</span>	
		客服不会要求用QQ远程控制您的计算机,所有要求远程的都是骗子。短信验证码、谷歌验证码非常重要，请勿透露给任何人，包括客服。
	</div>
	
	<div class="ad_aside">
		<a href="#" class="hover"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico1.png" />安全设置<i></i></a>
		<a href="<%=request.getContextPath()%>/safe.do?userSetting"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico2.png" />用户设置<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?question"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico3.png" />发起问题<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?questionColumn"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico4.png" />问题列表<i></i></a>
		<a href="#" class="bottom"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico5.png" />消息中心<i></i></a>
	</div>
	
	<div class="safe_section">
		
		<div class="safe_item " id="googleDiv">
			<span class="tit">谷歌验证</span>
			<div class="tip">提现，修改密码，及安全设置时用以输入谷歌验证码。 下载:Andriod/IOS</div>
			<a href="#" class="go_btn" id="google_btn">立即验证</a>
			<div class="clear"></div>	
		</div>
		<div class="safe_item" id="msgDiv">
			<span class="tit">短信验证</span>
			<div class="tip" id="msgDiv2">提现，修改密码，及安全设置时用以收取验证短信</div>
			<a href="javascript:validatePhone();" class="go_btn" id="msg_btn">立即验证</a>
			<div class="clear"></div>	
		</div>
		<div class="safe_item " id="emailDiv">
			<span class="tit">邮箱验证</span>
			<div class="tip" id="emailDiv2"><span>用于登录和找回密码</span></div>
			<a href="javascript:validateEmail();" class="go_btn" id="email_btn">立即验证</a>
			<div class="clear"></div>	
		</div>
		<div class="safe_item " id="loginPasswordDiv">
			<span class="tit">登录密码</span>
			<div class="tip">开通短信验证或谷歌验证才能进行设置</div>
			<a href="javascript:validateLoginPassword();" class="go_btn" id="loginPassword_btn">立即验证</a>
			<div class="clear"></div>	
		</div>
		<div class="safe_item safe_itemend" id="tradePasswordDiv">
			<span class="tit">交易密码</span>
			<div class="tip">开通短信验证或谷歌验证才能进行设置</div>
			<a href="javascript:validateTradePassword();" class="go_btn" id="tradePassword_btn">立即验证</a>
			<div class="clear"></div>	
		</div>
		
		<div class="clear"></div>	
	</div>
	
	<div class="clear"></div>
</div>

	<div class="alert_flog" id="alert_flog"></div>
	
	<div class="lg_win login_win" id="mobile_bound">
		<div class="lgwin_handle">
			<span class="a2" id="mobile_bound_span"><em>手机绑定</em></span>
		</div>
		
		<div class="lgwin_wrap">
			<form id="mobileBoundForm" name="mobileBoundForm" method="post">
				<div class="line25"></div>
				<div class="email_tip">
					<span>重要提示：</span> 为了您的账户安全，请绑定手机。	
				</div>
				<div class="line25"></div>
				<div class="in">
					<select name="location">
						<option>中国大陆(China)</option>
						<option>美国(America)</option>	
						<option>英国(English)</option>	
					</select>
				</div>
				<div class="line25"></div>
				<div class="in">
					<span class="qh">+86</span>
					<input id="bound_mobile" name="mobile" type="text" class="text text_tel" placeholder="请输入你的手机号码"/>	
					<span id='err_bound_mobile'></span>
				</div>
				<div class="line25"></div>
				<div class="in">
					<div class="in">
						<a href="javascript:;" class="get_yz">发送验证码</a>
						<input id="bound_mobileCheckCode" name="mobileCheckCode" type="text" class="text" placeholder="短信验证码" />	
						<span id='err_bound_mobileCheckCode'></span>
					</div>
				</div>
				<div class="line25"></div>
				
				<div class="sub_outer">
					<input type="button" class="sub" value="绑定" onclick="mobileBound();"/>
					<input type="reset" class="res" value="取消" />
					<div class="clear"></div>	
				</div>			
					
			</form>	
		</div>
	</div>
	
	
	<div class="lg_win login_win" id="mobile_unbound">
		<div class="lgwin_handle">
			<span class="a2" id="mobile_unbound_span"><em>解绑手机</em></span>
		</div>
		
		<div class="lgwin_wrap">
			<form id="mobileUnboundForm" name="mobileUnboundForm" method="post">
				<div class="line25"></div>
				<div class="email_tip">
					<span>重要提示：</span> 为了您的账户安全，不建议您解绑手机,如果您的手机丢失或者其他原因无法接收手机验证码，请通过邮件发送相关证件联系网站管理人员办理解绑。	
				</div>
				<div class="line25"></div>
				<div class="in">
					<div class="in">
						<a href="javascript:;" class="get_yz">点击获取</a>
						<input id="unbound_mobileCheckCode" name="mobileCheckCode" type="text" class="text" placeholder="短信验证码" />	
						<span id='err_unbound_mobileCheckCode'></span>
					</div>
				</div>
				<div class="line25"></div>
				
				<div class="sub_outer">
					<input type="button" class="sub" value="确定提交" onclick="mobileUnbound();"/>
					<input type="reset" class="res" value="取消" />
					<div class="clear"></div>	
				</div>			
					
			</form>	
		</div>
	</div>		


	<div class="lg_win login_win" id="email_bound">
		<div class="lgwin_handle">
			<span class="a3" id="email_bound_span"><em>绑定邮箱</em></span>
		</div>
		
		<div class="lgwin_wrap">
			<form id="emailBoundForm" name="emailBoundForm" method="post">
				<div class="line25"></div>
				<div class="email_tip">
					<span>重要提示：</span> 为了你的账号安全，请绑定邮箱。	
				</div>
				<div class="line25"></div>				
				<div class="in">
					<div class="in">						
						<input id="bound_email" name="email" type="text" class="text" placeholder="请输入邮箱"/>
						<span id='err_bound_email'></span>	
					</div>
				</div>
				<div class="line25"></div>				
				
				<div class="sub_outer">
					<input type="button" class="sub" value="确认" onclick="emailBound();"/>
					<input type="reset" class="res" value="取消" />
					<div class="clear"></div>	
				</div>			
					
			</form>	
		</div>
	</div>	
		
	<div class="lg_win login_win" id="chg_login_password">
		<div class="lgwin_handle">
			<span class="a2" id="chg_login_password_span"><em>登录密码</em></span>
		</div>
		
		<div class="lgwin_wrap">
			<form id="chgPasswordForm" name="chgPasswordForm" method="post">
				<div class="line25"></div>
				<div class="email_tip">
					<span>警告：</span> 登录密码不要与交易密码或其他网站密码一致，由此产生的账号被盗，本站概不负责。	
				</div>
				<div class="line25"></div>
				<div class="in">
					<input type="text" class="text ps1" placeholder="请输入原密码" />
					<input id="chg_oldPassword" name="oldPassword" type="password" class="text ps2" />
					<span id='err_chg_oldPassword'></span>	
				</div>
				<div class="line25"></div>
				<div class="in">
					<input type="text" class="text ps1" placeholder="请输入新密码" />
					<input id="chg_password" name="password" type="password" class="text ps2" />
					<span id='err_chg_password'></span>	
				</div>
				<div class="line25"></div>
				<div class="in">
					<input type="text" class="text ps1" placeholder="请再输入一次密码" />
					<input id="chg_repassword" name="repassword" type="password" class="text ps2" value="" />
					<span id='err_chg_repassword'></span>	
				</div>				
				<div class="line25"></div>
				<div class="in">
					<div class="in">
						<a href="javascript:;" class="get_yz">发送验证码</a>
						<input id="chg_mobileCheckCode" name="mobileCheckCode" type="text" class="text" placeholder="短信验证码" />	
						<span id='err_chg_mobileCheckCode'></span>
					</div>
				</div>
				<div class="line25"></div>
				
				<div class="sub_outer">
					<input type="button" class="sub" value="确定提交" onclick="changePassword();"/>
					<input type="reset" class="res" value="取消" />
					<div class="clear"></div>	
				</div>			
					
			</form>	
		</div>
	</div>		
	
	<div class="lg_win login_win" id="trade_password">
		<div class="lgwin_handle">
			<span class="a2" id="trade_password_span"><em>交易密码</em></span>
		</div>
		
		<div class="lgwin_wrap">
			<form id="chgTradePasswordForm" name="chgTradePasswordForm" method="post">
				<div class="line25"></div>
				<div class="email_tip">
					<span>警告：</span> 交易密码不要与登陆密码或其他网站密码一致，由此产生的账号被盗，本站概不负责。	
				</div>
				<div class="line25" id="trade_passwrod_line25"></div>
				<div class="in" id="trade_passwrod_old_div">
					<input type="text" class="text ps1" placeholder="请输入原密码" />
					<input id="chg_oldTradePassword" name="oldTradePassword" type="password" class="text ps2" />
					<span id='err_chg_oldTradePassword'></span>	
				</div>
				<div class="line25"></div>
				<div class="in">
					<input type="text" class="text ps1" placeholder="请输入新密码" />
					<input id="chg_tradePassword" name="tradePassword" type="password" class="text ps2" />
					<span id='err_chg_password'></span>	
				</div>
				<div class="line25"></div>
				<div class="in">
					<input type="text" class="text ps1" placeholder="请再输入一次密码" />
					<input id="chg_reTradePassword" name="reTradePassword" type="password" class="text ps2" value="" />
					<span id='err_chg_reTradePassword'></span>	
				</div>				
				<div class="line25"></div>
				<div class="in">
					<div class="in">
						<a href="javascript:;" class="get_yz">发送验证码</a>
						<input id="chg_tradeMobileCheckCode" name="mobileCheckCode" type="text" class="text" placeholder="短信验证码" />	
						<span id='err_chg_tradeMobileCheckCode'></span>
					</div>
				</div>
				<div class="line25"></div>
				
				<div class="sub_outer">
					<input type="button" class="sub" value="确定提交" onclick="changeTradePassword();"/>
					<input type="reset" class="res" value="取消" />
					<div class="clear"></div>	
				</div>			
					
			</form>	
		</div>
	</div>		

	
	
<!--footer start here-->
<jsp:include page="../test/footer.jsp"></jsp:include>
<!--footer end here-->


</body>
</html>