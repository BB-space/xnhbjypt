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
	var awardDialog;
	var awardForm;
	var passwrodInput;
	var editDialog;
	var editForm;
	$(function() {
		awardForm = $("#awardForm").form();
		editForm = $("#editForm").form();

		passwordInput = awardForm.find('[name=name]').validatebox({
			required : true
		});
		awardDialog = $('#awardDialog').show().dialog({
			modal : true,
			title : '发放红包',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (awardForm.find('[name=id]').val() != '') {
						awardForm.form('submit', {
							url : '${pageContext.request.contextPath}/compamy.do?sendRedPacket',
							success : function(data) {
								var d = $.parseJSON(data);
								var msg = "";
// 								console.log(d.obj);
								if(d.obj.status == "1"){
									msg = "发放成功";
								}else if(d.obj.status == "0"){
									msg = "发放失败，"+d.obj.returnMsg;
								}
								awardDialog.dialog('close');
								$.messager.show({
									msg : msg,
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} 
				}
			} ]
		}).dialog('close');
		
		editDialog = $('#editDialog').show().dialog({
			modal : true,
			title : '修改用户信息',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (editForm.find('[name=editId]').val() != '') {
						editForm.form('submit', {
							url : '${pageContext.request.contextPath}/compamy.do?edit',
							success : function(data) {
								console.log(data);
								editDialog.dialog('close');
								$.messager.show({
									msg : '修改成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} 
				}
			} ]
		}).dialog('close');
			
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/compamy.do?datagrid',
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
			} ,{
				title : 'openId',
				field : 'openId',
				width : 50,
				hidden : true,
			},{
				title : '应用ID',
				field : 'applyId',
				width : 50,
				hidden : true,
			} ] ],
			columns : [ [ {
				field : 'shopName',
				title : '门店名',
				width : 100,
			} ,{
				field : 'name',
				title : '姓名',
				width : 100,
			} ,{
				field : 'mobile',
				title : '手机号',
				width : 100,
			} ,{
				field : 'compamyUserId',
				title : '账号', 
				width : 100,
			} ,{
				field : 'cityName',
				title : '门店所属城市', 
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
	
// 	function formatterdate(val, row) {
// 		if (val != null) {
// 		var date = new Date(val);
// 		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
// 		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
// 		}
// 	}
	function append() {
		awardDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		awardForm.find('[name=name]').removeAttr('readonly');
		awardForm.form('clear');
	}

	function sendRedPack() {
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
			awardForm.find('[name=id]').attr('readonly', 'readonly');
			awardDialog.dialog('open');
			awardForm.form('clear');
			awardForm.form('load', {
				id : rows[0].id,
				openId : rows[0].openId,
				applyId : rows[0].applyId,
				shopName : rows[0].shopName,
				name : rows[0].name,
				compamyUserId : rows[0].compamyUserId,
				mobile : rows[0].mobile
			});
		}
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
			editForm.find('[name=editId]').attr('readonly', 'readonly');
			editDialog.dialog('open');
			editForm.form('clear');
			editForm.form('load', {
				editId : rows[0].id,
				openId : rows[0].openId,
				shopName : rows[0].shopName,
				name : rows[0].name,
				compamyUserId : rows[0].compamyUserId,
				mobile : rows[0].mobile
			});
		}
	}
// 	function del() {
// 		var ids = [];
// 		var rows = datagrid.datagrid('getSelections');
// 		if (rows.length > 0) {
// 			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
// 				if (r) {
// 					for (var i = 0; i < rows.length; i++) {
// 						ids.push(rows[i].id);
// 					}
// 					$.ajax({
// 						url : '${pageContext.request.contextPath}/award.do?del',  
// 						data : {
// 							ids : ids.join(',')
// 						},
// 						cache : false,
// 						dataType : "json",
// 						success : function(response) {
// 							datagrid.datagrid('unselectAll');
// 							datagrid.datagrid('reload');
// 							$.messager.show({
// 								title : '提示',
// 								msg : '删除成功！'
// 							});
// 						}
// 					});
// 				}
// 			});
// 		} else {
// 			$.messager.alert('提示', '请选择要删除的记录！', 'error');
// 		}
// 	}
	
	//查找
	function searchFun() {
		datagrid.datagrid('load',
				{
					shopName : $('#toolbar input[name=shopName]').val(),
					compamyUserId : $('#toolbar input[name=compamyUserId]').val(),
					mobile : $('#toolbar input[name=mobile]').val()
				});
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	function checkAmount(){
		var value = $("#totalAmount").val();
// 		alert(value);
		if(value ==""){
			$("#notes").html("请输入金额").css('color','red');
		}else if((value < 1) || (value >200)){
			$("#notes").html("金额需在1~200之间").css('color','red');
		}else if(value >=1 && value <=200){
			$("#notes").html("");
		}
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
						<th>门店名</th>
						<td><input name="shopName"></td>
						<th>账号</th>
						<td><input name="compamyUserId"></td>
						<th>手机号</th>
						<td><input name="mobile"></td>
					</tr>
					<tr>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0)">添加</a> --> <a
					class="easyui-linkbutton" iconCls="icon-add" onclick="sendRedPack();"
					plain="true" href="javascript:void(0)">发放红包</a><a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">编辑</a><!-- <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> --> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="awardDialog" style="display: none; overflow: hidden;width:400px;min-height:380px;">
		<form id="awardForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
					<th></th>
					<td><input name="openId" type="hidden" /></td>
					<th></th>
					<td><input name="applyId" type="hidden" /></td>
				</tr>
				<tr>
					<th>门店名：</th>
					<td><input name="shopName" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" readOnly="true"/></td>
				</tr>
				<tr>
					<th>姓名：</th>
					<td><input name="name" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" readOnly="true"/></td>
				</tr>
				<tr>
					<th>账号：</th>
					<td><input name="compamyUserId" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" readOnly="true"/></td>
				</tr>
				<tr>
					<th>手机号：</th>
					<td><input name="mobile" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" readOnly="true"/></td>
				</tr>
				<tr>
					<th>红包发送金额：</th>
					<td><input name="totalAmount" id="totalAmount" class="easyui-validatebox" required="true" onblur="checkAmount()"/>元
					    <span id="notes"></span>
					</td>
				</tr>
				<tr>
					<th>红包祝福语：</th>
					<td><input name="wishing" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>活动名称：</th>
					<td><input name="actName" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>备注：</th>
					<td><input name="remark" class="easyui-validatebox"/></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="editDialog" style="display: none; overflow: hidden;width:400px;min-height:380px;">
		<form id="editForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="editId" readonly="readonly" type="hidden" /></td>
					<th></th>
					<td><input name="openId" type="hidden" /></td>
				</tr>
				<tr>
					<th>门店名：</th>
					<td><input name="shopName" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" readOnly="true"/></td>
				</tr>
				<tr>
					<th>姓名：</th>
					<td><input name="name" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<th>账号：</th>
					<td><input name="compamyUserId" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<th>手机号：</th>
					<td><input name="mobile" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>