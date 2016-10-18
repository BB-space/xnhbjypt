<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menuUser.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var userDialog;
	var userForm;
	var passwordInput;
	var userRoleDialog;
	var userRoleForm;
	var empMemberDiv;
	var empMemberDatagrid;
	var userType = '${userType}';
	
	$(function() {
		$('#empMemberDiv').dialog({
			title	: '',
			width	: 600,
			height	: 400,
			modal	: true,
			closed	: true,
			buttons : [{
				text :'确定',
				handler:function(){
					$("#empMemberDiv").dialog('close');
					var row = $('#empMemberDatagrid').datagrid('getSelected');
					$('input[name="employeeMobile"]').val(row.userName);	
					$('input[name="employeeName"]').val(row.realname);
					$("#userDialog").dialog('open');
				},
			},{
				text :'取消',
				handler :function(){
					$("#empMemberDiv").dialog('close');
				}
			}]
		});
		
		userForm = $('#userForm').form();
		passwordInput = userForm.find('[name=password]').validatebox({
			required : true
		});

		userDialog = $('#userDialog').show().dialog({
			modal : true,
			title : '天猫会员信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (userForm.find('[name=id]').val() != '') {
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/tmallMember.do?edit',
							success : function(data) {
								console.log(data);
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
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/tmallMember.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										userDialog.dialog('close');
										$.messager.show({
											msg : '用户创建成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
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

		//页面显示数据
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/tmallMember.do?datagrid',
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
				field : 'taobao_user_nick',
				title : '淘宝会员',
				width : 100,
				sortable : true
			} ] ],
			columns : [ [ {
				field : 'mobile',
				title : '会员手机',
				width : 50,
			},{
				field : 'employeeAccount',
				title : '绑定帐号',
				width : 50,
				sortable : true
			},{
				align : 'center',
				field : 'bindTime',
				title : '绑定时间',
				width : 50,
				align : 'center',
				formatter:formatterdate
			},{
				align : 'center',
				field : 'shopName',
				title : '所属门店',
				width : 50,
				align : 'center'
			},{
				align : 'center',
				field : 'employeeMobile',
				title : '员工手机',
				width : 50,
				align : 'center'
			},{
				align : 'center',
				field : 'employeeName',
				title : '所属员工',
				width : 50,
				align : 'center'
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

	//设置显示时间
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	//编辑会员
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
			 
			userForm.find('[name=taobao_user_nick]').attr('readonly', 'readonly');
			userForm.find('[name=mobile]').attr('readonly', 'readonly');
			userForm.find('[name=shopName]').attr('readonly', 'readonly');
			userForm.find('[name=employeeMobile]').attr('readonly', 'readonly');
			userForm.find('[name=employeeName]').attr('readonly', 'readonly');
			userDialog.dialog('open');
			userForm.form('clear');
			//alert(rows[0].provinceId+'*'+rows[0].cityId+'*'+rows[0].shopName);
			userForm.form('load', {
				id : rows[0].id,
				taobao_user_nick : rows[0].taobao_user_nick,
				mobile : rows[0].mobile,
				shopName : rows[0].shopName,
				employeeMobile : rows[0].employeeMobile,
				employeeName : rows[0].employeeName,
				shopId : rows[0].shopId
			});
		}
	}
	
	function bindEmp(){
		var shopId = $("#shopId").val();
		$('#empMemberDiv').dialog('open');
		$('#empMemberDatagrid').datagrid({
			url : 'tmallMember.do?empDatagrid&shopId='+shopId,
			toolbar : '',
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
			rownumbers : true,  
			singleSelect : true,
			frozenColumns : [ [
			{
				title : '编号',
				field : 'id',
				width : 50,
				hidden : true,
			} ] ],
			columns : [ [ {
				field : 'userName',
				title : '员工手机',
				width : 100,
				align : 'center',
			},{
				field : 'realname',
				title : '员工姓名',
				width : 100,
				align : 'center'
			},{
				align : 'center',
				field : 'shopName',
				title : '门店',
				width : 100,
				align : 'center'
			}] ],
		});
	}

	//查找
	function searchFun() {
		datagrid.datagrid('load',
				{
					mobile : $('#toolbar input[name=mobile]').val(),
					shopName : $('#toolbar input[name=shopName]').val(),
					employeeMobile : $('#toolbar input[name=employeeMobile]').val()
				});
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
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
						<th>淘宝会员手机</th>
						<td><input name="mobile"></td>
						<c:if test="${userM.userType!='4'&&userM.userType!='10'}">
							<th>门店</th>
							<td><input name="shopName" />
						</c:if>
						<th>员工</th>
						<td><input name="employeeMobile" />
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				 <!-- <a class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> --> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="userDialog" style="display: none; overflow: hidden;width:350px;">
		<form id="userForm" method="post">
			<table>
				<input type="hidden" id="shopId" name="shopId">
				<tr>
					<th>用户ID</th>
					<td><input name="id" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>淘宝会员</th>
					<td><input id="taobao_user_nick" name="taobao_user_nick" class="easyui-validatebox"
						required="true" />
					</td>
				</tr>
				<tr>
					<th>手机</th>
					<td><input name="mobile" id="mobile"/></td>
				</tr>
				<tr>
					<th>门店名称</th> 
					<td><input name="shopName" id="shopName"/></td>
				</tr>
				<tr>
					<th>员工手机</th>
					<td><input name="employeeMobile" id="employeeMobile"/><input type="button" value="重新绑定员工" onclick="bindEmp();" style="background-color:RGB(#3B99CC)"></td>
				</tr>
				<tr>
					<th>员工</th>
					<td><input name="employeeName" id="employeeName"/></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>
	
	<!-- 卡项 -->
	<div id="empMemberDiv">
		<div id="toolbarEmp" class="datagrid-toolbar"
			style="height: auto;">
			<fieldset>
				<legend>信息</legend>
				<table class="tableForm">
					注意：只能给无归属任何员工的会员绑定新员工！！！
				</table>
			</fieldset>
			<div>
				
			</div>
		</div>
		<table id="empMemberDatagrid"></table>
	</div>
</body>
</html>