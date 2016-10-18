<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menunew.js" charset="UTF-8" type="text/javascript"></script>
<style type="text/css">
.maindiv{
	font-family: 'Microsoft YaHei';
}
.auditBtn , .rejectBtn{ 
	padding:2px 12px;
	border-radius:10px;
	margin-left:10px;
	color:#FFF;
	border: 1px solid #5AABE7;
	text-decoration: none;
	z-index: 999;
}
.auditBtn{
	background-color: #5AABE7;
}
.rejectBtn{
	border: 1px solid #5AABE7;
	color:#5AABE7;
}
.viewBtn{
	color:#5AABE7;
	text-decoration: none;
}
/**********/
.contract_top{
	margin-top:20px;
	padding-left:20px;
}
.contract_info{
	padding-left:20px;
	margin-top:20px;
}
.contract_info p{
	font-weight:bold;
	margin-top:30px;
	font-size:14px;
}
.contract_tb{
	width:96%;
	border-collapse: collapse;
	text-align: center;
}
.contract_tb tr td{
	border: 1px solid #E6E6E6;
	line-height: 35px;
}
.td1,.td3,.td5{
	width:10%;
	color:#4d4d4d;
}
.td2,.td4,.td6{
	font-weight: bold;
}
.td2,.td4{
	width:20%;
}
.td6{
	width:30%;
}
.contract_applydiv{
	width:96%;
	border:1px solid #E6E6E6;
	padding:20px 0px;
}
.zhizhao1{
	margin-top:10px;
	width:200px;
}
.rightAngle{
	display:inline-block;
	width:10px;
	height:10px;
	margin-left:20px;
	margin-right:20px;
	background: url("${pageContext.request.contextPath}/resources/css/login/img/rightAngle.png") no-repeat;
	background-size:100% 100%;
}

#rejectDiv {
	 position:absolute;
	 left:338px;
	 top:91px;
	 width:520px;
	 height:280px;
	 z-index:999999;
	 box-shadow: 0 2px 16px #ccc, 0 0 1px #ccc, 0 0 1px #ccc;
	 background:#FFF; 
}
#rejectDiv p{
	font-weight: bold;
	text-align: center;
}

.imghover{
	width:50%;
	position: absolute;
	z-index: 99999999;
	top:0;
	left:20%;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div class="maindiv" region="center" border="false" style="overflow: auto;">
		<div class="contract_top">
			<span onclick="history.go(-1)" style="cursor: pointer;">审核列表</span><span class="rightAngle"></span>
			${contractM.realname}
		</div>
		<div class="contract_info">
			<p>基本信息</p>
			<table class="contract_tb">
				<tr>
					<td class="td1">姓名</td>
					<td class="td2">${contractM.realname}</td>
					<td class="td3">手机号码</td>
					<td class="td4">${contractM.mobile}</td>
					<td class="td5">申请身份</td>
					<td class="td6">${contractM.userType}</td>
				</tr>
				<tr>
					<td class="td1">店铺名称</td>
					<td class="td2">${contractM.shopName}</td>
					<td class="td3">区域</td>
					<td class="td4">${contractM.shopArea}</td>
					<td class="td5">详细地址</td>
					<td class="td6">${contractM.address }</td>
				</tr>
				<tr>
					<td class="td1">法人身份证</td>
					<td class="td2">
						<c:if test="${not empty contractM.idCardPhoto}">
							<img class="zhizhao1" src="${contractM.idCardPhoto}">
						</c:if>
					</td>
					<td class="td3">营业执照</td>
					<td class="td4">
						<c:if test="${not empty contractM.licensePhoto}">
						<img class="zhizhao1" src="${contractM.licensePhoto}">
						</c:if>
					</td>
					<td class="td5">店铺信息</td>
					<td class="td6">
						<c:choose>
							<c:when test="${not empty contractM.shopInfo}">
								${contractM.shopInfo }	
							</c:when>
							<c:otherwise>
								/
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
			
			<p>收款信息</p>
			<table class="contract_tb">
				<tr>
					<td class="td1">收款人</td>
					<td class="td2">
						<c:if test="${contractM.isLegalPerson==1}">法人</c:if>
						<c:if test="${contractM.isLegalPerson==0}">非法人</c:if>
					</td>
					<td class="td3">委托收款涵</td>
					<td class="td4">
						<c:if test="${not empty contractM.delegationPhoto}">
						<img class="zhizhao1" src="${contractM.delegationPhoto}">
						</c:if>
					</td>
					<td class="td5">收款帐号</td>
					<td class="td6">
						<c:if test="${contractM.receiveType==0}">银行卡</c:if>
						<c:if test="${contractM.receiveType==1}">支付宝</c:if>
					</td>
				</tr>
				<tr>
					<td class="td1">开户姓名</td>
					<td class="td2">${contractM.openName}</td>
					<td class="td3">开户银行</td>
					<td class="td4">${contractM.openBank}</td>
					<td class="td5">开户帐号</td>
					<td class="td6">${contractM.openAccount}</td>
				</tr>
				<tr>
					<td class="td1">支付宝帐号</td>
					<td class="td2">${contractM.alipayAccount}</td>
					<td class="td3"></td>
					<td class="td4"></td>
					<td class="td5"></td>
					<td class="td6"></td>
				</tr>
			</table>
			
			<p>申请状态</p>
			<div class="contract_applydiv">
				<div style="float: left;margin-left:4%;">申请状态</div>
				<div style="float:right;margin-right:12%;">
					<a class='auditBtn' href='javascript:void(0);' onclick='audit("${contractM.id}");'><span>通过</span></a>  
					<a class='rejectBtn' href='javascript:void(0);' onclick='rejectDetail("${contractM.id}");'><span>拒绝</span></a> 
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>
	<div id="rejectDiv">
		<p>请填写拒绝原因</p>
		<textarea id="auditFailNote" rows="8" cols="" style="resize:none;width:440px;text-align: left;margin-left:40px;padding:8px 0px;" 
			placeholder="请填写拒绝原因，可以说明哪些资料不符合等内容">${contractM.auditFailNote}
			</textarea>
		<div style="text-align: center;margin-top:30px;">
			<a class='auditBtn' href='javascript:void(0);' onclick='confirm("${contractM.id}");'><span>确认</span></a>  
			<a class='rejectBtn' href='javascript:void(0);' onclick='cancel("${contractM.id}");'><span>取消</span></a> 
		</div>
	</div>
	<script type="text/javascript" charset="UTF-8">
	$(function(){
		$("#rejectDiv").hide();
		$('.zhizhao1').hover(function() {
			$(this).addClass("imghover");
		},
		function() {
			$(this).removeClass("imghover");
		});
	})
	function audit(id){
		$.ajax({
			url : 'contract.do?audit',
			data : {
				id : id
			},
			cache : false,
			dataType : "json",
			success : function(response) {
// 				datagrid.datagrid('unselectAll');
// 				datagrid.datagrid('reload');
				$.messager.show({
					title : '提示',
					msg : '审核成功！'
				});
			}
		});
	}
	
	function rejectDetail(id){
		$("#rejectDiv").show();		
	}
	
	function reject(id){
		$.ajax({
			url : 'contract.do?reject',
			data : {
				id : id
			},
			cache : false,
			dataType : "json",
			success : function(response) {
// 				datagrid.datagrid('unselectAll');
// 				datagrid.datagrid('reload');
				$.messager.show({
					title : '提示',
					msg : '审核成功！'
				});
			}
		});
	}
	function viewDetail(id){
		window.location.href="contract.do?auditDetail&id="+id;
	}
	
	function confirm(id){
		var note = $("#auditFailNote").val();
		$.ajax({
			url : 'contract.do?reject',
			data : {
				id : id,
				auditFailNote : note
			},
			cache : false,
			dataType : "json",
			success : function(response) {
// 				datagrid.datagrid('unselectAll');
// 				datagrid.datagrid('reload');
				$.messager.show({
					title : '提示',
					msg : '审核成功！'
				});
				$("#rejectDiv").hide();
			}
		});
	}
	
	function cancel(id){
		$("#rejectDiv").hide();
	}
	</script>
</body>
</html>