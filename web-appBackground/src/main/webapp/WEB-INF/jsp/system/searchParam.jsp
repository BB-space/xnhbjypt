<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript">
	var datagrid;
	var searchParamDialog;
	var searchParamForm;
	var passwrodInput;
	$(function() {
		searchParamForm = $("#searchParamForm").form();

		passwordInput = searchParamForm.find('[name=name]').validatebox({
			required : true
		});
		searchParamDialog = $('#searchParamDialog').show().dialog({
			modal : true,
			title : '添加搜索参数',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (searchParamForm.find('[name=id]').val() != '') {
						searchParamForm.form('submit', {
							url : '${pageContext.request.contextPath}/searchParam.do?edit',
							success : function(data) {
								searchParamDialog.dialog('close');
								$.messager.show({
									msg : '修改搜索参数成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						searchParamForm.form('submit', {
							url : '${pageContext.request.contextPath}/searchParam.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										searchParamDialog.dialog('close');
										$.messager.show({
											msg : '添加搜索参数成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									searchParamDialog.dialog('close');
									$.messager.show({
										msg : '添加搜索参数失败！',
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
			url : '${pageContext.request.contextPath}/searchParam.do?searchParamDatagrid',
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
				field : 'mobile',
				title : '用户名称',
				width : 100,
			} ,{
				field : 'menuName',
				title : '菜单',
				width : 100,
			} ,{
				field : 'cityNames',
				title : '城市集合',
				width : 200,
			} ,{
				field : 'createDateTime',
				title : '创建时间',
				width : 100,
				formatter:formatterdate,
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
		
		$("#menuId").combobox({
			valueField: 'id',
	        textField: 'text',
	        url: 'searchParam.do?menuList',
	        onSelect: function(record){
	        }
		});
		
		$("#cityNames").combobox({
			valueField: 'cityName',
	        textField: 'cityName',
	        url: 'searchParam.do?openCity',
	        onSelect: function(record){
	        }
		});
		
	});
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' 
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	function append() {
		searchParamDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		searchParamForm.find('[name=name]').removeAttr('readonly');
		searchParamForm.form('clear');
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
						url : '${pageContext.request.contextPath}/searchParam.do?del',  
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
					plain="true" href="javascript:void(0)">增加</a><a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="searchParamDialog" style="display: none; overflow: hidden;">
		<form id="searchParamForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>用户名称：</th>
					<td><input name="mobile" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>菜单名称：</th>
					<td><select name="menuId" style="width: 200px;" id="menuId"
						maxlength="30" class="easyui-combobox" data-options="editable:false"
						 required="true" ></select></td>
				</tr>
				<tr>
					<th>城市集合：</th>
					<td><select name="cityNames" style="width: 200px;" id="cityNames"
						maxlength="100" class="easyui-combobox" data-options="editable:false"
						 required="true" multiple="true">
						<option value="所有">所有</option>
						<option value="广州市">广州市</option>
						<option value="深圳市">深圳市</option>
						<option value="海口市">海口市</option>
					 </select></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>