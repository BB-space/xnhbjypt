<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
		$.post("checkOrder.do?createCard",{"orderId":orderId},function(data){
			data = $.parseJSON(data);
			$.messager.show({title:"提示",msg:data.msg});
		});
	}
	
	function importExcel() {
		$.post("groupon.do?importExcel",null,function(data){
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
				<legend>导入excel步骤</legend>
				<ul>
					<li>导入数据使用的excel文件暂只支持.xls格式的</li>
					<li>工作表各列的顺序为：序列号、用户手机号、消费时间、套餐信息、售价、结算价、分店名、验券帐号、商户ID、分店城市</li>
					<li>工作表不带表头，里面只保留需要导入的数据</li>
					<li>excel文件准备好之后，点击下方的“选择文件”按钮选择需要上传的文件，然后点击“导入”按钮即可</li>
				</ul>
			</fieldset>
			
			<fieldset style="border:1px groove #f0f0f0;background-color:#ffffff">
				<legend>导入excel</legend>
				<form enctype="multipart/form-data" method="post" action="groupon.do?importExcel">
					<table class="tableForm">
						<tr>
							<th></th>
							<td><input type="file" name="file" id="file"/></td>
							<td>
								<!-- <a class="easyui-linkbutton" iconCls="icon-search"
								plain="true" onclick="importExcel();" href="javascript:void(0);">导入</a> -->
								<input type="submit" value="导入"/>
							</td>
						</tr>
					</table>
				</form>
			</fieldset>
		</div>
		<table id="datagrid"></table>
	</div>
</body>
</html>