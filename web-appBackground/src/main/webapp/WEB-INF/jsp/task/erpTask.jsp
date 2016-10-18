<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var commonDialog;
	var commonForm;
	var taskDialog;
	var taskForm;
	$(function() {
		taskForm = $("#taskForm").form();
		taskDialog = $('#taskDialog').show().dialog({
			modal : true,
			title : '信息',
			closable: false,
			buttons : [ {
				text : '确定',
				handler : function() {
					if (taskForm.find('[name=checkPwd]').val() == '654321') {
						taskDialog.dialog('close');
						$.messager.alert("操作提示", "输入密码成功！");
						
					}else{
						$.messager.alert("操作提示", "输入密码错误！");
					}
				}
			} ]
		}).dialog('close');
		taskDialog.dialog('open');
	});
	
	function executeCheckYktNewMemberListener(){
		if(confirm("确认执行此程序？")){
			$.ajax({
				url:'${pageContext.request.contextPath}/task.do?executeCheckYktNewMemberListener',
				type:'POST',
				dataType:'JSON',
				success:function(data){
					alert(data.msg);
				}
			});
		}
	}
	
	function executeErpUserCardGiveNewListener(){
		if(confirm("确认执行此程序？")){
			$.ajax({
				url:'${pageContext.request.contextPath}/task.do?executeErpUserCardGiveNewListener',
				type:'POST',
				dataType:'JSON',
				success:function(data){
					alert(data.msg);
				}
			});	
		}
	}
	
	function executePushErpNewMemberWoman(){
		if(confirm("确认执行此程序？")){
			$.ajax({
				url:'${pageContext.request.contextPath}/task.do?executePushErpNewMemberWoman',
				type:'POST',
				dataType:'JSON',
				success:function(data){
					alert(data.msg);
				}
			});	
		}
	}
	
	function executePushErpNewMemberSix(){
		if(confirm("确认执行此程序？")){
			$.ajax({
				url:'${pageContext.request.contextPath}/task.do?executePushErpNewMemberSix',
				type:'POST',
				dataType:'JSON',
				success:function(data){
					alert(data.msg);
				}
			});	
		}
	}
	function executeRedPacket(){
		if(confirm("确认执行此程序？")){
			$.ajax({
				url:'${pageContext.request.contextPath}/task.do?executeRedPacket',
				type:'POST',
				dataType:'JSON',
				success:function(data){
					alert(data.msg);
				}
			});	
		}
	}
	</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
		    <fieldset>
				<legend>定时器执行</legend>
				<table class="tableForm">
<!-- 					<tr> -->
<!-- 						<th>额外赠送洗发露:</th> -->
<!-- 						<td><button onclick="executeCheckYktNewMemberListener();">执行CheckYktNewMemberListener</button></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th>珠中佛新赠券:</th> -->
<!-- 						<td><button onclick="executeErpUserCardGiveNewListener();">执行ErpUserCardGiveNewListener</button></td> -->
<!-- 					</tr> -->
					<tr>
						<th>玫瑰女神节新客成交推券</th>
						<td><button onclick="executePushErpNewMemberWoman();">执行pushErpNewMemberWoman</button></td>
					</tr>
					<tr>
						<th>六城新客成交推券</th>
						<td><button onclick="executePushErpNewMemberSix();">执行pushErpNewMemberSix</button></td>
					</tr>
					<tr>
						<th>推送红包</th>
						<td><button onclick="executeRedPacket();">执行executeRedPacket</button></td>
					</tr>
				</table>
			</fieldset>
		</div>
		<!-- <table id="datagrid"></table> -->
	</div>  
	<div id="taskDialog" style="display: none; overflow: hidden;">
		<form id="taskForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden"/></td>
				</tr>
				<tr>
					<th>验证密码</th>
					<td>
						<input name="checkPwd" class="easyui-textbox" type="password" data-options="required:true" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>