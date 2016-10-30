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
	width:280px;
	float:right;	
	padding-top:84px;
	white-space:nowrap;
	 overflow:hidden; 
	 text-overflow:ellipsis;
}
.newsad_pub li a{
	display:inline-block;
	max-width:160px;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;	
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
		
		<div class="newsad_right rt" >
			
			<div class="newsad_pub" >
				
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