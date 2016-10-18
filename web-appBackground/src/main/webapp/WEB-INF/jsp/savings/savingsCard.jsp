<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var savingsCardDialog;
	var savingsCardForm;
	var passwrodInput;
	$(function() {
		savingsCardForm = $("#savingsCardForm").form();

		passwordInput = savingsCardForm.find('[name=name]').validatebox({
			required : true
		});
		savingsCardDialog = $('#savingsCardDialog').show().dialog({
			modal : true,
			title : '添加储金卡',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (savingsCardForm.find('[name=id]').val() != '') {
						savingsCardForm.form('submit', {
							url : '${pageContext.request.contextPath}/savingsCard.do?edit',
							success : function(data) {
								savingsCardDialog.dialog('close');
								$.messager.show({
									msg : '修改储金卡成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						savingsCardForm.form('submit', {
							url : '${pageContext.request.contextPath}/savingsCard.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										savingsCardDialog.dialog('close');
										$.messager.show({
											msg : '添加储金卡成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									savingsCardDialog.dialog('close');
									$.messager.show({
										msg : '添加储金卡失败！',
										title : '提示'
									});
									datagrid.datagrid('reload');
								}
							}
						});
					}
				}
			} ]
		}).dialog('close');
			
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/savingsCard.do?datagrid',
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
			idField : 'id',
			singleSelect : true,//单选 
			rownumbers : true,
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 50,
				hidden : true,
			} ] ],
			columns : [ [ {
				field : 'name',
				title : '名称',
				width : 100,
			} ,{
				field : 'buyMoney',
				title : '储金价值',
				width : 100,
			} ,{
				field : 'giveMoney',
				title : '赠送储金',
				width : 100,
			} ,{
				field : 'status',
				title : '状态',
				width : 100,
				hidden : true
			} ,{
				field : 'describes',
				title : '描述',
				width : 100,
			} ,{
				field : 'note',
				title : '备注',
				width : 100,
			} ,{
				field : 'totalValue',
				title : '总价值',
				width : 30,
			} ,{
				field : 'distribution',
				title : '门店分布',
				width : 100,
			},{
				field : 'purchaseInfo',
				title : '购买须知',
				width : 300,
			} ] ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});

	});
	function append() {
		savingsCardDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		savingsCardForm.find('[name=name]').removeAttr('readonly');
		savingsCardForm.form('clear');
	}

	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length != 1 && rows.length != 0) {
			var names = [];
			for (var i = 0; i < rows.length; i++) {
				names.push(rows[i].name);
			}
			$.messager.show({
				msg : '只能择一条数据 进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '条数据',
				title : '提示'
			});
		} else if (rows.length == 1) {
			passwordInput.validatebox({
				required : false
			});
			savingsCardForm.find('[name=id]').attr('readonly', 'readonly');
			savingsCardDialog.dialog('open');
			savingsCardForm.form('clear');
			savingsCardForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
				buyMoney : rows[0].buyMoney,
				giveMoney : rows[0].giveMoney,
				describes : rows[0].describes,
				note : rows[0].note,
				totalValue : rows[0].totalValue,
				purchaseInfo : rows[0].purchaseInfo,
				distribution : rows[0].distribution
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
						url : '${pageContext.request.contextPath}/savingsCard.do?del',  
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
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0)">增加</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">编辑</a><a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="savingsCardDialog" style="display: none; overflow: hidden;width:400px;height:580px;">
		<form id="savingsCardForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>名称：</th>
					<td><input name="name" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>储金价值：</th>
					<td><input name="buyMoney" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" /></td>
				</tr>
				<tr>
					<th>赠送储金：</th>
					<td><input name="giveMoney" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>描述：</th>
					<td><textarea cols=40 rows=5 name="describes" class="textarea easyui-validatebox"></textarea></td>
				</tr>
				<tr>
					<th>备注：</th>
					<td><textarea cols=40 rows=5 name="note" class="textarea easyui-validatebox"></textarea></td>
				</tr>
				<tr>
					<th>总价值：</th>
					<td><input name="totalValue" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>门店分布：</th>
					<td><input name="distribution" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>购买须知：</th>
					<td><textarea cols=40 rows=10 name="purchaseInfo" class="textarea easyui-validatebox"></textarea></td>
				</tr>
				<tr>
					<th></th>
					<td><span style="color:red;font-size:6px">购买须知每点要求之间加上^字符用于后台截取字符串</span></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>