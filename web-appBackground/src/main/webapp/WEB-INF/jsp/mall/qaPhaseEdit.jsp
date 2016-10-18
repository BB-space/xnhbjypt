<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<jsp:include page="../common/inc/xheditor.jsp"></jsp:include>
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
$(function(){
	$('#content').xheditor({
	    tools : 'full',
	    skin : 'default',
	    html5Upload : false,
	    upImgUrl : "${pageContext.request.contextPath}/uploadController.do?image",
	    upImgExt : "jpg,jpeg,png,gif"
	}); 	
})
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<div class="head_top">
			<div style="float:left;"> 问答>>添加</div>
			<div style="text-align:right;">
				<button onclick="window.location.href='${pageContext.request.contextPath}/qaPhase/qaPhase.do'">>>返回</button>
			</div>
		</div>
		<form method="post" action="${pageContext.request.contextPath}/qaPhase/toEdit.do">
			<table>
				<tr>
					<td>标题<input type="hidden" name="id" value="${qm.id}"></td>
					<td><input type="text" id="text" name="title" class="easyui-validatebox" required="required" value="${qm.title}"></td>
				</tr>
				<tr>
					<td>显示状态</td>
					<td>
						<select name="showStatus"  class="easyui-combobox">
							<option value="0" <c:if test="${qm.showStatus==0}">selected="selected"</c:if>>不显示<option>
							<option value="1" <c:if test="${qm.showStatus==1}">selected="selected"</c:if>>显示</option>
						</select>
					</td>
				</tr>
				<tr><td>内容</td>
					<td>
						<textarea id="content" name="contentStr" class="content" style="height:300px; width: 100%;">
						${qm.contentStr}
					    </textarea>
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
</body>
</html>