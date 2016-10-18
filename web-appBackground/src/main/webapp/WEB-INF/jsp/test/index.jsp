<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>数字资产交易平台</title>
<link href="<%=request.getContextPath()%>/resources/css/test/bootstrap.css" rel="stylesheet" type="text/css" media="all">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="<%=request.getContextPath()%>/resources/js/test/jquery-1.11.0.min.js"></script>
<!-- Custom Theme files -->
<link href="<%=request.getContextPath()%>/resources/css/test/style.css" rel="stylesheet" type="text/css" media="all"/>
<!-- Custom Theme files -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
 <script src="<%=request.getContextPath()%>/resources/js/test/bootstrap.min.js"></script>
 <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/test/flexslider.css" type="text/css" media="screen" />
</head>
<body>
<!-- NAVBAR
================================================== -->
<div class="header">
    <div class="navbar-wrapper">
      <div class="container">
        <nav class="navbar navbar-inverse navbar-static-top">
            <div class="navbar-header">
              <div class="logo wow">
                    <a class="navbar-brand" href="index.html"><img src="<%=request.getContextPath()%>/resources/img/test/logo.png" /></a>
              </div>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
             <nav class="cl-effect-11">
              <ul class="nav navbar-nav">
                <li><a href="index.html" data-hover="Home"><img src="<%=request.getContextPath()%>/resources/img/test/navHome2.png"></a></li>
				<li><a href="trade.html" data-hover="About"><img src="<%=request.getContextPath()%>/resources/img/test/navTrade.png"></a></li>
				<li><a href="finance.html" data-hover="Services"><img src="<%=request.getContextPath()%>/resources/img/test/navFinance.png"></a></li>
				<li><a href="safe.html" data-hover="Shortcodes"><img src="<%=request.getContextPath()%>/resources/img/test/navSafe.png"></a></li>
				<li><a href="news.html" data-hover="Portfolio"><img src="<%=request.getContextPath()%>/resources/img/test/navNews.png"></a></li>
				<li class="loginDiv">
					<img src="<%=request.getContextPath()%>/resources/img/test/btnLogin.png" id="login">
					<img src="<%=request.getContextPath()%>/resources/img/test/btnReg.png" id="reg">
					<img src="<%=request.getContextPath()%>/resources/img/test/flag.png">
				</li>
              </ul>
            </nav>
            </div>
            <div class="clearfix"> </div>
             </nav>
			 
          </div>
           <div class="clearfix"> </div>
    </div>
     <div class="clearfix"> </div>
</div>
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
$(window).load(function(){
  $('.flexslider').flexslider({
	animation: "slide",
	start: function(slider){
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
			<table class="tbTrade">
				<tr class="tr1">
					<td>交易配对</td>
					<td>最新成交价</td>
					<td>变化</td>
					<td>高</td>
					<td>低</td>
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
				</tr>
				<tr>
					<td>比特币(BTC)/人民币</td>
					<td>3383</td>
					<td>0.00%</td>
					<td>0</td>
					<td>0</td>
				</tr>
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
<div class="footer">
	<div class="container">
		<div class="footer-main">	
			<div class="footer-left">
				<ul class="footer-nav">
					<li>
							<div class="subt">关于我们</div>
							<div>公司简介</div>
							<div>联系我们</div>
							<div>费率说明</div>
					</li>
					<li>
							<div class="subt">新手帮助</div>
							<div>注册指南</div>
							<div>交易指南</div>
							<div>充值指南</div>
					</li>
					<li>
							<div class="subt">下载中心们</div>
							<div>网络流通币钱包下载</div>
							<div>浏览器下载</div>
							<div>斯利姆币区块浏览器</div>
					</li>
					<li>
							<div class="subt">在线客服们</div>
							<div>QQ:246341869</div>
							<div>QQ:341255207</div>
							<div>邮箱：Incoin@163.com</li>
					</li>
				</ul>
			</div>
			<div class="footer-right">
				<p>关注微信</p>
				<div style="margin-top:0.5em;">
					<img src="<%=request.getContextPath()%>/resources/img/test/qrcode.png" style="width:4.8em;height:4.8em;">
				</div>
			</div>
		</div>
	</div>
</div>
<div class="copy-right">
	  <div class="crl">桂ICP备16003977</div>
	  <div class="crr">工商注册号91450100MA5K943Q6A</div>
	  <div class="clearfix"></div>
</div>
<!--footer end here-->
</body>
</html>