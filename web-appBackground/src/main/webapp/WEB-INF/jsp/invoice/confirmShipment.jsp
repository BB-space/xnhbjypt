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
	
	$(function() {
		commonForm = $('#commonForm').form();
		commonDialog = $('#commonDialog').show().dialog({
			modal : true,
			title : '发货单发货确认',
			width : 600,
			height: 400
		}).dialog('close');

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/confirmShipment/datagrid.do',
			toolbar : '#toolbar',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			singleSelect:true,
			idField : 'id',
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 50,
				hidden : true,
				checkbox : true
			},{
				field : 'deliveryNo',
				title : '发货单号',
				width : 100,
				formatter : function(value,row,index){
					return "<a href='${pageContext.request.contextPath}/deliveryManage/deliveryManageItem.do?id="+row.id+"&orderId="+row.orderId+"'>"+value+"</a>";
				}
			} ] ],
			columns :[[{
				field : 'username',
				title : '用户',
				width : 50,
			},{
				field : 'orderTime',
				title : '下单时间',
				width : 50,
				formatter:function(value,row,index){ 
                    return sy.fdate(new Date(value));
				}
			},{
				field : 'weight',
				title : '理论重量',
				width : 50,
			},{
				field : 'realWeight',
				title : '实际重量',
				width : 50,
				formatter:function(value,row,index){
					return '<a href="javascript:void(0)" onclick="edit(\''+row.id+'\')">称重</a>';
				}
			},{
				field : 'deliveryStatus',
				title : '状态',
				width : 50,
				formatter:function(value,row,index){
					if(value==3){
						return '待确认发货';
					}
				}
			}]]
		});

	});

	function append() {
		commonForm.form('clear');
		commonDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		commonForm.find('[name=name]').removeAttr('readonly');
	}

	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length != 1 && rows.length != 0) {
			var names = [];
			for (var i = 0; i < rows.length; i++) {
				names.push(rows[i].name);
			}
			$.messager.show({
				msg : '只能择一个商品进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '个商品',
				title : '提示'
			});
		} else if (rows.length == 1) {
			commonDialog.dialog('open');
			commonForm.form('clear');
			commonForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
				restrictedArea : rows[0].restrictedArea,
				couponNum : rows[0].couponNum,
				deliveryNo : rows[0].deliveryNo,
				username : rows[0].username
			});
		}
	}

	function del() {
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/deliveryApp/del.do',
						data : {
							ids : ids.join(',')
						},
						cache : false,
						dataType : "json",
						success : function(response) {
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('reload');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
	}

	function searchFun() {
		datagrid.datagrid('load',{
			orderNo : $('#toolbar input[name=orderNo]').val()
		});
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	function reloadFun(){
		datagrid.datagrid('reload');
	}
	function picking(){
		var id=$("#devid").val();
		var realWeight = $("#realWeight").val();
		if(realWeight==""){
			alert('请填写实际重量');
			return false;
		}
		if(confirm('确认发货')){
			$.post('${pageContext.request.contextPath}/confirmShipment/confirmAudit.do',{id:id,realWeight:realWeight},function(data){
				window.location.href='${pageContext.request.contextPath}/confirmShipment/confirmShipment.do';
			})		
		}
	}
	function sendBack(){
		var id=$('#devid').val();
		if(confirm('确认退回总仓')){
			$.post('${pageContext.request.contextPath}/confirmShipment/sendBackPicking.do',{id:id},function(data){
				window.location.href='${pageContext.request.contextPath}/confirmShipment/confirmShipment.do';
			})	
		}
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<div id="toolbar" class="datagrid-toolbar"
			style="height: auto; display: none;">
			<fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<td>名称</td>
						<td><input name="orderNo" placeholder="订单号"/></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">增加</a> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a> --><a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="reloadFun();"
					plain="true" href="javascript:void(0);">刷新</a><a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="commonDialog" style="display: none; overflow: hidden;">
		<form id="commonForm" method="post">
			<p style="text-align:right;">
			<a href="javascript:void(0)" class="easyui-linkbutton">发货单打印</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="picking()">确定发货</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="sendBack()">退回分仓</a>
			<p>
			<hr>
			<table class="tableForm">
				<input type="hidden" name="id" id="devid">
				<tr>
					<th>发货单号</th>
					<td><input name="deliveryNo" class="easyui-text" readonly="readonly"/></td>
					<th>客户</th>
					<td><input name="username" class="easyui-text" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>理论重量(kg)</th>
					<td><input name="weight" class="easyui-text" readonly="readonly"/></td>
					<th>实际重量(kg)</th>
					<td><input id="realWeight" name="realWeight" class="easyui-number"/>kg</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>