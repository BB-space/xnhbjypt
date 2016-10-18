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
$(function(){
	$('.bt').click(function(){
		var cj = $(this).attr("value");
		//alert(cj);
		$.ajaxFileUpload({
	         url:'${pageContext.request.contextPath}/showTable.do?inMeetingPhone',
	         fileElementId:'file',
	         data:{cj:cj},
	         success: function (data, status){
	           alert("发送成功！");
	         },
	         error: function (data, status)
	         {
	            alert("发送失败！");
	          }
	              }
	 );
		//alert("file:"+$("#onefile").val());
	})
})
</script>
</head>
<body>
	<div region="center" border="false" style="overflow: hidden">
		<div>
		<form id="choujiang">
			<input type="file" name="file" id="file"/>
			<br>
			<input type="button" class="bt" id="cj1" value="一等奖"/>
			<input type="button" class="bt" id="cj2" value="二等奖"/>
			<input type="button" class="bt" id="cj3" value="三等奖"/>
			<input type="button" class="bt" id="cj4" value="四等奖"/>
			<input type="button" class="bt" id="cj5" value="五等奖"/>
			<input type="button" class="bt" id="cj6" value="特等奖"/>
			</form>
		</div>
		
	</div>  


</body>
</html>