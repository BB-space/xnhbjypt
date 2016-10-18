<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<jsp:include page="../common/inc/xheditor.jsp"></jsp:include>
<style type="text/css">
.tableForm tr td{
	line-height: 35px;
}
</style>

<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var templateDialog;
	var templateForm;
	var passwordInput;
	
	$(function() {
		
		templateForm = $('#templateForm').form();
	
		templateDialog = $('#templateDialog').show().dialog({
			modal : true,
			title : '模板管理',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (templateForm.find('[name=id]').val() != '') {
						templateForm.form('submit', {
							url : '${pageContext.request.contextPath}/template.do?edit',
							success : function(data) {
								templateDialog.dialog('close');
								$.messager.show({
									msg : '模板编辑成功！',
									title : '提示'
								});
								datagrid.datagrid('reload');
							}
						});
					} else {
						templateForm.form('submit', {
							url : '${pageContext.request.contextPath}/template.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										templateDialog.dialog('close');
										$.messager.show({
											msg : '模板创建成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									$.messager.show({
										msg : '模板创建失败！',
										title : '提示'
									});
								}
							}
						});
					}
				}
			} ]
		}).dialog('close');
	

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/template.do?datagrid',
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
			rownumbers : true,
			idField : 'id',
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 50,
				checkbox : true,
				hidden : true,
			} ] ],
			columns : [ [{
				field : 'templateName',
				title : '模板名称',
				width : 30
			},{
				field : 'tName',
				title : '简写名称',
				width : 20
			},{
				field : 'templateId',
				title : '模板id',
				width : 100
			},{
				field : 'first',
				title : '头部内容',
				width : 100
			},{
				field : 'remark',
				title : '尾部内容',
				width : 100,
			},{
				field : 'url',
				title : '跳转url',
				width : 100,
			}]]
		});
	
	});


	function append() {
		templateForm.form('clear');
		templateDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		templateForm.find('[name=name]').removeAttr('readonly');
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
			templateDialog.dialog('open');
			templateForm.form('clear');
			templateForm.form('load', {
				id : rows[0].id,
				templateName : rows[0].templateName,
				tName : rows[0].tName,
				templateId : rows[0].templateId,
				first : rows[0].first,
				remark : rows[0].remark,
				url : rows[0].url
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
						url : '${pageContext.request.contextPath}/template.do?del',
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
			name : $('#toolbar input[name=name]').val()
		});
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	function reloadFun(){
		datagrid.datagrid('reload');
	}
	
	function changePicUrl() {
			var dFile = document.getElementById('file');
			var dImg = document.getElementById('pic');
			if (dFile.files) {
				document.getElementById("pic").style.display = 'block';
				dImg.src = window.URL.createObjectURL(dFile.files[0]);
			} else if (dFile.value.indexOf('\\') > -1
					|| dFile.value.indexOf('\/') > -1) {
				dImg.src = dFile.value;
			}  
		
	}
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
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
						<td>商品名称</td>
						<td><input name="name"/></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add"  onclick="append();"
					plain="true" href="javascript:void(0);">增加</a> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a><a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="reloadFun();"
					plain="true" href="javascript:void(0);">刷新</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="templateDialog" style="display: none; overflow: hidden;width:300px;min-height:400px;">
		<form id="templateForm" method="post">
			<table class="tableForm">
				<tr>
					<th>模板名称:</th>
					<td><input name="templateName" style="width: 200px;" class="easyui-validatebox"  /></td>
					<td><input name="id" style="width: 200px;" hidden="true"/></td>
				</tr>
				<tr>
					<th>简写名称:</th>
					<td><input name="tName" style="width: 200px;" class="easyui-validatebox"  /></td>
				</tr>
				<tr>
					<th>模板id:</th>
					<td><input name="templateId" style="width: 200px;" class="easyui-validatebox"  /></td>
				</tr>
				<tr>
					<th>跳转url:</th>
					<td><input name="url" style="width: 200px;" class="easyui-validatebox"  /></td>
				</tr>
				<tr>
					<th>头部内容:</th>
					<td><textarea name="first" style="width:200px;height:100px;"></textarea></td>
				</tr>
				<tr>
					<th>尾部内容:</th>
					<td><textarea name="remark" style="width:200px;height:100px;"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>