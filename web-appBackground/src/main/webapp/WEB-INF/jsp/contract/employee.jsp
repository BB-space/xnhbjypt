<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/account.css">
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var contractDialog;
	var contractForm;
	var passwrodInput;
	var totalEmp = '${totalEmp}';
	var month = '${month}';
	var endTime = localStorage.endTime;
	var beginTime = localStorage.beginTime;
	console.log(beginTime+" "+endTime+" "+month);
	
	$(function() {
		$("#totalEmp").html(totalEmp);
		
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/account.do?employeeDetail',
			toolbar : '#toolbar',
			title : '',
			iconCls : 'icon-save',
			pagination : false,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'id',
			singleSelect : true,//单选 
			rownumbers : false,
			columns : [ [ {
				field : 'id',
				title : '序列',
				hidden:true,
			},{
				field : 'shopName',
				title : '门店名称',
				width : '20%',
				align : 'center',
			},{
				field : 'employeeName',
				title : '员工姓名',
				width : '20%',
				align : 'center',
			} ,{
				field : 'employeeMobile',
				title : '手机号码',
				width : '20%',
				align : 'center',
			} ,{
				field : 'payment',
				title : '员工销售金额',
				width : '20%',
				align : 'center',
			} ,{
				field : 'content',
				title : '操作', 
				width : '20%',
				align : 'center',
				formatter: function(value,row,index){
					return '<div class="color1" onclick="getDetailLink('+index+')" >查询销售详情</div>';
				}
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
	function searchFun() {
		datagrid.datagrid('load',
				{
			employeeName : $('#toolbar input[name=employeeName]').val(),
			employeeMobile : $('#toolbar input[name=employeeMobile]').val()
				});
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	
	function empComeBg(){
		window.location.href="${pageContext.request.contextPath}/account.do?monthIndex&beginTime="
    		+beginTime+"&endTime="+endTime+"&month="+month;
	}
	function getDetailLink(index){
		var row = $('#datagrid').datagrid('getData').rows[index];
		console.log(row.employeeName+" "+row.employeeMobile+" "+row.payment);
		localStorage.employeeName = row.employeeName;
		window.location.href="${pageContext.request.contextPath}/account.do?product&totalPro="+row.payment
				+"&employeeMobile="+row.employeeMobile;
	}
</script>
<style type="text/css">
</style>
</head>
<body class="easyui-layout" fit="true">
    <div id="empDiv" class="empDiv" region="center" border="false" style="height:100%;">
	    <div class="contract_top font1">
			<span class="comback" onclick="empComeBg()">确认款项</span><span class="rightAngle"></span>
			<span>${month }月数据分析</span><span class="rightAngle"></span>
		</div>
		<div id="toolbar" class="" style="height: auto;">
				<table class="tableForm font1">
					<tr class="search-Height">
						<th>员工姓名</th>
						<td><input id="employeeName" name="employeeName"></td>
						<th>手机号码</th>
						<td><input id="employeeMobile" name="employeeMobile"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table> 
		 </div>
		 <div class="datagridTable"><table id="datagrid" ></table></div>
		 <div class="footBg font1 marTop">门店总销售额&nbsp;<span id="totalEmp" class="font2"></span></div>
	</div>
</body>
</html>