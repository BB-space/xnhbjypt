<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<style>
	body{
		
	}
	.box{
		width:100%;
		margin:5% 0;
		text-align:center;
	}
	.invoice{
		width:30%;
	}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div class="box"><img src="resources/img/invoice.png" class="invoice"></div>
</body>
</html>