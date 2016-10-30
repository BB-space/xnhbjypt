// 导航代码
function NavMenu(cssEle, obcoin) {
	jQuery('#trade').mouseenter(function() {
		jQuery('.deal_list').show();
	});
	jQuery('#trade').mouseleave(function() {
		jQuery('.deal_list').hide();
	});

	jQuery('#userfinance').mouseenter(function() {
		jQuery.ajaxSetup({
			cache : false
		});
		var url = "/real/headerdetail.html?random=" + Math.round(Math.random() * 100);
		jQuery.post(url, null, function(data) {
			if (data != null) {
				var totalCapital = data.totalCapital;
				var fTotalRmb = data.fTotalRmb;
				var coinDetail = data.coinDetail;
				var mywalletlist = jQuery("#mywalletlist");
				jQuery.each(coinDetail, function(key, value) {

					mywalletlist.find("#myWalleTotal" + key).html(MoneyFormat(Number(value[3]), 4));
					mywalletlist.find("#myWalleFrozen" + key).html(MoneyFormat(Number(value[4]), 4));
					var myWalleHistoryPrize = mywalletlist.find("#myWalleHistoryPrize" + key).value;
					var prize = value[5];
					if (Number(myWalleHistoryPrize) > Number(prize)) {
						mywalletlist.find("#myWallePrizeImg" + key).css({
							"background" : "url(/static/front/images/trade/arrows2.png) no-repeat center center",
							"background-size" : "12px 12px"
						});
					}
					if (Number(myWalleHistoryPrize) < Number(prize)) {
						mywalletlist.find("#myWallePrizeImg" + key).css({
							"background" : "url(/static/front/images/trade/arrows1.png) no-repeat center center",
							"background-size" : "12px 12px"
						});
					}
					mywalletlist.find("#myWallePrize" + key).html(MoneyFormat(Number(prize), 4));
					mywalletlist.find("#myWalleTotalPrize" + key).html(MoneyFormat(Number(value[6]), 4));
				});
				mywalletlist.find("#myWalleTotalCapitalTrade").html(MoneyFormat(Number(totalCapital), 4));
				mywalletlist.find("#myWalleTotalRmb").html(MoneyFormat(Number(fTotalRmb), 4));
			}
		}, "json");
		jQuery('#mywalletlist').show();
		jQuery('#userfinance').css("background-position-x", "-229px");
		jQuery('#mywalletname').addClass("mywallet_name_active");
	}).mouseleave(function() {
		jQuery('#mywalletlist').hide();
		jQuery('#mywalletname').removeClass("mywallet_name_active");
	});
	// 更新消息中心
	if (jQuery("#leftmenumessagecount").length > 0) {
		setInterval(function() {
			var url = "/question/messagecount.html?random=" + Math.round(Math.random() * 100);
			jQuery.post(url, null, function(data) {
				if (data.code == 0) {
					jQuery("#leftmenumessagecount").html(data.count);
				}
			}, "json");
		}, 1000 * 60);
	}
	// 绑定错误提示框点击关闭按钮
	jQuery("span.errortips", ".coin_dialog").on("click", function() {
		jQuery(this).hide();
		jQuery(this).siblings('input').focus();
	})

	jQuery("span.errortips", ".coin_dialog").prev().focus(function() {
		var ele = jQuery(this).siblings("span.errortips");
		if (ele && ele.length > 0) {
			ele.hide();
		}
	})

	// 悬浮功能
	jQuery(".function-button a").mouseenter(function() {
		jQuery(this).find("em").css({
			"background-color" : "#4a91e3"
		});
		jQuery(this).find("span").stop().animate({
			"right" : "36px"
		});
	}).mouseleave(function() {
		jQuery(this).find("em").css({
			"background-color" : "#636363"
		});
		jQuery(this).find("span").stop().animate({
			"right" : "-64px"
		});
	});
	// 语言切换
	jQuery(".lan", ".lanselect").click(function() {
		jQuery.get("/language.html?lan=" + this.id + "&random=" + Math.round(Math.random() * 100), function(data) {
			if (data.status == 1) {
				window.location.reload();
			}
		}, "json");
	});
	lrFixFooter("#allFooter");
	ScrollImgLeft();
}

function lrFixFooter(obj) {
	var footer = jQuery(obj), doc = jQuery(document);
	function fixFooter() {
		if (doc.height() - 4 <= jQuery(window).height()) {
			footer.css({
				width : "100%",
				position : "absolute",
				left : 0,
				bottom : 0
			});
		} else {
			footer.css({
				position : "static"
			});
		}
	}
	fixFooter();
	jQuery(window).on('resize.footer', function() {
		fixFooter();
	});
	jQuery(window).on('scroll.footer', function() {
		fixFooter();
	});
}
function MoneyFormat(money, digit) {
	var reg = /^(-?\d*)\.?\d{1,4}$/;
	if (money != null && money.toString().split(".") != null && money.toString().split(".")[1] != null && money.toString().split(".")[1].length > digit) {
		if (!reg.test(money)) {
			var end = money.toString().split(".")[1];
			if (end.length > digit) {
				end = end.substring(0, digit);
			}
			money = money.toString().split(".")[0] + "." + end;
		}
	}
	return money;
}
var priceTmp = [];
// 用于记录setInterval返回得id 方便停止
var intervalId = null;
// interval 时间间隔 默认是3
var intervalTime;
// 用于记录三日趋势数据和昨日价格
var trends;
//滚动
function ScrollImgLeft() {
	var speed = 40;
	if(jQuery("#scroll_begin").length > 0 && jQuery("#scroll_end").length > 0 && jQuery("#scroll_div").length > 0){
	var scroll_begin = document.getElementById("scroll_begin");
	var scroll_end = document.getElementById("scroll_end");
	var scroll_div = document.getElementById("scroll_div");
	if (scroll_begin.offsetWidth > 1010) {
		scroll_end.innerHTML = scroll_begin.innerHTML;
		function Marquee() {
			if (scroll_end.offsetWidth - scroll_div.scrollLeft <= 0)
				scroll_div.scrollLeft -= scroll_begin.offsetWidth;
			else
				scroll_div.scrollLeft++;
		}
		var MyMar = setInterval(Marquee, speed);
		scroll_div.onmouseover = function() {
			clearInterval(MyMar);
		}
		scroll_div.onmouseout = function() {
			MyMar = setInterval(Marquee, speed);
		}
	}}
}