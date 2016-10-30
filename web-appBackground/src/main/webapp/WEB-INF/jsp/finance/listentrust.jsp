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
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/highstock.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/exporting.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/jquery.SuperSlide.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/account.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/user.js"></script>
<script src="<%=request.getContextPath()%>/resources/commonfiles/fin.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/resources/commonfiles/jquery.flot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/jquery.placeholder-1.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/commonfiles/language_cn.js"></script>

<jsp:include page="../test/head.jsp"></jsp:include>
<style type="text/css">
.rightArea {
	width: 815px;
	min-height: 560px;
	float: left;
	position: relative;
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
	padding-top: 10px;
	padding-left: 30px;
	top: -30px;
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
		<a href="<%=request.getContextPath()%>/finance.do?record"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico6.png" />账单明细<i></i></a>
		<a href="#" class="hover"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico7.png" />委托明细<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?question"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico8.png" />发起问题<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?questionCulmn"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico9.png" />问题列表<i></i></a>
		<a href="#" class="end"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico10.png" />消息中心<i></i></a>
		
	</div>
	
	<div class="rightArea">
		<div class="Areacon">
			<div class="Areatitle">
				<div class="title">
					<span class="bigTitle">
						委托明细
					</span>
				</div>
			</div>
			<div class="bigTopTab">
				<div class="accountfilter">
					<form action="./commonfiles/s7.html" method="get" id="recordFilterForm">
						过滤器：
						<select id="recordType">
							<option value="/financial/listentrust.html" selected="selected">
								全部
							</option>
										<option value="/financial/listentrust.html?symbol=2">
											比特币(BTC)
										</option>
										<option value="/financial/listentrust.html?symbol=3">
											莱特币(LTC)
										</option>
										<option value="/financial/listentrust.html?symbol=4">
											斯利姆(SLM)
										</option>
						</select>
					</form>
				</div>
			</div>
			<div class="entrustTen">
				<div id="Tenbody" class="Tenbody" style="display: block">
					<table style="border:none;">
						<tbody><tr>
							<th width="160">
								网络流通币
							</th>
							<th width="100">
								委托时间
							</th>
							<th width="90">
								委托类别
							</th>
							<th width="100">
								委托数量
							</th>
							<th width="100">
								委托金额
							</th>
							<th width="90">
								手续费
							</th>
							<th width="100">
								委托价格
							</th>
							<th width="95">
								成交数量
							</th>
							<th width="95">
								成交金额
							</th>
							<th width="90">
								平均成交价
							</th>
							<th width="130">
								状态/操作
							</th>
						</tr>
						
							<tr>
								<td colspan="11" align="center">
									<span class="no-data-tips">
										暂无委托
									</span>
								</td>
							</tr>
						
						
						</tbody>
					</table>
					<input type="hidden" value="1" id="currentPage">
					<div class="page">
						<ul>
						</ul>
					</div>
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