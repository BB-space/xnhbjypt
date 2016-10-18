<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript">
	var datagrid;
	var balanceForm;
	$(function() {
		balanceForm = $("#balanceForm").form();

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/balance.do?datagrid',
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
				/* field : 'companyCode',
				title : '门店编码',
				width : 80,
			} ,{
				field : 'companyName',
				title : '门店名称',
				width : 130,
			} ,{
				field : 'memberNo',
				title : '会员编码',
				width : 80,
			} ,{
				field : 'memberName',
				title : '会员名称',
				width : 80,
			} ,{ */
				field : 'mobile',
				title : '手机号码',
				width : 80,
			} ,{
				field : 'fldMemberCardCode',
				title : '卡编号',
				width : 120,
			} ,{
				field : 'cardTypeName',
				title : '卡描述',
				width : 100,
			} ,{
				field : 'fldOutstanding',
				title : '余额',
				width : 80,
			} ,{
				field : 'type',
				title : '所属',
				width : 80,
				formatter:function(value,row,index){
			 		if(value == 'siyu') {
			 			return '丝域';
			 		}else if(value == 'sihui'){
			 			return '丝荟';
			 		}
					return value;
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
			},
			onLoadError : function(args){
				alert("没有登录系统，或登录超时，请重新登录");
				window.top.location.href = '${pageContext.request.contextPath}/index.jsp';				
			}
		});

	});
	
	//查找
	function searchFun() {
		datagrid.datagrid('unselectAll');
		datagrid.datagrid('load',
			{
				mobile : $('#toolbar input[name=mobile]').val()
			});
	}
	
	function clearFun() {
		datagrid.datagrid('unselectAll');
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
						<th>电话号码</th>
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