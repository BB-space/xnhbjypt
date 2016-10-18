<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>


<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var userDialog;
	var userForm;
	var passwordInput;
	var userRoleDialog;
	var userRoleForm;
	
	$(function() {

		userForm = $('#userForm').form();

		passwordInput = userForm.find('[name=password]').validatebox({
			required : true
		});

		$('[name=roleId]').combotree({
			url : '${pageContext.request.contextPath}/role/tree.do',
			animate : false,
			lines : !sy.isLessThanIe8(),
			checkbox : true,
			onLoadSuccess : function(node, data) {
				var t = $(this);
				if (data) {
					$(data).each(function(index, d) {
						if (this.state == 'closed') {
							t.tree('expandAll');
						}
					});
				}
			}
		});
		
		$('[name=businessId]').combotree({
			url : '${pageContext.request.contextPath}/business/tree.do',
			animate : false,
			lines : !sy.isLessThanIe8(),
			checkbox : true,
			onLoadSuccess : function(node, data) {
				var t = $(this);
				if (data) {
					$(data).each(function(index, d) {
						if (this.state == 'closed') {
							t.tree('expandAll');
						}
					});
				}
			}
		});
		
		

		userRoleDialog = $('#userRoleDialog').show().dialog({
			modal : true,
			title : '批量编辑用户角色',
			buttons : [ {
				text : '编辑',
				handler : function() {
					userRoleForm.submit();
				}
			} ]
		}).dialog('close');

		userRoleForm = $('#userRoleForm').form({
			url : '${pageContext.request.contextPath}/user.do?editUsersRole',
			success : function(data) {
				var d = $.parseJSON(data);
				if (d) {
					userRoleDialog.dialog('close');
					$.messager.show({
						msg : '批量修改用户角色成功！',
						title : '提示'
					});
					datagrid.datagrid('reload');
				}
			}
		});

		userDialog = $('#userDialog').show().dialog({
			modal : true,
			title : '用户信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (userForm.find('[name=id]').val() != '') {
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/user.do?edit',
							success : function(data) {
								var d = $.parseJSON(data);
								if(d.success==true){
									userDialog.dialog('close');
									$.messager.show({
										msg : d.msg,
										title : '提示',
									});
									datagrid.datagrid('reload');
								}else{
									$.messager.show({
										msg : d.msg,
										title : '提示'
									});
								}
							}
						});
					} else {
						if(!checkData())return;
						
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/user.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if(d.success==true){
										userDialog.dialog('close');
										$.messager.show({
											msg : d.msg,
											title : '提示',
										});
										datagrid.datagrid('reload');
									}else{
										$.messager.show({
											msg : d.msg,
											title : '提示'
										});
									}
								} catch (e) {
									$.messager.show({
										msg : '用户名称已存在！',
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
			url : '${pageContext.request.contextPath}/user.do?datagrid',
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
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 50,
				checkbox : true
			}, {
				field : 'userName',
				title : '用户名称',
				width : 100,
				sortable : true
			} ] ],
			columns : [ [ {
				field : 'password',
				title : '密码',
				width : 100,
				hidden : true
			}, {
				field : 'userType',
				title : '用户类型',
				width : 100,
				formatter : function(value, rowData, rowIndex) {
					if (value == '2') {
						return '会员用户';
					} else if(value == '1')  {
						return '员工用户';
					}else if(value == '0')  {
						return '后台用户';
					}/* else if(value == '3')  {
						return '游客用户';
					} */else if(value == '4')  {
						return '店长用户';
					}else if(value == '6')  {
						return '区域管理';
					}else if(value == '9')  {
						return '加盟员工';
					}else if(value == '10')  {
						return '加盟店长';
					}else if(value == '11')  {
						return '分中心人员';
					}else if(value == '12')  {
						return '天猫总部';
					}else if(value == '13')  {
						return '加盟商';
					} else{
						return '未知';
					}
				}
			},{
				field : 'createDateTime',
				title : '创建时间',
				width : 150,
				formatter:formatterdate
			},{
				field : 'editDateTime',
				title : '编辑时间',
				width : 150,
				formatter:formatterdate
			}, {
				field : 'roleText',
				title : '角色',
				width : 100
			}, {
				field : 'roleId',
				title : '角色',
				width : 100,
				hidden : true
			}, {
				field : 'businessText',
				title : '职务',
				width : 100
			}, {
				field : 'businessId',
				title : '职务',
				width : 100,
				hidden : true
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
	
	//设置显示时间
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}

	function append() {
		userDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		userForm.find('[name=name]').removeAttr('readonly');
		userForm.form('clear');
	}

	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length != 1 && rows.length != 0) {
			var names = [];
			for (var i = 0; i < rows.length; i++) {
				names.push(rows[i].name);
			}
			$.messager.show({
				msg : '只能择一个用户进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '个用户',
				title : '提示'
			});
		} else if (rows.length == 1) {
			passwordInput.validatebox({
				required : false
			});
			userForm.find('[name=name]').attr('readonly', 'readonly');
			userDialog.dialog('open');
			userForm.form('clear');
			//alert(rows[0].province+'*'+rows[0].city+'*'+rows[0].store+'*'+rows[0].createdatetime+'*'+rows[0].type);
			userForm.form('load', {
				userName : rows[0].userName,
				id : rows[0].id,
				userType : rows[0].userType,
				roleId : rows[0].roleId
			});
		}
	}
	
	function editRole() {
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			for (var i = 0; i < rows.length; i++) {
				ids.push(rows[i].id);
			}
			userRoleForm.find('input[name=userIds]').val(ids.join(','));
			userRoleDialog.dialog('open');
		} else {
			$.messager.alert('提示', '请选择要编辑的记录！', 'error');
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
						url : '${pageContext.request.contextPath}/user.do?del',
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
					userName : $('#toolbar input[name=userName]').val()
				});
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	
	//添加前检查数据是否为空
	function checkData(){
		var userType = $('#userType').val();
		var userPassword = $('#userPassword').val();
		//alert(userType+"**"+userPassword+"**"+roleId);
		if(userType == '' || userType == null){
			alert('用户类型不能为空，请输入！');
			return false;
		}
		if(userPassword == ''){
			alert('登录密码不能为空，请输入！');
			return false;
		}
		return true;
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
						<th>用户名称</th>
						<td colspan="2"><input name="userName" style="width: 305px;" />
						</td>
						
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">增加</a> -->  <!-- <a 
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> -->  <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a><a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="editRole();"
					plain="true" href="javascript:void(0);">批量更改角色</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="userDialog" style="display: none; overflow: hidden;">
		<form id="userForm" method="post">
			<table class="tableForm">
				<tr>
					<th>用户类型</th>
					<td><select name="userType" id="userType"><option value="0">后台用户</option>
					<option value="1">员工用户</option>
					<option value="2">会员用户</option>
				<!-- 	<option value="3">游客用户</option> -->
					<option value="4">店长用户</option>
					<option value="5">客服用户</option>
					<option value="6">区域管理</option>
					<option value="7">操作人员</option>
					<option value="9">加盟员工</option>
					<option value="10">加盟店长</option>
					<option value="11">分中心人员</option>
					<option value="12">天猫总部</option>
					<option value="13">加盟商</option>
					</select></td>
				</tr>
				<tr>
					<th>用户ID</th>
					<td><input name="id" id="id" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>登录名称</th>
					<td><input name="userName" id="userName" class="easyui-validatebox"
						required="true" /></td>
				</tr>
				<tr title="如果不更改密码,请留空!">
					<th>登录密码</th>
					<td><input name="userPassword" id="userPassword" type="password" /></td>
				</tr>
				<tr>
					<th>所属角色</th>
					<td><select name="roleId" style="width: 156px;"></select></td>
				</tr>
				<tr>
					<th>所属职务</th>
					<td><select name="businessId" style="width: 156px;"></select></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="userRoleDialog" style="display: none; overflow: hidden;">
		<form id="userRoleForm" method="post">
			<table class="tableForm">
				<input type="hidden" name="userIds" />
				<tr>
					<th>所属角色</th>
					<td><select name="roleId" style="width: 156px;"></select></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<!--  <div onclick="append();" iconCls="icon-add">增加</div>-->
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>
</body>
</html>