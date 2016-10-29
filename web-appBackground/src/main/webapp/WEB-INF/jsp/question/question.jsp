<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html style="background:#f1f6f9;">
<head>
<link href="<%=request.getContextPath()%>/resources/css/test/style1.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=request.getContextPath()%>/resources/css/test/style4.css" rel="stylesheet" type="text/css" media="all"/>
<jsp:include page="../test/head.jsp"></jsp:include>
<link href="<%=request.getContextPath()%>/resources/css/test/question.css" rel="stylesheet" type="text/css" media="all"/>
<script type="text/javascript">

$(function(){
	//修改菜单头图片
	$("#index").attr('src', "<%=request.getContextPath()%>/resources/img/test/navHome.png"); 
	$("#trade").attr('src', "<%=request.getContextPath()%>/resources/img/test/navTrade.png"); 
	$("#finance").attr('src', "<%=request.getContextPath()%>/resources/img/test/navFinance.png"); 
	$("#safe").attr('src', "<%=request.getContextPath()%>/resources/img/test/navSafe2.png"); 
	$("#news").attr('src', "<%=request.getContextPath()%>/resources/img/test/navNews.png"); 
});

//提交问题
function submitQuestion(){
	var questionType = $('#questionType').val();
	var questionCentent = $('#questionCentent').val();
	var questionUser = trim($('#questionUser').val());
	var question_mobile = $('#question_mobile').val();
	if(questionType == "-1"){
		$('#errorMsg').html('请选择问题类型。');
		return;
	}
	if(questionCentent == ""){
		$('#errorMsg').html('请输入问题描述。 ');
		return;
	}
	if(questionUser == ""){
		$('#errorMsg').html('请输入姓名。  ');
		return;
	}
	if(question_mobile == ""){
		$('#errorMsg').html('请输入正确的电话号码。  ');
		return;
	}
	
	var dataPara = $('#submitQuestionForm').serializeArray();
	$.ajax({
		url : '${pageContext.request.contextPath}/question.do?submitQuestion',
		type : 'post',
		data : dataPara,
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success == true) {
				window.location.href = "${pageContext.request.contextPath}/question.do?questionColumn";
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
		<a href="<%=request.getContextPath()%>/safe.do?safeSetting" ><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico1.png" />安全设置<i></i></a>
		<a href="<%=request.getContextPath()%>/safe.do?userSetting"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico2.png" />用户设置<i></i></a>
		<a href="#" class="hover"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico3.png" />发起问题<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?questionColumn"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico4.png" />问题列表<i></i></a>
		<a href="#" class="bottom"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico5.png" />消息中心<i></i></a>
	</div>
	
	<div class="safe_section" id="ask_question" style="display: block;">
	
		<div class="initiateProblem">
			<div class="specificContent">
				<form method="post" id="submitQuestionForm" >
				<ul>
					<li>
						<span class="c1">
							<span class="red">*</span>
							问题类型:
						</span>
						<span class="c2">
							<select id="questionType" name="questionType">
								<option value="-1">
									---请选择问题类型---
								</option>
								
									<option value="1">充值问题</option>
								
									<option value="2">提现问题</option>
								
									<option value="3">其它问题</option>
								
							</select>
						</span>
					</li>
					<li>
						<span style="float:left;" class="c1">
							<span class="red">*</span>
							问题描述:
						</span>
						<span style="float:left;" id="" class="c2">
							<span>
								<textarea id="questionCentent" name="questionCentent" rows="4" cols="50" class="textarea" id="desc" style="resize: none"></textarea>
							</span>
						</span>
					</li>
					<li>
						<span class="c1">
							<span class="red">*</span>
							姓名:
						</span>
						<span class="c2">
							<input id="questionUser" name="questionUser" type="text" class="blankInformation">
						</span>
					</li>
					<li>
						<span class="c1">
							<span class="red">*</span>
							联系电话:
						</span>
						<span class="c2">
							<input id="question_mobile" name="mobile" type="text" onkeyup="value=value.replace(/[^\d]/g,'')"  class="blankInformation" >
						</span>
					</li>
				</ul>
				</form>
			</div>
			<div>
				<span style="color: red;padding-left: 210px;" id="errorMsg">&nbsp;</span>
				<br>
				<a onclick="javascript:submitQuestion();" class="questionButtonblue" href="javascript:void(0)">
					提交问题
				</a>
			</div>
		</div>
	
	</div>
	<div class="clear"></div>
</div>

<!--footer start here-->
<jsp:include page="../test/footer.jsp"></jsp:include>
<!--footer end here-->


</body>
</html>