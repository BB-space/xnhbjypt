<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var userDialog;
	var userForm;
	var passwordInput;
	$(function() {
		userForm = $("#userForm").form();

		passwordInput = userForm.find('[name=name]').validatebox({
			required : true
		});
		userDialog = $('#userDialog').show().dialog({
			modal : true,
			title : '添加用户',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (userForm.find('[name=id]').val() != '') {
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/signUser.do?edit',
							success : function(data) {
								userDialog.dialog('close');
								$.messager.show({
									msg : '修改成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/signUser.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d.success) {
										userDialog.dialog('close');
										$.messager.show({
											msg : '添加成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}else{
										$.messager.show({
											msg : '添加失败，已存在该号码！',
											title : '提示'
										});
									}
								} catch (e) {
									userDialog.dialog('close');
									$.messager.show({
										msg : '添加失败！',
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
			url : '${pageContext.request.contextPath}/signUser.do?datagrid',
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
				field : 'openId',
				title : 'openId',
				width : 50,
				hidden : true,
			} ,{
				field : 'mobile',
				title : '电话', 
				width : 50,
			} ,{
				field : 'userType',
				title : '用户类型',
				width : 50,
			} ,{
				field : 'realname',
				title : '姓名',
				width : 70,
			} ,{
				field : 'signStatus',
				title : '签到状态',
				width : 50,
				formatter : function(value, rowData, rowIndex) {
					if(value == 1)  {
						return "<font style='color:break;'>已签到</font>";
					}else{
						return "<font style='color:red;'>未签到</font>";
					}
				}
			} ,{
				field : 'signTime',
				title : '签到时间',
				width : 50,
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
		
	});
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	function append() {
		$("#status").hide();
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
				msg : '只能择一条数据 进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '条数据',
				title : '提示'
			});
		} else if (rows.length == 1) {
			passwordInput.validatebox({
				required : false
			});
			$("#status").show();
			userForm.find('[name=id]').attr('readonly', 'readonly');
			userDialog.dialog('open');
			userForm.form('clear');
			userForm.form('load', {
				id : rows[0].id,
				openId : rows[0].openId,
				mobile : rows[0].mobile,
				userType : rows[0].userType,
				area : rows[0].area,
				signStatus : rows[0].signStatus,
				realname : rows[0].realname,
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
						url : '${pageContext.request.contextPath}/signUser.do?del',  
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

	//查找
	function searchFun() {
		datagrid.datagrid('load',
				{
			userType : $('#userType').val(),
			mobile : $('#toolbar input[name=mobile]').val(),
			realname : $('#toolbar input[name=realname]').val()
				});
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	//上传
	function uploadUser(){
 //		var dataPara = $('#uploadUserForm').serializeArray();
//		var dFile = document.getElementById('file');
		$.ajax({
			url : '${pageContext.request.contextPath}/signUser.do?uploadUser',
			type : 'post',
			data : dFile.value,
			success : function(data){
				var d = $.parseJSON(data);
				if(d.success){
					$.messager.show({
						title : '提示',
						msg : '上传成功！'
					});
	            	window.location.href = "${pageContext.request.contextPath}/signUser.do?index";
				}else{
					$.messager.show({
						title : '提示',
						msg : '上传失败，请重新上传！'
					});
				}
			}
		});
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
						<th>用户类型</th>
						<td><select name="userType" id="userType" style="width:130px">
						       <option value="">---请选择---</option>
					           <c:forEach items="${userTypeList }" var="u">
					              <option value="${u}">${u}</option>
					           </c:forEach>
					        </select>
						</td>
						<th>手机号</th>
						<td><input name="mobile"></td>
						<th>姓名</th>
						<td><input name="realname"></td>
					
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
					plain="true" href="javascript:void(0)">编辑</a> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
					<!-- excel上传 -->
					<form id="uploadUserForm" method="post" enctype="multipart/form-data" action="signUser.do?uploadUser">
					              上传文件：<input id="file" name="files" type="file"> 
					             <input type="submit" value="上传" onclick="uploadUser();">
				    </form>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="userDialog" style="display: none; overflow: hidden;width:30%;height:40%;">
		<form id="userForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th></th>
					<td><input name="openId" type="hidden" /></td>
				</tr>
				<tr>
					<th>用户类型：</th>
					<td><input name="userType" style="width: 200px;" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<th>手机号：</th>
					<td><input name="mobile" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>姓名：</th>
					<td><input name="realname" style="width: 200px;" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<th>区域：</th>
					<td><input name="area" style="width: 200px;" class="easyui-validatebox"/></td>
				</tr>
				<tr id="status">
					<th>签到状态：</th>
					<td>
					    <select name="signStatus" id="signStatus" style="width: 130px;" class="easyui-validatebox">
					       <option value="0">未签到</option>
					       <option value="1">已签到</option>
					    </select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>