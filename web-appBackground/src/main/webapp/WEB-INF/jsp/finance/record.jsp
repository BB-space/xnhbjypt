<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html style="background:#f1f6f9;">
<head>
<link href="<%=request.getContextPath()%>/resources/css/test/style1.css" rel="stylesheet" type="text/css" media="all"/>
<link rel="icon" href="#favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="#favicon.ico" type="image/x-icon">
<link href="<%=request.getContextPath()%>/resources/commonfiles/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" type="text/css" media="screen, projection">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/common.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/jquery-1.8.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/script.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/jquery-ui-1.10.4.custom.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/coincommon.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/jquery.placeholder-1.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/fin.js" ></script>
<jsp:include page="../test/head.jsp"></jsp:include>
<style type="text/css">
.rightArea {
	width: 815px;
	min-height: 560px;
	float: left;
	position: relative;
	margin-top: 43px;
	padding-left: 30px;
	padding-bottom: 65px;
}
.Areacon {
	font-size: 14px;
	background: #fff;
	border: 1px solid #e1e1e2;
	padding: 50px 30px 0;
	float: left;
	width: 953px;
	min-height: 542px;
}
.Areatitle {
	line-height: 45px;
	font-weight: 700;
	font-size: 14px;
	position: absolute;
	padding-left: 30px;
	top: -43px;
	left: 0;
}
.title {
	height: 45px;
	line-height: 45px;
	min-width: 150px;
	color: #000;
	background: #fff;
	display: inline;
	cursor: pointer;
	font-size: 16px;
	text-align: center;
	border: 1px solid #e1e1e2;
	border-style: solid solid none solid;
	float: left;
}
.bigTopTab {
	height: 40px;
	background: #fff;
}

 .accountfilter {
	line-height: 40px;
	color: #747373;
}
</style>

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
		<a href="<%=request.getContextPath()%>/finance.do?index"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico5.png" />个人财务<i></i></a>
		<a href="#" class="hover"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico6.png" />账单明细<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?listentrust"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico7.png" />委托明细<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?question"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico8.png" />发起问题<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?questionColumn"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico9.png" />问题列表<i></i></a>
		<a href="#" class="end"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico10.png" />消息中心<i></i></a>
		
	</div>
	
	<div class="rightArea">
		<div class="Areacon">
			<div class="Areatitle">
				<div class="title">
					<span class="bigTitle">
						账单明细
					</span>
				</div>
			</div>
			<div class="bigTopTab">
				<div class="accountfilter">
					<form action="<%=request.getContextPath()%>/resources/commonfiles/s6.html" method="get" id="recordFilterForm">
						过滤器：
						<select  id="recordType">
										<option value="/account/record.html?recordType=1&amp;symbol=0" selected="selected">CNY充值</option>
										<option value="/account/record.html?recordType=2&amp;symbol=0">CNY提现</option>
										<option value="/account/record.html?recordType=3&amp;symbol=2">BTC充值</option>
										<option value="/account/record.html?recordType=3&amp;symbol=3">LTC充值</option>
										<option value="/account/record.html?recordType=3&amp;symbol=4">SLM充值</option>
										<option value="/account/record.html?recordType=4&amp;symbol=2">BTC提现</option>
										<option value="/account/record.html?recordType=4&amp;symbol=3">LTC提现</option>
										<option value="/account/record.html?recordType=4&amp;symbol=4">SLM提现</option>
										<option value="/account/record.html?recordType=5&amp;symbol=2">BTC买入</option>
										<option value="/account/record.html?recordType=5&amp;symbol=3">LTC买入</option>
										<option value="/account/record.html?recordType=5&amp;symbol=4">SLM买入</option>
										<option value="/account/record.html?recordType=6&amp;symbol=2">BTC卖出</option>
										<option value="/account/record.html?recordType=6&amp;symbol=3">LTC卖出</option>
										<option value="/account/record.html?recordType=6&amp;symbol=4">SLM卖出</option>
						</select>
					</form>
				</div>
				<input type="hidden" value="0" id="playSymobl">
			</div>
			<div class="entrustTen">
				<div id="Tenbody" class="Tenbody" style="display: block">
					<table style="border:none;">
						<tbody><tr>
							<th width="200">
								交易时间
							</th>
							<th width="160">
								类型
							</th>
							<th width="150">
								FC数量
							</th>
							<th width="120">
								人民币数量
							</th>
							<th width="120">
								手续费
							</th>
							<th width="150">
								平均成交价
							</th>
							<th width="120">
								状态
							</th>
						</tr>
							<tr>
								<td colspan="7">
									<span class="no-data-tips">
										您暂时没有账单记录
									</span>
								</td>
							</tr>
						
						</tbody>
					</table>
					
				</div>
			</div>
		</div>
	</div>
	
	<div class="clear"></div>
</div>

<!--footer start here-->
<jsp:include page="../test/footer.jsp"></jsp:include>
<!--footer end here-->

</body>
</html>