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
	var queryDialog;
	var queryForm;
	var passwrodInput;
	$(function() {
		queryForm = $("#queryForm").form();

		passwordInput = queryForm.find('[name=name]').validatebox({
			required : true
		});
		$("#datagrid").html("");
		var	url = '${pageContext.request.contextPath}/queryMemberCard.do?datagird';
		grid(url,'',2,'','');
	});
	
	function instancePagination(pg,url,mobile,status,memberName,cardName) {
		$(pg).pagination({
			onBeforeRefresh:function(){  
			},  
			onRefresh:function(pageNumber,pageSize){  
	    	   $.post(url,  
    				{'page' : pageNumber,
    				 'rows' : pageSize,
    				 'shortNumber' : '${userM.shortNumber}',
    				 'mobile' : mobile,
    				 'status' : status,
    				 'memberName' : memberName,
    				 'cardName' : cardName},
    			    function(data) {
					 	if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
				    		alert('没有登录系统，或登录超时，请重新登录');
				    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
				    		return;
				    	}
    			    	var d = $.parseJSON(data);
    			    	$('#datagrid').datagrid('unselectAll');
    			    	$('#datagrid').datagrid('loadData',d);
	    		});  
	        },  
	       onChangePageSize:function(){  
	       },  
	       onSelectPage:function(pageNumber,pageSize){
	    	   $.post(url,  
    				{'page' : pageNumber,
    				 'rows' : pageSize,
    				 'shortNumber' : '${userM.shortNumber}',
    				 'mobile' : mobile,
    				 'status' : status,
    				 'memberName' : memberName,
    				 'cardName' : cardName},
    			    function(data) {
    					 if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
    				    		alert('没有登录系统，或登录超时，请重新登录');
    				    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
    				    		return;
    				    	}
    			    	var d = $.parseJSON(data);
    			    	$('#datagrid').datagrid('unselectAll');
    			    	$('#datagrid').datagrid('loadData',d);
	    		});
	        }  
	   });
	}
	
	//查找
	function searchFun() {
		var mobile = $("#mobile").val();
		var status = $("#status").val();
		var memberName = $("#memberName").val();
		var cardName = $("#cardName").val();
		var url = '${pageContext.request.contextPath}/queryMemberCard.do?datagird';
		grid(url,mobile,status,memberName,cardName);
	}
	
	function grid(url,mobile,status,memberName,cardName){
		$.post(url,  
				{'page' : 1,
				 'rows' : 15,
				 'shortNumber' : '${userM.shortNumber}',
				 'mobile' : mobile,
				 'status' : status,
				 'memberName' : memberName,
				 'cardName' : cardName},
			    function(data) {
					var d = $.parseJSON(data);
					$('#datagrid').datagrid({
						url : '',
						toolbar : '#toolbar',
						title : '',
						iconCls : 'icon-save',
						pagination : true,
						pageSize : 15,
						pageList : [15],
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
							field : 'memberName',
							title : '姓名',
							width : 100,
						},{
							field : 'mobile',
							title : '手机号',
							width : 100,
						},{
							field : 'cardName',
							title : '卡券名称',
							width : 100,
						},{
							field : 'status',
							title : '使用状态',
							width : 100,
							formatter:function(value,row,index){
								if(value=='1'){
									return "已使用";
								}else if(value=='0'){
									return "未使用";
								}
							}
						},{
							field : 'deadlinesStr',
							title : '截止日期',
							width : 100,
						}] ],
						onRowContextMenu : function(e, rowIndex, rowData) {
							e.preventDefault();
							$(this).datagrid('unselectAll');
							$(this).datagrid('selectRow', rowIndex);
						},
						onLoadError : function(args){
							alert("没有登录系统，或登录超时，请重新登录");
							window.top.location.href = '${pageContext.request.contextPath}/index.jsp';		
						}
					});
					$('#datagrid').datagrid('unselectAll');
					$('#datagrid').datagrid({data: d});
					pg = $("#datagrid").datagrid("getPager"); 
					if(pg) {  
						instancePagination(pg,url,mobile,status,memberName,cardName);
					}
				 });
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		var url = '${pageContext.request.contextPath}/queryMemberCard.do?datagird';
		grid(url,'',2,'','');
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
						<th>会员手机号</th>
						<td><input name="mobile" id="mobile"></td>
						<th>会员姓名</th>
						<td><input name="memberName" id="memberName"></td>
						<th>卡券类型</th>
						<td><input name="cardName" id="cardName"></td>
						<th>使用状态</th>
						<td>
							<select id="status" name="status"  class="easyui-validatebox" required="true">
								<option value="2"></option>
								<option value="1">已使用</option>
								<option value="0">未使用</option>
							</select>
						</td>
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