<%@ page pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理登陆</title>
<style type="text/css">
	 .top{
		width: 100%;
		height: 7rem;
		background-color: rgb(55,151,202);
		
	} 
 	 .main{
		background: url("resources/img/imgshop/loginbg.png") no-repeat;
		height:799px; 
	}
	.ul_login{
		margin:1rem;
		padding:0;
	}
	.ul_login li{
		list-style: none;
		line-height: 50px;    
	}  
	a{
		color: rgb(90,181,255);
		text-decoration: none;
	}
	a:hover {
		color: rgb(90,181,255);
	}
	a:VISITED {
		color: rgb(90,181,255);
		text-decoration: none; 
	}
	
</style>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.6.4.min.js"></script>

<script type="text/javascript" 
	src="${pageContext.request.contextPath}/resources/js/jquery.cookie.js"></script>
<script type="text/javascript">

function refreshVerifyCode() {
	$('#imgVerifyCode').attr("src", "${pageContext.request.contextPath}/kaptcha.do?getKaptchaImage&t=" +  Math.floor(Math.random()*100));
}

//var mark = {"username":false,"password":false};
$(document).ready(function(){
 	if ($.cookie("rmbUser") == "true") {
	        $("#ck_rmbUser").attr("checked", true);
	        $("#username").val($.cookie("username"));
	        $("#password").val($.cookie("password"));
	  } 
});

	function save(){
		if ($("#ck_rmbUser").attr("checked")) {
	        var str_username = $("#username").val();
	        var str_password = $("#password").val();
	        $.cookie("rmbUser", "true", { expires: 7 }); //存储一个带7天期限的cookie
	        $.cookie("username", str_username, { expires: 7 });
	        $.cookie("password", str_password, { expires: 7 });
	    }
	    else {
	        $.cookie("rmbUser", "false", { expire: -1 });
	        $.cookie("username", "", { expires: -1 });
	        $.cookie("password", "", { expires: -1 });
	        window.location.href = "${pageContext.request.contextPath}/index.do";
	    } 
	}
	
	function loginSubmit(){
	var dataPara = $('#loginForm').serializeArray();
	$.ajax({
			url : '${pageContext.request.contextPath}/user.do?bgLogin',
			type : 'post',
			data : dataPara,
			success : function(data){
				var d = $.parseJSON(data);
				if(d.success==true){
					//save();
					window.location.href = "${pageContext.request.contextPath}/index.do";		
				}else{
					$("#username").focus();
					$("#username").val("");
					$("#password").val("");
					refreshVerifyCode();
					alert("用户名或密码错误，请重新输入！");
					return false;
					}
			}
		});
}
document.onkeydown=keyListener;
function keyListener(e){
	if(e.keyCode == 13){
		loginSubmit();
	}
}	
</script>

</head>

<body style="margin: 0px;padding: 0px;">
<div style="width:1440px;margin:0 auto;">     
<div class="top">
	<img src="resources/img/imgshop/logohair.png" alt="" style="margin:0.8rem 0 0 0.8rem;"/>
	<img src="resources/img/imgshop/logohelp.png" alt="" style="float: right;margin:3.5rem 2rem 0 0"/>
</div>
<div class="main">
  <div style="float:right;width:570px;margin-top:80px;margin-right:100px;">
  	  <div style="float:left">
	  <div style="width:405px;height:300px;background-color:rgb(243,251,254);
	  	border-radius:10px;">
	  <form id="loginForm" name="loginForm" method="post">
	    <!-- <table width="500" border="0" cellpadding="0" cellspacing="0">
	       <tr>
	        <td height="40" colspan="2"><a href="#">扫一扫登录</a></td>
	      </tr>
	      <tr> 
	        <td height="40">账户：
	        <input type="text" id="username" name="userName"  style="height:15px; width:100px;  " />
	        	<span id='errusername'></span>
	        </td>
	      </tr>
	      <tr>
	        <td height="40">密码：
	       <input type="password" id="password" name="userPassword" style="height:15px; width:100px; " /></td>
	      </tr>
	      <tr>
	        <td height="40" colspan="2">
	        	<input type="checkbox" id="ck_rmbUser"/>记住账号
	        </td>
	      </tr>
	      <tr>
	        <td height="40" >
	        	<input type="button" value="登录" id="loginSubmit"/>
	        
	        	<input type="button" value="忘记密码"/>
	        </td>
	      </tr>
	    </table> -->         
	    <ul class="ul_login">
	    	<li style="line-height: 18px;padding-top:4px;">
	    		<span style="margin-left:285px;"><a href="${pageContext.request.contextPath}/weChat.do?login">扫一扫登录</a></span>
	    	</li>
	    	<li><span style="font-size:1.6rem;font-weight: bold;color: rgb(143,143,143)">微商后台系统</span></li>
	    	<li><img src="resources/img/imgshop/loginuser.png" alt="" style="margin-left:4px"/><sapn style="margin-left:6px;">帐号</sapn>
	    		<input type="text" id="username" name="userName"  style="height:30px; width:270px;"/>
<!-- 	        	<span id='errusername'></span> -->
	    	</li>
	    	<li><img src="resources/img/imgshop/loginpwd.png" alt="" style="margin-left:8px;"/><span style="margin-left:8px;">密码</span>
	    		<input type="password" id="password" name="userPassword" style="height:30px; width:270px; " />
	    	</li>
	    	<li>
	    		<input type="checkbox" id="ck_rmbUser" style="margin-left:4.2rem;"/>记住账号
	    		<span style="margin-left:7rem;color: black">忘记密码</span>
	    	</li>
	    	<li>
	    		<div onclick="loginSubmit()" style="width:93px;line-height:35px;margin-left:65px;color:rgb(255,255,255);text-align:center;background: url('resources/img/imgshop/loginbtn.png');">
	    			<span style="">登录</span>
	    		</div>
	    	</li> 
	    </ul>      
	  </form>
	  </div>
	  <div class="ul_imglist" style="margin-left:80px;margin-top:32px;">
	  		<div>
	  		<img src="resources/img/imgshop/loginu1.png" alt="" />
	  		<img src="resources/img/imgshop/loginu2.png" alt="" />
	  		<img src="resources/img/imgshop/loginu3.png" alt="" />
	  		<img src="resources/img/imgshop/loginu4.png" alt="" />
	  		</div>
	  		<div>
	  			<img src="resources/img/imgshop/loginulist.png" alt="" style="margin:15px 0 0 240px"/>
	  		</div>
	  </div>   
	  </div>
	  <div style="float:right;margin-top:18px;">
	  	<img src="resources/img/imgshop/loginqrcode.png" alt="" />
	  </div>
	  <div style="clear: both"></div>
  </div>
  <div style="clear: both;"></div>
  <div style="margin-top:250px;text-align: center;">粤ICP备15028020号</div>
</div>
</div>
</body>
</html>