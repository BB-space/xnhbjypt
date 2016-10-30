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
</head>
<body style="background:#f1f6f9;">
<div class="news_ad">
		
		<div class="newsad_left lt">
			
			<div class="title">新闻中心</div>
			<c:forEach items="${articleList}" var="item" varStatus="status">
			<div class="news_item">
				<a href="news.do?detail&id=${item.id}" class="photo"
					target="_blank"> <img
					src="<%=request.getContextPath()%>/resources/img/test/news_photo.jpg" />
				</a>

				<div class="name">
					<a href="news.do?detail&id=${item.id}">${item.title}</a>
				</div>
				<div class="tip"><a>${item.contentStr}</a></div>

				<div class="mof">
					<a href="#" class="go_btn">${item.typeName}</a>
					<div class="date">
						发表时间：
						${item.createDateTime}
					</div>
					<div class="read">浏览：${item.click}人阅读</div>
					<div class="tags">
						<span> 标签：</span> <span>活动</span> <em>|</em> <span>金币</span> <em>|</em>
						<span>到账</span>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</c:forEach>
			
			
			<div class="news_page">
							<c:if test="${currentPage==1}">
					<a class="prev" href="javascript:void(0)">上一页</a>
				</c:if>
				 <c:if test="${currentPage!=1}">
					<a class="prev"
						href="${pageContext.request.contextPath}/news.do?index&page=${currentPage-1}">上一页</a>
				</c:if> 
				
				<span class="current_page">${currentPage}</span>
				
				
					
				<c:if test="${currentPage==pageTimes}">
					<a class="next" href="javascript:void(0)">下一页</a>
				</c:if>
				 <c:if test="${currentPage!=pageTimes}">
					<a class="next"
						href="${pageContext.request.contextPath}/news.do?index&page=${currentPage+1}">下一页</a>
				</c:if> 
			</div>	
		
		</div>	
		
		<div class="newsad_right rt">
			
			<div class="newsad_pub">
				
				<div class="title2">
					<span class="tit">官方公告</span>
					<a href="#" target="_blank" class="more">更多</a>
				</div>
				
				<ul>
				<c:forEach items="${articleList}" var="item" varStatus="status">
					<li>
						<span>[ ${item.mdTime} ]</span>
						<a href="news.do?detail&id=${item.id}" target="_blank" class="name">${item.title}</a>
					</li>	
				</c:forEach>
				</ul>
					
			</div>
			
			<div class="newsad_pub">
				
				<div class="title2">
					<span class="tit">新闻资讯</span>
					<a href="#" target="_blank" class="more">更多</a>
				</div>
				
				<ul>
					<c:forEach items="${articleList2}" var="item" varStatus="status">
					<li>
						<span>[ ${item.mdTime} ]</span>
						<a href="news.do?detail&id=${item.id}" target="_blank" class="name">${item.title}</a>
					</li>	
				</c:forEach>
				</ul>
					
			</div>		

				
		</div>
		
		<div class="clear"></div>	
	</div>

<!--footer start here-->
<jsp:include page="../test/footer.jsp"></jsp:include>
<!--footer end here-->


</body>
</html>