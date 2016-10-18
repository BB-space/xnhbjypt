<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>丝域电商系统</title>
<style type="text/css">
.top {
	width: 100%;
	height: 7rem;
	background-color: rgb(55, 151, 202);
}
.container{
	background: none !important;
}
.main {
	background: url("resources/img/imgshop/loginbg.png") no-repeat;
	height: 799px;
}
.ul_login {
	margin: 1rem;
	padding: 0;
}
.ul_login li {
	list-style: none;
	line-height: 50px;
}
a {
	color: rgb(90, 181, 255);
	text-decoration: none;
}
a:hover {
	color: rgb(90, 181, 255);
}
a:VISITED {
	color: rgb(90, 181, 255);
	text-decoration: none;
} 

.upload{font-size:14px;display:inline-block;padding:4px;vertical-align:middle; background:#E6E6E6; position:relative; overflow:hidden;color: #4d4d4d}
.upload:hover{color:#4d4d4d}
.upload:visited{color:#4d4d4d}
.upload input{position:absolute; right:0; top:0; font-size:100px; opacity:0; filter:alpha(opacity=0);}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.cookie.js"></script>
<link rel="stylesheet" href="resources/css/login/css/login.css"/>
<link rel="stylesheet" href="resources/css/login/css/reg.css"/>
<script type="text/javascript" src="resources/css/login/js/login.js"></script>
</head>
<body onload="setSysName()">
	<div class="heading" id="heading">
		<div class="box"><div><span><img src="resources/css/login/img/LOGO.png" id="logo"/></span></div></div>
		<div class="box"><div><span><img src="resources/css/login/img/login_r.png"/></span></div></div>
	</div>
	<div class="container" id="container">
		<div class="sysName">
			<div id="sysJoinName">
				<span id="sysJoinNsapn">丝域加盟商注册</span>
			</div>
		</div>
		
		<div class="theCenterBox" style="">
			<div class="theLoginBox">
				<div style="margin-top:30px;">
				<ul class="regUl">
					<li><span>1</span>信息填写</li>
					<li><span>2</span>签署协议</li>
					<li><span>3</span>资料上传</li>
					<li class="lispec"><span class="lispanspec">4</span>等待审核</li>
					<li><span>5</span>注册成功</li>
				</ul>
				</div>
				<div class="regAuditImg">
					<img alt="" src="${pageContext.request.contextPath}/resources/css/login/img/regTip1.png">
					<p style="margin-top:26px">您的审核已提交</p>
					<p>审核结果将在3个工作日内回复结果，</p>
					<p>可登录后台微信系统查看进度</p>
				</div>
				<div class="readAgree" style="margin-top:20px;">
					<div class="readAgreeBtn readAgreeBtnGreen" onclick="joinLogin();" style="width:320px;">登录后台系统</div>
				</div>
				<p style="position: relative;">
					<p style="text-align:center;margin-top:20px;font-size:14px;">如有疑问，请在微信公众号“丝域养发馆总部”留言</p>
				</p>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
</html>