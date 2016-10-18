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
	var subcenterDialog;
	var subcenterForm;
	var passwrodInput;
	$(function() {
		subcenterForm = $("#subcenterForm").form();

		passwordInput = subcenterForm.find('[name=name]').validatebox({
			required : true
		});
		subcenterDialog = $('#subcenterDialog').show().dialog({
			modal : true,
			title : '添加省份',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (subcenterForm.find('[name=id]').val() != '') {
						subcenterForm.form('submit', {
							url : '${pageContext.request.contextPath}/subcenter.do?edit',
							success : function(data) {
								subcenterDialog.dialog('close');
								$.messager.show({
									msg : '修改分中心成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						subcenterForm.form('submit', {
							url : '${pageContext.request.contextPath}/subcenter.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										subcenterDialog.dialog('close');
										$.messager.show({
											msg : '添加分中心成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									subcenterDialog.dialog('close');
									$.messager.show({
										msg : '添加分中心失败！',
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
			url : '${pageContext.request.contextPath}/subcenter.do?datagrid',
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
				field : 'subcenterName',
				title : '分中心',
				width : 100,
			} ,{
				field : 'subcenterNumber',
				title : '分中心架构编码',
				width : 100,
			} ,{
				field : 'seq',
				title : '序列号',
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
		subcenterDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		subcenterForm.find('[name=name]').removeAttr('readonly');
		subcenterForm.form('clear');
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
			subcenterForm.find('[name=id]').attr('readonly', 'readonly');
			subcenterDialog.dialog('open');
			subcenterForm.form('clear');
			subcenterForm.form('load', {
				id : rows[0].id,
				subcenterName : rows[0].subcenterName,
				subcenterNumber : rows[0].subcenterNumber,
				seq : rows[0].seq,
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
						url : '${pageContext.request.contextPath}/subcenter.do?del',  
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

	<div id="subcenterDialog" style="display: none; overflow: hidden;">
		<form id="subcenterForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>分中心：</th>
					<td><input name="subcenterName" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>分中心架构编码：</th>
					<td><input name="subcenterNumber" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" /></td>
				</tr>
				<tr>
					<th>序列号：</th>
					<td><input name="seq" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>