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
/******委托记录*********/
.entrustTen {
	
}

.gary {
	color: #747373;
}

.entrustTen .Tentitle {
	line-height: 35px;
	font-weight: 700;
	font-size: 14px;
	padding: 10px 0;
	background: #fff;
}

.entrustTen .Tentitle .title {
	height: 35px;
	color: #66b2e3;
	background: #f5f5f5;
	display: block;
	cursor: pointer;
}

.entrustTen .Tenbody {
	background: none repeat scroll 0 0 #FFFFFF;
	display: none;
	font-size: 12px;
	padding-bottom: 45px;
}

.entrustTen .Tenbody table {
	text-align: center;
	border-left: none;
}

.entrustTen .Tenbody table th {
	color: #747373;
	line-height: 30px;
	font-weight: normal;
}

.entrustTen .Tenbody table td {
	color: #747373;
	line-height: 30px;
	border-top: 1px solid #e4e4e4;
}

.entrustTen .Tenbody table td.green {
	color: #009900;
}

.entrustTen .Tenbody table td.red {
	color: #ee3523;
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
		<a href="<%=request.getContextPath()%>/question.do?questionCulmn"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico9.png" />问题列表<i></i></a>
		<a href="#" class="end"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico10.png" />消息中心<i></i></a>
	</div>
	
	<div class="rightArea">
			<div class="Areatitle">
				<div class="title">
					<span class="bigTitle">
						<a href="s1.html">
							银行汇款
						</a>
					</span>
				</div>
				<div class="notitle">
					<span class="bigTitle">
						<a href="s1_2.html">
							环迅支付
						</a>
					</span>
				</div>
			</div>
			<div class="coinBox recharge clear Areacon ">
				<div id="riskArea4" class="remitStep">
					<div class="specificStepHint">
						<p id="specificStepHintText1" class="specificStepText specificStepl specificStepSel">
							填写汇款金额:
						</p>
						<p id="specificStepHintText2" class="specificStepText">
							前往网银汇款
						</p>
						<p id="specificStepHintText3" class="specificStepText">
							提交汇款信息
						</p>
						<p id="specificStepHintText4" class="specificStepText specificStepr">
							完成汇款
						</p>
					</div>
					<span id="specificStepBackground" class="specificStepBackground1"></span>
				</div>
				<div id="moneyDiv" style="display:block;height:240px">
					<div class="clear" style="width:1020px;">
						<div class="numberBlock">
							<ul>
								<li>
									<input type="hidden" value="0.84" id="random">
									<input type="hidden" onclick="javascript:showDiyMoney(6);" id="number6" name="finMoney" value="diy" disabled="false">
									<label for="number6">
										<span class="item">
											填写汇款金额:
										</span>
									</label>
									<input type="text" onblur="this.value.replace(/^\D|\D$/,&#39;&#39;)" onafterpaste="this.value=this.value.replace(/\D/g,&#39;&#39;)" onkeyup="this.value=this.value.replace(/\D/g,&#39;&#39;)" value="请输入金额" class="num" id="diyMoney" onfocus="javascript:clearDiyMoney();" style="">
									<span style="" id="randomSpan">.84</span>
								</li>
								<li>
									<label for="number5">
										<span class="item">
											选择银行：
										</span>
									</label>
									<select name="sbank" id="sbank" class="num">
										
									</select>
								</li>
							</ul>
							<input type="hidden" value="4" name="type" id="finType">
							<a class="button-blue2 " style="margin-left:90px" title="确定充值" onclick="javascript:submitFinForm();" href="javascript:void(0);" id="finButton">
								确定充值
							</a>
						</div>
						<div class="explainBlank">
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
				<div style="display:none;padding-left: 70px;" id="alipayhandDiv">
					<strong style="color:red;">
						请您按如下步骤操作：
					</strong>
					<div class="alipayhand" style="font-size: 16px;">
						<span id="tips2">
							2.
							按照下表填写“我要付款”表单：
						</span>
						<br>
						<ul id="tips2bank">
							<li>
								<span class="c1">
									收款人：
								</span>
								<span class="c2" id="fownerName">x</span>
							</li>
							<li>
								<span class="c1">
									收款人账号：
								</span>
								<span class="c2" id="fbankNumber">x</span>
							</li>
							<li>
								<span class="c1">
									收款人开户行：
								</span>
								<span class="c2" id="fbankAddress">x</span>
							</li>
							<li>
								<span class="c1">
									金额：
								</span>
								<span id="bankMoney" class="c2"></span>
							</li>
							<li>
								<span class="c1">
									备注/附言/摘要：
								</span>
								<span id="bankInfo" class="c2"></span>
							</li>
							<li>
								<span class="icon" style="background-position-y:-1245px"></span>
								<p style="padding: 0 10px;width: 562px;border: 1px solid #ff0000;background-color: #fef2f2;font-size: 14px;">
									转账汇款时请一定在“备注/附言/摘要”栏目里填写此数字，此数字只可使用一次，每次汇款请填写新生成的数字
								</p>
							</li>
						</ul>
						<span id="tips3">
							3.
							输入“校验码”并点击“下一步”付款
						</span>
						<br>
					</div>
					<a class="button-blue2" onclick="javascript:backModifyMoney();" style="width: 118px;margin-left: 30px;" href="javascript:void(0);">
						返回修改金额
					</a>
					<a class="button-blue2" onclick="javascript:submitPaymentInformation();" style="margin-left:100px;margin-top:30px;" href="javascript:void(0);">
						我已经完成银行汇款，下一步
					</a>
				</div>
				<div id="blankRemittance" style="display:none;" class="blankRemittance">
					<span style="font-size: 16px;color:red;">
						您确认已经汇款，请填写银行汇款确认：
					</span>
					<ul>
						<li>
							<span class="c1">
								汇入银行:
							</span>
							<span class="c2" id="rfownerName">xxxx</span>
						</li>
						<li>
							<span class="c1">
								汇入银行账号:
							</span>
							<span class="c2" id="rfbankNumber">xxxx</span>
						</li>
						<li>
							<span class="c1">
								收款人:
							</span>
							<span class="c2" id="rfbankAddress">xxxx</span>
						</li>
						<li>
							<span class="c1">
								充值金额:
							</span>
							<span id="subMoney" class="c2 red"></span>
						</li>
						<li>
							<span class="c1">
								备注/附言/摘要:
							</span>
							<span id="desc" class="c2 red"></span>
						</li>
						<li>
							<span class="c1">
								您的汇出银行:
							</span>
							<span class="c2">
								<input type="text" name="" value="" class="blankInformation" id="fromBank">
							</span>
							<span class="red">
								&nbsp;&nbsp;
								(如：中国银行、支付宝)
							</span>
						</li>
						<li>
							<span class="c1">
								银行账号:
							</span>
							<span class="c2">
								<input type="text" name="" value="" class="blankInformation" id="fromAccount">
							</span>
							<span class="red">
								&nbsp;&nbsp;
								(银行卡号，华夏填账号非银行卡号，支付宝付款请填写您的账户)
							</span>
						</li>
						<li>
							<span class="c1">
								开户姓名:
							</span>
							<span class="c2">
								<input type="text" value="石文浩" name="" class="blankInformation" id="fromPayee">
							</span>
							<span class="red">
								&nbsp;&nbsp;
								(银行卡持有人的姓名，支付宝姓名)
							</span>
						</li>
						<li>
							<span class="c1">
								手机号码:
							</span>
							<span class="c2">
								<input type="text" name="" value="" class="blankInformation" id="fromPhone">
							</span>
						</li>
						<li style="display: none;">
							<span class="c1">
								汇款方式:
							</span>
							<span>
								<label>
									<input type="radio" value="1" id="" name="fromType">
									<span class="item">
										柜台转款
									</span>
								</label>
								<label>
									<input type="radio" value="2" name="fromType">
									<span class="item">
										ATM机
									</span>
								</label>
								<label>
									<input type="radio" checked="checked" value="0" name="fromType">
									<span class="item">
										网上银行
									</span>
								</label>
							</span>
						</li>
						<li style="padding-top:15px;">
							<a onclick="javascript:submitTransferAccounts();" id="" href="javascript:void(0);" class="buttonblue3">
								提交
							</a>
						</li>
					</ul>
				</div>
				<div id="TransferAccountsComplete" style="display:none;padding:50px 0 50px 150px;" class="blankRemittance">
					<span class="bankRechargeSucess"></span>
					<span style="font-size: 14px" class="returnbackground">
						提交成功，我们收到汇款后，会尽快处理，请耐心等待本站的人工处理。
						<a href="#account/rechargeCny.html" class="">
							继续充值
							&gt;&gt;&gt;
						</a>
					</span>
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
									操作
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
							<ul>
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