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
	var shopDialog;
	var shopForm;
	var passwrodInput;
	$(function() {
		shopForm = $("#shopForm").form();

		passwordInput = shopForm.find('[name=name]').validatebox({
			required : true
		});
			
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/showTable.do?datagrid',
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
				title : '门店编号',
				field : 'fldCompanyCode',
				width : 50,

			} ] ],
			columns : [ [ {
				field : 'fldCompanyName1',
				title : '门店名称',
				width : 100,
			}, {
				field : 'fldMemberNo',
				title : '会员编码',
				width : 100,
			},{
				field : 'fldName1',
				title : '会员名称',
				width : 100,
			},{
				field : 'num',
				title : '数量',
				width : 100,
			},{
				field : 'mdlx',
				title : '数量合计',
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
			}
		});

	});



</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">

		</div>
		<table id="datagrid"></table>
	</div>  


</body>
</html>