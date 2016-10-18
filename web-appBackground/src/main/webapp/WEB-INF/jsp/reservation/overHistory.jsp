<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>

<style type="text/css">
	 
	.reserTop{
		font-size: 1.5rem;
		margin: 0.2rem;
	}
	.submit{
	width: 5em;
	height: 2em;
	background-color:rgb(59,153,204);
	color:white;
	margin-top: 0.2rem;
	}
	
	.font{
		font-size: 0.8rem;
		text-align: center;
	}
	.stamp{
		width: 40%;
		margin: 1rem 2rem;
		border:1px red solid;
	}
	.submitCancel{
	width: 5em;
	height: 2em;
	background-color:#808080;
	color:white;
	margin-top: 0.2rem;
	}
</style>
<script type="text/javascript">
    var datagrid;
	$(function() {
		
		//页面显示数据
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/historyReservation.do?datagridOver',
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
			singleSelect : true,//单选 
			rownumbers : true,
			idField : 'id',
			frozenColumns : [ [ {                               
				title : 'id',
				field : 'id',
				width : 50,
				hidden : true
			} ] ],
			columns : [ [ {
				field : 'shopName',
				title : '预约门店',
				width : 100,
				sortable : true  
			}, {
				field : 'mobile',
				title : '预约手机',
				width : 100,
				sortable : true
			},{
				field : 'productName',
				title : '预约项目',
				width : 100,
				sortable : true
			},{
				field : 'reservationTime',
				title : '预约时间',
				width : 100,
				formatter:formatterdate
			},{
				field : 'createDateTime',
				title : '创建时间',
				width : 100,
				formatter:formatterdate
			},{
				field : 'reservationStatus',
				title : '状态',
				width : 100,
				formatter : function(value, rowData, rowIndex) {
					if (value == '0') {
						return '待确认';
					} else if(value == '1')  {
						return '预约成功';
					}else if(value == '2')  {
						return '取消预约';
					}else if(value == '3')  {
						return '失约';
					}else if(value == '4'){
						return '已到店';
					}else{
						return '未知';
					}
				}
			},{
				field : 'disposeDateTime',
				title : '门店处理时间',
				width : 100,
				formatter:formatterdate
			},{
				field : 'describes',
				title : '备注',
				width : 100,
				sortable : true
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
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	//查找
	function searchFun() {
		//alert($('#reservationStatus').val());
		datagrid.datagrid('load',
		{
			shopName : $('#toolbar input[name=shopName]').val(),
			mobile :  $('#toolbar input[name=mobile]').val(),
			reservationStatus :  $('#reservationStatus').val(),
			startTime : $('#toolbar input[comboname=startTime]').datetimebox('getValue'),
			endTime : $('#toolbar input[comboname=endTime]').datetimebox('getValue'),
		});
	}

	//清空
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	
</script>
</head>
<body class="easyui-layout" fit="true" >
	<div region="center" >
		<div style="height: auto; display: none;" id="toolbar" class="datagrid-toolbar" >
			<fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<th>预约门店</th>
						<td><input name="shopName" /><td>
						<th>预约手机</th>
						<td><input name="mobile"></td>
						<th>状态</th>
						<td>
							<select name="reservationStatus" id="reservationStatus">
							<option value="">请选择预约状态</option>
							<option value="0">待确认</option>
							<option value="1">预约成功</option>
							<option value="2">取消预约</option>
							<option value="3">失约</option>
							<option value="4">已到店</option>
							</select>
						</td>
						
						<th>开始时间</th>
						<td><input name="startTime" class="easyui-datetimebox"  
						    id="startTime"/></td>
						<th>结束时间</th>
						<td><input name="endTime" class="easyui-datetimebox"  
						    id="endTime"/></td>
					
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