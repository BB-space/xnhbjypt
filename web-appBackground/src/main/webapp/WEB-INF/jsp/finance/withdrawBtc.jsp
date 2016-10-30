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
		<a href="#" class="hover"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico4.png" />网络流通币提现<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?index"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico5.png" />个人财务<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?record"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico6.png" />账单明细<i></i></a>
		<a href="<%=request.getContextPath()%>/finance.do?listentrust"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico7.png" />委托明细<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?question"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico8.png" />发起问题<i></i></a>
		<a href="<%=request.getContextPath()%>/question.do?questionCulmn"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico9.png" />问题列表<i></i></a>
		<a href="#" class="end"><img src="<%=request.getContextPath()%>/resources/img/test/finance_ico10.png" />消息中心<i></i></a>
		
	</div>
	
	<div class="rightArea">
		<input type="hidden" id="isEmptyAuth" value="0">
		<input type="hidden" id="symbol" value="2">
		<input type="hidden" value="" id="withdrawAddr" name="withdrawAddr">
		<input type="hidden" value="0.0" id="btcbalance" name="btcbalance">
		<div class="Areatitle">
			<div class="title">
				<span class="bigTitle">
					<a href="s4.html">
						BTC提现
					</a>
				</span>
			</div>
			<div class="notitle">
				<span class="bigTitle">
					<a href="s4-2.html">
						LTC提现
					</a>
				</span>
			</div>
			<div class="notitle">
				<span class="bigTitle">
					<a href="s4-3.html">
						SLM提现
					</a>
				</span>
			</div>
		</div>
		<div class="coinBox lasttenorder clear Areacon ">
			<div class="coinBoxBody">
				<div class="riskArea">
					<span class="hinttext1">
						<span class="icon"></span>
						<span class="define">重要提示：</span>为了您的账户安全，每笔提现最小数量<span class="red">1</span>，最大数量<span class="red">50000</span>，如果您有更高的需求，请与网站客服联系。请注意如果您提现的数量过大或过小，或者小数点后位数过多，网络(非本站)会收取手续费，一般为 0.0001。因此您收到的网络流通币是提现数量扣除支付手续费后的数量。
					</span>
					<span class="hinttext">
						<span class="icon"></span>
						<span class="define">重要提示：</span>本站客服不会要求用QQ远程控制您的计算机,所有要求远程的都是<strong style="color:red">骗子</strong>。<strong style="color:red">短信验证码、谷歌验证码非常重要，请勿透露给任何人，包括本站的客服。</strong>
					</span>
				</div>
				<div class="rmbout">
					<div class="divMargins">
						<span class="c1">
							提现地址:
						</span>
						<span id="withdrawAddrSpan">
									<a onclick="javascript:modifyWithdrawBtcAddr();" href="javascript:void(0);">
										设置
									</a>
						</span>
					</div>
					<div>
						<span class="c1">
							提现数量:
						</span>
						<span>
							<input type="text" onblur="javascript:withdrawBtcAmountBlur(&#39;modifyResultTips&#39;,&#39;withdrawAmount&#39;,2);" id="withdrawAmount" name="withdrawAmount">
						</span>
						&nbsp;&nbsp;
						<span id="withdrawAmountTips" class="fred"></span>
					</div>
					<div>
						<span class="c1">
							交易密码:
						</span>
						<span>
							<input type="password" onkeydown="callbackEnter(submitWithdrawBtcForm);" id="tradePwd" name="tradePwd">
						</span>
					</div>
						<div id="withdrawTotpCodeLi">
							<span class="c2">
								谷歌验证码:
							</span>
							<span>
								<input type="text" id="withdrawTotpCode" name="withdrawTotpCode">
							</span>
						</div>
					<div>
						<span class="c1">&nbsp;</span>
						<span id="modifyResultTips" class="fred"></span>
					</div>
					<div>
						<a class="button-blue2 confirmfin" title="确定提现" onclick="javascript:submitWithdrawBtcForm(&#39;BTC&#39;);" href="javascript:void(0);" id="withdrawBtcButton">
							确定提现
						</a>
					</div>
				</div>
			</div>
			<div class="entrustTen">
				<div class="Tentitle">
					<div class="title">
						<span class="left">
							最近10笔提现记录
						</span>
					</div>
				</div>
				<div id="Tenbody" class="Tenbody" style="display: block">
					<table style="border:none;">
						<tbody><tr>
							<th width="180">
								提现时间
							</th>
							<th width="100">
								提现数量
							</th>
							<th width="100">
								手续费
							</th>
							<th width="430">
								提现地址
							</th>
							<th width="120">
								提现状态
							</th>
							<th width="120">
								操作
							</th>
						</tr>
							<tr>
								<td align="center" colspan="6">
									<span class="no-data-tips">
										您暂时没有提现数据
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