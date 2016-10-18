<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var contractDialog;
	var contractForm;
	var passwrodInput;
	$(function() {
		contractForm = $("#contractForm").form();

		passwordInput = contractForm.find('[name=name]').validatebox({
			required : true
		});

	});
	function load(value){
		window.location.href="${pageContext.request.contextPath}/regInstruction.do?export&path="+value;
	}
	
	function read(value){
		window.location.href="${pageContext.request.contextPath}/regInstruction.do?read&path="+value;
	}
</script>
<style type="text/css">
.table{
    width:90%;
    text-align:center;
    margin-top:20px;
    line-height:30px;
}
.bg{
    background-color: #DFDEDE;
}
.td{
    border:1px #D0D0D0 solid;
    width:50%;
}
.load{
    border-radius:25px;
    color:#fff;
    background-color: #5AAAE7;
    border-style: none;
    width:55px;
    height:20px;
}
.read{
   border-radius:25px;
   color:#5AAAE7;
   background-color: #fff;
   border: 1px #5AAAE7 solid;
   width:55px;
   height:20px;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<table class="table" align="center" cellspacing="0">
		    <tr class="bg"> 
		       <td class="td">电子协议</td>
		       <td class="td">操作</td>
		    </tr>
		    <tr> 
		       <td class="td">丝域门店天猫商城代销商品协议、丝域门店天猫商城代销结算协议</td>
		       <td class="td">
<!-- 		           <input type="submit" class="load" value="下载" onclick="load('/resources/css/regInstruct.pdf')"/>&nbsp; -->
		           <input type="submit" class="read" value="查看" onclick="read('/resources/css/regInstruct.pdf')"/>
		       </td>
		    </tr>
		    <tr> 
		       <td class="td">入驻团购申请书、线上团购奖罚规定</td>
		       <td class="td">
<!-- 		           <input type="submit" class="load" value="下载" onclick="load('/resources/css/tuan.pdf')"/>&nbsp; -->
		           <input type="submit" class="read" value="查看" onclick="read('/resources/css/tuan.pdf')"/>
		       </td>
		    </tr>
		</table>
	</div>
</body>
</html>