<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript" charset="UTF-8">

	function exportTen() {
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportTen";
	}
	
	function exportShopTen() {
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportShopTen";
	}
	
	function exportEighteen() {
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportEighteen";
	}
	
	function exportFriend() {
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportFriend";
	}
	
	function exportShopFriend() {
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportShopFriend";
	}
	
	function exportItemGood() {
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportItemGood";
	}
	
	function exportShopItem() {
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportShopItem";
	}
	
	function exportShopGoodOne() {
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportShopGoodOne";
	}
	
	function exportShopGoodTwo() {
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportShopGoodTwo";
	}
	
	function searchTen(type) {
		var url;
		if(type == 'ten') {
			url = '${pageContext.request.contextPath}/reportForm.do?searchTen';
		}else {
			url = '${pageContext.request.contextPath}/reportForm.do?searchEighteen';
		}
		$("#tendatagrid").html("");
		$.post(url,  
			{'page' : 1,
			 'rows' : 10},
		    function(data) {
				var d = $.parseJSON(data);
				$('#tendatagrid').datagrid({
					url : '',
					title : '',
					iconCls : 'icon-save',
					fitColumns : true,
					nowrap : false,
					border : false,
					pagination : true,
					pageSize : 10,
					pageList : [ 10 ],
					idField : 'memberopenid',
					rownumbers : true,  
					singleSelect : true,
					columns : [ [{
						field : 'memberopenid',
						title : 'openId',
						width : 150,
					},{
						field : 'memberMobile',
						title : '手机号',
						width : 100,
					},{
						field : 'getNum1',
						title : '获取数量',
						width : 100,
					},{
						field : 'useNum1',
						title : '使用数量',
						width : 100,
					},{
						field : 'type',
						title : '卡类型',
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
				$('#tendatagrid').datagrid('unselectAll');
				$('#tendatagrid').datagrid({data: d});
				pg = $("#tendatagrid").datagrid("getPager"); 
				if(pg) {  
					instancePagination(pg,url);
				}
		});
	}
	
	function searchShopTen(type){
		var url;
		if(type == 'shopten') {
			url = '${pageContext.request.contextPath}/reportForm.do?searchShopTen';
		}else {
			url = '${pageContext.request.contextPath}/reportForm.do?searchShopFriend';
		}
		$("#tendatagrid").html("");
		$.post(url,  
			{'page' : 1,
			 'rows' : 10},
		    function(data) {
				var d = $.parseJSON(data);
				$('#tendatagrid').datagrid({
					url : '',
					title : '',
					iconCls : 'icon-save',
					fitColumns : true,
					nowrap : false,
					border : false,
					pagination : true,
					pageSize : 10,
					pageList : [ 10 ],
					idField : 'date',
					rownumbers : true,  
					singleSelect : true,
					columns : [ [{
						field : 'date',
						title : '日期',
						width : 150,
					},{
						field : 'shopName',
						title : '门店名',
						width : 100,
					},{
						field : 'staffName',
						title : '员工名字',
						width : 100,
					},{
						field : 'num',
						title : '核销数量',
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
				$('#tendatagrid').datagrid('unselectAll');
				$('#tendatagrid').datagrid({data: d});
				pg = $("#tendatagrid").datagrid("getPager"); 
				if(pg) {  
					instancePagination(pg,url);
				}
		});
	}
	
	function searchFriend() {
		var	url = '${pageContext.request.contextPath}/reportForm.do?searchFriend';
		$("#tendatagrid").html("");
		$.post(url,  
			{'page' : 1,
			 'rows' : 10},
		    function(data) {
				var d = $.parseJSON(data);
				$('#tendatagrid').datagrid({
					url : '',
					title : '',
					iconCls : 'icon-save',
					fitColumns : true,
					nowrap : false,
					border : false,
					pagination : true,
					pageSize : 10,
					pageList : [ 10 ],
					idField : 'openId',
					rownumbers : true,  
					singleSelect : true,
					columns : [ [{
						field : 'openId',
						title : 'openId',
						width : 150,
					},{
						field : 'mobile',
						title : '手机号',
						width : 100,
					},{
						field : 'getNum',
						title : '获取数量',
						width : 100,
					},{
						field : 'giveNum',
						title : '赠送数量',
						width : 100,
					},{
						field : 'receiveNum',
						title : '已被接收数量',
						width : 100,
					},{
						field : 'useNum',
						title : '已使用数量',
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
				$('#tendatagrid').datagrid('unselectAll');
				$('#tendatagrid').datagrid({data: d});
				pg = $("#tendatagrid").datagrid("getPager"); 
				if(pg) {  
					instancePagination(pg,url);
				}
		});
	}
	
	function searchItemGood() {
		var	url = '${pageContext.request.contextPath}/reportForm.do?searchItemGood';
		$("#tendatagrid").html("");
		$.post(url,  
			{'page' : 1,
			 'rows' : 10},
		    function(data) {
				var d = $.parseJSON(data);
				$('#tendatagrid').datagrid({
					url : '',
					title : '',
					iconCls : 'icon-save',
					fitColumns : true,
					nowrap : false,
					border : false,
					pagination : true,
					pageSize : 10,
					pageList : [ 10 ],
					idField : 'openId',
					rownumbers : true,  
					singleSelect : true,
					columns : [ [{
						field : 'openId',
						title : 'openId',
						width : 80,
					},{
						field : 'mobile',
						title : '手机号',
						width : 80,
					},{
						field : 'itemNum1',
						title : '服务券线下获取数量',
						width : 100,
					},{
						field : 'itemNum2',
						title : '服务券线下核销数量',
						width : 100,
					},{
						field : 'itemNum3',
						title : '服务券线上获取数量',
						width : 100,
					},{
						field : 'itemNum4',
						title : '服务券线上核销数量',
						width : 100,
					},{
						field : 'goodNum1',
						title : '348产品券线下获取数量',
						width : 100,
					},{
						field : 'goodNum2',
						title : '348产品券线下核销数量',
						width : 100,
					},{
						field : 'goodNum3',
						title : '348产品券线上获取数量',
						width : 100,
					},{
						field : 'goodNum4',
						title : '348产品券线上核销数量',
						width : 100,
					},{
						field : 'goodNum5',
						title : '108产品券线下获取数量',
						width : 100,
					},{
						field : 'goodNum6',
						title : '108产品券线下核销数量',
						width : 100,
					},{
						field : 'goodNum7',
						title : '108产品券线上获取数量',
						width : 100,
					},{
						field : 'goodNum8',
						title : '108产品券线上核销数量',
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
				$('#tendatagrid').datagrid('unselectAll');
				$('#tendatagrid').datagrid({data: d});
				pg = $("#tendatagrid").datagrid("getPager"); 
				if(pg) {  
					instancePagination(pg,url);
				}
		});
	}
	
	function searchShopItemGood(type) {
		var url;
		if(type == 'fuwu') {
			url = '${pageContext.request.contextPath}/reportForm.do?searchShopItem';
		}else if(type == 'goodOne'){
			url = '${pageContext.request.contextPath}/reportForm.do?searchShopGoodOne';
		}else {
			url = '${pageContext.request.contextPath}/reportForm.do?searchShopGoodTwo';
		}
		$("#tendatagrid").html("");
		$.post(url,  
			{'page' : 1,
			 'rows' : 10},
		    function(data) {
				var d = $.parseJSON(data);
				$('#tendatagrid').datagrid({
					url : '',
					title : '',
					iconCls : 'icon-save',
					fitColumns : true,
					nowrap : false,
					border : false,
					pagination : true,
					pageSize : 10,
					pageList : [ 10 ],
					idField : 'date',
					rownumbers : true,  
					singleSelect : true,
					columns : [ [{
						field : 'date',
						title : '日期',
						width : 150,
					},{
						field : 'shopName',
						title : '门店名',
						width : 100,
					},{
						field : 'staffName',
						title : '员工名字',
						width : 100,
					},{
						field : 'num',
						title : '核销数量',
						width : 100,
					},{
						field : 'status',
						title : '购买方式',
						width : 100,
					},{
						field : 'type',
						title : '卡类型',
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
				$('#tendatagrid').datagrid('unselectAll');
				$('#tendatagrid').datagrid({data: d});
				pg = $("#tendatagrid").datagrid("getPager"); 
				if(pg) {  
					instancePagination(pg,url);
				}
		});
	}
	
	function instancePagination(pg,url) {
		$(pg).pagination({
			onBeforeRefresh:function(){  
			},  
			onRefresh:function(pageNumber,pageSize){  
	    	   $.post(url,  
    				{'page' : pageNumber,
    				 'rows' : pageSize},
    			    function(data) {
					 	if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
				    		alert('没有登录系统，或登录超时，请重新登录1');
				    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
				    		return;
				    	}
    			    	var d = $.parseJSON(data);
    			    	$('#tendatagrid').datagrid('unselectAll');
    			    	$('#tendatagrid').datagrid('loadData',d);
	    		});  
	        },  
	       onChangePageSize:function(){  
	       },  
	       onSelectPage:function(pageNumber,pageSize){
	    	   $.post(url,  
    				{'page' : pageNumber,
    				 'rows' : pageSize},
    			    function(data) {
    					 if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
    				    		alert('没有登录系统，或登录超时，请重新登录2');
    				    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
    				    		return;
    				    	}
    			    	var d = $.parseJSON(data);
    			    	$('#tendatagrid').datagrid('unselectAll');
    			    	$('#tendatagrid').datagrid('loadData',d);
	    		});
	        }  
	   });
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<fieldset>
				<legend>导出</legend>
				<table class="tableForm">
					<tr>
						<th>10元券</th>
						<td><a class="easyui-linkbutton" plain="true" onclick="searchTen('ten');">查找</a></td>
						<td>
							<a class="easyui-linkbutton" plain="true" onclick="exportTen();">导出</a>
						</td>
						<th>门店核销10元券</th>
						<td><a class="easyui-linkbutton" plain="true" onclick="searchShopTen('shopten');">查找</a></td>
						<td>
							<a class="easyui-linkbutton" plain="true" onclick="exportShopTen();">导出</a>
						</td>
						<th>18元券</th>
						<td><a class="easyui-linkbutton" plain="true" onclick="searchTen('eighteen');">查找</a></td>
						<td>
							<a class="easyui-linkbutton" plain="true" onclick="exportEighteen();">导出</a>
						</td>
					</tr>
					<tr>
						<th>亲友券</th>
						<td><a class="easyui-linkbutton" plain="true" onclick="searchFriend();">查找</a></td>
						<td>
							<a class="easyui-linkbutton" plain="true" onclick="exportFriend();">导出</a>
						</td>
						<th>门店核销亲友券</th>
						<td><a class="easyui-linkbutton" plain="true" onclick="searchShopTen('shopfriend');">查找</a></td>
						<td>
							<a class="easyui-linkbutton" plain="true" onclick="exportShopFriend();">导出</a>
						</td>
					</tr>
					<tr>
						<th>会员项目券和产品券</th>
						<td><a class="easyui-linkbutton" plain="true" onclick="searchItemGood();">查找</a></td>
						<td>
							<a class="easyui-linkbutton" plain="true" onclick="exportItemGood();">导出</a>
						</td>
						<th>门店核销服务券</th>
						<td><a class="easyui-linkbutton" plain="true" onclick="searchShopItemGood('fuwu');">查找</a></td>
						<td>
							<a class="easyui-linkbutton" plain="true" onclick="exportShopItem();">导出</a>
						</td>
						<th>门店核销348产品券</th>
						<td><a class="easyui-linkbutton" plain="true" onclick="searchShopItemGood('goodOne');">查找</a></td>
						<td>
							<a class="easyui-linkbutton" plain="true" onclick="exportShopGoodOne();">导出</a>
						</td>
						<th>门店核销108产品券</th>
						<td><a class="easyui-linkbutton" plain="true" onclick="searchShopItemGood('goodTwo');">查找</a></td>
						<td>
							<a class="easyui-linkbutton" plain="true" onclick="exportShopGoodTwo();">导出</a>
						</td>
					</tr>
				</table>
			</fieldset>
		</div>
		<table id="tendatagrid"></table>
	</div> 
</body>
</html>