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
	$(function() {
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/userCardVerify.do?employeeViewDatagrid',
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
				field : 'dateTime',
				title : '核销日期',
				width : 100,
			 	formatter:function(value,row,index){
			 		if(!!value) {
			 			value = value.substring(0, 16);
			 		}
					return value;
				}
			}, {
				field : 'cityName',
				title : '城市',
				width : 70,
			}, {
				field : 'shopName',
				title : '门店名',
				width : 100,
			}, {
				field : 'userName',
				title : '核销人',
				width : 100,
			}, {
				field : 'verifyNumber',
				title : '核销数量',
				width : 120,
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
		
		$("#cityName").combobox({
			valueField: 'cityName',
	        textField: 'cityName',
	        url: 'userCardVerify.do?employeeCityName',
	        onSelect: function(record){
	        }
		});

	});

	//查找
	function searchFun() {
		$('#datagrid').datagrid('unselectAll');
		datagrid.datagrid('load',
			{
				fromDate : $('#fromDate').datebox('getValue'), 
				toDate : $('#toDate').datebox('getValue'), 
				cityName : $('#cityName').combobox('getValue')
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
						<td>开始日期</td>
						<td><input name="fromDate" class="easyui-datebox" data-options="editable:false"  
						    id="fromDate"/></td>
						<td>结束日期</td>
						<td><input name="toDate" class="easyui-datebox" data-options="editable:false"  
						    id="toDate"/></td>
						<td>城市</td>
						<td><select id="cityName" class="easyui-combobox" name="cityName" data-options="editable:false" 
							 style="width:150px;">
							    <option value="">请选择</option>
							</select></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
		</div>
		<table id="datagrid"></table>
	</div>  
</body>
</html>