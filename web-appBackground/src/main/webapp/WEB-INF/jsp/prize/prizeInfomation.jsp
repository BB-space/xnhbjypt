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
	var prizeInfomationDialog;
	var prizeInfomationForm;
	var passwrodInput;
	$(function() {
		prizeInfomationForm = $("#prizeInfomationForm").form();

		passwordInput = prizeInfomationForm.find('[name=name]').validatebox({
			required : true
		});
		prizeInfomationDialog = $('#prizeInfomationDialog').show().dialog({
			modal : true,
			title : '添加奖品',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (prizeInfomationForm.find('[name=id]').val() != '') {
						prizeInfomationForm.form('submit', {
							url : '${pageContext.request.contextPath}/prizeInfomation.do?edit',
							success : function(data) {
								prizeInfomationDialog.dialog('close');
								$.messager.show({
									msg : '修改奖品成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						prizeInfomationForm.form('submit', {
							url : '${pageContext.request.contextPath}/prizeInfomation.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										prizeInfomationDialog.dialog('close');
										$.messager.show({
											msg : '添加奖品成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									prizeInfomationDialog.dialog('close');
									$.messager.show({
										msg : '添加奖品失败！',
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
			url : '${pageContext.request.contextPath}/prizeInfomation.do?prizeInfomationDatagrid',
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
				title : '奖品名称',
				width : 100,
			} ,{
				field : 'price',
				title : '奖品价格',
				width : 50,
			} ,{
				field : 'introduce',
				title : '奖品介绍',
				width : 100,
			},{
				field : 'grade',
				title : '奖品等级',
				width : 100,
			},{
				field : 'noUserCard',
				title : '未使用券',
				width : 100,
			},{
				field : 'userCard',
				title : '已使用券',
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
		prizeInfomationDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		prizeInfomationForm.find('[name=name]').removeAttr('readonly');
		prizeInfomationForm.form('clear');
		prizeInfomationForm.form('load', {
            introduce : '最萌家庭'
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
			prizeInfomationForm.find('[name=id]').attr('readonly', 'readonly');
			prizeInfomationDialog.dialog('open');
			prizeInfomationForm.form('clear');
			prizeInfomationForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
				price : rows[0].price,
				introduce : rows[0].introduce,
				grade : rows[0].grade,
				noUserCard : rows[0].noUserCard,
				userCard : rows[0].userCard,
				cardDetail : rows[0].cardDetail,
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
						url : '${pageContext.request.contextPath}/prizeInfomation.do?del',  
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
			introduce : $('#toolbar input[name=introduce]').val()
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
						<th>奖品介绍</th>
						<td><select class="easyui-combobox" name="introduce" style="width:200px;">
						    <option value="最萌家庭">最萌家庭</option>
						    <option value="员工服务奖品">员工服务奖品</option>
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

	<div id="prizeInfomationDialog" style="display: none; overflow: hidden;width:400px;">
		<form id="prizeInfomationForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>奖品类别：</th>
					<td><input name="introduce" style="width: 200px;"	maxlength="30"
					 class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>奖品名称：</th>
					<td><input name="name" style="width: 200px;" maxlength="100"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>奖品价格：</th>
					<td><input name="price" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>未使用券：</th>
					<td><input name="noUserCard" style="width: 300px;"
						maxlength="30" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<th>已使用券：</th>
					<td><input name="userCard" style="width: 300px;"
						maxlength="30" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<th>券说明：</th>
					<td><textarea rows="6" cols="" name="cardDetail" style="width: 300px;"
						 class="easyui-validatebox" required="true"></textarea>
					</td>
				</tr>
				<tr>
					<th>奖品等级：</th>
					<td><input name="grade" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" /></td>
				</tr>
				<tr>
					<th>奖品等级：</th>
					<td><input name="grade" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>