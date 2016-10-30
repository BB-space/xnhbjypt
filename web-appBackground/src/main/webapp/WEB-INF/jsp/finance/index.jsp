<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html style="background:#f1f6f9;">
<head>
<link href="<%=request.getContextPath()%>/resources/css/test/style1.css" rel="stylesheet" type="text/css" media="all"/>
<jsp:include page="../test/head.jsp"></jsp:include>
<script type="text/javascript">

$(function(){
	//修改菜单头图片
	$("#index").attr('src', "<%=request.getContextPath()%>/resources/img/test/navHome.png"); 
	$("#trade").attr('src', "<%=request.getContextPath()%>/resources/img/test/navTrade.png"); 
	$("#finance").attr('src', "<%=request.getContextPath()%>/resources/img/test/navFinance2.png"); 
	$("#safe").attr('src', "<%=request.getContextPath()%>/resources/img/test/navSafe.png"); 
	$("#news").attr('src', "<%=request.getContextPath()%>/resources/img/test/navNews.png"); 
});

</script>
</head>
<body style="background:#f1f6f9;">

<div class="ad_main">	
	
	<div class="ad_aside">
	
		<a href="<%=request.getContextPath()%>/finance.do?rechargeCny"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico1.png" />人民币充值<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?withdrawCny"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico2.png" />人民币提现<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?rechargeBtc"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico3.png" />网络流通币充值<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?withdrawBtc"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico4.png" />网络流通币提现<i></i></a>
		<a href="#" class="hover"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico5.png" />个人财务<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?record"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico6.png" />账单明细<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?listentrust"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico7.png" />委托明细<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?question"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico8.png" />发起问题<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?questionCulmn"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico9.png" />问题列表<i></i></a>
		<a href="#" class="end"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico10.png" />消息中心<i></i></a>
		
	</div>
	
	<table class="fina_tab">
		<tr>
			<th>可用金额</th>			
			<th>冻结</th>
			<th>总量</th>
			<th class="t4">操作</th>
		</tr>	
		<tr>
			<td>
				<div class="tfull">
					<span class="tag">CNY</span>
					0	
				</div>
			</td>	
			<td>0</td>
			<td>0</td>
			<td class="t4">
				<a href="#" class="mof_a">提现</a>
				<a href="#" class="mof_a">充值</a>
			</td>
		</tr>
		<tr>
			<td>
				<div class="tfull">
					<span class="tag">BTC</span>
					0	
				</div>
			</td>	
			<td>0</td>
			<td>0</td>
			<td class="t4">
				<a href="#" class="mof_a">提现</a>
				<a href="#" class="mof_a">充值</a>
			</td>
		</tr>
		<tr>
			<td>
				<div class="tfull">
					<span class="tag">LTC</span>
					0	
				</div>
			</td>	
			<td>0</td>
			<td>0</td>
			<td class="t4">
				<a href="#" class="mof_a">提现</a>
				<a href="#" class="mof_a">充值</a>
			</td>
		</tr>
		<tr>
			<td>
				<div class="tfull">
					<span class="tag">SLM</span>
					0	
				</div>
			</td>	
			<td>0</td>
			<td>0</td>
			<td class="t4">
				<a href="#" class="mof_a">提现</a>
				<a href="#" class="mof_a">充值</a>
			</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	
	<div class="clear"></div>
</div>

<!--footer start here-->
<jsp:include page="../test/footer.jsp"></jsp:include>
<!--footer end here-->

</body>
</html>