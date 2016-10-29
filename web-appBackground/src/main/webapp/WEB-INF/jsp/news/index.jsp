<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html style="background: #f1f6f9;">
<head>
<link href="<%=request.getContextPath()%>/resources/css/test/style1.css"
	rel="stylesheet" type="text/css" media="all" />
<link href="<%=request.getContextPath()%>/resources/css/test/style4.css"
	rel="stylesheet" type="text/css" media="all" />
<jsp:include page="../test/head.jsp"></jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/pager/jqueryPager.css">
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/pager/jqueryPager.js"> 
</script>	           
<style type="text/css">
.main_content {
	width: 940px;
	margin: 0 auto;
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

<style type="text/css">
.coinBoxBody {
	background: none repeat scroll 0 0 #ffffff;
	*padding: 4px 3px;
	padding: 0 10px;
}

.security li {
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

//
question
.initiateProblem {
	background: none repeat scroll 0 0 #ffffff;
	padding: 0 10px;
}

.initiateProblem .specificContent {
	width: 740px;
	padding-left: 20px;
	padding-top: 10px;
	height: 250px;
}

.questionButtonblue {
	display: inline-block;
	font-weight: 700;
	font-size: 14px;
	color: #fff;
	text-align: center;
	width: 150px;
	height: 32px;
	line-height: 32px;
	background-color: #66b2e3;
	margin: 30px 0 76px 180px;
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
	$("#safe").attr('src', "<%=request.getContextPath()%>/resources/img/test/navSafe.png"); 
	$("#news").attr('src', "<%=request.getContextPath()%>/resources/img/test/navNews2.png");
	});

	//验证两次姓名一样
	function checkRealName() {
		var realName = trim($('#realName').val());
		var realName2 = trim($('#realName2').val());

		if (realName == '') {
			$('#errorMessage').html('请填写姓名 ');
			return false;
		} else if (realName2 != realName) {
			$('#errorMessage').html('两次输入的姓名不一致');
			return false;
		} else {
			$('#errorMessage').html('');
			return true;
		}
	}

	//提交
	function validateIdentity() {
		if (!checkRealName())
			return;

		var cardNumber = trim($('#cardNumber').val());
		if (cardNumber == '') {
			$('#errorMessage').html('请填写证件号码');
			return;
		}

		var dataPara = $('#validateIdentityForm').serializeArray();
		$
				.ajax({
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
	function submitUserinfoForm() {
		var old_nickName = '${sessionScope.frontUserM.nickName}';
		var new_nickName = $('#nickName').val();

		if (new_nickName == old_nickName)
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
	function showItem(item) {
		/* $("#safe_setting_img").removeClass("hover");
		$("#user_setting_img").removeClass("hover");
		$("#ask_question_img").removeClass("hover");
		$("#question_list_img").removeClass("hover");
		$("#msg_center_img").removeClass("hover"); */

		$('#safe_setting').hide();
		$('#user_setting2').hide();
		$('#ask_question').hide();

		if (item == "safe") {
			$("#safe_setting_img").addClass("hover");
			$('#safe_setting').show();
		} else if (item == "user") {
			$("#user_setting_img").addClass("hover");
			$('#user_setting2').show();
		} else if (item == "ask") {
			$("#ask_question_img").addClass("hover");
			$('#ask_question').show();
		} else if (item == "question") {
			$("#question_list_img").addClass("hover");
		} else if (item == "msg") {
			$("#msg_center_img").addClass("hover");
		}
	}
</script>
</head>
<body style="background: #f1f6f9;">
	<div class="news_ad">
		<div class="title">新闻中心</div>


		<c:forEach items="${articleList}" var="item" varStatus="status">
			<div class="news_item">
				<a href="newsController.do?detail&id=${item.id}" class="photo"
					target="_blank"> <img
					src="<%=request.getContextPath()%>/resources/img/test/news_photo.jpg" />
				</a>

				<div class="name">
					<a href="newsController.do?detail&id=${item.id}">${item.title}</a>
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

		<div class="clear"></div>
	</div>

	<!--footer start here-->
	<jsp:include page="../test/footer.jsp"></jsp:include>
	<!--footer end here-->


</body>
</html>