<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>字资产交易平台</title>
<jsp:include page="../test/head.jsp"></jsp:include>
<script type="text/javascript">

$(function(){
	//修改菜单头图片
	$("#index").attr('src', "<%=request.getContextPath()%>/resources/img/test/navHome.png"); 
	$("#trade").attr('src', "<%=request.getContextPath()%>/resources/img/test/navTrade2.png"); 
	$("#finance").attr('src', "<%=request.getContextPath()%>/resources/img/test/navFinance.png"); 
	$("#safe").attr('src', "<%=request.getContextPath()%>/resources/img/test/navSafe.png"); 
	$("#news").attr('src', "<%=request.getContextPath()%>/resources/img/test/navNews.png"); 
});

</script>
</head>
<body>

<div class="trade_banner">
	<ul class="pics">
		<li style="background-image:url(<%=request.getContextPath()%>/resources/img/test/trade_banner.jpg);"><a href="#" target="_blank"></a></li>	
		<li style="background-image:url(<%=request.getContextPath()%>/resources/img/test/8.jpg);"><a href="#" target="_blank"></a></li>
		<li style="background-image:url(<%=request.getContextPath()%>/resources/img/test/6.jpg);"><a href="#" target="_blank"></a></li>
	</ul>
	<div class="btns">
		<span class="hover"></span>
		<span></span>	
		<span></span>
	</div>	
	
	<div class="trade_tip">
		<div class="wrapin">
			<span class="tit">友情提示：</span>请控制风险，不要投入超过您风险承受能力的资金，不要投资您所不了解的数字货币，拒绝传销组织，警惕虚假宣传。	
		</div>	
	</div>
	
</div>
<script type="text/javascript">
	new FadeAdver({
		divs : $(".trade_banner .pics li"),
		btns : $(".trade_banner .btns span"),
		speed : 5000	
	});	
</script>

<div class="trade_top">
	
	<table class="tra_tab">
		<tr>
			<th>币种</th>
			<th>最新成交价</th>
			<th>买一价</th>
			<th>卖一价</th>
			<th>最高价</th>
			<th>最低价</th>
			<th>24H涨跌幅</th>
			<th>24H成交量</th>			
		</tr>
		<tr url="http://www.baidu.com">
			<td>比特币(BTC)</td>
			<td class="red">￥3878.78</td>
			<td>￥3878.78</td>	
			<td>￥3878.78</td>	
			<td>￥0</td>	
			<td>￥0</td>	
			<td class="red">0.0%</td>	
			<td>0</td>				
		</tr>
		<tr class="db"  url="http://www.baidu.com">
			<td>比特币(BTC)</td>
			<td class="red">￥3878.78</td>
			<td>￥3878.78</td>	
			<td>￥3878.78</td>	
			<td>￥0</td>	
			<td>￥0</td>	
			<td class="red">0.0%</td>	
			<td>0</td>				
		</tr>
		<tr url="http://www.baidu.com">
			<td>比特币(BTC)</td>
			<td class="red">￥3878.78</td>
			<td>￥3878.78</td>	
			<td>￥3878.78</td>	
			<td>￥0</td>	
			<td>￥0</td>	
			<td class="red">0.0%</td>	
			<td>0</td>				
		</tr>
	</table>
	<script type="text/javascript">
		
		$(".tra_tab tr").click(function(){
			location.href=$(this).attr("url");	
		});
			
	</script>
	
</div>

<div class="trade_ct">	
	
	<div class="tradect_wrap">
		
		<div class="tradect_item">
			<div class="title">新闻资讯</div>	
			
			<div class="out">
				<div class="inner">
					<ul>
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>	
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>	
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>	
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>							
					</ul>	
				</div>		
			</div>
			
			<a href="#" class="more">查看更多</a>
			
		</div>
		
		<div class="tradect_item">
			<div class="title">官方公告</div>	
			
			<div class="out">
				<div class="inner">
					<ul>
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>	
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>	
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>	
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>							
					</ul>	
				</div>		
			</div>
			
			<a href="#" class="more">查看更多</a>
			
		</div>
		
		<div class="tradect_item">
			<div class="title">数字资产信息</div>	
			
			<div class="out">
				<div class="inner">
					<ul>
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>	
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>	
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>	
						<li>
							<dl>
								<dt>2014-09-30</dt>
								<dd>注册送币活动第四批用户已送达！</dd>
							</dl>	
						</li>							
					</ul>	
				</div>		
			</div>
			
			<a href="#" class="more">查看更多</a>
			
		</div>
		
		<div class="clear"></div>	
	</div>
	
	<div class="clear"></div>	
</div>
<script type="text/javascript">
	
	
		
</script>

<div class="trade_bt">
	<div class="title">风险警告</div>	
	<p>本交易平台采取自由交换，不涉及国际金融交易、洗钱和非法集资、传销。如本平台发现以上情形，本平台可以拒绝成交，最终解释权归本平台所有。</p>
	<p>本交易平台，不参与任何虚拟币和网络流通币的交换、买卖，本平台拒绝资金池和庄家，如发现以上情形，本平台可拒绝交换。</p>
	<p>请控制风险，不要投入超过您风险承受能力的资金，不要投资您不了解的数位货币和网络流通币，警惕虚假宣传，谨慎交易、交换。</p>
	<p>数位货币和网络流通币具有极高的风险（预挖、暴涨暴跌、团队解散、科技缺陷），</p>
	<p>根据国家五部委《关于防范比特币风险的通知》，交易平台仅为网络流通币和虚拟币爱好者提供一个自由的网上交换的平台，</p>
	<p>对币的价值不承担任何审查、担保、赔偿的责任，</p>
	<p>如不能接受以上告知，请勿进行交换，</p>
</div>

<!--footer start here-->
<jsp:include page="../test/footer.jsp"></jsp:include>
<!--footer end here-->



</body>
</html>