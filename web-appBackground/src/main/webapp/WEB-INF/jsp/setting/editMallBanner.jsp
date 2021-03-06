<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<style type="text/css">
.head_top{
	padding-top:5px;
	padding-left:10px;
	padding-bottom:5px;
	border-bottom: 1px solid #ccc;
}
.widget_main{
	height:500px; 
}
.division table{
	width:100%;
	border-collapse: collapse;
}
.division table tr td{
	height:45px;
	border: 1px solid #ccc;
}
.division table tr td.td1{
	text-align: right;
	width:200px;
}
</style>
<script type="text/javascript" charset="UTF-8">
$(function(){
    $('#goodsDatagrid').dialog({
		title	: '商品',
		width	: 1000,
		height	: 400,
		modal	: true,
		closed	: true,
		buttons : [{
			text :'确定',
			handler:function(){
				$("#goodsDatagrid").dialog('close');
				//var row = $('#datagrid').datagrid('getSelected');
				var row = $('#datagrid').datagrid('getSelected');
				$("#title").val(row.title);
				$(".topTable").show();
				$("#wrapper").val(row.wrapper);
				$("#url").val("mallwx.do?mallGoods?&id="+row.id);  
			},
		},{
			text :'取消',
			handler :function(){
				$("#goodsDatagrid").dialog('close');
			}
		}]
	});	
});
function changePicUrl() {
	var dFile = document.getElementById('file');
	var dImg = document.getElementById('pic');
	if (dFile.files) {
		document.getElementById("pic").style.display = 'block';
		// dImg.src = dFile.files[0].getAsDataURL();//这里不懂？？
		dImg.src = window.URL.createObjectURL(dFile.files[0]);
	} else if (dFile.value.indexOf('\\') > -1
			|| dFile.value.indexOf('\/') > -1) {
		dImg.src = dFile.value;
	}
} 
function ajaxGetList(){
      $('#goodsDatagrid').dialog('open');
      $('#datagrid').datagrid({
	url : '${pageContext.request.contextPath}/widgetSetting/ajaxGetList.do',
	toolbar : '#toolbar',
	title : '',
	iconCls : 'icon-save',
	pagination : true,
	pageSize : 10,
	pageList : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
	fit : false,
	fitColumns : true,
	nowrap : false,
	border : false,
	idField : 'id',
	rownumbers : true,  
	singleSelect : true,
	frozenColumns : [ [
	{
		title : '编号',
		field : 'id',
		width : 50,
		hidden : true,
	} ] ], 
	columns : [ [{
		field : 'goodsNo',
		title : '商品编号 ',
		width : 100,
		sortable : true,					
	},{
		field : 'name',
		title : '标题',
		width : 100,
		sortable : true,
	},{
		field : 'price',
		title : '点击量',
		width : 100,
		sortable : true,
	}] ]
});
}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<div class="head_top">商城>>banner图片>>修改</div>
		<div class="widget_main">
			<form enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/mallBanner/toEditMallBanner.do" >
				<div class="division">
					<input type="hidden" name="id" value="${wsm.id}">
					<table class="topTable">
						<tr>
							<td style="text-align: right;width: 200px;">上级目录123：${wsm.parentId}</td>
							<td>
								<select style="width: 150px;" name="parentId">
									<option value="0" label="banner广告" <c:if test="${wsm.parentId==0}">selected="selected"</c:if> >banner广告</option>
									<option value="1" label="banner商品" <c:if test="${wsm.parentId==1}">selected="selected"</c:if> >banner商品</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;width: 200px;">标题：<input type="hidden" name="updateId"  value="${sws.id}"></td>
							<td><input type="text" id="text" name="text" value="${wsm.text}" class="easyui-validatebox" required="required"></td>
						</tr>
						<tr>
							<td style="text-align: right;width: 200px;">排序</td>
							<td><input type="text" id="seq" name="seq" class="easyui-numberbox" value="${wsm.seq}"></td>
						</tr>
					</table>
				</div>
				<div class="division">
					<table class="">
						<tr>
							<td class="td1">选择图片：</td>
							<td>
							<input id="file" name="file" type="file" onchange="changePicUrl()"><br> 
							<input type="hidden" value="${wsm.picture}" name="picture">
							<img name="pic" id="pic" alt="" src="${wsm.picture}" style="width:300px;height:200px;">
							</td>
						</tr>
						<tr>
							<td style="text-align: right;width: 200px;">链接地址</td>
							<td>
								<input type="text" id="url" name="url" value="${wsm.url}" style="width:400px;">
								<input type="button" value="打开列表"  onclick="ajaxGetList()">
							</td>
						</tr>
					</table>
				</div>
				<table style="margin: 0 auto"> 
					<tr>
						<td colspan="2">            
							<input type="submit" id="saveBtn" value="保存">
							<input type="button" value="取消" onclick="javascript:window.history.go(-1)">
						</td>    
					</tr>
				</table>
			</form>
		</div>     
	</div>
	<div id="goodsDatagrid">
		<table id="datagrid"></table> 
	</div>
</body>
</html>