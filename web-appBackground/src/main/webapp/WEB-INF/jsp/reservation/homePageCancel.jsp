<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>

<style type="text/css">
	.reservation{
		border:0px rgb(79,129,189) solid;
		margin: 0rem 1rem;
		border:0px red solid;
		position: absolute;
		width:30%;
	}
	.reserTop{
		font-size: 1.5rem;
		margin: 1rem;
	}
	.submit{
	width: 5em;
	height: 2em;
	background-color:rgb(59,153,204);
	color:white;
	margin-top: 0.2rem;
	}
	.submitCancel{
	width: 5em;
	height: 2em;
	background-color:#808080;
	color:white;
	margin-top: 0.2rem;
	}
	
	.font{
		font-size: 1rem;
		text-align: center;
	}
	.stamp{
		width: 40%;
		margin: 1rem 2rem;
		border:1px red solid;
	}
	.ys{
		color:rgb(59,153,204);
	}
	.bgys{
		background-color:rgb(59,153,204);
		color:white;
	}
	
</style>
<script type="text/javascript">
	var reserTimes="";
	function cancelReservation(val){
		$.messager.confirm('请确认', '您确定要取消此预约吗？', function(data){
			if(data){
				window.location.href="reservation.do?addCancelReservation&id="+val;
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
	function init(){ 
		windowHeight=$(window).height(); 
		windowWidth=$(window).width(); 
		popHeight=$(".window").height(); 
		popWidth=$(".window").width(); 
	} 
	
	//关闭窗口的方法 
	function closeWindow(){ 
	$(".title img").click(function(){ 
	$(this).parent().parent().hide("slow"); 
	}); 
	} 
	
	//弹出预约时间
	 function reservation(val){
		init();
		var tempArr = val.split(",");
		id = tempArr[0];
		reserTimes=tempArr[1];
		//计算弹出窗口的左上角Y的偏移量 
		var popY=(windowHeight-popHeight)/8; 
		var popX=(windowWidth-popWidth)/8; 
		//设定窗口的位置 
		$("#reservationTime").css("top",popY).css("left",popX)	
			.show(); 
		setTime(val);
	}
	 function no(){//
         window.location.href = "reservation.do?homePage";
	  }
    function sure(){//
		   window.location.href = "reservation.do?homePageSure";
	   }
   function cancels(){//
		   window.location.href = "reservation.do?homePageCancel";
	   } 
</script>
</head>
<body>
	<div style="height:1000rem;">
	 <table width="100%" id="content" >
		<tr>
			<!-- 预约 -->
			<td>
			<div class="reservation">
			<div >
				<div class="reserTop ys">
					今日预约 
					<span style="float: right;font-size: 1rem;padding-top: 0.3rem;">
						<fmt:formatDate value="<%=new java.util.Date() %>" pattern="yyyy-MM-dd"/>
					</span>
				</div>
			</div>
			<table width="100%">
				<tr>
					<td class="bgys font" onclick="no()"> 未应约 </td>
					<td class="bgys font" onclick="sure()"> 确认应约 </td>
					<td class="ys font" onclick="cancels()"> 取消应约  </td>
				</tr>
			</table>
				<c:forEach items="${cancalList }" var="t">
					<table  width="100%" >
						<tr>
							<td class="font">
								<div align="left">
									<div>${t.memberName }</div>
									<div>电话：${t.mobile }</div>
									<div>预约时间：
									<fmt:formatDate value="${t.reservationTime }" pattern="yyyy-MM-dd HH:mm:ss"/></div>
									<div>预约项目：${t.productName }</div>
								</div>
							</td>
					       
						</tr>
					</table>
						 <div ><!--灰色水平线  -->
		                 <hr size="1em" color="#C0C0C0" />
	                  </div>
	            </c:forEach>
			</div>
			</td>		
			</tr>
	</table> 
	<!-- <div style="margin-left: 35%;border-left:1px rgb(169,169,169) solid;height: 100rem;float: left;"></div> -->
	<%-- <div style="width:60%;margin-left: 40%;">
			<jsp:include page="/WEB-INF/jsp/cardpay/cardpay.jsp"/> 
	</div> --%>
	<%-- <jsp:include page="/WEB-INF/jsp/reservation/reservationTime.jsp"></jsp:include> --%> 

	</div>	
</body>
</html>