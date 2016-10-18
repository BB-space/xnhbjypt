<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<jsp:include page="../common/inc/xheditor.jsp"></jsp:include>
<style type="text/css">
.head_top{
	margin:10px 0 0 5px;
}
.hf{
	float:left;
}
.tableForm tr td{
	line-height: 35px;
}
ul li{
	list-style: none;
	float:left;
	width:20%;
}
</style>

<script type="text/javascript" charset="UTF-8">
var datagrid;
var commonDialog;
var commonForm;

$(function() {
	datagrid = $('#datagrid').datagrid({
		url : '${pageContext.request.contextPath}/invoicePicking/detailDatagrid.do',
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
		singleSelect:false,
		idField : 'id',
		frozenColumns : [ [ {
			title : 'id',
			field : 'id',
			width : 50,
			hidden : true,
			checkbox : false
		},{
			field : 'goodsNo',
			title : '产品代码',
			width : 100,
		} ] ],
		columns :[[{
			field : 'goodsName',
			title : '产品名称',
			width : 100,
		},{
			field : 'quantity',
			title : '数量',
			width : 100,
		}]]
	});

});
function operate(){
	if(confirm('确认扫码完成')){
		$.post('${pageContext.request.contextPath}/barCodeCheck/barCodeAudit.do',function(data){
			window.location.href='${pageContext.request.contextPath}/barCodeCheck/barCodeCheck.do';
		})		
	}
}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<div class="head_top">
			<div style="float:left;"> 产品供应管理>>发货单明细</div>
			<div style="text-align:right;">
				<button onclick="window.location.href='${pageContext.request.contextPath}/barCodeCheck/barCodeCheck.do'">>>返回</button>
			</div>
		</div>
		<div class="widget_main">
			<div style="text-align: right"><button >开始验货</button>&nbsp;<button onclick="operate();">操作完成</button></div>
			<div>
				<ul>
					<li>客户：${deliveryManageM.username}</li>
					<li>发货单号:${deliveryManageM.deliveryNo}</li>
					<li>下单日期：${deliveryManageM.orderTime}</li>
					<li>处理状态：<c:if test="${deliveryManageM.deliveryStatus==1}">待分仓拣货</c:if></li>
				</ul>
				<div style="clear:both"></div>
			</div>
		</div>
		<br>
		<table id="datagrid"></table>
	</div>
</body>
</html>