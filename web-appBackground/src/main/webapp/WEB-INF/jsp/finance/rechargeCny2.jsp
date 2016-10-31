<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html style="background:#f1f6f9;">
<head>
<link href="<%=request.getContextPath()%>/resources/css/test/style1.css" rel="stylesheet" type="text/css" media="all"/>
<link rel="icon" href="#" type="image/x-icon">
<link rel="shortcut icon" href="#" type="image/x-icon">
<link href="<%=request.getContextPath()%>/resources/commonfiles/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" type="text/css" media="screen, projection">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/common.css" type="text/css">
<link media="screen, projection" type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/financial.css">
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
.rightArea .Areatitle .title {
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
.notitle {
	height: 35px;
	line-height: 35px;
	min-width: 150px;
	color: #7a7a7a;
	background: #fff;
	display: inline;
	cursor: pointer;
	font-size: 16px;
	text-align: center;
	border: 1px solid #e1e1e2;
	float: left;
	margin-top: 9px;
}
 .accountfilter {
	line-height: 40px;
	color: #747373;
}
 .bigTitle {
	display: block;
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
		<a href="#" class="hover"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico1.png" />人民币充值<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?withdrawCny"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico2.png" />人民币提现<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?rechargeBtc"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico3.png" />网络流通币充值<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?withdrawBtc"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico4.png" />网络流通币提现<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?index" ><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico5.png" />个人财务<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?record"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico6.png" />账单明细<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?listentrust"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico7.png" />委托明细<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?question"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico8.png" />发起问题<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?questionColumn"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico9.png" />问题列表<i></i></a>
		<a href="#" class="end"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico10.png" />消息中心<i></i></a>
	</div>
	
	<div class="rightArea">
			<div class="Areatitle">
				<div class="notitle">
					<span class="bigTitle">
						<a href="<%=request.getContextPath()%>/finance.do?rechargeCny">
							银行汇款
						</a>
					</span>
				</div>
				<div class="title">
					<span class="bigTitle">
						<a href="<%=request.getContextPath()%>/finance.do?rechargeCny2">
							环迅支付
						</a>
					</span>
				</div>
			</div>
			<div class="coinBox recharge clear Areacon ">
					<div id="riskArea4" class="remitStep">
						<span id="specificStepBackground" class="specificStepBackground1"></span>
					</div>
					<div id="moneyDiv" style="display:block;padding-left: 70px;">
							<div class="clear" style="width:900px;">
							<div class="numberBlock" style="float: none;">
								<ul>
									<li>
										<input type="hidden" value="0.24" id="random">
										<input type="hidden" onclick="javascript:showDiyMoney(6);" id="number6" name="finMoney" value="diy" disabled="false">
										<label for="number6">
											<span class="item"> 填写汇款金额:</span>
										</label>
										<input type="text" onblur="this.value.replace()" onafterpaste="this.value=this.value.replace()" value="请输入金额" class="num" id="diyMoney" onfocus="javascript:clearDiyMoney();" style="">
									</li>
								</ul>
								<div class="olBankListBlock">
								<dl id="inputbankcode" style="padding-top:0;padding-left: 115px;width: 600px;">
									
										<dt><input type="radio" checked="checked" name="bank_input_bankcode" id="webbank_shb_id2" value="2"></dt>
										<dd><label for="webbank_shb_id2" style="cursor:pointer;"><img src="<%=request.getContextPath()%>/resources/commonfiles/isppay.gif"></label>
										</dd>
									
								</dl>
							</div>
								<input type="hidden" value="1" name="type" id="finType">
								<a class="button-blue2 " style="margin-top:30px;margin-left: 136px;" onclick="return submitOnLineForm(this);" href="javascript:void(0);" target="_blank" id="finButton">
									确定充值
								</a>
							
							</div>
							
							
							<div class="olexplainBlank">
								<p>
								<strong class="black fontsize-16"><i>1. </i></strong>银行卡汇款目前仅支持<strong class="red">100.0元以上</strong>汇款,<strong class="red">100.0元元以下汇款不予处理。</strong>
								</p>
								<p>
									<strong class="black fontsize-16">
										<i>2. </i>
									</strong>
									充值时间：7*24小时，收到汇款后30分钟内入账，服务咨询QQ : 2463418169。
								</p>

							</div>

						</div>
					</div>
                 <div class="entrustTen">
					<div class="Tentitle">
						<div class="title">
							<span class="left">
								充值记录
							</span>
						</div>
					</div>
					<div id="Tenbody" class="Tenbody" style="display: block">
						<table style="border:none;">
							<tbody><tr>
								<th width="170">
									订单号
								</th>
								<th width="250">
									时间
								</th>
								<th width="120">
									充值方式
								</th>
								<th width="150">
									金额
								</th>
								<th width="150">
									状态
								</th>
								<th width="150">
									
								</th>
							</tr>
							
							<tr>
								<td align="center" colspan="6">
									<span class="no-data-tips">
										您暂时没有充值数据
									</span>
								</td>
							</tr>
							
						</tbody></table>
						<div class="page">
							<ul><li><a style="color:#FFFFFF;" class="current_ss" href="javascript:void(0)">1</a></li>
							</ul>
						</div>
						<input type="hidden" id="currentPage" value="1">
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