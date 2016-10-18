<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>


<jsp:include page="../common/inc/xheditor.jsp"></jsp:include>
<style type="text/css">
.tableForm tr td{
	line-height: 35px;
}
</style>

<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var goodsDialog;
	var goodsForm;
	var passwordInput;
	
	$(function() {
		 $('#content').xheditor({
		        tools : 'full',
		        skin : 'default',
		        html5Upload : false,
		        upImgUrl : "${pageContext.request.contextPath}/uploadController.do?image",
		        upImgExt : "jpg,jpeg,png,gif"
		    }); 
		 
		 $('#catId').combotree( {
				//获取数据URL
				url : '${pageContext.request.contextPath}/category/tree.do',
				//选择树节点触发事件
				onSelect : function(node) {
					//返回树对象
					var tree = $(this).tree;
					//选中的节点是否为叶子节点,如果不是叶子节点,清除选中
					var isLeaf = tree('isLeaf', node.target);
					console.log(node.id);
					if (!isLeaf) {
						//清除选中
						$('#catId').combotree('clear');
					}
				},
				onLoadSuccess : function(node, data) {
					var t = $(this);
					if (data) {
						$(data).each(function(index, d) {
							if (this.state == 'closed') {
								t.tree('expandAll');
							}
						});
					}
				}
			});
	});

	function changePicUrls() {
		var dFile = document.getElementById('file');
		var dImg = document.getElementById('picts');
		if (dFile.files) {
			document.getElementById("picts").style.display = 'block';
			dImg.src = window.URL.createObjectURL(dFile.files[0]);
		} else if (dFile.value.indexOf('\\') > -1
				|| dFile.value.indexOf('\/') > -1) {
			dImg.src = dFile.value;
		}  
	}
	
	function changePicUrls2() {
		var dFile = document.getElementById('filePic');
		var dImg = document.getElementById('pics');
		if (dFile.files) {
			document.getElementById("pics").style.display = 'block';
			dImg.src = window.URL.createObjectURL(dFile.files[0]);
		} else if (dFile.value.indexOf('\\') > -1
				|| dFile.value.indexOf('\/') > -1) {
			dImg.src = dFile.value;
		}  
	}
	
	function changePicUrl(i) {
		if(i==1){
			var dFile = document.getElementById('file1');
			var dImg = document.getElementById('pic1');
			if (dFile.files) {
				document.getElementById("pic1").style.display = 'block';
				dImg.src = window.URL.createObjectURL(dFile.files[0]);
			} else if (dFile.value.indexOf('\\') > -1
					|| dFile.value.indexOf('\/') > -1) {
				dImg.src = dFile.value;
			}    
		}
		if(i==2){
			var dFile = document.getElementById('file2');
			var dImg = document.getElementById('pic2');
			if (dFile.files) {
				document.getElementById("pic2").style.display = 'block';
				dImg.src = window.URL.createObjectURL(dFile.files[0]);
			} else if (dFile.value.indexOf('\\') > -1
					|| dFile.value.indexOf('\/') > -1) {
				dImg.src = dFile.value;
			}    
		}
	}
	
	
	function check(){
		var catId=$("#catId").combotree("getValue");
		if(catId==""){
			alert("请选择商品类型！");
			return false;
		}else if($("#name").val()==""){
			alert("请输入商品名称！");
			return false;
		}else if($("#goodsNo").val()==""){
			alert("请输入商品编号！");
			return false;
		}else if($("#itemType").val()==""){
			alert("物品类别不能为空，请选择！");
			return false;
		}else if($("#price").val()==""){
			alert("请输入价格！");
			return false;
		}else if(isNaN($("#price").val())){
			alert("价格的输入值必须是数字！");
			return false;
		}else if($("#integral").val()==""){
			alert("请输入积分！");
			return false;
		}else if(isNaN($("#integral").val())){
			alert("积分的输入值必须是数字！");
			return false;
		}else if($("#kcQuantity").val()==""){
			alert("请输入库存量！");
			return false;
		}else if(isNaN($("#kcQuantity").val())){
			alert("库存量的输入值必须是数字！");
			return false;
		}else if($("#specification").val()==""){
			alert("请输入商品规格！");
			return false;
		}else if($("#weight").val()==""){
			alert("请输入商品重量！");
			return false;
		}else if($("#description").val()==""){
			alert("请输入对此商品的描述！");
			return false;
		}else if($("#productArea").val()==""){
			alert("请输入商品产地！");
			return false;
		}else if($("#pictures").val()==""){
			alert("请选择图片1！");
			return false;
		}else if($("#pic").val()==""){
			alert("请选择图片2！");
			return false;
		}else{
			return ture;
		}
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<div class="head_top">桌面>>商品信息>>编辑</div>
		<div class="widget_main">
		
		<form method="post" action="${pageContext.request.contextPath}/goods.do?edit"
		   onsubmit="return check()" enctype="multipart/form-data">
			<table class="tableForm">
				<tr>
					<th>商品ID</th>
					<td><input name="id" id="id" readonly="readonly" value="${goodsM.id }"/></td>
					<th>商品类别</th>
					<td>
						<input id="catId" name="catId"  value="${goodsM.catId}"
						style="width:150px;">
					</td>
					<th>商品名称</th>
					<td><input name="name" id="name" value="${goodsM.name }" class="easyui-textbox" type="text" data-options="required:true" /></td>
					<th>商品编号</th>
					<td>
					<input name="goodsNo" id="goodsNo" value="${goodsM.goodsNo }" type="easyui-validatebox" class="easyui-textbox" data-options="required:true"/>
					</td>
					<th>物品类别</th>
					<td>
						<select name="itemType" id="itemType" class="easyui-validatebox" required="true" style="width:150px;">
							<c:if test="${goodsM.itemType=='物品'}">
								<option value="物品" selected="selected">物品</option>
								<option value="卡项">卡项</option>
							</c:if>
							<c:if test="${goodsM.itemType=='卡项'}">
								<option value="物品">物品</option>
								<option value="卡项" selected="selected">卡项</option>
							</c:if>
						</select>
					</td>
				</tr>
				<tr>
					<th>价格</th>
					<td><input name="price" id="price" value="${goodsM.price }" class="easyui-textbox" type="text" data-options="required:true"/></td>
					<th>积分</th>
					<td><input name="integral" id="integral" value="${goodsM.integral }" class="easyui-textbox" type="text" data-options="required:true"/></td>
					<th>库存数量</th>
					<td><input name="kcQuantity" id="kcQuantity" value="${goodsM.kcQuantity }" class="easyui-textbox" type="text"/></td>
					<th>上架/下架</th>
					<td>
						<select class="easyui-validatebox" name="status" id="status" style="width:150px;">
							<c:if test="${goodsM.status=='1'}">
								<option value="1" selected="selected">上架</option>
								<option value="0">下架</option>
							</c:if>
							<c:if test="${goodsM.status=='0'}">
								<option value="1">上架</option>
								<option value="0"  selected="selected">下架</option>
							</c:if>
						</select>
					</td>
					<th>显示</th>
					<td>
					<select class="easyui-validatebox" name="showStatus" id="showStatus" data-options="required:true" style="width:150px;">
						<c:if test="${goodsM.showStatus=='1'}">
							<option value="1" selected="selected">显示</option>
							<option value="0">隐藏</option>
						</c:if>
						<c:if test="${goodsM.showStatus=='0'}">
							<option value="1">显示</option>
							<option value="0" selected="selected">隐藏</option>
						</c:if>
							
					</select>
					</td>
				</tr>
				<tr>
					<th>规格</th>
					<td><input name="specification" id="specification" value="${goodsM.specification }" class="easyui-textbox" type="text" data-options="required:true"/></td>
					<th>重量</th>
					<td>
					<input name="weight" id="weight" value="${goodsM.weight }" type="easyui-validatebox" class="easyui-textbox" data-options="required:true"/>
					</td>
					<th>商品描述</th>
					<td>
						<input name="description" id="description" value="${goodsM.description }" class="easyui-textbox" data-options="required:true,multiline:true" style="height:60px;"/>
					</td>
					<th>功效</th>
					<td><input name="efficacy" id="efficacy" value="${goodsM.efficacy }" class="easyui-textbox" data-options="multiline:true" style="height:60px;"/></td>
					<th>用法</th>
					<td><input name="usages" id="usage" value="${goodsM.usages }" class="easyui-textbox" data-options="multiline:true" style="height:60px;"/></td>
				</tr>
				<tr>
					<th>产地</th>
					<td><input name="productArea" id="productArea" value="${goodsM.productArea }" class="easyui-textbox" type="text" data-options="required:true"/></td>
					<th>标签</th>
					<td><input name="tag" id="tag" value="${goodsM.tag }" class="easyui-textbox" data-options="multiline:true" style="height:60px;"/></td>
					
					<th>出货规则</th>
					<td>
						<select name="deliveryRulesId" id="deliveryRules" style="width: 100px">
							<c:forEach items="${mList }" var="t">
								<option value="${t.id }" <c:if test="${goodsM.deliveryRulesId==t.id }">selected="selected"</c:if> >${t.express }</option>
							</c:forEach>
						</select>
					</td>
					<th>店员返现</th>
					<td><input name="empRebate" class="easyui-numberbox" value="${goodsM.empRebate}" min="0" precision="2" max="1"/></td>
					<th>店长返现</th>
					<td><input name="managerRebate" class="easyui-numberbox" value="${goodsM.managerRebate}" min="0" precision="2" max="1"/></td>
				</tr>
					
				<tr>
					<th>图片</th>
					<td>
						<input id="file" type="file" name="files" value="${goodsM.pictures }" onchange="changePicUrls()">
						<input type="hidden" name="pictures" id="pictures"  value="${goodsM.pictures }">
					
						<img name="pictures" id="picts" alt="" src="${goodsM.pictures }"
						style=" width: 50px; height: 50px;">
						
						
					</td>
				
						<td class="td1" rowspan="2">内容：</td>
						<td colspan="6" rowspan="2" >
				            <textarea id="content"  name="content" class="content" style="height:300px; width: 100%;">
								${goodsM.content }
				            </textarea>
						</td>
						<td>商品LOGO
						<input id="filePic" type="file" name="files" value="${goodsM.pic }" onchange="changePicUrls2()">
						<input type="hidden" name="pic" id="pic"  value="${goodsM.pic }">
					
						<img name="pic" id="pics" alt="" src="${goodsM.pic }"
						style=" width: 50px; height: 50px;">
						
						
					</td>
				</tr>
				<tr>
					<th>排序</th>
				    <td><input type="text" name="seq" value="${ goodsM.seq}" class="easyui-textbox"/></td>
					<td>产品概览<br/>
						<input id="file1" type="file" name="files"   onchange="changePicUrl(1)">
						<input type="hidden" name="photo1" id="photo"  value="${one }">
						<img name="pic1" id="pic1" alt="" src="${one }"
						style=" width: 50px; height: 50px;">
					<br/>
					
						<input id="file2" type="file" name="files"  onchange="changePicUrl(2)">
						<input type="hidden" name="photo2" id="photo"  value="${two }">
						<img name="pic2" id="pic2" alt="" src="${two }"
						style=" width: 50px; height: 50px;">
					</td>
					
				</tr>
				<tr>
						<td colspan="8" style="text-align: center">
							<input type="submit" value="保存">
							<input type="button" value="取消" onclick="window.history.go(-1)">
						</td>
					</tr>
			</table>
		</form>
	</div>
	</div>
	
</body>
</html>