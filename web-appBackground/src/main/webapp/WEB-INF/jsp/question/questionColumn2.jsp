<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html style="background:#f1f6f9;">
<head>

<link href="<%=request.getContextPath()%>/resources/css/test/style1.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=request.getContextPath()%>/resources/css/test/style4.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=request.getContextPath()%>/resources/css/test/question.css" rel="stylesheet" type="text/css" media="all"/>
<link rel="icon" href="#favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="#favicon.ico" type="image/x-icon">
<link href="<%=request.getContextPath()%>/resources/commonfiles/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" type="text/css" media="screen, projection">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/common.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/commonfiles/question.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/jquery-1.8.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/script.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/jquery-ui-1.10.4.custom.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/coincommon.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/highstock.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/exporting.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/jquery.SuperSlide.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/account.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/user.js"></script>
<script src="<%=request.getContextPath()%>/resources/commonfiles/fin.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resources/commonfiles/jquery.flot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/jquery.placeholder-1.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/language_cn.js"></script>

<jsp:include page="../test/head.jsp"></jsp:include>
<style type="text/css">
.rightArea {
	width: 850px;
	min-height: 560px;
	float: left;
	position: relative;
	margin-top: 43px;
	padding-left: 30px;
	padding-bottom: 65px;
}
.Areacon {
	font-size: 14px;
	background: #fff;
	border: 1px solid #e1e1e2;
	padding: 50px 30px 0;
	float: left;
	width: 820px;
	min-height: 542px;
}
.Areatitle {
	line-height: 45px;
	font-weight: 700;
	font-size: 14px;
	position: absolute;
	padding-left: 30px;
	top: -43px;
	left: 0;
}
.title {
	height: 45px;
	line-height: 45px;
	min-width: 150px;
	color: #000;
	background: #fff;
	display: inline;
	cursor: pointer;
	font-size: 16px;
	text-align: center;
	border: 1px solid #e1e1e2;
	border-style: solid solid none solid;
	float: left;
}
 .rightArea .Areatitle .notitle {
	height: 35px;
	line-height: 35px;
	min-width: 150px;
	color: #7a7a7a;
	background: #fff;
	display: inline;
	cursor: pointer;
	font-size: 16px;
	text-align: center;
	border: 1px solid #e1e1e2;
	float: left;
	margin-top: 9px;
}
.bigTopTab {
	height: 40px;
	background: #fff;
}

 .accountfilter {
	line-height: 40px;
	color: #747373;
}
.coinBoxBody {
	background: none repeat scroll 0 0 #ffffff;
	*padding: 4px 3px;
	padding: 0 10px;
}
.riskArea {
	background: none repeat scroll 0 0 #fae5e7;
	padding: 10px 0;
	vertical-align: middle;
}
.rightArea .riskArea span.hinttext1 {
	vertical-align: middle;
	color: #777783;
	font-size: 14px;
	line-height: 20px;
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

//删除问题
function cancelQuestion(item){
	var dataPara = {questionId:item};
	$.ajax({
		url : '${pageContext.request.contextPath}/question.do?cancelQuestion',
		type : 'post',
		data : dataPara,
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success == true) {
				window.location.href = "<%=request.getContextPath()%>/question.do?questionColumn2";
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
	
	
	<div class="rightArea">
			<div class="Areatitle">
				<div class="notitle">
					<span class="bigTitle">
						<a href="<%=request.getContextPath()%>/question.do?questionColumn">
							未解决
						</a>
					</span>
				</div>
				<div class="title">
					<span class="bigTitle">
						<a href="<%=request.getContextPath()%>/question.do?questionColumn2">
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
							
							<c:forEach items="${questionList}" var="item" varStatus="status">
							<tr>
								<td class="gray" width="80">${item.questionNumber}</td>
								<td class="gray" width="110">${item.questionType}</td>
								<td class="gray" width="150">${item.questionCentent}</td>
								<td class="gray" width="150">${item.replyCentent}</td>
								<td class="gray" width="150">${item.createDateTime}</td>
								<td class="gray" width="80">${item.status}</td>
								<td class="gray" width="60">
									<a onclick="javascript:cancelQuestion('${item.questionId}');" href="javascript:void(0);">
										删除
									</a>
								</td>
							</tr>
							</c:forEach>
							
							<!-- <tr>
								<td colspan="7">
									<span class="no-data-tips">
										您暂时没有提问记录
									</span>
								</td>
							</tr> -->
							
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
	
	<div class="clear"></div>
</div>

<!--footer start here-->
<jsp:include page="../test/footer.jsp"></jsp:include>
<!--footer end here-->


</body>
</html>