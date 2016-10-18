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
	
</style>
<script type="text/javascript">

	function post(){
		//alert(2);
		var content=$("#content").val();
		if(content==null||content==""){
			$.messager.alert('提示',
				' 请输入内容,才可发送信息！'
			);
			return ;
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/postMessage.do?addMessage',
			data : {
				content : content
			},
			cache : false,
			dataType : "json",
			success : function(data) {
				$("#container").load("postMessage.do?index",null,null); 
				$.messager.show({
					title : '提示',
					msg : '添加成功！'
				});
			}
		});
		//window.location.href='postMessage.do?addMessage&content='+content;
	}
</script>
</head>
<body>
	<div style="margin-left: 1rem;height: 100%;overflow: auto;">
	 	<div>
	 		<textarea rows="4" cols="58" name="content" id="content"></textarea>
	 		<input type="button" value="发送" onclick="post()">
	 	</div>
	 	<div>
	 	<c:forEach items="${list }" var="t">
	 		<table>
	 			<tr>
	 				<td>
	 					${t.shopName } : ${t.content }
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>
	 					发布时间  :
	 					 ${t.createDateTime }
	 				</td>
	 			</tr>
	 		</table>
	 		<div ><!--灰色水平线  -->
		           <hr size="1em" color="#C0C0C0" />
	        </div>
	 	</c:forEach>
	 	</div>
	</div>	
</body>
</html>