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
	var moneyDialog;
	var moneyForm;
	var passwordInput;
	$(function() {
		moneyForm = $("#moneyForm").form();

		passwordInput = moneyForm.find('[name=name]').validatebox({
			required : true
		});
		moneyDialog = $('#moneyDialog').show().dialog({
			modal : true,
			title : '退款补推红包',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (moneyForm.find('[name=id]').val() != '') {
						moneyForm.form('submit', {
							url : '${pageContext.request.contextPath}/money.do?editPush',
							success : function(data) {
								var d = $.parseJSON(data);
								if(d.success){
									moneyDialog.dialog('close');
									$.messager.show({
										msg : '补推成功！',
										title : '提示'
									}); 
									datagrid.datagrid('reload');
								}else{
									$.messager.show({
										msg : '补推失败！',
										title : '提示'
									});
								}
								
							}
						});
					} /* else { 
						moneyForm.form('submit', {
							url : '${pageContext.request.contextPath}/money.do?addVote',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d.success) {
										moneyDialog.dialog('close');
										$.messager.show({
											msg : '添加奖品成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}else {
										$.messager.show({
											msg : '图片不可为空！',
											title : '提示'
										});
									}
								} catch (e) {
									moneyDialog.dialog('close');
									$.messager.show({
										msg : '添加奖品失败！',
										title : '提示'
									});
									datagrid.datagrid('reload');
								}
							}
						});
					} */
				}
			} ]
		}).dialog('close');
			
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/money.do?datagrid',
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
				field : 'reOpenid',
				title : 'reOpenid', 
				width : 50,
				hidden : true,
			} ,{
				field : 'mobile',
				title : '接收人号码',
				width : 50,
			} ,{
				field : 'mchBillno',
				title : '商户订单号 ',
				width : 70,
			} ,{
				field : 'totalAmount',
				title : '发放金额',
				width : 50,
			},{
				field : 'createDateTime',
				title : '发放时间',
				width : 50,
				formatter:formatterdate,
			} ,{
				field : 'status',
				title : '发放类型',
				width : 50,
				formatter : function(value, rowData, rowIndex) {
					if(value == '1')  {
						return '正常发放';
					}else if(value == '2')  {
						return '补推发放';
					}
				}
			},{
				field : 'receiveStatus',
				title : '领取状态',
				width : 50,
				formatter : function(value, rowData, rowIndex) {
					if(value == '1')  {
						return "<font style='color:break;'>已领取</font>";
					}else if(value == '2')  {
						return "<font style='color:red;'>已退款</font>";
					}else{
						return "<font style='color:green;'>已发放待领取</font>";
					}
				}
			} ,{
				field : 'receiveTime',
				title : '领取/退款时间',
				width : 50,
				formatter:formatterdate,
			} ,{
				field : 'pushId',
				title : '补推Id',
				width : 50,
				hidden : true,
			},{
				field : 'pushStatus',
				title : '补推状态',
				width : 50,
			} ,{
				field : 'pushTime',
				title : '补推时间',
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
		moneyDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		moneyForm.find('[name=name]').removeAttr('readonly');
		moneyForm.form('clear');
		moneyForm.form('load', {
			promotion : 0
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
			if(rows[0].receiveStatus != '2'){//退款
				$.messager.show({
					msg : '只能操作退款的数据',
					title : '提示'
				});
				return ;
			}
			passwordInput.validatebox({
				required : false
			});
			moneyForm.find('[name=id]').attr('readonly', 'readonly');
			moneyDialog.dialog('open');
			moneyForm.form('clear');
			moneyForm.form('load', {
				id : rows[0].id,
				reOpenid : rows[0].reOpenid,
				mobile : rows[0].mobile,
				totalAmount : rows[0].totalAmount,
				wxappid : rows[0].wxappid,
				mchId : rows[0].mchId,
			});
		}
	}

	//查找
	function searchFun() {
		datagrid.datagrid('load',
				{
			mobile : $('#toolbar input[name=mobile]').val(),
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
						<th>接收者号码</th>
						<td><input name="mobile"></td>
					
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0)">增加</a> --> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">补推</a><!-- <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> --> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="moneyDialog" style="display: none; overflow: hidden;">
		<form id="moneyForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
					<th></th>
					<td><input name="reOpenid" type="hidden" /></td>
				</tr>
				<tr>
					<th></th>
					<td><input name="wxappid" type="hidden" /></td>
					<th></th>
					<td><input name="mchId" type="hidden" /></td>
				</tr>
				<tr>
					<th>手机号：</th>
					<td><input name="mobile" style="width: 200px;" readonly="readonly"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>金额：</th>
					<td><input name="totalAmount" placeholder="单位：元" style="width: 200px;" class="easyui-validatebox" required="true"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>