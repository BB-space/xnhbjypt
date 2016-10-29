<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html style="background:#f1f6f9;">
<head>
<link href="<%=request.getContextPath()%>/resources/css/test/style1.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=request.getContextPath()%>/resources/css/test/style4.css" rel="stylesheet" type="text/css" media="all"/>
<jsp:include page="../test/head.jsp"></jsp:include>
<style type="text/css">
.coinBoxBody {
	background: none repeat scroll 0 0 #ffffff;
	*padding: 4px 3px;
	padding: 0 10px;
}
.security li{
    padding: 10px 0;
}
li span.c1 {
    display: inline-block;
    width: 180px;
    text-align: right;
    padding-right: 20px;
}

.inputStyle {
    height: 25px;
}
.red {
    color: red;
}
.buttonblue3 {
	display: inline-block;
	font-weight: 700;
	font-size: 14px;
	color: #fff;
	text-align: center;
	width: 120px;
	height: 32px;
	line-height: 32px;
	background: #ec5322;
	margin-left: 120px;
	border-radius: 3px
}
//-----------
.Areacon {
	font-size: 14px;
	background: #fff;
	border: 1px solid #e1e1e2;
	padding: 30px 30px 0;
	float: left;
	width: 953px;
	min-height: 542px;
}
.clear {
    zoom: 1;
    clear: both;
}
.Tentitle {
	line-height: 35px;
	font-weight: 700;
	font-size: 14px;
	padding: 10px 10px;
	background: #fff;
}
.coinBoxBody {
	background: none repeat scroll 0 0 #ffffff;
	*padding: 4px 3px;
	padding: 0 10px;
}
.userSetBtn {
	display: inline-block;
	font-weight: 700;
	font-size: 14px;
	color: #fff;
	text-align: center;
	width: 120px;
	height: 32px;
	line-height: 32px;
	background-color: #66b2e3;
	border-radius: 3px;
}

//question
.initiateProblem{
	background:none repeat scroll 0 0 #ffffff;
	padding:0 10px;
}
.initiateProblem .specificContent{
	width:740px;
	padding-left:20px;
	padding-top:10px;
	height: 250px;
}
.questionButtonblue{
	display:inline-block;
	font-weight:700;
	font-size:14px;
	color:#fff;
	text-align:center;
	width:150px;
	height:32px;
	line-height:32px;
	background-color:#66b2e3;
	margin:30px 0 76px 180px;
	border-radius: 3px;
}
pan.c2 {
    display: inline-block;
    font-size: 14px;
    font-weight: 700;
    padding-left: 20px;
    text-align: left;
}

#specificContent ul li {
    line-height: 35px;
    float: left;
    padding-bottom: 10px;
}

</style>
<script type="text/javascript">

$(function(){
	//修改菜单头图片
	$("#index").attr('src', "<%=request.getContextPath()%>/resources/img/test/navHome.png"); 
	$("#trade").attr('src', "<%=request.getContextPath()%>/resources/img/test/navTrade.png"); 
	$("#finance").attr('src', "<%=request.getContextPath()%>/resources/img/test/navFinance.png"); 
	$("#safe").attr('src', "<%=request.getContextPath()%>/resources/img/test/navSafe2.png"); 
	$("#news").attr('src', "<%=request.getContextPath()%>/resources/img/test/navNews.png"); 
});




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
		<a href="<%=request.getContextPath()%>/safe.do?questionColumn"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico4.png" />问题列表<i></i></a>
		<a href="<%=request.getContextPath()%>/safe.do?message" class="bottom"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico5.png" />消息中心<i></i></a>
	</div>
	
	<div class="safe_section" id="ask_question" style="display: block;">
	
		<div class="initiateProblem">
			<div class="specificContent">
				<form method="post" id="askQuestionForm" >
				<ul>
					<li>
						<span class="c1">
							<span class="red">*</span>
							问题类型:
						</span>
						<span class="c2">
							<select id="questionType">
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
								<textarea onblur="trimValue(this);" rows="4" cols="50" class="textarea" id="desc" style="resize: none"></textarea>
							</span>
						</span>
					</li>
					<li>
						<span class="c1">
							<span class="red">*</span>
							姓名:
						</span>
						<span class="c2">
							<input type="text" onblur="trimValue(this);" name="" value="李时岐" class="blankInformation" id="name">
						</span>
					</li>
					<li>
						<span class="c1">
							<span class="red">*</span>
							联系电话:
						</span>
						<span class="c2">
							<input type="text" onkeyup="value=value.replace(/[^\d]/g,'')" name="" value="" class="blankInformation" id="phone">
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