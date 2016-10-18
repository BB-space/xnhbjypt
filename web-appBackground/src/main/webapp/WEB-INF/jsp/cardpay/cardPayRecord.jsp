<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var cityDialog;
	var cityForm;
	var passwrodInput;
	$(function() {
		cityForm = $("#cityForm").form();

		passwordInput = cityForm.find('[name=name]').validatebox({
			required : true
		});
		cityDialog = $('#cityDialog').show().dialog({
			modal : true,
			title : '取消订单',
			top : '0px',
			width : 450,
			height : 250,
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (cityForm.find('[name=id]').val() != '') {
						cityForm.form('submit', {
							url : '${pageContext.request.contextPath}/cardpayBackground.do?updateOrderStatus',
							success : function(data) {
								cityDialog.dialog('close');
								
								if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
						    		alert('没有登录系统，或登录超时，请重新登录');
						    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
						    		return;
						    	}
								
								$.messager.show({
									title : '提示',
									msg : '取消订单成功！'
								}); 
								searchFun();
							}
						});
					}
				}
			} ]
		}).dialog('close');
			
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/cardpayBackground.do?cardPayDatagrid',
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
				title : '',
				field : 'id',
				width : 50,
				hidden : true,
				checkbox : true
			} ] ],
			columns : [ [ {
				field : 'orderNo',
				title : '订单编号',
				width : 60,
			}, {
				field : 'mobile',
				title : '手机号码',
				width : 70,
			}, {
				field : 'goodsId',
				title : '物品Id',
				width : 100,
				hidden : true,
			}, {
				field : 'goodsName',
				title : '消费项目',
				width : 120,
			}, {
				field : 'quantity',
				title : '数量',
				width : 50,
			}, {
				field : 'price',
				title : '单价',
				width : 50,
			}, {
				field : 'orderTime',
				title : '消费时间',
			 	width : 100,
			 	formatter:function(value,row,index){
			 		if(!!value) {
			 			value = value.substring(0, 16);
			 		}
					return value;
				}
			}, {
				field : 'status',
				title : '订单状态',
				width : 70,
				formatter:function(value,row,index){
					if(value=='1'){
						return "<font style='color:green;'>已确认</font>";
					}else if(value=='0'){
						return "<font style='color:red;'>未确认</font>";
					}else if(value=='2'){
						return "<font style='color:gray;'>已取消</font>";
					}else if(value=='3'){
						return "<font style='color:green;'>已确认</font>";
					}
				}
			}, {
				field : 'remarks',
				title : '取消原因',
				width : 120
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
				names.push(rows[i].title);
			}
			$.messager.show({
				msg : '只能择一条数据 进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '条数据',
				title : '提示'
			});
		} else if (rows.length == 1) {
			if(rows[0].status != '0'){
				$.messager.show({title:'提示',msg:'只能取消状态为【<font style="color:red;">未确认</font>】的订单'});
				return;
			}
			
			$.post("${pageContext.request.contextPath}/cardpayBackground.do?getOrderItemName",
				{"orderId":rows[0].id},
				function(data){
					var d = $.parseJSON(data);
					cityDialog.dialog('open');
					cityForm.form('clear');
					cityForm.form('load', { 
						orderId : rows[0].id,
						orderNo : rows[0].orderNo,
						orderItem : d.msg
					});
			});
			
		}
	}
	
	//查找
	function searchFun() {
		$('#datagrid').datagrid('unselectAll');
		var status = $('#status').combobox('getValue');
		datagrid.datagrid('load',
			{
				mobile : $('#toolbar input[name=mobile]').val(),
				orderNo : $('#toolbar input[name=orderNo]').val(),
				status : status
			});
	}
	
	function clearFun() {
		$('#datagrid').datagrid('unselectAll');
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<fieldset style="border:1px groove #f0f0f0;">
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<td>手机号码</td>
						<td><input name="mobile"></td>
						<td>订单编号</td>
						<td><input name="orderNo"></td>
						<td>订单状态</td>
						<td><select id="status" class="easyui-combobox" name="status" data-options="editable:false" 
							 style="width:150px;">
							    <option value="">请选择</option>
							    <option value="0">未确认</option>
							    <option value="1">已确认</option>
							    <option value="2">已取消</option>
							</select></td>
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
			<div>
			    <a  class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">取消订单</a><a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>  

	<div id="cityDialog" style="display: none; overflow: hidden;">
		<form id="cityForm" method="post">
			<table class="tableForm">
				<tr>
					<td><input name="orderId" type="hidden" /></td>
				</tr>
				<tr>
					<td>订单编号：</td>  
					<td><input name="orderNo" id="order" readonly="readonly" style="width: 360px;"/></td>
				</tr>
				<tr>
					<td>消费项目：</td>  
					<td><textarea name="orderItem" rows="3" cols="30" style="width: 360px;resize:none" readonly="readonly"></textarea></td>
					<!-- <td><input name="orderItem" readonly="readonly" style="width: 230px;"/></td> -->
				</tr>
				<tr>
					<td>取消原因：</td>
					<td><textarea name="remarks" rows="4" cols="30" style="width: 360px;resize:none" maxlength="200"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>