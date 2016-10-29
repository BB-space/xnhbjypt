<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html style="background:#f1f6f9;">
<head>
<link href="<%=request.getContextPath()%>/resources/css/test/style1.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=request.getContextPath()%>/resources/css/test/style4.css" rel="stylesheet" type="text/css" media="all"/>
<jsp:include page="../test/head.jsp"></jsp:include>
<style type="text/css">

.newsad_left{
	width:767px;
	float:left;	
}
.newsad_right{
	width:270px;
	float:right;	
	padding-top:84px;
}
</style>
<script type="text/javascript">

$(function(){
	if('${sessionScope.frontUserM.realName}'){
		$('#user_setting1').hide();
		$('#user_setting2').hide();
		$('#safe_setting').show();
	}else {
		$('#user_setting1').show();
		$('#user_setting2').hide();
		$('#safe_setting').hide();
	}
	
	//修改菜单头图片
	$("#index").attr('src', "<%=request.getContextPath()%>/resources/img/test/navHome.png"); 
	$("#trade").attr('src', "<%=request.getContextPath()%>/resources/img/test/navTrade.png"); 
	$("#finance").attr('src', "<%=request.getContextPath()%>/resources/img/test/navFinance.png"); 
	$("#safe").attr('src', "<%=request.getContextPath()%>/resources/img/test/navSafe2.png"); 
	$("#news").attr('src', "<%=request.getContextPath()%>/resources/img/test/navNews.png"); 
});

//验证两次姓名一样
function checkRealName(){
	var realName = trim($('#realName').val());
	var realName2 = trim($('#realName2').val());
	
	if(realName == ''){
		$('#errorMessage').html('请填写姓名 ');
		return false;		
	}else if(realName2 != realName){
		$('#errorMessage').html('两次输入的姓名不一致');
		return false;
	}else {
		$('#errorMessage').html('');
		return true;
	}
}

//提交
function validateIdentity(){
	if(!checkRealName())
		return;
	
	var cardNumber = trim($('#cardNumber').val());
	if(cardNumber == ''){
		$('#errorMessage').html('请填写证件号码');		
		return;
	}
	
	var dataPara = $('#validateIdentityForm').serializeArray();
	$.ajax({
		url : '${pageContext.request.contextPath}/safe.do?validateIdentity',
		type : 'post',
		data : dataPara,
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success == true) {
				$('#user_setting1').hide();
				$('#user_setting2').show();
				$('#uid').html(d.obj.uid);
				$('#email').html(d.obj.email);
				$('#nickName').html(d.obj.nickName);
				$('#show_realName').html(d.obj.realName);
			} 
		}
	});
}


//修改用户昵称
function submitUserinfoForm(){
	var old_nickName = '${sessionScope.frontUserM.nickName}';
	var new_nickName = $('#nickName').val();
	
	if(new_nickName == old_nickName)
		return;
	
	var dataPara = $('#userinfoForm').serializeArray();
	$.ajax({
		url : '${pageContext.request.contextPath}/safe.do?updateNickName',
		type : 'post',
		data : dataPara,
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success == true) {
				console.info('${sessionScope.frontUserM.nickName}');
			} 
		}
	});
}

//显示哪部分
function showItem(item){
	/* $("#safe_setting_img").removeClass("hover");
	$("#user_setting_img").removeClass("hover");
	$("#ask_question_img").removeClass("hover");
	$("#question_list_img").removeClass("hover");
	$("#msg_center_img").removeClass("hover"); */
	
	$('#safe_setting').hide();
	$('#user_setting2').hide();
	$('#ask_question').hide();
	
	
	if(item == "safe"){
		$("#safe_setting_img").addClass("hover");
		$('#safe_setting').show();
	}else if(item == "user"){
		$("#user_setting_img").addClass("hover");
		$('#user_setting2').show();
	}else if(item == "ask"){
		$("#ask_question_img").addClass("hover");
		$('#ask_question').show();
	}else if(item == "question"){
		$("#question_list_img").addClass("hover");
	}else if(item == "msg"){
		$("#msg_center_img").addClass("hover");
	}
}

</script>
<style type="text/css">
.main_content {
	width: 940px;
	margin: 0 auto;
	margin-top:10px;
	background: #FFF;
}

.content_title {
	background:
		url("${pageContext.request.contextPath}/resource/images/drx_main_title_bg.jpg")
		no-repeat;
	height: 35px;
	width: 940px;
}
.content_txt {
	width: 900px;
	margin:0 auto;
	padding-bottom: 20px;
}
.content_txt span.show_info{
	float:right;
}
.content_txt ul li{
	border-bottom: 1px dashed #CCCCCC;
	line-height: 30px;
}
.page_btn{
	text-align: center;
}
</style>
</head>
<body style="background:#f1f6f9;">
<div class="main">
		<div class="content_color">
			<span class="blue_color">赛事新闻</span>
		</div>
		<div class="main_content">
			<div class="content_title">
				<p style="float: left; padding-left:60px; font-size: 14px; line-height: 32px; font-weight: bold; color: #fff;">
				${articleDetail.title}
				</p>  
				<div style="text-align: right;"><p style=" padding: 0 10px; font-size: 14px; line-height: 32px; font-weight: bold; color: #fff;">
				浏览量：${articleDetail.click}</p></div>
			</div>
			<div class="clearfix"></div>
			<div class="content_txt">
				${articleDetail.contentStr}  
			</div>
		</div>
	</div>

<!--footer start here-->
<jsp:include page="../test/footer.jsp"></jsp:include>
<!--footer end here-->


</body>
</html>