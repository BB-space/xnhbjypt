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
	var savingsItemDialog;
	var savingsItemForm;
	var passwrodInput;
	$(function() {
		savingsItemForm = $("#savingsItemForm").form();

		passwordInput = savingsItemForm.find('[name=name]').validatebox({
			required : true
		});
		savingsItemDialog = $('#savingsItemDialog').show().dialog({
			modal : true,
			title : '添加赠送卡项',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (savingsItemForm.find('[name=id]').val() != '') {
						savingsItemForm.form('submit', {
							url : '${pageContext.request.contextPath}/savingsItem.do?edit',
							success : function(data) {
								savingsItemDialog.dialog('close');
								$.messager.show({
									msg : '修改赠送卡项成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						savingsItemForm.form('submit', {
							url : '${pageContext.request.contextPath}/savingsItem.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										savingsItemDialog.dialog('close');
										$.messager.show({
											msg : '添加赠送卡项成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									savingsItemDialog.dialog('close');
									$.messager.show({
										msg : '添加赠送卡项失败！',
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
			url : '${pageContext.request.contextPath}/savingsItem.do?datagrid',
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
				field : 'type',
				title : '卡项类型',
				width : 100,
			} ,{
				field : 'name',
				title : '名称',
				width : 100,
			} ,{
				field : 'money',
				title : '价值的钱',
				width : 100,
			} ,{
				field : 'unit',
				title : '单位',
				width : 100,
			} ,{
				field : 'describes',
				title : '描述',
				width : 100,
			} ,{
				field : 'note',
				title : '备注',
				width : 100,
			} ,{
				field : 'validTimeStr',
				title : '有效期开始时间',
				width : 100,
			} ,{
				field : 'invalidTimeStr',
				title : '有效期结束时间',
				width : 100,
			}] ],
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
		savingsItemDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		savingsItemForm.find('[name=name]').removeAttr('readonly');
		savingsItemForm.form('clear');
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
			savingsItemForm.find('[name=id]').attr('readonly', 'readonly');
			savingsItemDialog.dialog('open');
			savingsItemForm.form('clear');
			savingsItemForm.form('load', {
				id : rows[0].id,
				type : rows[0].type,
				name : rows[0].name,
				money : rows[0].money,
				unit : rows[0].unit,
				describes : rows[0].describes,
				note : rows[0].note,
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
						url : '${pageContext.request.contextPath}/savingsItem.do?del',  
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

	<div id="savingsItemDialog" style="display: none; overflow: hidden;width:400px;min-height:380px;">
		<form id="savingsItemForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>类型：</th>
					<td><select id="type" class="easyui-combobox" name="type" style="width:200px;" required="true">
						    <option value="1">赠券</option>
						    <option value="3">卡项</option>
						    <option value="2">物品</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>名称：</th>
					<td><input name="name" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>价值的钱：</th>
					<td><input name="money" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" /></td>
				</tr>
				<tr>
					<th>单位：</th>
					<td><input name="unit" style="width: 200px;"
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
					<th>有效期开始时间：</th>
					<td>
						<input name="validTimeStr" class="easyui-datetimebox"/>
					</td>
				</tr>
				<tr>
					<th>有效期结束时间：</th>
					<td>
						<input name="invalidTimeStr" class="easyui-datetimebox"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>