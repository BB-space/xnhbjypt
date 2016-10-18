<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript">
	var datagrid;
	var balanceForm;
	$(function() {
	});
	
	//查找
	function searchFun() {
		var mobile = $("#mobile").val();
		$.post("checkOrder.do?findOrder",{"mobile":mobile},function(data){
			data = $.parseJSON(data);
			$("#datagrid").datagrid({
				url : '',
				toolbar : '#toolbar',
				title : '',
				iconCls : 'icon-save',
				pagination : false,
				pageSize : 10,
				pageList : [ 10, 20, 30, 40, 50],
				fit : true,
				fitColumns : true,
				nowrap : false,
				border : false,
				idField : 'id',
				singleSelect : true,//单选 
				rownumbers : true,
				columns : [ [ {
					field : 'mobile',
					title : '用户手机号码',
					width : 50,
				},{
					field : 'orderId',
					title : '订单id',
					width : 100,
				},{
					field : 'wxPayNo',
					title : '微信订单号',
					width : 100,
				},{
					field : 'orderTime',
					title : '下单时间',
					width : 100,
				},{
					field : 'isPay',
					title : '是否已支付',
					width : 100,
					formatter: function(value){
						if(value == "是"){
							return '<font color="red">是</font>';
						}
						return '<font color="green">否</font>';
					}
				},{
					field : 'isCreate',
					title : '是否已生成卡券',
					width : 100,
					formatter: function(value){
						if(value == "是"){
							return '<font color="red">是</font>';
						}
						return '<font color="green">否</font>';
					}
				}] ],
				onRowContextMenu : function(e, rowIndex, rowData) {
					e.preventDefault();
					$(this).datagrid('unselectAll');
					$(this).datagrid('selectRow', rowIndex);
				},
				onLoadError : function(args){
					alert("没有登录系统，或登录超时，请重新登录");
					window.top.location.href = '${pageContext.request.contextPath}/index.jsp';		
				}
			});
			//$("#datagrid").datagrid({data:data});
			
			$("#datagrid").datagrid('loadData',data);
		});
	}
	
	function clearFun() {
		/* datagrid.datagrid('unselectAll'); */
		$('#toolbar input').val('');
		datagrid.datagrid('loadData',{total:0, rows:[]});
	}
	
	function createCard() {
		var orderId = $("#orderId").val();
		$.post("checkOrder.do?createCard",{"orderId":orderId},function(data){
			data = $.parseJSON(data);
			$.messager.show({title:"提示",msg:data.msg});
		});
	}
	
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="true" >
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<fieldset style="border:1px groove #f0f0f0;background-color:#ffffff">
				<legend>补卡步骤</legend>
				<ul>
					<li>咨询客户并确认客户已支付成功但未收到卡券的订单有几单</li>
					<li>输入用户手机号码，查询用户所有订单信息</li>
					<li>订单列表中，是否已支付状态为“是”，是否已生成卡券为“否”的订单就是客户未收到卡券的订单</li>
					<li>复制该订单的订单id</li>
					<li>将订单id粘贴至输入框，点击生成卡券，此时浏览器右下角会有提示信息</li>
				</ul>
			</fieldset>
			<fieldset style="border:1px groove #f0f0f0;background-color:#ffffff">
				<legend>需要查询的用户信息</legend>
				<table class="tableForm">
					<tr>
						<th>电话号码</th>
						<td><input name="mobile" id="mobile"></td>
						<td>
							<a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a>
							<a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="clearFun();" href="javascript:void(0);">清空</a>
						</td>
					</tr>
				</table>
			</fieldset>
			<fieldset style="border:1px groove #f0f0f0;background-color:#ffffff">
				<legend>需要生成卡券的订单id</legend>
				<table class="tableForm">
					<tr>
						<th>&nbsp;订单id</th>
						<td><input name="orderId" id="orderId"></td>
						<td>
							<a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="createCard();" href="javascript:void(0);">生成卡券</a>
							<a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="clearFun();" href="javascript:void(0);">清空</a>
						</td>
					</tr>
				</table>
			</fieldset>
		</div>
		<table id="datagrid"></table>
	</div>
</body>
</html>