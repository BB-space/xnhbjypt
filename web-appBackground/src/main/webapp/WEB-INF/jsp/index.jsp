<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>丝域电商系统</title>
<jsp:include page="./common/inc/meta.jsp"></jsp:include>
<jsp:include page="./common/inc/easyui.jsp"></jsp:include>
</head>
<body id="indexLayout" class="easyui-layout" fit="true">
<%-- 	<div region="north" href="<%=request.getContextPath()%>/north.do" style="height:100px;overflow: hidden;
	background: url('<%=request.getContextPath()%>/resources/img/default.jpg') repeat-y;"></div> --%>
	<div region="north" href="<%=request.getContextPath()%>/north.do" style="height:90px;overflow: hidden;border:0;"></div>
	<div region="west" href="<%=request.getContextPath()%>/west.do" split="false" style="width:200px;overflow: hidden;border:0;"></div>
<%-- 	<div region="west" href="<%=request.getContextPath()%>/west.do" title="导航" split="false" style="width:200px;overflow: hidden;"></div> --%>
	<div region="center" href="<%=request.getContextPath()%>/center.do" style="overflow: hidden;"></div>
<%-- 	<div region="center" href="<%=request.getContextPath()%>/center.do" title="欢迎使用APP后台管理系统" style="overflow: hidden;"></div> --%>
	<div region="south" href="<%=request.getContextPath()%>/south.do" style="height:30px;overflow: hidden;border:0;"></div>
</body>
</html>