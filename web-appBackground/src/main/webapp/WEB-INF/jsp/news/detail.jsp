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
	//修改菜单头图片
	$("#index").attr('src', "<%=request.getContextPath()%>/resources/img/test/navHome.png"); 
	$("#trade").attr('src', "<%=request.getContextPath()%>/resources/img/test/navTrade.png"); 
	$("#finance").attr('src', "<%=request.getContextPath()%>/resources/img/test/navFinance.png"); 
	$("#safe").attr('src', "<%=request.getContextPath()%>/resources/img/test/navSafe.png"); 
	$("#news").attr('src', "<%=request.getContextPath()%>/resources/img/test/navNews2.png"); 
});

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