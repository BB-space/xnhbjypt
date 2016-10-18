<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var verificationDialog;
	var verificationForm;
	var passwordInput;
	$(function() {
		verificationForm = $("#verificationForm").form();

		passwordInput = verificationForm.find('[name=mobile]').validatebox({
			required : true
		});

	

		//页面显示数据
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/verification.do?datagrid',
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
				field : 'mobile',
				title : '会员电话',
				width : 100,
				sortable : true
			} ] ],
			columns : [ [ {
				field : 'code',
				title : '验证码',
				width : 50,
				sortable : true
			},{
				field : 'createDateTime',
				title : '获取时间',
				width : 100,
				formatter:formatterdate
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
	

	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
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
						<th>会员电话</th>
						<td><input name="mobile"></td>
					
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