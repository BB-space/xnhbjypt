<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript">
	var beginTime ;
	var endTime ;
	
	$(function(){
		$("#btn1").on('click',function(){
			beginTime = $("#beginTime").val();
			endTime = $("#endTime").val();
			if(beginTime == '') {
				alert("选择开始时间");
				return ;
			}else if(endTime == '') {
				alert("选择结束时间");
				return ;
			}
			//执行同步购卡顾客
			$.post('${pageContext.request.contextPath}/bestie.do?getThousand',
					{'beginTime':beginTime,'endTime':endTime},
					function(data){
				var d = $.parseJSON(data);
				alert(d.msg);
			});
		});
		$("#btn2").on('click',function(){
			beginTime = $("#beginTime").val();
			endTime = $("#endTime").val();
			if(beginTime == '') {
				alert("选择开始时间");
				return ;
			}else if(endTime == '') {
				alert("选择结束时间");
				return ;
			}
			//执行同步服务顾客
			$.post('${pageContext.request.contextPath}/bestie.do?getProject',
					{'beginTime':beginTime,'endTime':endTime},
					function(data){
				var d = $.parseJSON(data);
				alert(d.msg);
			});
		});
		$("#btn3").on('click',function(){
			beginTime = $("#beginTime").val();
			endTime = $("#endTime").val();
			if(beginTime == '') {
				alert("选择开始时间");
				return ;
			}else if(endTime == '') {
				alert("选择结束时间");
				return ;
			}
			//执行更新服务顾客
			$.post('${pageContext.request.contextPath}/bestie.do?updateProject',
					{'beginTime':beginTime,'endTime':endTime},
					function(data){
				var d = $.parseJSON(data);
				alert(d.msg);
			});
		});
		$("#btn4").on('click',function(){
			beginTime = $("#beginTime").val();
			endTime = $("#endTime").val();
			if(beginTime == '') {
				alert("选择开始时间");
				return ;
			}else if(endTime == '') {
				alert("选择结束时间");
				return ;
			}
			//执行赠券购卡顾客
			$.post('${pageContext.request.contextPath}/bestie.do?giveThousand',
					{'beginTime':beginTime,'endTime':endTime},
					function(data){
				var d = $.parseJSON(data);
				alert(d.msg);
			});
		});
		$("#btn5").on('click',function(){
			beginTime = $("#beginTime").val();
			endTime = $("#endTime").val();
			if(beginTime == '') {
				alert("选择开始时间");
				return ;
			}else if(endTime == '') {
				alert("选择结束时间");
				return ;
			}
			//执行赠券服务顾客
			$.post('${pageContext.request.contextPath}/bestie.do?giveProject',
					{'beginTime':beginTime,'endTime':endTime},
					function(data){
				var d = $.parseJSON(data);
				alert(d.msg);
			});
		});
		$("#btnNational1").on('click',function(){
			var beginTimeal = $("#beginTimeal").val();
			var endTimeal = $("#endTimeal").val();
			if(endTimeal == '') {
				alert("选择结束时间");
				return ;
			}
			$.messager.progress({title:'请等待',msg:'同步数据中...'});
			//执行同步国庆节新会员1
			$.post('${pageContext.request.contextPath}/bestie.do?getNationUser',
					{'beginTime':beginTimeal,'endTime':endTimeal},
					function(data){
				$.messager.progress('close');
				var d = $.parseJSON(data);
				alert(d.msg);
			});
		});
	});
</script>
<style type="text/css">
	.container{
		margin-left:20px;
		margin-top:20px;
	}
</style>
</head>
<body class="easyui-layout">
	
	<div class="container">
		开始时间：<input type="date" id="beginTime">&nbsp;&nbsp;&nbsp;&nbsp;结束时间：<input type="date" id="endTime"><br/><br/><br/>
		<input type="button" value="同步购卡顾客" id="btn1"><br/><br/>
		<input type="button" value="同步服务顾客" id="btn2"><br/><br/>
		<input type="button" value="更新服务顾客" id="btn3"><br/><br/>
		<input type="button" value="赠券购卡顾客" id="btn4"><br/><br/>
		<input type="button" value="赠券服务顾客" id="btn5">
	</div>
	<br/>
	<div class="container">
		开始时间：<input type="date" id="beginTimeal">&nbsp;&nbsp;&nbsp;&nbsp;结束时间：<input type="date" id="endTimeal"><br/><br/>
		<input type="button" value="同步国庆新会员" id="btnNational1"><br/><br/>
<!-- 		<input type="button" value="同步国庆新会员2" id="btnNational2"><br/><br/> -->
	</div>
	
	<article>
		
	</article>
</body>
</html>