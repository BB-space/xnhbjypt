<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript" charset="UTF-8">
    $(function(){
//     	$("#zyDiv").hide();
    });
	function exportzzf() {
		var beginTime = $("#beginTime").datebox('getValue');
		var endTime = $("#endTime").datebox('getValue');
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportzzf&beginTime="+beginTime+"&endTime="+endTime;
	}
	
	function exportgsq() {
		var beginTime = $("#beginTimeGSQ").datebox('getValue');
		var endTime = $("#endTimeGSQ").datebox('getValue');
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportgsq&beginTime="+beginTime+"&endTime="+endTime;
	}
	function exportbsx() {
		var beginTime = $("#beginTimeBSX").datebox('getValue');
		var endTime = $("#endTimeBSX").datebox('getValue');
		window.location.href="${pageContext.request.contextPath}/reportForm.do?exportbsx&beginTime="+beginTime+"&endTime="+endTime;
	}
	
	function searchzzf() {
		var beginTime = $("#beginTime").datebox('getValue');
		var endTime = $("#endTime").datebox('getValue');
// 		alert(beginTime+" "+endTime);
		$("#datagrid").html("");
		$.post('reportForm.do?searchzzf',  
			{'beginTime': beginTime,
			 'endTime': endTime},
		    function(data) {
				var d = $.parseJSON(data);
				$('#datagrid').datagrid({
					url : '',
					title : '',
					iconCls : 'icon-save',
					fitColumns : true,
					nowrap : false,
					border : false,
					pagination : false,
					pageSize : 10,
					pageList : [ 10 ],
					idField : 'id',
					rownumbers : true,  
					singleSelect : true,
					columns : [ [{
						field : 'id',
						title : '序列',
						width : 50,
						hidden:true,
					},{
						field : 'shop',
						title : '预约门店',
						width : 150,
					},{
						field : 'shopNum',
						title : '预约次数',
						width : 100,
					},{
						field : 'subscribeProject',
						title : '预约项目',
						width : 100,
					},{
						field : 'projectNum',
						title : '预约次数',
						width : 80,
					},{
						field : 'subscribeTime',
						title : '预约时间',
						width : 100,
					},{
						field : 'stimeNum',
						title : '次数',
						width : 100,
					},{
						field : 'createTime',
						title : '创建时间',
						width : 100,
					},{
						field : 'ctimeNum',
						title : '创建人数',
						width : 100,
					},{
						field : 'otherStatus',
						title : '状态',
						width : 100,
					},{
						field : 'statusNum',
						title : '次数',
						width : 100,
					},{
						field : 'yktSubscribeNum',
						title : '一卡通客人预约数量',
						width : 100,
					},{
						field : 'timeOut15Num',
						title : '超过15分钟没有处理预约次数',
						width : 100,
					},{
						field : 'subscribeAllManNum',
						title : '预约总人数',
						width : 100,
					},{
						field : 'subscribeAllNum',
						title : '预约总次数',
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
				/* pg = $("#datagrid").datagrid("getPager"); 
				if(pg) {  
					instancePagination(pg,url);
				} */
		});
	}
	
	function searchgsq(){
		var beginTime = $("#beginTimeGSQ").datebox('getValue');
		var endTime = $("#endTimeGSQ").datebox('getValue');
		$("#datagrid").html("");
		$.post('reportForm.do?searchgsq',  
				{'beginTime': beginTime,
				 'endTime': endTime},
			    function(data) {
					var d = $.parseJSON(data);
					$('#datagrid').datagrid({
						url : '',
						title : '',
						iconCls : 'icon-save',
						fitColumns : true,
						nowrap : false,
						border : false,
						pagination : false,
						pageSize : 10,
						pageList : [ 10 ],
						idField : 'id',
						rownumbers : true,  
						singleSelect : true,
						columns : [ [{
							field : 'id',
							title : '序列',
							width : 50,
							hidden:true,
						},{
							field : 'shop',
							title : '预约门店',
							width : 150,
						},{
							field : 'shopNum',
							title : '预约次数',
							width : 100,
						},{
							field : 'subscribeProject',
							title : '预约项目',
							width : 100,
						},{
							field : 'projectNum',
							title : '预约次数',
							width : 80,
						},{
							field : 'subscribeTime',
							title : '预约时间',
							width : 100,
						},{
							field : 'stimeNum',
							title : '次数',
							width : 100,
						},{
							field : 'createTime',
							title : '创建时间',
							width : 100,
						},{
							field : 'ctimeNum',
							title : '创建人数',
							width : 100,
						},{
							field : 'otherStatus',
							title : '状态',
							width : 100,
						},{
							field : 'statusNum',
							title : '次数',
							width : 100,
						},{
							field : 'yktSubscribeNum',
							title : '一卡通客人预约数量',
							width : 100,
						},{
							field : 'timeOut15Num',
							title : '超过15分钟没有处理预约次数',
							width : 100,
						},{
							field : 'subscribeAllManNum',
							title : '预约总人数',
							width : 100,
						},{
							field : 'subscribeAllNum',
							title : '预约总次数',
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
			});
	}
	
	function searchbsx(){
		var beginTime = $("#beginTimeBSX").datebox('getValue');
		var endTime = $("#endTimeBSX").datebox('getValue');
		$("#datagrid").html("");
		$.post('reportForm.do?searchbsx',  
				{'beginTime': beginTime,
				 'endTime': endTime},
			    function(data) {
					var d = $.parseJSON(data);
					$('#datagrid').datagrid({
						url : '',
						title : '',
						iconCls : 'icon-save',
						fitColumns : true,
						nowrap : false,
						border : false,
						pagination : false,
						pageSize : 10,
						pageList : [ 10 ],
						idField : 'id',
						rownumbers : true,  
						singleSelect : true,
						columns : [ [{
							field : 'id',
							title : '序列',
							width : 50,
							hidden:true,
						},{
							field : 'shop',
							title : '预约门店',
							width : 150,
						},{
							field : 'shopNum',
							title : '预约次数',
							width : 100,
						},{
							field : 'subscribeProject',
							title : '预约项目',
							width : 100,
						},{
							field : 'projectNum',
							title : '预约次数',
							width : 80,
						},{
							field : 'subscribeTime',
							title : '预约时间',
							width : 100,
						},{
							field : 'stimeNum',
							title : '次数',
							width : 100,
						},{
							field : 'createTime',
							title : '创建时间',
							width : 100,
						},{
							field : 'ctimeNum',
							title : '创建人数',
							width : 100,
						},{
							field : 'otherStatus',
							title : '状态',
							width : 100,
						},{
							field : 'statusNum',
							title : '次数',
							width : 100,
						},{
							field : 'yktSubscribeNum',
							title : '一卡通客人预约数量',
							width : 100,
						},{
							field : 'timeOut15Num',
							title : '超过15分钟没有处理预约次数',
							width : 100,
						},{
							field : 'subscribeAllManNum',
							title : '预约总人数',
							width : 100,
						},{
							field : 'subscribeAllNum',
							title : '预约总次数',
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
    			    	$('#datagrid').datagrid('unselectAll');
    			    	$('#datagrid').datagrid('loadData',d);
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
	
	/* function reservate(){
		$("#reservateDiv").show();
		$("#zyDiv").hide();
	}
	function zy(){
		$("#reservateDiv").hide();
		$("#zyDiv").show();
	} */
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: true;">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
		    <!-- <input type="button" value="预约数据" onclick="reservate()"/>
		    <input type="button" value="直营数据" onclick="zy()"/> -->
			<fieldset id="reservateDiv">
				<legend>预约数据</legend>
				<table class="tableForm">
					<tr>
						<th>珠中佛预约</th>
						<td></td>
						<td>预约时间</td>
						<td><input id="beginTime" class="easyui-datebox" />-
						    <input id="endTime" class="easyui-datebox" />
						</td>
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchzzf();">查找</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="exportzzf();">导出</a></td>
					</tr>
					<tr>
					    <th>广深琼预约</th>
					    <td></td>
						<td>预约时间</td>
						<td><input id="beginTimeGSQ" class="easyui-datebox" />-
						    <input id="endTimeGSQ" class="easyui-datebox" />
						</td>
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchgsq();">查找</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="exportgsq();">导出</a></td>
					</tr>
					<tr>
					    <th>北上西成渝预约</th>
					    <td></td>
						<td>预约时间</td>
						<td><input id="beginTimeBSX" class="easyui-datebox" />-
						    <input id="endTimeBSX" class="easyui-datebox" />
						</td>
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchbsx();">查找</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="exportbsx();">导出</a></td>
					</tr>
				</table>
			</fieldset>
		</div>
		<table id="datagrid"></table>
	</div> 
</body>
</html>