<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>字资产交易平台</title>
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

<!-- ECharts单文件引入 -->
<script src="<%=request.getContextPath()%>/resources/js/echarts.js"></script>
    
<jsp:include page="../test/head.jsp"></jsp:include>
<style type="text/css">
.marketArea {
    width: 1200px;
}
.marketArea .rightArea {
    width: 1200px;
}
.marketArea .rightArea .Areacon {
    width: 1138px;
}
.marketArea .rightArea .Areacon {
    font-size: 14px;
    background: #fff;
    border: 1px solid #e1e1e2;
    padding: 30px 0px 0;
    float: left;
    min-height: 542px;
}
.buysellTitle {
    float: left;
}
.trademarket {
    width: 1138px;
    height: 580px;
    display: block;
}
.top-con {
    height: 50px;
    padding-bottom: 20px;
    background: #fff;
    border-bottom: solid 1px #cccccc;
}
.top-con .wblock245 {
    width: 210px;
}
.top-con .top-con-block {
    line-height: 50px;
    text-align: center;
    float: left;
    color: #797979;
    font-size: 16px;
    position: relative;
}
.top-con .wblock170 {
    width: 239px;
}
.right-con {
    height: 430px;
    background: #fff;
}
.right-con-left {
    width: 725px;
    float: left;
    padding: 30px 30px 5px 0;
}
.top-top {
    height: 70px;
}
.top-top .top-top-item {
    width: 412px;
    color: #777783;
    font-size: 16px;
    line-height: 25px;
    float: left;
}
.top-top .top-top-item-right {
    width: 280px;
}
.top-top .top-top-item .numsize24 {
    min-width: 85px;
}
.top-top .top-top-item span {
    font-size: 14px;
    display: inline-block;
}
.buysell-box {
    width: 725px;
    padding-bottom: 5px;
    padding-top: 5px;
    float: left;
}
.buysell-box .buy-box {
    width: 350px;
    height: 305px;
    float: left;
    border-right: #e4e4e4 2px dashed;
}
.buysell-box .one {
    width: 290px;
    height: 50px;
    float: left;
    position: relative;
}
.buysell-box .cnytips {
    position: absolute;
    top: 0;
    left: 0;
    font-size: 14px;
    line-height: 35px;
    color: #aaaaaa;
    padding-left: 5px;
}
.buysell-box input[type=text] {
    width: 283px;
    height: 35px;
    float: left;
    border: #cbcbcb solid 1px;
    outline: none;
    text-align: right;
    padding-right: 5px;
}
.buysell-box .two {
    width: 290px;
    height: 50px;
    float: left;
}
.buysell-box .thr {
    width: 290px;
    height: 50px;
    float: left;
    position: relative;
}
.buysell-box .fou {
    width: 290px;
    height: 70px;
    float: left;
}
.buysell-box .fou-box {
    width: 287px;
    height: 58px;
    float: left;
    border: #aaaaaa dotted 1px;
}
.buysell-box .tradesum {
    float: left;
    font-size: 14px;
    padding-top: 5px;
    padding-left: 5px;
}
.buysell-box .tradetype {
    float: right;
    font-size: 14px;
    padding-top: 5px;
    padding-right: 5px;
    padding-left: 5px;
}
.buysell-box .fiv {
    width: 290px;
    height: 40px;
    float: left;
}
.buysell-box .six {
    width: 290px;
    height: 50px;
    float: left;
}
.buysell-box input[type=button] {
    width: 283px;
    height: 35px;
    float: left;
    border: #cbcbcb solid 1px;
    outline: none;
    text-align: center;
    padding-right: 5px;
    cursor: pointer;
}
.buysell-box .sellbutton {
    background: #d00212;
    color: #fff;
}

.buysell-box .buybutton {
    background: #009900;
    color: #fff;
}



.coinBoxbuybtc {
    width: 383px;
    float: left;
    padding-top: 30px;
    font-size: 12px;
}

.buysell-box {
    width: 725px;
    padding-bottom: 5px;
    padding-top: 5px;
    float: left;
}

.coinBoxbuybtc {
    width: 383px;
    float: left;
    padding-top: 30px;
    font-size: 12px;
}
.coinBoxbuybtc .orderlist {
	padding-left: 20px;
	border: #e4e4e4 1px solid;
}
.coinBoxbuybtc .orderlist li {
	line-height: 30px;
	font-size: 14px;
}
.coinBoxbuybtc .orderlist li.info {
	border-bottom: #f5f7fa 1px solid
}

.coinBoxbuybtc .orderlist li span {
	color: #434343;
	display: inline-block;
}
.coinBoxbuybtc .orderlist li span.c1 {
	width: 60px;
	*width: 60px;
	padding-left: 0;
}

.coinBoxbuybtc .orderlist li span.c2 {
	width: 85px;
	*width: 85px;
	padding-left: 0;
}

.coinBoxbuybtc .orderlist li span.c3 {
	width: 105px;
	*width: 105px;
	padding-left: 0;
	text-align: left;
}

.coinBoxbuybtc .orderlist li span.green {
	color: #009900;
}


</style>
<script type="text/javascript">

//数据意义：开盘(open)，收盘(close)，最低(lowest)，最高(highest)
var data0 = splitData([
    ['2013/1/24', 2320.26,2320.26,2287.3,2362.94],
    ['2013/1/25', 2300,2291.3,2288.26,2308.38],
    ['2013/1/28', 2295.35,2346.5,2295.35,2346.92],
    ['2013/1/29', 2347.22,2358.98,2337.35,2363.8],
    ['2013/1/30', 2360.75,2382.48,2347.89,2383.76],
    ['2013/1/31', 2383.43,2385.42,2371.23,2391.82],
    ['2013/2/1', 2377.41,2419.02,2369.57,2421.15],
    ['2013/2/4', 2425.92,2428.15,2417.58,2440.38],
    ['2013/2/5', 2411,2433.13,2403.3,2437.42],
    ['2013/2/6', 2432.68,2434.48,2427.7,2441.73],
    ['2013/2/7', 2430.69,2418.53,2394.22,2433.89],
    ['2013/2/8', 2416.62,2432.4,2414.4,2443.03],
    ['2013/2/18', 2441.91,2421.56,2415.43,2444.8],
    ['2013/2/19', 2420.26,2382.91,2373.53,2427.07],
    ['2013/2/20', 2383.49,2397.18,2370.61,2397.94],
    ['2013/2/21', 2378.82,2325.95,2309.17,2378.82],
    ['2013/2/22', 2322.94,2314.16,2308.76,2330.88],
    ['2013/2/25', 2320.62,2325.82,2315.01,2338.78],
    ['2013/2/26', 2313.74,2293.34,2289.89,2340.71],
    ['2013/2/27', 2297.77,2313.22,2292.03,2324.63],
    ['2013/2/28', 2322.32,2365.59,2308.92,2366.16],
    ['2013/3/1', 2364.54,2359.51,2330.86,2369.65],
    ['2013/3/4', 2332.08,2273.4,2259.25,2333.54],
    ['2013/3/5', 2274.81,2326.31,2270.1,2328.14],
    ['2013/3/6', 2333.61,2347.18,2321.6,2351.44],
    ['2013/3/7', 2340.44,2324.29,2304.27,2352.02],
    ['2013/3/8', 2326.42,2318.61,2314.59,2333.67],
    ['2013/3/11', 2314.68,2310.59,2296.58,2320.96],
    ['2013/3/12', 2309.16,2286.6,2264.83,2333.29],
    ['2013/3/13', 2282.17,2263.97,2253.25,2286.33],
    ['2013/3/14', 2255.77,2270.28,2253.31,2276.22],
    ['2013/3/15', 2269.31,2278.4,2250,2312.08],
    ['2013/3/18', 2267.29,2240.02,2239.21,2276.05],
    ['2013/3/19', 2244.26,2257.43,2232.02,2261.31],
    ['2013/3/20', 2257.74,2317.37,2257.42,2317.86],
    ['2013/3/21', 2318.21,2324.24,2311.6,2330.81],
    ['2013/3/22', 2321.4,2328.28,2314.97,2332],
    ['2013/3/25', 2334.74,2326.72,2319.91,2344.89],
    ['2013/3/26', 2318.58,2297.67,2281.12,2319.99],
    ['2013/3/27', 2299.38,2301.26,2289,2323.48],
    ['2013/3/28', 2273.55,2236.3,2232.91,2273.55],
    ['2013/3/29', 2238.49,2236.62,2228.81,2246.87],
    ['2013/4/1', 2229.46,2234.4,2227.31,2243.95],
    ['2013/4/2', 2234.9,2227.74,2220.44,2253.42],
    ['2013/4/3', 2232.69,2225.29,2217.25,2241.34],
    ['2013/4/8', 2196.24,2211.59,2180.67,2212.59],
    ['2013/4/9', 2215.47,2225.77,2215.47,2234.73],
    ['2013/4/10', 2224.93,2226.13,2212.56,2233.04],
    ['2013/4/11', 2236.98,2219.55,2217.26,2242.48],
    ['2013/4/12', 2218.09,2206.78,2204.44,2226.26],
    ['2013/4/15', 2199.91,2181.94,2177.39,2204.99],
    ['2013/4/16', 2169.63,2194.85,2165.78,2196.43],
    ['2013/4/17', 2195.03,2193.8,2178.47,2197.51],
    ['2013/4/18', 2181.82,2197.6,2175.44,2206.03],
    ['2013/4/19', 2201.12,2244.64,2200.58,2250.11],
    ['2013/4/22', 2236.4,2242.17,2232.26,2245.12],
    ['2013/4/23', 2242.62,2184.54,2182.81,2242.62],
    ['2013/4/24', 2187.35,2218.32,2184.11,2226.12],
    ['2013/4/25', 2213.19,2199.31,2191.85,2224.63],
    ['2013/4/26', 2203.89,2177.91,2173.86,2210.58],
    ['2013/5/2', 2170.78,2174.12,2161.14,2179.65],
    ['2013/5/3', 2179.05,2205.5,2179.05,2222.81],
    ['2013/5/6', 2212.5,2231.17,2212.5,2236.07],
    ['2013/5/7', 2227.86,2235.57,2219.44,2240.26],
    ['2013/5/8', 2242.39,2246.3,2235.42,2255.21],
    ['2013/5/9', 2246.96,2232.97,2221.38,2247.86],
    ['2013/5/10', 2228.82,2246.83,2225.81,2247.67],
    ['2013/5/13', 2247.68,2241.92,2231.36,2250.85],
    ['2013/5/14', 2238.9,2217.01,2205.87,2239.93],
    ['2013/5/15', 2217.09,2224.8,2213.58,2225.19],
    ['2013/5/16', 2221.34,2251.81,2210.77,2252.87],
    ['2013/5/17', 2249.81,2282.87,2248.41,2288.09],
    ['2013/5/20', 2286.33,2299.99,2281.9,2309.39],
    ['2013/5/21', 2297.11,2305.11,2290.12,2305.3],
    ['2013/5/22', 2303.75,2302.4,2292.43,2314.18],
    ['2013/5/23', 2293.81,2275.67,2274.1,2304.95],
    ['2013/5/24', 2281.45,2288.53,2270.25,2292.59],
    ['2013/5/27', 2286.66,2293.08,2283.94,2301.7],
    ['2013/5/28', 2293.4,2321.32,2281.47,2322.1],
    ['2013/5/29', 2323.54,2324.02,2321.17,2334.33],
    ['2013/5/30', 2316.25,2317.75,2310.49,2325.72],
    ['2013/5/31', 2320.74,2300.59,2299.37,2325.53],
    ['2013/6/3', 2300.21,2299.25,2294.11,2313.43],
    ['2013/6/4', 2297.1,2272.42,2264.76,2297.1],
    ['2013/6/5', 2270.71,2270.93,2260.87,2276.86],
    ['2013/6/6', 2264.43,2242.11,2240.07,2266.69],
    ['2013/6/7', 2242.26,2210.9,2205.07,2250.63],
    ['2013/6/13', 2190.1,2148.35,2126.22,2190.1]
]);


$(function(){
	//修改菜单头图片
	$("#index").attr('src', "<%=request.getContextPath()%>/resources/img/test/navHome.png"); 
	$("#trade").attr('src', "<%=request.getContextPath()%>/resources/img/test/navTrade2.png"); 
	$("#finance").attr('src', "<%=request.getContextPath()%>/resources/img/test/navFinance.png"); 
	$("#safe").attr('src', "<%=request.getContextPath()%>/resources/img/test/navSafe.png"); 
	$("#news").attr('src', "<%=request.getContextPath()%>/resources/img/test/navNews.png"); 
	
	//基于准备好的dom，初始化echarts图表
	var myChart = echarts.init(document.getElementById('main')); 

	var option = {
		    title: {
		        text: 'K线图',
		        left: 0
		    },
		    tooltip: {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'line'
		        }
		    },
		    legend: {
		        data: ['日K', 'MA5', 'MA10', 'MA20', 'MA30']
		    },
		    grid: {
		        left: '10%',
		        right: '10%',
		        bottom: '15%'
		    },
		    xAxis: {
		        type: 'category',
		        data: data0.categoryData,
		        scale: true,
		        boundaryGap : false,
		        axisLine: {onZero: false},
		        splitLine: {show: false},
		        splitNumber: 20,
		        min: 'dataMin',
		        max: 'dataMax'
		    },
		    yAxis: {
		        scale: true,
		        splitArea: {
		            show: true
		        }
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataZoom : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType: {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    dataZoom: [
		        {
		            type: 'inside',
		            start: 50,
		            end: 100
		        },
		        {
		            show: true,
		            type: 'slider',
		            y: '90%',
		            start: 50,
		            end: 100
		        }
		    ],
		    series: [
		        {
		            name: '日K',
		            type: 'candlestick',
		            data: data0.values,
		            markPoint: {
		                label: {
		                    normal: {
		                        formatter: function (param) {
		                            return param != null ? Math.round(param.value) : '';
		                        }
		                    }
		                },
		                data: [
		                    {
		                        name: 'XX标点',
		                        coord: ['2013/5/31', 2300],
		                        value: 2300,
		                        itemStyle: {
		                            normal: {color: 'rgb(41,60,85)'}
		                        }
		                    },
		                    {
		                        name: 'highest value',
		                        type: 'max',
		                        valueDim: 'highest'
		                    },
		                    {
		                        name: 'lowest value',
		                        type: 'min',
		                        valueDim: 'lowest'
		                    },
		                    {
		                        name: 'average value on close',
		                        type: 'average',
		                        valueDim: 'close'
		                    }
		                ],
		                tooltip: {
		                    formatter: function (param) {
		                        return param.name + '<br>' + (param.data.coord || '');
		                    }
		                }
		            },
		            markLine: {
		                symbol: ['none', 'none'],
		                data: [
		                    [
		                        {
		                            name: 'from lowest to highest',
		                            type: 'min',
		                            valueDim: 'lowest',
		                            symbol: 'circle',
		                            symbolSize: 10,
		                            label: {
		                                normal: {show: false},
		                                emphasis: {show: false}
		                            }
		                        },
		                        {
		                            type: 'max',
		                            valueDim: 'highest',
		                            symbol: 'circle',
		                            symbolSize: 10,
		                            label: {
		                                normal: {show: false},
		                                emphasis: {show: false}
		                            }
		                        }
		                    ],
		                    {
		                        name: 'min line on close',
		                        type: 'min',
		                        valueDim: 'close'
		                    },
		                    {
		                        name: 'max line on close',
		                        type: 'max',
		                        valueDim: 'close'
		                    }
		                ]
		            }
		        },
		        {
		            name: 'MA5',
		            type: 'line',
		            data: calculateMA(5),
		            smooth: true,
		            lineStyle: {
		                normal: {opacity: 0.5}
		            }
		        },
		        {
		            name: 'MA10',
		            type: 'line',
		            data: calculateMA(10),
		            smooth: true,
		            lineStyle: {
		                normal: {opacity: 0.5}
		            }
		        },
		        {
		            name: 'MA20',
		            type: 'line',
		            data: calculateMA(20),
		            smooth: true,
		            lineStyle: {
		                normal: {opacity: 0.5}
		            }
		        },
		        {
		            name: 'MA30',
		            type: 'line',
		            data: calculateMA(30),
		            smooth: true,
		            lineStyle: {
		                normal: {opacity: 0.5}
		            }
		        },

		    ]
		};

	// 为echarts对象加载数据 
	myChart.setOption(option);
});

function splitData(rawData) {
    var categoryData = [];
    var values = []
    for (var i = 0; i < rawData.length; i++) {
        categoryData.push(rawData[i].splice(0, 1)[0]);
        values.push(rawData[i])
    }
    return {
        categoryData: categoryData,
        values: values
    };
}

function calculateMA(dayCount) {
    var result = [];
    for (var i = 0, len = data0.values.length; i < len; i++) {
        if (i < dayCount) {
            result.push('-');
            continue;
        }
        var sum = 0;
        for (var j = 0; j < dayCount; j++) {
            sum += data0.values[i - j][1];
        }
        result.push(sum / dayCount);
    }
    return result;
}



</script>
</head>
<body>

<div class="marketArea ">
		<div class="rightArea">
			<div class="Areacon">
				<div class="buysellTitle">
					<div class="top-con">
						<div id="cointradedetail" class="top-con-block wblock245 pointer">
							<img id="MarketCoinLogo" class="coinicon" src="/upload/coinlogo/201606301642019_piSkl.png"></img>
							<span id="MarketCoinName" class="marRightTop1Name"> 莱特币(LTC) </span>
							
								<span class="down"></span>
								<!-- <div class="deal_trade_list" id="markettradecoindetail">
									<div class="nocontent"></div>
									<dl>
										<dd>
											<a href="/trade/coin.html?coinType=1&tradeType=0 ">
												<i class="deal_list_pic_pts" style="background:url(/upload/coinlogo/201606301641038_TiaMT.png) no-repeat;background-size: 100% 100%;"></i>
												<div class="all_coin_name">
													<p>狗狗币(DOGE)</p>
													<span id="lastDealPrize_1">
														￥0.001646
													</span>
													<input type="hidden" id="coinBoxHistoryLastDealPrize1" value="0.001646 }" />
												</div>
											</a>
										</dd>
									
										<dd>
											<a href="/trade/coin.html?coinType=4&tradeType=0 ">
												<i class="deal_list_pic_pts" style="background:url(/upload/coinlogo/201606301642047_Ogdhg.png) no-repeat;background-size: 100% 100%;"></i>
												<div class="all_coin_name">
													<p>斯利姆(SLM)</p>
													<span id="lastDealPrize_4">
														￥7.4
													</span>
													<input type="hidden" id="coinBoxHistoryLastDealPrize4" value="7.4 }" />
												</div>
											</a>
										</dd>
										
									</dl>
								</div> -->
							
						</div>
						<div class="top-con-block wblock245">
							<span>
								最新价：
							</span>
							<span id="marketLast" class="topred">
								￥25.28
							</span>
							<input type="hidden" id="coinBoxHistoryLastDealPrize3" value="25.28 }" />
						</div>
						<div class="top-con-block wblock170">
							<span>
								最低价：
							</span>
							<span id="marketLow" class="topgrend">
								￥0
							</span>
						</div>
						<div class="top-con-block wblock170">
							<span>
								最高价：
							</span>
							<span id="marketHigh" class="topred">
								￥0
							</span>
						</div>
						<div class="top-con-block wblock170">
							<span>
								涨幅：
							</span>
								
									<span id="marketRose" class="topred"> 0.0% </span>
							
						</div>
					</div>
					<!-- <div class="trademarket">
						<iframe frameborder="0" border="0" width="100%" height="100%" id="klineFullScreen" src="/kline/start.html?symbol=3&themename=dark"></iframe>
					</div> -->
					
					<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    				<div id="main" class="trademarket" ></div>
    
					<div class="right-con">
						<div class="right-con-left">
							<div class="top-top">
								<div class="top-top-item">
									<span class="numsize24">
										可用(CNY)：
									</span>
									<span id="toptradecnymoney">
										11
									</span>
								</div>
								<div class="top-top-item top-top-item-right">
									<span class="numsize24">
										冻结(CNY)：
									</span>
									<span id="toptradefrozencnymoney">
										0
									</span>
								</div>
								<div class="top-top-item">
									<span class="numsize24">
										可用(LTC)：
									</span>
									<span id="toptrademtccoin">
										0
									</span>
								</div>
								<div class="top-top-item top-top-item-right">
									<span class="numsize24">
										冻结(LTC)：
									</span>
									<span id="toptradefrozenmtccoin">
										0
									</span>
								</div>
							</div>
							<div class="buysell-box">
								
								<div class="buy-box">
									<div class="one">
										<span class="cnytips">
											买入价
											CNY
										</span>
										<input type="text" class="buysellinput" name="tradeCnyPrice" id="userbuyCnyBalance" style="ime-mode:disabled" onpaste="return false" ondragenter="return false" oncontextmenu="return false;" onkeyup="javascript:NumVerify(1,0);" onkeyup="javascript:NumVerify(2,0);" onclick="this.focus();this.select();" onKeypress="return VerifyKeypress(this,event);" value='25.76' />
									</div>
									<div class="two">
										<div style="margin:0px 0px;" class="clear" id="numberBar">
											<div id="idSliderbuy" class="slider3" style="float:left;margin-left:10px;">
												<a class="percentCirclebgFirst" id="percentbuyZer" href="javascript:void(0)"></a>
												<a class="percentCirclebgPositionOne" id="percentbuyOne" href="javascript:void(0)"></a>
												<a class="percentCirclebgPositionTwo" id="percentbuyTwo" href="javascript:void(0)"></a>
												<a class="percentCirclebgPositionThree" id="percentbuyThree" href="javascript:void(0)"></a>
												<a class="percentCirclebgPositionFour" id="percentbuyFour" href="javascript:void(0)"></a>
												<div id="idBarbuy2" class="barRed">
													<div id="idBarbuy" class="bar3" onmouseover="this.style.cursor='pointer'"></div>
												</div>
											</div>
										</div>
									</div>
									<div class="thr">
										<span class="cnytips">
											买入量
											LTC
										</span>
										<input type="text" style="ime-mode:disabled" class="buysellinput" name="tradeAmount" id="tradebuyAmount" onkeyup="javascript:NumVerify(2,0);" onpaste="return false" ondragenter="return false" oncontextmenu="return false;" onkeydown="if(event.keyCode==13)event.keyCode=9" onclick="this.focus();this.select();" onkeyup="javascript:NumVerify(1,0);" onKeypress="return VerifyKeypress(this,event);" />
									</div>
									<div class="fou">
										<div class="fou-box">
											<span class="tradesum">
												交易额
											</span>
											<span class="tradetype">
												CNY
											</span>
											<span id="tradebuyTurnover" class="trademoney">0.00</span>
										</div>
									</div>
									<div class="fiv">
										<div id="trademtcBuyTips" class="fred center tradeBtcTips"></div>
									</div>
									<div class="six">
										<input type="button" class="sellbutton" value="买入LTC" onclick="submitTradeBtcForm(0)" />
									</div>
								</div>
								
								<div class="sell-box">
									<div class="one">
										<span class="cnytips">
											卖出价
											CNY
										</span>
										<input type="text" class="buysellinput" style="ime-mode:disabled" name="tradeCnyPrice" id="usersellCnyBalance" onpaste="return false" ondragenter="return false" oncontextmenu="return false;" onclick="this.focus();this.select();" onkeydown="if(event.keyCode==13)event.keyCode=9" onkeyup="javascript:NumVerify(1,1);" onKeypress="return VerifyKeypress(this,event);" value='24.71' />
									</div>
									<div class="two">
										<div style="margin:0px 0px;" class="clear" id="numberBar">
											<div id="idSlidersell" class="slider3" style="float:left;margin-left:10px;">
												<a class="percentCirclebgFirst" id="percentsellZer" href="javascript:choicepercert(0)"></a>
												<a class="percentCirclebgPositionOne" id="percentsellOne" href="javascript:choicepercert(1)"></a>
												<a class="percentCirclebgPositionTwo" id="percentsellTwo" href="javascript:choicepercert(2)"></a>
												<a class="percentCirclebgPositionThree" id="percentsellThree" href="javascript:choicepercert(3)"></a>
												<a class="percentCirclebgPositionFour" id="percentsellFour" href="javascript:choicepercert(4)"></a>
												<div id="idBarsell2" class="barGreen">
													<div id="idBarsell" class="bar3" onmouseover="this.style.cursor='pointer'"></div>
												</div>
											</div>
										</div>
									</div>
									<div class="thr">
										<span class="cnytips">
											卖出量
											LTC
										</span>
										<input type="text" class="buysellinput" style="ime-mode:disabled" name="tradeAmount" id="tradesellAmount" onpaste="return false" ondragenter="return false" oncontextmenu="return false;" onkeydown="if(event.keyCode==13)event.keyCode=9" onclick="this.focus();this.select();" onkeyup="javascript:NumVerify(2,1);" onKeypress="return VerifyKeypress(this,event);" />
									</div>
									<div class="fou">
										<div class="fou-box">
											<span class="tradesum">
												交易额
											</span>
											<span class="tradetype">
												CNY
											</span>
											<span id="tradesellTurnover" class="trademoney">0.00</span>
										</div>
									</div>
									<div class="fiv">
										<div id="trademtcsellTips" class="fred center tradeBtcTips"></div>
									</div>
									<div class="six">
										<input type="button" class="buybutton" value='卖出LTC' onclick="submitTradeBtcForm(1)" />
									</div>
								</div>
							</div>
							<div id="entrustInfo" class="clear dealinfo">
								<span style="font-size: 18px;padding-bottom: 20px;display: block;">
									<span>
										最新成交
									</span>
									<a href="financial/listentrust.html?symbol=3">
										我的成交
									</a>
								</span>
								<table>
									<thead>
										<tr>
											<th width="150">
												成交时间
											</th>
											<th width="100">
												类型
											</th>
											<th width="150">
												成交价
											</th>
											<th width="150">
												成交量
											</th>
											<th width="150">
												总计
											</th>
										</tr>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						</div>
						<div id="coinBoxbuybtc" class="coinBoxbuybtc">
							<span style="font-size: 18px;padding-bottom: 20px;display: block;">
								委托信息
							</span>
							<ul class="orderlist">
									
									<li onmouseover="this.style.cursor='pointer';this.style.backgroundColor='#FFFFAA';" onmouseout="this.style.backgroundColor=' #fff';" onclick="javascript:autoTrade(1,1,'LTC');">
										<span class="c1 green ">
											卖
											(2)
										</span>
										<span class="c2 ">
											<input id="sellPrice1" type="hidden" value="25.77" />
											25.77
										</span>
										<span class="c3 green ">
											
											<input id="sellAmount1" type="hidden" value="0.689881" />
											0.689881
										</span>
												<span style="width:0.689881px;background: #ee3523;height: 15px;"></span>
									</li>
								
								<li class="info">&nbsp;</li>
								
									<li onmouseover="this.style.cursor='pointer';this.style.backgroundColor=' #FFFFAA';" onmouseout="this.style.backgroundColor=' #fff';" onclick="javascript:autoTrade(1,0,'LTC');">
										<span class="c1 red ">
											买
											(1)
										</span>
										<span class="c2">
											<input id="buyPrice1" type="hidden" value="24.71" />
											24.71
										</span>
										<span class="c3 red">
											
											<input id="buyAmount1" type="hidden" value="1.070336" />
											1.070336
										</span>
												<span style="width:1.070336px;background: #ee3523;height: 15px;"></span>
									</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 	<input type="hidden" value="1" id="tradeType">
	<input type="hidden" value="3" id="symbol">
	<input id="coinName" type="hidden" value="莱特币">
	<input id="coinshortName" type="hidden" value="LTC">
	<span id="secondNumber" style="display:none"></span>
	<input type="hidden" value="true" id="isopen">
	<input type="hidden" value="" id="tradePwd">
	<div style="display:none;" id="updatePhoneDiv" class="coin_dialog">
		<div style="width:400px;" id="updatePhone_content_auth" class="dialog_content">
			<div id="updatePhone_title_auth" class="dialog_title">
				<span>
					交易密码
				</span>
				<a title="关闭" class="dialog_closed" href="javascript:closeUpdatePhone();"></a>
			</div>
			<div class="dialog_body">
				<div class="center tips_body" id="oldValidatePhoneDiv">
					
						
							<span class="black">
								您未设置安全交易密码，请先设置安全交易密码!
							</span>
							</br>
							</br>
							<a href="/user/security.html">
								设置安全交易密码
								&gt;&gt;
							</a>
							</br>
							</br>
						
						
					
				</div>
			</div>
		</div>
	</div> -->




<!--footer start here-->
<jsp:include page="../test/footer.jsp"></jsp:include>
<!--footer end here-->

</body>
</html>