<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js"
	charset="UTF-8" type="text/javascript"></script>

<style type="text/css">
.reserTop {
	font-size: 1.5rem;
	margin: 0.2rem;
}

.submit {
	border: solid 2px rgb(57, 94, 138);
	width: 5em;
	height: 2em;
	background-color: rgb(79, 129, 189);
	color: white;
	margin-top: 0.2rem;
}

.font {
	font-size: 0.8rem;
	text-align: center;
}

.stamp {
	width: 40%;
	margin: 1rem 2rem;
	border: 1px red solid;
}
</style>
<script type="text/javascript">
	function cancelReservation(val) {
		$.messager
				.confirm(
						'请确认',
						'您确定要取消此预约吗？',
						function(data) {
							if (data) {
								window.location.href = "reservation.do?addCancelReservation&id="
										+ val;
							}
						});
	}

	//获取窗口的高度 
	var windowHeight;
	//获取窗口的宽度 
	var windowWidth;
	//获取弹窗的宽度 
	var popWidth;
	//获取弹窗高度 
	var popHeight;
	function init() {
		windowHeight = $(window).height();
		windowWidth = $(window).width();
		popHeight = $(".window").height();
		popWidth = $(".window").width();
	}

	//关闭窗口的方法 
	function closeWindow() {
		$(".title img").click(function() {
			$(this).parent().parent().hide("slow");
		});
	}

	//弹出预约时间
	function reservation(val) {
		init();
		id = val;
		//计算弹出窗口的左上角Y的偏移量 
		var popY = (windowHeight - popHeight) / 8;
		var popX = (windowWidth - popWidth) / 8;
		//设定窗口的位置 
		$("#reservationTime").css("top", popY).css("left", popX).slideToggle(
				"slow");

	}

	var url;//存储跳转路径
	//判断手机号是否存在，且该门店所属
	function urlTrun(url, mobile) {
		$.post('user.do?findUser', {
			"mobile" : mobile
		}, function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				window.location.href = url;
			} else {
				alert("该手机用户不存在！");
			}
		});
	}

	function no() {
		// 		window.location.href = "reservation.do?reservationInfo";
		var mobile = $("#mobile").val();
		url = "reservation.do?reservationInfo&mobile=" + mobile;
		if (mobile != "") {
			urlTrun(url, mobile);//判断手机号是否存在，且该门店所属
		} else {
			window.location.href = url;
		}
	}
	function sure() {
		// 		$("#reservationBody").load("reservation.do?reservationSure",null,null); 
		var mobile = $("#mobile").val();
		url = "reservation.do?reservationSure&mobile=" + mobile;
		if (mobile != "") {
			$.post('user.do?findUser', {
				"mobile" : mobile
			}, function(data) {
				var d = $.parseJSON(data);
				if (d.success) {
					$("#reservationBody").load(url, null, null);
				} else {
					alert("该手机用户不存在！");
				}
			});
		} else {
			$("#reservationBody").load(url, null, null);
		}
	}
	function cancels() {
		// 		$("#reservationBody").load("reservation.do?reservationCancel",null,null); 
		var mobile = $("#mobile").val();
		url = "reservation.do?reservationCancel&mobile=" + mobile;
		if (mobile != "") {
			$.post('user.do?findUser', {
				"mobile" : mobile
			}, function(data) {
				var d = $.parseJSON(data);
				if (d.success) {
					$("#reservationBody").load(url, null, null);
				} else {
					alert("该手机用户不存在！");
				}
			});
		} else {
			$("#reservationBody").load(url, null, null);
		}
	}

	//将时间转换成yyyy-MM-dd
	Date.prototype.Format = function(fmt) {
		var o = {
			"M+" : this.getMonth() + 1, //月份 
			"d+" : this.getDate(), //日 
			"h+" : this.getHours(), //小时 
			"m+" : this.getMinutes(), //分 
			"s+" : this.getSeconds(), //秒 
			"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
			"S" : this.getMilliseconds()
		//毫秒 
		};
		if (/(y+)/.test(fmt))
			fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
						: (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	};

	//触发日历控件
	function onSelect(date) {
		date = date.Format("yyyy-MM-dd");
// 		window.location.href = "reservation.do?showReservationCancel&time="+ date;
		var mobile = $("#mobile").val();
		url = "reservation.do?showReservationCancel&time=" + date + "&mobile="+ mobile;
		if (mobile != "") {
			urlTrun(url, mobile);
		} else {
			window.location.href = url;
		}

	}
</script>
</head>
<body class="easyui-layout">
	<div style="overflow: auto; height: 100%;" id="reservationBody">
		<div style="color: rgb(59, 153, 204)">
			<div class="reserTop ys">
				今日预约 <span
					style="float: right; font-size: 1rem; padding-top: 0.3rem;">
					<span style="color: #000;">手机号：</span> <input name="mobile"
					id="mobile" class="easyui-validatebox" type="text"
					vlaue="${mobile }" /> <input name="useDateTime"
					class="easyui-datebox" type="text" data-options="onSelect:onSelect"
					id="dateTime" value="${time }" />
				</span>
			</div>
		</div>
		<table width="100%" id="content">
			<tr>
				<td>
					<div class="reservation">
						<div onclick="no()"
							style="background-color: rgb(59, 153, 204); color: white;">
							<div align="center" class="reserTop">
								未应约
								<%-- <span style="float: right;font-size: 1rem;padding-top: 0.3rem;">
					<fmt:formatDate value="<%=new java.util.Date() %>" pattern="yyyy-MM-dd"/>
					</span> --%>
							</div>
						</div>
					</div>
				</td>
				<td>
					<div class="reservation">
						<div onclick="sure()"
							style="background-color: rgb(59, 153, 204); color: white;">
							<div align="center" class="reserTop">
								确认应约
								<%-- <span style="float: right;font-size: 1rem;padding-top: 0.3rem;">
					<fmt:formatDate value="<%=new java.util.Date() %>" pattern="yyyy-MM-dd"/>
					</span> --%>
							</div>
						</div>
					</div>
				</td>
				<td>
					<div class="reservation">
						<div onclick="cancels()"
							style="background-color: rgb(221, 221, 221); color: rgb(59, 153, 204)">
							<div align="center" class="reserTop">
								取消应约
								<%-- <span style="float: right;font-size: 1rem;padding-top: 0.3rem;">
					<fmt:formatDate value="<%=new java.util.Date() %>" pattern="yyyy-MM-dd"/>
					</span>  --%>
							</div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div id="cancelReservation">
						<table width="100%">
							<tr>
								<th align="center" width="5%">序号</th>
								<th align="center" width="15%">会员名</th>
								<th align="center" width="20%">会员电话</th>
								<th align="center" width="30%">预约项目</th>
								<th align="center" width="30%">取消预约时间</th>
							</tr>
						</table>
						<%
							int a = 1;
						%>
						<c:forEach items="${list }" var="t">
							<table width="100%">
								<tr>
									<td class="font" width="5%"><%=a++%></td>
									<td class="font" width="15%">${t.memberName }</td>
									<td class="font" width="20%">${t.mobile }</td>
									<td class="font" width="30%">${t.productName }</td>
									<td class="font" width="30%"><fmt:formatDate
											value="${t.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>

								</tr>
							</table>
							<div>
								<!--灰色水平线  -->
								<hr size="1em" color="#C0C0C0" />
							</div>
						</c:forEach>
					</div>
				</td>
			</tr>
		</table>
		<%--<jsp:include page="/WEB-INF/jsp/reservation/reservationPageTime.jsp"></jsp:include> --%>
	</div>
</body>
</html>
