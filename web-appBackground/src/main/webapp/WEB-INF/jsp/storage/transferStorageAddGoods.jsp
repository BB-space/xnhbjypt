<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<style type="text/css">
.head_top{
	padding:10px 0 10px 10px;
	background-color:rgb(240,240,240);
}
.uinn{
	padding:10px 0 10px 10px;
}
</style>
<script type="text/javascript" charset="UTF-8">
var datagrid;
var commonDialog;
var commonForm;
$(function() {
	commonForm = $('#commonForm').form();
	commonDialog = $('#commonDialog').show().dialog({
		modal : true,
		title : '订单信息',
		buttons : [ {
			text : '确定',
			handler : function() {
				if (commonForm.find('[name=id]').val() != '') {
					commonForm.form('submit', {
						url : '${pageContext.request.contextPath}/order/edit.do',
						success : function(data) {
							commonDialog.dialog('close');
							$.messager.show({
								msg : '编辑成功！',
								title : '提示'
							});
							datagrid.datagrid('reload');
						}
					});
				} else {
					commonForm.form('submit', {
						url : '${pageContext.request.contextPath}/order/add.do',
						success : function(data) {
							try {
								var d = $.parseJSON(data);
								if (d) {
									commonDialog.dialog('close');
									$.messager.show({
										msg : '创建成功！',
										title : '提示'
									});
									datagrid.datagrid('reload');
								}
							} catch (e) {
								$.messager.show({
									msg : '名称已存在！',
									title : '提示'
								});
							}
						}
					});
				}
			}
		} ]
	}).dialog('close');

	datagrid = $('#datagrid').datagrid({
		url : '${pageContext.request.contextPath}/goods/datagrid.do',
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
		rownumbers : true,
		singleSelect:false,
		idField : 'id',
		frozenColumns : [ [ {
			title : 'id',
			field : 'id',
			width : 50,
			hidden : false,
			checkbox : true
		},{
			field : 'goodsNo',
			title : '商品编号',
			width : 100,
			formatter : function(value,row,index){
				return "<a onclick='orderItemList("+value+")'>"+value+"</a>";
			}
		} ] ],
		columns :[[{
			field : 'name',
			title : '商品名称',
			width : 20,
		},{
			field : 'price',
			title : '价格',
			width : 20
		},{
			field : 'integral',
			title : '积分',
			width : 20
		},{
			field : "pictures",
			title : '图片',
			width : 50,
			formatter:function(value,row,index){
				return '<img src="'+row.pictures+'" style=" width: 40px; height: 40px;"/>';
			}
		} ] ],
		checkOnSelect: true,
		selectOnCheck: true,
		onLoadSuccess:function(data){       
			//console.log(data);
			if(data){
				$.each(data.rows, function(index, item){
					if(item.checked){
						$('#datagrid').datagrid('checkRow', index);
					}
				});
			}
		} 
	});
	
	$('#ButonGetCheck').click(function(){
		var checkedItems = $('#datagrid').datagrid('getChecked');
		var names = [];
		$.each(checkedItems, function(index, item){
			names.push(item.id);
		});
		//console.log(names.join(","));
		$.post("${pageContext.request.contextPath}/transferStorage/addGoodsItem.do",{ids:names.join(",")},function(data){
			
		});
		window.location.href="${pageContext.request.contextPath}/transferStorage/transferStorageAdd.do";
	})
});
</script>

</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
<!-- 		<div class="head_top"> -->
<!-- 			<div style="float:left;"> 产品供应管理>>商品选择</div> -->
<!-- 			<div style="text-align:right;"> -->
<!-- 				<button onclick="javascirpt:history.go(-1)">>>返回</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="uinn"> -->
<!-- 			<input type="text"><input type="button" value="查询"> -->
<!-- 			<input type="checkBox"> -->
<!-- 		</div> -->
		<div id="toolbar" class="datagrid-toolbar"
			style="height: auto; display: none;">
			<fieldset>
				<div style="float:left;">
				<legend>商品选择</legend>
				<table class="tableForm">
					<tr>
						<td>商品编号</td>
						<td><input name="orderNo"/></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
				</div>
				<div style="float:right">
				<input type="button" id="ButonGetCheck" value="确认选择" />
				<button onclick="window.location.href='${pageContext.request.contextPath}/warehouseEntry/warehouseEntryAdd.do'">>>返回</button>
				</div>
				
			</fieldset>
			
			<div>
				  <!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick=""
					plain="true" href="javascript:void(0);">确认选择</a> --> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a><a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="reloadFun();"
					plain="true" href="javascript:void(0);">刷新</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>
</body>
</html>