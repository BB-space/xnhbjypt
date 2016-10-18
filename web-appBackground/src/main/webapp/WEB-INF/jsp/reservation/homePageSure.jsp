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
	var reserTimes="";
	function cancelReservation(){
		var rows = datagridSure.datagrid('getSelections');
		id=rows[0].id;
// 		alert(id);
		 $.messager.confirm('请确认', '您确定要取消此预约吗？', function(data){
			if(data){
				$.ajax({
					url : '${pageContext.request.contextPath}/reservation.do?cancelReservations',
					data : {
						ids : id
					},
					cache : false,
					dataType : "json",
					success : function(response) {
						datagridSure.datagrid('unselectAll');
						datagridSure.datagrid('reload');
						$.messager.show({
							title : '提示',
							msg : '取消预约成功！'
						});
					}
				});
				//window.location.href="reservation.do?addCancelReservations&ids="+id;
			}
		}); 
	}
    var datagridSure;
	var tableForm;
	var passwordInput;
	
	$(function() {

		passwordInput = timeForm.find('[name=password]').validatebox({
			required : true
		});
		
		//页面显示数据
		datagridSure = $('#datagridSure').datagrid({
			url : '${pageContext.request.contextPath}/reservation.do?datagridSure',
			toolbar : '#toolbars',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
			fit : true,
			//height:600,
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
				/*} , {
				field : 'memberName',
				title : '会员名',
				width : 100,
				sortable : true  */
			} ] ],
			columns : [ [ {
				field : 'mobile',
				title : '会员电话',
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
			/*  },{
				field : 'we',
				title : '操作',
				align : 'center',
				width : 100,
				formatter : function(value,row,index){
					return "<div><span onclick='cancelReservation()'> 取消预约</span></div>";
				} */
			} ] ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagridSure('unselectAll');
				$(this).datagridSure('selectRow', rowIndex);
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
		datagridSure.datagrid('load',
		{
			mobile :  $('#toolbars input[name=mobile]').val(),
			time : $('#toolbars input[comboname=time]').datebox('getValue'),
		
		});
	}

	//清空
	function clearFun() {
		$('#toolbars input').val('');
		datagrid.datagrid('load', {});
	}
	
	function arriveShop(){
		var rows = datagridSure.datagrid('getSelections');
		id=rows[0].id;
// 		alert(id);
		 $.messager.confirm('请确认', '您确定要操作此预约吗？', function(data){
			if(data){
				$.ajax({
					url : '${pageContext.request.contextPath}/reservation.do?arriveShop',
					data : {
						id : id
					},
					cache : false,
					dataType : "json",
					success : function(response) {
						datagridSure.datagrid('unselectAll');
						datagridSure.datagrid('reload');
						$.messager.show({
							title : '提示',
							msg : '已到店成功！'
						});
					}
				});
			}
		}); 
	}

</script>
</head>
<body style="border:1px red solid">
	<div region="center" style="overflow: hidden;" class="easyui-layout" fit="true" >
		<div id="toolbars" class="datagrid-toolbar">
			<fieldset>
				<legend>会员确认预约</legend>
				<table class="tableForm">
					<tr>
						<th>会员电话</th>
						<td><input name="mobile"></td>
						<th>预约时间</th>
						<td><input name="time" class="easyui-datebox"  
						    id="time"/></td>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
				
			</fieldset>
			<div>
				<a
					class="easyui-linkbutton" iconCls="icon-add" onclick="arriveShop()"
					plain="true" href="javascript:void(0);">已到店</a> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="cancelReservation();"
					plain="true" href="javascript:void(0);">取消预约</a>  <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagridSure.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		
		</div>
		<table id="datagridSure"></table>
	</div>  
</body>
</html>