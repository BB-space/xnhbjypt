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
	var unBoundCardDialog;
	var unBoundCardForm;
	var passwrodInput;
	$(function() {
		unBoundCardForm = $("#unBoundCardForm").form();

		passwordInput = unBoundCardForm.find('[name=name]').validatebox({
			required : true
		});
		unBoundCardDialog = $('#unBoundCardDialog').show().dialog({
			modal : true,
			title : '修改卡项信息',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (unBoundCardForm.find('[name=id]').val() != '') {
						unBoundCardForm.form('submit', {
							url : '${pageContext.request.contextPath}/unBoundCard.do?edit',
							success : function(data) {
								unBoundCardDialog.dialog('close');
								$.messager.show({
									msg : '修改卡项信息成功！',
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
			url : '${pageContext.request.contextPath}/unBoundCard.do?datagrid',
			toolbar : '#toolbar',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50],
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
				field : 'companyCode',
				title : '门店编码',
				width : 100,
			} ,{
				field : 'companyName',
				title : '门店名称',
				width : 100,
			} ,{
				field : 'memberNo',
				title : '会员编码',
				width : 100,
			} ,{
				field : 'memberName',
				title : '会员名称',
				width : 100,
			} ,{
				field : 'mobile',
				title : '手机号码',
				width : 100,
			} ,{
				field : 'memberCardCode',
				title : '卡编号',
				width : 100,
			} ,{
				field : 'memberCardTypeCode',
				title : '卡模板编号',
				width : 100,
			} ,{
				field : 'description',
				title : '卡描述',
				width : 100,
			} ,{
				field : 'saleDate',
				title : '售卡日期',
				width : 100,
			} ,{
				field : 'belong',
				title : '所属：siyu、sihui',
				width : 100,
				hidden : true
			} ,{
				field : 'status',
				title : '绑定状态: 0、未绑定，1、绑定',
				width : 100,
				hidden : true
			}] ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
			onLoadError : function(args){
				alert("没有登录系统，或登录超时，请重新登录");
				window.top.location.href = '${pageContext.request.contextPath}/index.jsp';				
			}
		});

	});

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
			unBoundCardForm.find('[name=id]').attr('readonly', 'readonly');
			unBoundCardDialog.dialog('open');
			unBoundCardForm.form('clear');
			unBoundCardForm.form('load', {
				id : rows[0].id,
			});
		}
	}
	function updateBound() {
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您确认要把当前所选卡项设为已绑定？', function(r) {
				if (r) {
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/unBoundCard.do?updateStatus',  
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
								msg : '成功修改绑定状态！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要修改绑定状态的记录！', 'error');
		}
	}
	
	//查找
	function searchFun() {
		datagrid.datagrid('load',
			{
				memberName : $('#toolbar input[name=memberName]').val(),
				mobile : $('#toolbar input[name=mobile]').val()
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
			<fieldset style="border:1px groove #f0f0f0;background-color:#ffffff">
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<th>会员姓名</th>
						<td><input name="memberName"></td>
						<th>电话号码</th>
						<td><input name="mobile"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
					<!-- <tr>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr> -->
				</table>
			</fieldset>
			<!-- <div>
				<a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">编辑</a><a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="updateBound();"
					plain="true" href="javascript:void(0)">已绑定</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div> -->
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="unBoundCardDialog" style="display: none; overflow: hidden;">
		<form id="unBoundCardForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>绑定号码：</th>
					<td><input name="mobile" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" required="true" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>