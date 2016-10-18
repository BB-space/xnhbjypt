<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menunew.js" charset="UTF-8" type="text/javascript"></script>
<style type="text/css">
.maindiv{
	font-family: 'Microsoft YaHei';
}
.auditBtn , .rejectBtn{ 
	padding:2px 12px;
	border-radius:10px;
	margin-left:10px;
	color:#FFF;
	border: 1px solid #5AABE7;
	text-decoration: none;
	z-index: 999;
}
.auditBtn{
	background-color: #5AABE7;
}
.rejectBtn{
	border: 1px solid #5AABE7;
	color:#5AABE7;
}
.viewBtn{
	color:#5AABE7;
	text-decoration: none;
}
/**********/

/***************top***************/
.clear{
	clear:both;
}
.lBox{
	width:200px;
	height:90px;
 	background:#1A1A1A;
	float:left;
	text-align:center;
}
.rBox{
	float:left;
	width:80%;
}
.n-box{
	display:inline-block;
}
.title{
 	float:left;
	height:90px;
}
.table{
	display:table;
	width:100%;
	height:90px;
}
.table span {
	display:table-cell;
	vertical-align:middle;
}
.contant{
/* 	float:right; */
	position:absolute;
	right:20px;
	top:0px;
	z-index:1000;
}
.contant .box{
	display:inline-block;
}
.bor{
	height:5px;
	border-right:1px solid rgb(211,211,211);
}
#logoTitle{
	margin-left:20px;
	margin-right:30px;
	width:70%;
}
.v-vertical{
	width:1px;
	height:20px;
	border-right:1px solid #000;
	margin:0 5px;
}
.n-btn{
	border:1px solid rgba(211,211,211,0.5);
	background:#fff;
	border-radius:12px;
	font-size:12px;
	padding: 2px 12px;
	cursor:pointer;
	outline:none;
}
.logoutBtn{
	background:#000;
	color:#fff;
}

.pwd-box{
	display:none;
	position:fixed;
	width:430px;
	height:290px;
	top:150px;
	box-shadow:0 0 20px rgba(227,227,227,1);
	text-align:center;
	padding:30px 80px;
	background:#fff;
}
.pwd-box .box{
/* 	padding:20px 50px; */
}
.pwd-box .box .mod{
	color:#000;
	font-size:20px;
	font-weight:bold;
	margin:10px 0 30px 0 ;
}
.pwd-box .box .m-box{
	margin:30px 0;
}
.pwd-box .box .m-box .c-box{
	float:left;
}
.pwd-box .box .m-box .c-l{
 	width:120px;
 	text-align:right;
 	font-size:16px;
 	font-weight:bold;
 	color:#4D4D4D;
 	height:30px;
 	line-height:30px;
}
.pwd-box .box .m-box .c-r{
 	width:290px;
 	text-align:left;
 	padding-left:20px;
}
.m-input {
	border:1px solid #E3E3E3;
	border-radius:2px;
	height:25px;
	width:220px;
}
.pwd-box .box .m-box .c-r .m-btn{
	font-size:14px;
	color:#5AABE7;
	border:1px solid #5AABE7;
	border-radius:10px;
	background:#fff;
	padding:2px 20px;
	font-weight:bold;
	outline:none;
	cursor:pointer;
}
.pwd-box .box .m-box .c-r .m-save{
	background:#5AABE7;
	color:#fff;
	margin-right:30px;
}
.pwd-box .box .m-box .c-r .m-save-c{
	background:#E3E3E3;
	color:#5AABE7;
	margin-right:30px;
	border:1px solid #E3E3E3;
}
.tip{
	color:red;
	padding-left:45px;
}

/**********end******************/

.readAgreeBtn{font-size:14px;width:280px;background-color: #48a631;color:#FFF;cursor:pointer;margin:0 auto;text-align: center;padding:10px 0;border-radius:4px;}

</style>
</head>
<body class="" fit="true">
	<div style="background:rgb(255,255,255);height:90px;border-bottom:1px solid rgb(229,229,229)">
		<!-- <div class="n-box lBox"> -->
			<!-- <div class="table"><span><img src="resources/img/northImg/logo.png"></span></div> -->
		<!-- </div> -->
		<div class="n-box" id="n-rBox">
			<div class="title"><div class="table"><span><img src="resources/img/northImg/title.png" id="logoTitle"></span></div></div>
		</div>
		<div style="clear: both">
			<audio id="audio" controls="controls" style="display:none">
	  		<source src="<%=request.getContextPath()%>/resources/audio/duanxintishi.mp3" type="audio/mpeg">
			</audio>
		</div>
		<div class="contant">
				<div class="box"><div class="table"><span><img src="resources/img/northImg/person.png"></span></div></div>
				<div class="box"><div class="table"><span>${regM.mobile}</span></div></div>
				<div class="box"><div class="table"><span>
					<c:choose>
						<c:when test="${userM.userType == '4' || userM.userType == '10' }">店长</c:when>
						<c:when test="${userM.userType == '1' || userM.userType == '9' }">员工</c:when>
						<c:when test="${userM.userType == '11'}">分中心</c:when>
						<c:when test="${userM.userType == '12'}">总部</c:when>
						<c:when test="${userM.userType == '13'}">加盟商</c:when>
						<c:otherwise>普通用户</c:otherwise>
					</c:choose>
				</span></div></div>
				<div class="box"><div class="table"><span><div class="v-vertical"></div></span></div></div>
				<c:if test="${userM.userType == '4' || userM.userType == '10' 
					|| userM.userType == '1' || userM.userType == '9'}">
					<div class="box"><div class="table"><span><img src="resources/img/northImg/shop.png"></span></div></div>
					<div class="box"><div class="table"><span>${userM.shopName }</span></div></div>
					<div class="box"><div class="table"><span><div class="v-vertical"></div></span></div></div>
				</c:if>
				<!-- <div class="box"><div class="table"><span><input type="button" id="modifyPwd" class="n-btn" value="修改密码" onclick="modifyPwd()"></span></div></div> -->
				<!-- <div class="box"><div class="table"><span><div class="v-vertical"></div></span></div></div> -->
				<div class="box"><div class="table"><span><input type="button" id="logout" class="n-btn logoutBtn" value="退出登录" onclick="logout(true)"></span></div></div>
	<!-- 			<ul class="ul_app"> -->
	<!-- 				<li><img alt="" src="resources/img/imgshop/logo.png" style="margin-top:0.4rem;"></li> -->
	<!-- 				<li style="margin-left:0.5rem;margin-right:0.5rem;"> -->
	<%-- 				<c:choose> --%>
	<%-- 				<c:when test="${userM.cityGroup!=null && userM.text=='区域门店'}"> --%>
	<!-- 					<div style="margin-top:20px;font-size:1rem"> -->
	<!-- 					<select id="sel"> -->
	<!-- 						<option  value="0" selected>请选择门店</option> -->
	<%-- 						<c:forEach items="${shopList }" var="t"> --%>
	<%-- 							<option value="${t.shortNumber }" id="${t.shortNumber }" <c:if test="${companyCode==t.shortNumber }">selected="selected"</c:if> >${t.shopName }</option> --%>
	<%-- 						</c:forEach> --%>
	<!-- 					</select> -->
	<!-- 					</div> -->
	<%-- 				</c:when> --%>
	<%-- 				<c:when test="${userM.cityGroup==null&& userM.text=='区域门店'}"> --%>
	<!-- 					<div style="margin-top:20px;font-size:1rem"> -->
	<!-- 					<select id="sel"> -->
	<!-- 						<option value="0" selected>请选择门店</option> -->
	<%-- 						<c:forEach items="${shopList }" var="t"> --%>
	<%-- 							<option value="${t.shortNumber }" id="${t.shortNumber }" <c:if test="${companyCode==t.shortNumber }">selected="selected"</c:if> >${t.shopName }</option> --%>
	<%-- 						</c:forEach> --%>
	<!-- 					</select> -->
	<!-- 					</div> -->
	<%-- 				</c:when> --%>
	<%-- 				<c:otherwise> --%>
	<%-- 					<div style="margin-top:20px;font-size:1rem">${userM.shopName}</div> --%>
	<%-- 				</c:otherwise> --%>
	<%-- 				</c:choose> --%>
	<%-- 					<div style="margin-top:10px;cursor: pointer;font-size:0.5rem" onclick="logout(true);">  ${userM.userName}   退出登录</div></li> --%>
	<%-- 				<li style="margin-left:0.5rem;"><div style="margin-top:30px;">【${userM.shopName}】${userM.userName}</span></div></li> --%>
	<%-- 				<li style="margin-left:1rem;"><div style="margin-top:30px;cursor: pointer" onclick="logout(true);">退出登录</div></li> --%>
	<!-- 			</ul> -->
			</div>
	</div>
	<div class="pwd-box" id="pwd-box">
		<div class="box">
			<div class="mod">修改密码</div>
			<div class="m-box">
				<div class="c-box c-l">当前密码</div>
				<div class="c-box c-r"><input type="password" id="original" onblur="isNull(this)" class="m-input"></div>
				<div class="clear"></div>
				<div id="org_tip" class="tip"></div>
			</div>
			<div class="m-box">
				<div class="c-box c-l">新密码</div>
				<div class="c-box c-r"><input type="password" id="newPwd" onblur="isPasswd(this)" class="m-input"></div>
				<div class="clear"></div>
				<div id="new_tip" class="tip"></div>
			</div>
			<div class="m-box">
				<div class="c-box c-l">确认密码</div>
				<div class="c-box c-r"><input type="password" id="newPwdConfim" onblur="isSame(this)" class="m-input" disabled="disabled"></div>
				<div class="clear"></div>
				<div id="confim_tip" class="tip"></div>
			</div>
			<div class="m-box">
				<div class="c-box c-l"></div>
				<div class="c-box c-r">
					<input type="button" value="保存" onclick="" class="m-btn m-save-c" id="saveBtn">
					<input type="button" value="取消" onclick="modifyClose()" class="m-btn">
				</div>
				<div class="clear"></div>
				<div id="save_tip" class="tip"></div>
			</div>
		</div>
	</div>
	<div class="maindiv" region="center" border="false" style="overflow: auto;">
		<div style="text-align: center;">
			<img src="${pageContext.request.contextPath}/resources/css/login/img/auditWait.png" style="margin-top:60px;">
			<p style="font-size:14px;font-weight: bold;margin-top:32px;">正在审核您的资料，请随时关注审核结果</p>
			<div class="readAgree" style="margin-top:38px;">
				<div id="btnOk" class="readAgreeBtn" onclick="modifyInfo();">修改资料</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" charset="UTF-8">
	var websocket;
	var isCreatw = false;
	var title="";
	var win;
	var input;
	var isQj = true;
	var toUser="";
		function logout(b) {
			$.cookie("usertype", null);
			$.post('user.do?logout', function() {
				if (b) {
					window.location.href = "${pageContext.request.contextPath}/indexNew.jsp";
				} else {
					loginAndRegDialog.dialog('open');
				}
			});
		}

		function userInfo() {
			addTabFun({
				src : 'userController.do?userInfo',
				title : '个人信息'
			});
		}
		function bofang(){
			//alert("开始播放声音！");
			var myVideo=document.getElementById("audio");
			myVideo.play();
			
		}
		
		$(document).ready(function(){
			//initWebSocket();
		 	
		});
		
		$(function() {
			var bodyWidth = Number(window.innerWidth);
			$("#n-rBox").css('width',(bodyWidth-220));
			var pLeft = (bodyWidth-600)/2+"px";
			$("#pwd-box").css("left",pLeft);
			$("#sel").change(function(){
				var companyCode=$("#sel option:selected").attr("id");
				$.ajax({
					url : '${pageContext.request.contextPath}/user.do?bgLogins',
					type : 'post',
					data : {
						companyCode:companyCode
					},
					success : function(data){
						var d = $.parseJSON(data);
						 if(d.success==true){
							window.location.href = "${pageContext.request.contextPath}/index.do";		
						}else{
							alert(d.msg);
						}
					}
				});
			});
			
		});
		
		function confim(){
			var original = $("#original").val();
			var newPwd = $("#newPwd").val();
			var newPwdConfim = $("#newPwdConfim").val();
			if(original == '' || original == null) {
				$("#org_tip").html("请输入您当前的密码");
				return ;
			}
			$.post('user.do?modifyPwd',
					{'original':original,'newPwd':newPwd,'newPwdConfim':newPwdConfim},
					function(data){
				var d = $.parseJSON(data);
				if(d.success){
//	 				$("#save_tip").html(d.msg+"<br>");
					$("#pwd-box").hide();
				}else {
					$("#save_tip").html(d.msg);
				}
			});
		}
		
		function isNull(t){
			var org = t.value;
			if(org == '' || org == null) {
				$("#org_tip").html("请输入您当前的密码");
				$("#newPwdConfim").val("");
				$("#newPwdConfim").attr("disabled",true);
				$("#saveBtn").removeClass("m-save");
				$("#saveBtn").addClass("m-save-c");
				$("#saveBtn").removeAttr("onclick");
				return false;
			}
			$("#org_tip").html("");
			return true;
		}
		
		function isPasswd(s){
			var pwd = s.value;
			var patrn = /^(\w){6,20}$/;
			if(!patrn.exec(pwd)){
				$("#new_tip").html("数字、字母、下划线组成6~16个字符");
				$("#newPwdConfim").val("");
				$("#newPwdConfim").attr("disabled",true);
				$("#saveBtn").removeClass("m-save");
				$("#saveBtn").addClass("m-save-c");
				$("#saveBtn").removeAttr("onclick");
				return false;
			}
			$("#new_tip").html("");
			$("#newPwdConfim").attr("disabled",false);
			return true;
		}
		
		function isSame(t){
			var confim = t.value;
			var pwd = $("#newPwd").val();
			if(confim != pwd) {
				$("#confim_tip").html("两次输入的密码不一致");
				$("#saveBtn").removeClass("m-save");
				$("#saveBtn").addClass("m-save-c");
				$("#saveBtn").removeAttr("onclick");
				return false;
			}
			$("#confim_tip").html("");
			$("#saveBtn").removeClass("m-save-c");
			$("#saveBtn").addClass("m-save");
			$("#saveBtn").attr("onclick","confim()");
			return true;
		}
		
		function modifyPwd(){
			$("#original").val("");
			$("#newPwd").val("");
			$("#newPwdConfim").val("");
			$("#newPwdConfim").attr("disabled",true);
			$("#saveBtn").removeClass("m-save");
			$("#saveBtn").addClass("m-save-c");
			$("#saveBtn").removeAttr("onclick");
			$("#confim_tip").html("");
			$("#new_tip").html("");
			$("#org_tip").html("");
			$("#save_tip").html("");
			$("#pwd-box").show();
		}
		
		function modifyClose(){
			$("#pwd-box").hide();
		}
	function modifyInfo(){
		window.location.href="${pageContext.request.contextPath}/joinUser.do?register&state=0";
	}
	</script>
</body>
</html>