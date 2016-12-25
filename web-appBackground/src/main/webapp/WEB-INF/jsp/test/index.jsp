<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<jsp:include page="./head.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	 getJypthq();
	 setInterval("getJypthq()", 3000);  
});

function getJypthq() {  
	
	$.ajax({
		type: "POST",
		url: '<%=request.getContextPath()%>/trade.do?getJypthq&tm='+new Date().getTime(),
		dataType:'json',
		cache: false,
		success: function(data){
			
			var title = '<tr class="tr1"><td>交易配对</td><td>最新成交价</td><td>变化</td><td>高</td><td>低</td></tr>';
			var vtr = '';
			$.each(data.obj, function(i, obj){
				 vtr += '<tr ';
				 vtr += ' onclick="toKLine('+"'"+data.obj[i].type+"'"+');"><td>'+data.obj[i].type + '/人民币'
						+'</td><td class="red">￥'+data.obj[i].buy+'</td><td></td><td>￥'+data.obj[i].high
						+'</td><td>￥'+data.obj[i].low+'</td></tr>'
		 	});
			
			if(vtr != ''){
				$('#tbTrade').empty();
				$('#tbTrade').append(title);
				$('#tbTrade').append(vtr);
			}
		}
	});
} 

function toKLine(type){
	window.location.href = '<%=request.getContextPath()%>/trade.do?kline&type=' + type;
}
</script>
<body>
<!--banner start here-->
 <div class="banner">
 		<div class="banner-main">
	 	   <section class="slider">
			 <div class="flexslider">
				<ul class="slides">
				  <li>
				  	<div class="banner-bottom">
				  		<div class="container">
					  		<!-- <div class="bann-text wow bounceInRight" data-wow-delay="0.3s">
							 	<h3>Choose Us</h3>
							 	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>	
						 	</div -->			 	
					   </div>
				 	</div>
				  </li>
				  <li>
				  	<div class="banner-bottom1">
				  		<div class="container">
					   </div>
				 	</div>
				  </li>
				  <li>
				  	<div class="banner-bottom2">
				  		<div class="container">
					   </div>
				 	</div>
				  </li>		  
			    </ul>
			 </div>
			 <div class="clearfix"> </div>
		   </section>
 		</div>
 </div>
<!--banner end here-->
<!-- FlexSlider -->
<script defer src="<%=request.getContextPath()%>/resources/js/test/jquery.flexslider.js"></script>
<script type="text/javascript">
	$(function(){
		
	});

	$(window).load(function() {
		$('.flexslider').flexslider({
			animation : "slide",
			start : function(slider) {
				$('body').removeClass('loading');
			}
		});
	});

	
</script>
<!-- FlexSlider -->
<!--banner-info strat here-->
<div class="main">
	<div class="index-news">
		<p>最新资讯</p>
		<div class="news-bg1"></div>
		<div class="autobox">
			<div class="innerbox">
			<div class="boxLeft">
				<span><img src="<%=request.getContextPath()%>/resources/img/test/news1.png"></span>
				<div class="incontent">
					<ul>
						<li>
							<p>2014-09-30</p>
							<div class="newstt">注册送币活动第四期已送达</div>
							<div class="newsli">亲爱的平台用户感谢感谢大家一直以来对SLM货币的支持注册送币或... </div>
						</li>
						<li>
							<p>2014-09-30</p>
							<div class="newstt">注册送币活动第四期已送达</div>
							<div class="newsli">亲爱的平台用户感谢感谢大家一直以来对SLM货币的支持注册送币或... </div>
						</li>
						<li>
							<p>2014-09-30</p>
							<div class="newstt">注册送币活动第四期已送达</div>
							<div class="newsli">亲爱的平台用户感谢感谢大家一直以来对SLM货币的支持注册送币或... </div>
						</li>
					</ul>
				</div>
			</div>
			<div class="boxRight">
				<span><img src="<%=request.getContextPath()%>/resources/img/test/news2.png"></span>
				<div class="incontent">
					<ul>
						<li>
							<p>2014-09-30</p>
							<div class="newstt">注册送币活动第四期已送达</div>
							<div class="newsli">亲爱的平台用户感谢感谢大家一直以来对SLM货币的支持注册送币或... </div>
						</li>
						<li>
							<p>2014-09-30</p>
							<div class="newstt">注册送币活动第四期已送达</div>
							<div class="newsli">亲爱的平台用户感谢感谢大家一直以来对SLM货币的支持注册送币或... </div>
						</li>
						<li>
							<p>2014-09-30</p>
							<div class="newstt">注册送币活动第四期已送达</div>
							<div class="newsli">亲爱的平台用户感谢感谢大家一直以来对SLM货币的支持注册送币或... </div>
						</li>
					</ul>
				</div>
			</div>
			</div>
		</div>
	</div>
	<div class="index-news">
		<p>最新交易</p>
		<div class="news-bg1"></div>
		<div class="tradeInfo">
			<table class="tbTrade"  id="tbTrade">
				<tr class="tr1">
					<td>交易配对</td>
					<td>最新成交价</td>
					<td>变化</td>
					<td>高</td>
					<td>低</td>
				</tr>
				<!-- <tr>
					<td>比特币(BTC)/人民币</td>
					<td>3383</td>
					<td>0.00%</td>
					<td>0</td>
					<td>0</td>
				</tr>
				<tr>
					<td>比特币(BTC)/人民币</td>
					<td>3383</td>
					<td>0.00%</td>
					<td>0</td>
					<td>0</td>
				</tr>
				<tr>
					<td>比特币(BTC)/人民币</td>
					<td>3383</td>
					<td>0.00%</td>
					<td>0</td>
					<td>0</td>
				</tr> -->
			</table>
		</div>
	</div>
	<div class="index-news">
		<p>选择我们</p>
		<div class="news-bg1"></div>
		<div class="chooseUs">
			<div class="autobox">
				<div class="innerbox">
					<div class="boxLeft">
						<span class="aboutItemLeft"><img src="<%=request.getContextPath()%>/resources/img/test/n1.png"></span>
						<span class="aboutItemRight">
							<p class="about1">自动API对接系统</p>
							<p class="aboutp1">客户以最快的时间以最有效的方式自动把货币充值到平台</p>
						</span>
						<div class="clearfix"></div>
						<span class="aboutItemLeft"><img src="<%=request.getContextPath()%>/resources/img/test/n2.png"></span>
						<span class="aboutItemRight">
							<p class="about1">自动API对接系统</p>
							<p class="aboutp1">客户以最快的时间以最有效的方式自动把货币充值到平台</p>
						</span>
						<div class="clearfix"></div>
						<span class="aboutItemLeft"><img src="<%=request.getContextPath()%>/resources/img/test/n3.png"></span>
						<span class="aboutItemRight">
							<p class="about1">自动API对接系统</p>
							<p class="aboutp1">客户以最快的时间以最有效的方式自动把货币充值到平台</p>
						</span>
						<div class="clearfix"></div>
					</div>
					<div class="boxRight">
						<span class="aboutItemLeft"><img src="<%=request.getContextPath()%>/resources/img/test/n4.png"></span>
						<span class="aboutItemRight">
							<p class="about1">自动API对接系统</p>
							<p class="aboutp1">客户以最快的时间以最有效的方式自动把货币充值到平台</p>
						</span>
						<div class="clearfix"></div>
						<span class="aboutItemLeft"><img src="<%=request.getContextPath()%>/resources/img/test/n5.png"></span>
						<span class="aboutItemRight">
							<p class="about1">自动API对接系统</p>
							<p class="aboutp1">客户以最快的时间以最有效的方式自动把货币充值到平台</p>
						</span>
						<div class="clearfix"></div>
						<span class="aboutItemLeft"><img src="<%=request.getContextPath()%>/resources/img/test/n6.png"></span>
						<span class="aboutItemRight">
							<p class="about1">自动API对接系统</p>
							<p class="aboutp1">客户以最快的时间以最有效的方式自动把货币充值到平台</p>
						</span>
						<div class="clearfix"></div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
		</div>
	</div>
</div>

<!--footer start here-->
<jsp:include page="./footer.jsp"></jsp:include>
<!--footer end here-->
</body>
</html>