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
	var batchDialog;
	var batchForm;
	$(function() {
		commonForm = $('#commonForm').form();
		batchForm = $("#batchForm").form();
		commonDialog = $('#commonDialog').show().dialog({
			modal : true,
			title : '信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (commonForm.find('[name=id]').val() != '') {
						commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/deliveryManage/edit.do',
							success : function(data) {
								commonDialog.dialog('close');
								$.messager.show({
									msg : '编辑成功！',
									title : '提示'
								});
								datagrid.datagrid('reload');
							}
						});
					} else {
						commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/deliveryManage/add.do',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										commonDialog.dialog('close');
										$.messager.show({
											msg : '创建成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									$.messager.show({
										msg : '名称已存在！',
										title : '提示'
									});
								}
							}
						});
					}
				}
			} ]
		}).dialog('close');
		batchDialog = $('#batchDialog').show().dialog({modal : true,title : '总仓拣货批次选择'}).dialog('close');

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/deliveryManage/datagrid.do',
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
				checkbox : false
			},{
				field : 'deliveryNo',
				title : '发货单号',
				width : 100,
				formatter : function(value,row,index){
					return "<a href='${pageContext.request.contextPath}/deliveryManage/deliveryManageItem.do?id="+row.id+"&orderId="+row.orderId+"'>"+value+"</a>";
				}
			} ] ],
			columns :[[{
				field : 'deliveryBatch',
				title : '批次号',
				width : 50,
			},{
				field : 'username',
				title : '用户',
				width : 100,
			},{
				field : 'warehouseName',
				title : '发货仓',
				width : 50
			},{
				field : 'orderNo',
				title : '订单编号',
				width : 100,
				
			},{
				field : 'deliveryTime',
				title : '发货单生成时间',
				width : 50,
				formatter:function(value,row,index){
					return sy.fdate(new Date(value));
				}
			},{
				field : 'deliveryStatus',
				title : '状态',
				width : 50,
				formatter: function(value,row,index){
					if(value==0){
						return "待总仓拣货";
					}else if(value==1){
						return "待分仓拣货";
					}else if(value==2){
						return "待条码验货";
					}else if(value==3){
						return "待确认发货";
					}else if(value==4){
						return "已发货";
					}
				}
			}]]
		});

	});
	
	//设置显示时间
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}

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
				userId:rows[0].userId,
				deliveryStatus : rows[0].deliveryStatus,
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
						url : '${pageContext.request.contextPath}/deliveryManage/del.do',
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
			deliveryStatus : $('#dvs').val()
		});	
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	function reloadFun(){
		datagrid.datagrid('reload');
	}
	function pickingAction() {
		batchForm.form('clear');
		batchDialog.dialog('open');
	}
	function picking(){
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要更改当前所选状态？', function(r) {
				if (r) {
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/deliveryManage/editPicking.do',
						data : {
							ids : ids.join(',')
						},
						cache : false,
						dataType : "json",
						success : function(response) {
							console.log(response);
							if(response.RESULT=="SUCCESS"){
								datagrid.datagrid('unselectAll');
								datagrid.datagrid('reload');
								$.messager.show({
									title : '提示',
									msg : '更改成功！'
								});
							}else if(response.RESULT=="ERROR"){
								$.messager.show({
									title : '提示',
									msg : '无需重复此操作！'
								});	
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要更改的记录！', 'error');
		}
	}
	function batchPrint(){
		alert('打你妹啊');
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
						<td>状态</td>
						<td>
							<select name="deliveryStatus" id="dvs">
								<option value="0">待总仓拣货</option>
								<option value="1">待分仓拣货</option>
								<option value="2">待条码验货</option>
								<option value="3">待确认发货</option>
								<option value="4">已发货</option>
								<option value="5">已收货</option>
								<option value="6">退回总仓拣货</option>
							</select>
						</td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add"
					plain="true" href="${pageContext.request.contextPath}/deliveryManage/deliveryManageSelect.do">手动生成</a> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">批次删除</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="picking();"
					plain="true" href="javascript:void(0);">总仓拣货完成</a><!-- <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="batchPrint();"
					plain="true" href="javascript:void(0);">批次发货单打印</a> --><a
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
			<table class="tableForm">
				<tr>
					<th>ID</th>
					<td><input name="id" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>名称</th>
					<td>
						<input name="deliveryStatus" class="easyui-textbox" type="text" data-options="required:true" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="batchDialog" style="display:none;overfloat:hidden;">
		<form id="batchForm" method="post">
			<table class="tableForm" style="width:300px;">
				<tr>
					<td>批次</td>
					<td>
						<select name="deliveryBatch" style="width:120px;">
							<option>123</option>
							<option>123</option>
						</select>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton">确定</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>