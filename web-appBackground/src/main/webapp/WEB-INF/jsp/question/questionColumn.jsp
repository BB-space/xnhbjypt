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
function submitQuestionForm(){
	var old_nickName = '${sessionScope.frontUserM.nickName}';
	var new_nickName = $('#nickName').val();
	
	if(new_nickName == old_nickName)
		return;
	
	var dataPara = $('#submitQuestionForm').serializeArray();
	$.ajax({
		url : '${pageContext.request.contextPath}/question.do?submitQuestion',
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
		<a href="<%=request.getContextPath()%>/safe.do?safeSetting" ><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico1.png" />安全设置<i></i></a>
		<a href="<%=request.getContextPath()%>/safe.do?userSetting"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico2.png" />用户设置<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?question"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico3.png" />发起问题<i></i></a>
		<a href="#" class="hover"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico4.png" />问题列表<i></i></a>
		<a href="#" class="bottom"><img src="<%=request.getContextPath()%>/resources/img/test/safe_ico5.png" />消息中心<i></i></a>
	</div>
	
	<div class="safe_section" id="question_column" >
	
		<div class="rightArea">
			<div class="Areatitle">
				<div class="title">
					<span class="bigTitle">
						<a href="#">
							未解决
						</a>
					</span>
				</div>
				<div class="notitle">
					<span class="bigTitle">
						<a href="#">
							已解决
						</a>
					</span>
				</div>
			</div>
			<div class="Areacon">
				<div class="entrustTen">
					<div id="Tenbody" class="Tenbody" style="display: block">
						<table style="border:none;">
							<tr>
								<th width="120">
									问题编号
								</th>
								<th width="178">
									问题类型
								</th>
								<th width="180">
									问题描述
								</th>
								<th width="180">
									问题回复
								</th>
								<th width="180">
									提交时间
								</th>
								<th width="100">
									问题状态
								</th>
								<th width="80">
									操作
								</th>
							</tr>
							
							<tr>
								<td colspan="7">
									<span class="no-data-tips">
										您暂时没有提问记录
									</span>
								</td>
							</tr>
							
							</tbody>
						</table>
						<div class="page">
							<ul>
							</ul>
							<input type="hidden" id="currentPage" value="0">
							<input type="hidden" id="type" value="1">
						</div>
					</div>
				</div>
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