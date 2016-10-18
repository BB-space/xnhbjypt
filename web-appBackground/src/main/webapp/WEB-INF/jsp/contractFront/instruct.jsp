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
		<div class="theCenterBox">	
			<div class="read" style="">请阅读协议</div>
			
			<div class="readContent">
				<div class="readLeft" style="overflow-x:hidden">
					<%-- <textarea readonly="readonly" rows="24" cols="" style="width:100%;">${left.content}</textarea> --%>
					${left.content}
				</div>
				<div class="readRight" style="overflow-x:hidden">
					<%-- <textarea readonly="readonly" rows="24" cols="" style="width:100%;">${right.content}</textarea> --%>
					${right.content}
				</div>
				<div class="clearfix"></div>
			</div>	
			<div class="readTip">
				<p>请仔细阅读"<span>丝域门店天猫商城代销商品协议</span>"、"<span>丝域门店天猫商城代销结算协议</span>"
				、"<span>入驻团购申请书</span>"、"<span>线上团购奖罚规定 </span>"合同协议
				</p>
			</div>
			<div class="readAgree">
				<div id="btnOk" class="readAgreeBtn">同意并注册(3)</div>
			</div>
		</div>
		
	</div>
	<script type="text/javascript">
	var wait =3; //设置秒数(单位秒)
	var secs = 0;          
	for(var i=1;i<=wait;i++) { 
	 window.setTimeout("sTimer("+i+")",i*1000);
	} 
	function sTimer(num) {
	 if(num==wait)  {
	  document.getElementById("btnOk").style.backgroundColor='#48a631';
	  document.getElementById("btnOk").innerHTML=" 同意并注册 "; 
	  document.getElementById("btnOk").disabled=false;
	  addEvent(document.getElementById("btnOk"),"click",agree);
	 }else{ 
	  secs=wait-num;
	  document.getElementById("btnOk").innerHTML="同意并注册("+secs+")"; 
	 } 
	} 
    function addEvent(element,e,fn) {
      if(element.addEventListener) {
        element.addEventListener(e,fn,false);
      }
      else {
        element.attachEvent("on"+e,fn);
      }
    }
	</script>
</body>
</html>