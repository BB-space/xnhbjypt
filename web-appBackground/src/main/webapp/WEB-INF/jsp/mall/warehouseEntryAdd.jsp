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
.return 
table{
	border-collapse: collapse;
}
table tr td{
	line-height:30px;
	border-bottom:1px solid #ccc;
}
#tableGoods{
	min-width:1000px;
}
#tableGoods tr td{
	border:1px solid #ccc;
}
</style>
<script type="text/javascript" charset="UTF-8">
$(function() {
	$("#saveBtn").click(function(){
		$.post("${pageContext.request.contextPath}/warehouseEntry/add.do",$("form").serialize(),function(data){
			alert("ok");
		});		
	})
});

function editItem(value,id){
	console.log(value.value);
	var editQty = value.value;
// 	alert(editQty);
// 	alert(id);
	$.post("${pageContext.request.contextPath}/warehouseEntry/editEntryItem.do",{id:id,editQty:editQty},function(data){
		window.location.reload();
	});
}

function deleteItem(id){
	$.post("${pageContext.request.contextPath}/warehouseEntry/deleteEntryItem.do",{id:id},function(data){
		window.location.reload();
	})
}

function saveEntry(){
	//alert($("input[name='entryNo']").val());
	var entry={
			entryNo:$("input[name='entryNo']").val(),
			sourceType:$("input[name='sourceType']").val(),
			warehouseId:$("select[name='warehouseId']").val(),
			entryDatetime:$("input[name='entryDatetime']").val()
	};

	$.post("${pageContext.request.contextPath}/warehouseEntry/warehouseEntryAddFinal.do",{
// 		entryNo:$("input[name='entryNo']").val(),
		sourceType:$("select[name='sourceType']").val(),
		warehouseId:$("select[name='warehouseId']").val(),
		entryDatetime:$("input[name='entryDatetime']").val()},function(data){
			alert('入库成功');
			window.location.href='${pageContext.request.contextPath}/warehouseEntry/warehouseEntry.do';
	})
}
</script>

</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<div class="head_top">
			<div style="float:left;"> 产品供应管理>>入库单编辑</div>
			<div style="text-align:right;">
				<button onclick="window.location.href='${pageContext.request.contextPath}/warehouseEntry/warehouseEntry.do'">>>返回</button>
			</div>
		</div>
		<form>
			<table>
				<tr>
					<td>入库单单号：<input type="text" name="entryNo" style="width:120px"></td>
					<td>源单类型：
						<select name="sourceType">
							<option value="其他入库">其他入库</option>
							<option value="其他出库">其他出库</option>
						</select>
					</td>
					<td>
						仓库：
						<select name="warehouseId">
							<c:forEach items="${mList }" var="item">
								<option value="${item.id }">${item.warehouseName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>日期：
						<input class="easyui-datetimebox" type="text" name="entryDatetime">
					</td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<div>
				<input type="button" value="添加" onclick="window.location.href='${pageContext.request.contextPath}/warehouseEntry/warehouseEntryAddGoods.do'">
				<input type="button" value="刷新" onclick="window.location.href='${pageContext.request.contextPath}/warehouseEntry/warehouseEntryAdd.do'">
				<input type="button" value="保存" onclick="saveEntry();">
				<div>
					<table id="tableGoods">
						<tr>
							<td>产品代码</td>
							<td>产品名称</td>
							<td>规格型号</td>
							<td>入库数量</td>
							<td></td>
						</tr>
						<c:forEach items="${entryGoodsList}" var="item" varStatus="status">
							<tr>
								<td>${item.goodsNo}</td>
								<td>${item.name}</td>
								<td>${item.specification}</td>
								<td>
									<input type="text" value="${item.entryGoodsQty}" name="entryGoodsQty" onchange="javascript:editItem(this,'${item.id}')">
								</td>
								<td>
									<input type="button" value="删除" onclick="deleteItem('${item.id}')">
								</td>
							</tr>									
						</c:forEach>
					</table>
				</div>
			</div>			
		</form>
		
	</div>
</body>
</html>