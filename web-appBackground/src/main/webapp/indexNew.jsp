<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理登陆</title>
<style type="text/css">
.top {
	width: 100%;
	height: 7rem;
	background-color: rgb(55, 151, 202);
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
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.cookie.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		if ($.cookie("rmbUser") == "true") {
			$("#ck_rmbUser").attr("checked", true);
			var name = $.cookie("username");
			var password = $.cookie("password");
			$("#username").val(name);
			$("#password").val(password);
			$("#username").css("background","rgba(255,255,255,0.8)");
		}
	});

	function save() {
		if ($("#ck_rmbUser").attr("checked")) {
			var str_username = $("#username").val();
			var str_password = $("#password").val();
			$.cookie("rmbUser", "true", {
				expires : 7
			}); //存储一个带7天期限的cookie
			$.cookie("username", str_username, {
				expires : 7
			});
			$.cookie("password", str_password, {
				expires : 7
			});
		} else {
			$.cookie("rmbUser", "false", {
				expire : -1
			});
			$.cookie("username", "", {
				expires : -1
			});
			$.cookie("password", "", {
				expires : -1
			});
			window.location.href = "${pageContext.request.contextPath}/index.do";
		}
	}

	function loginSubmit() {
		var dataPara = $('#loginForm').serializeArray();
		$.ajax({
			url : '${pageContext.request.contextPath}/user.do?bgLogin',
			type : 'post',
			data : dataPara,
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success == true) {
					if(d.msg=="审核"){
						if(d.obj=="auditWaiting"){
							window.location.href="${pageContext.request.contextPath}/contract.do?auditSkip";
							return false;	
						}else{
							$("#username").focus();
							$("#username").val("");
							$("#password").val("");
							alert("用户名或密码错误，请重新输入！");
							return false;
						}
					}
					save();
					window.location.href = "${pageContext.request.contextPath}/index.do";
				} else {
					$("#username").focus();
					$("#username").val("");
					$("#password").val("");
					alert("用户名或密码错误，请重新输入！");
					return false;
				}
			}
		});
	}
	function reg() {
		window.location.href="${pageContext.request.contextPath}/joinUser.do?register";
	}
</script>
<link rel="stylesheet" href="resources/css/login/css/login.css"/>
<script type="text/javascript" src="resources/css/login/js/login.js"></script>
</head>
<body onload="setSysName()">
	<div class="heading" id="heading">
		<div class="box"><div><span><img src="resources/css/login/img/LOGO.png" id="logo"/></span></div></div>
		<div class="box"><div><span><img src="resources/css/login/img/login_r.png"/></span></div></div>
	</div>
	<div class="container" id="container">
		<div class="sysName">
			<div id="sysName"><span id="sysNsapn">微信后台系统</span></div>
		</div>
		<div class="loginBox" id="loginBox">
			<form id="loginForm" name="loginForm" method="post">
				<div class="chooseBtn">
					<div class="box light">二维码登录</div>
					<div class="box">账号登录</div>
					<div class="clear"></div>
				</div>
				<div class="onLogin">
					<div class="nameBox">
						<img src="resources/css/login/img/name.png">
						<input type="text" id="username" name="userName" class="writeText" value="请输入账号" 
							onfocus="javascript:if(this.value=='请输入账号') this.value='';"
							onblur="javascript:if(this.value=='') this.value='请输入账号';"/>
					</div>
					<div class="nameBox">
						<img src="resources/css/login/img/pwd.png">
						<input type="password" id="password" name="userPassword" class="writeText"/>
					</div>
					<div class="keep">
						<input type="checkbox" id="ck_rmbUser" /><span>记住密码</span>
					</div>
					<div class="btnBox">
						<input type="button" value="注&nbsp册" class="btn" onclick="reg();">
						<input type="button" value="登&nbsp录" class="btn loginBtn" onclick="loginSubmit()">	
						<div class="clear"></div>
					</div>
<!-- 					<input type="button" value="登&nbsp;&nbsp;录" class="loginBtn" onclick="loginSubmit()"> -->
				</div>
			</form>
		</div>
	</div>
	<div class="footing" id="footing">
		<p id="banquan">©2016 珠海市丝域连锁企业管理有限公司 <img src="resources/css/login/img/small.png">粤ICP备15028020号</p>
	</div>
</body>
</html>