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
	var prizeSettingDialog;
	var prizeSettingForm;
	var passwrodInput;
	$(function() {
		prizeSettingForm = $("#prizeSettingForm").form();

		passwordInput = prizeSettingForm.find('[name=name]').validatebox({
			required : true
		});
		prizeSettingDialog = $('#prizeSettingDialog').show().dialog({
			modal : true,
			title : '添加奖项',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (prizeSettingForm.find('[name=id]').val() != '') {
						var rows = datagrid.datagrid('getSelections');
						if(rows[0].prizeName == $("#prizeName").val() && rows[0].prizeInfomatiomIds == $("#prizeInfomatiomIds").combobox('getValues')){
							prizeSettingDialog.dialog('close');
							$.messager.show({
								msg : '修改奖项成功！',
								title : '提示'
							}); 
							return;
						}
						
						prizeSettingForm.form('submit', {
							url : '${pageContext.request.contextPath}/prizeSetting.do?edit',
							success : function(data) {
								prizeSettingDialog.dialog('close');
								$.messager.show({
									msg : '修改奖项成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						prizeSettingForm.form('submit', {
							url : '${pageContext.request.contextPath}/prizeSetting.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										prizeSettingDialog.dialog('close');
										$.messager.show({
											msg : '添加奖项成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									prizeSettingDialog.dialog('close');
									$.messager.show({
										msg : '添加奖项失败！',
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
			url : '${pageContext.request.contextPath}/prizeSetting.do?prizeSettingDatagrid',
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
				field : 'prizeName',
				title : '奖项名称',
				width : 100,
			} ,{
				field : 'prizeInfomatiomIds',
				title : '奖品Id集合',
				width : 100,
				hidden : true
			} ,{
				field : 'prizeInfomatiomNames',
				title : '奖品名称',
				width : 300,
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
		
		$("#prizeInfomatiomIds").combobox({
			valueField: 'id',
	        textField: 'name',
	        url: 'prizeInfomation.do?prizeInfomationList',
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
		prizeSettingDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		prizeSettingForm.find('[name=name]').removeAttr('readonly');
		prizeSettingForm.form('clear');
		prizeSettingForm.form('load', {
// 			introduce : '最萌家庭'
		});
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
			prizeSettingForm.find('[name=id]').attr('readonly', 'readonly');
			prizeSettingDialog.dialog('open');
			prizeSettingForm.form('clear');
			prizeSettingForm.form('load', {
				id : rows[0].id,
				prizeName : rows[0].prizeName,
				prizeInfomatiomIds : rows[0].prizeInfomatiomIds
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
						url : '${pageContext.request.contextPath}/prizeSetting.do?del',  
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
		datagrid.datagrid('load',
				{
			       prizeName : $('#toolbar input[name=prizeName]').val(),
			       prizeType : $('#toolbar input[name=prizeType]').val()
				});
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
					    <th>奖品类别</th>
						<td><select class="easyui-combobox" name="prizeType" style="width:200px;">
						    <option value="最萌家庭">最萌家庭</option>
						    <option value="双十二积分奖品">双十二积分奖品</option>
							</select>
						</td>
						<th>奖项名称</th>
						<td><input name="prizeName" id="prizeName" type="text"/>
						</td>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
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

	<div id="prizeSettingDialog" style="display: none; overflow: hidden;">
		<form id="prizeSettingForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>奖项名称：</th>
					<td><input name="prizeName" id="prizeName" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>包括奖品：</th>
					<td><select name="prizeInfomatiomIds" id="prizeInfomatiomIds"  class="easyui-combobox" data-options="editable:false"
					 multiple="true" style="width: 210px"></select></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
