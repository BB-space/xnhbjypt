<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/account.css">
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var datagridPro;
	var contractDialog;
	var passwrodInput;
	var employeeName;
	var employeeMobile;
	var beginTime = '${beginTime}',endTime = '${endTime}';
	var selMonth = '${month}';
	
	$(function() {
		$("#empDiv").hide();
		$("#proDiv").hide();
		
		$("#month").html('${month}');
		$("#num1").html('${num1}');
		$("#num2").html('${num2}');
		$("#num3").html('${num3}');
		$("#num4").html('${num4}');
		$("#num5").html('${num5}');
		$("#num6").html('${num6}');
		$("#num7").html('${num7}');
		var monthStatus = '${monthStatus}';
		if(monthStatus == "1"){//已确认
			$("#sureMBefore").hide();
			$("#sureMAfter").show();
		}else{
			$("#sureMAfter").hide();
			$("#sureMBefore").show();
		}
		
		$('#datetime1').datebox({    
            onShowPanel : function() {// 显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层    
                span.trigger('click'); // 触发click事件弹出月份层   
                if (!tds)    
                    setTimeout(function() {// 延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔    
                        tds = p.find('div.calendar-menu-month-inner td');    
                        tds.click(function(e) {    
                            e.stopPropagation(); // 禁止冒泡执行easyui给月份绑定的事件    
                            var year = /\d{4}/.exec(span.html())[0]// 得到年份    
                            , month = parseInt($(this).attr('abbr'), 10) + 1; // 月份    
                            $('#datetime1').datebox('hidePanel')// 隐藏日期对象    
                            .datebox('setValue', year + '-' + month); // 设置日期的值    
                        });    
                    }, 0);    
            },    
            parser : function(s) {// 配置parser，返回选择的日期    
                if (!s)    
                    return new Date();    
                var arr = s.split('-');    
//                 nowMonthFirstDay = s+"-01";
                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);    
            },   
            formatter : function(d) {    
                var month = d.getMonth(); 
                var nextMonth = d.getMonth()+1;
                if(month<10){  
                    month = "0"+month;  
                }
                if(nextMonth<10){  
                	nextMonth = "0"+nextMonth;  
                }
                
                var myDate = new Date(); //获得当前时间
                var nowyear = myDate.getFullYear();//获得年、月、日
                var nowmonth = myDate.getMonth( )+1;
                var nowMonthFirstDay = nowyear+'-'+nowmonth+'-01';
                var k = 0;
                if (d.getMonth() == 0) {  //12月  
                	beginTime = d.getFullYear()-1 + '-12'  + '-01';
                	endTime = d.getFullYear() + '-01' + '-01';
                	if(beginTime < '2016-08-01'){
                    	alert("此活动从8月开始哦");
                    }else if(beginTime>=nowMonthFirstDay){//判断时间
                    	alert("选择时间限制在本月之前哦");
                    }else{
                    	selMonth = 12;
                    	k=1;
                    }
                } else {    
                	beginTime = d.getFullYear() + '-' + month + '-01';
                	endTime = d.getFullYear() + '-' + nextMonth + '-01';
                	if(beginTime < '2016-08-01'){
                    	alert("此活动从8月开始哦");
                    }else if(beginTime>=nowMonthFirstDay){//判断时间
                    	alert("选择时间限制在本月之前哦");
                    }else{
                    	k=1;
                    	selMonth = d.getMonth(); //传递到前台
                    }
                }   
                
                if(k == 1){
                	window.location.href="${pageContext.request.contextPath}/account.do?monthIndex&beginTime="
                		+beginTime+"&endTime="+endTime+"&month="+selMonth;
                }
                
            }// 配置formatter，只返回年月    
        });    
        var p = $('#datetime1').datebox('panel'), // 日期选择对象    
        tds = false, // 日期选择对象中月份    
        span = p.find('span.calendar-text'); // 显示月份层的触发控件    
	});
	
	function employeeDetail(){
		$("#div").hide();
		$("#datagrid").html("");
		$("#total").html($("#num5").text());
		getData();
	}
	function getData(employeeName,employeeMobile){
		$.post('account.do?employeeDetail',  
				{'employeeName':employeeName,'employeeMobile':employeeMobile},
			    function(data) {
					var d = $.parseJSON(data);
					$('#datagrid').datagrid({
						url : '',
						title : '',
						iconCls : 'icon-save',
						fitColumns : true,
						nowrap : false,
						border : false,
						pagination : false,
						pageSize : 10,
						pageList : [ 10 ],
						idField : 'id',
						rownumbers : false,  
						singleSelect : true,
						columns : [ [{
							field : 'id',
							title : '序列',
							hidden:true,
						},{
							field : 'shopName',
							title : '门店名称',
							width : '20%',
							align : 'center',
						},{
							field : 'employeeName',
							title : '员工姓名',
							width : '20%',
							align : 'center',
						} ,{
							field : 'employeeMobile',
							title : '手机号码',
							width : '20%',
							align : 'center',
						} ,{
							field : 'payment',
							title : '员工销售金额',
							width : '20%',
							align : 'center',
						} ,{
							field : 'content',
							title : '操作', 
							width : '20%',
							align : 'center',
							formatter: function(value,row,index){
								return '<div class="color1" onclick="getDetailLink('+index+')" >查询销售详情</div>';
							}
						} ] ],
						onRowContextMenu : function(e, rowIndex, rowData) {
							e.preventDefault();
							$(this).datagrid('unselectAll');
							$(this).datagrid('selectRow', rowIndex);
						},
						onLoadError : function(args){
							alert("没有登录系统，或登录超时，请重新登录");
							window.top.location.href = '${pageContext.request.contextPath}/index.jsp';		
						}
					});
					$('#datagrid').datagrid('unselectAll');
					$('#datagrid').datagrid({data: d});
					datagrid = $('#datagrid').datagrid({data: d});
					/* pg = $("#datagrid").datagrid("getPager"); 
					if(pg) {  
						instancePagination(pg,url);
					} */
			});
			$("#empDiv").show();
	}
	function searchFun() {
		var employeeName = $("#employeeName").val();
		var employeeMobile = $("#employeeMobile").val();
// 		alert(employeeName+" ** "+employeeMobile);
		$("#div").hide();
		$("#datagrid").html("");
		$("#total").html($("#num5").text());
		getData(employeeName,employeeMobile);
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		getData();
// 		datagrid.datagrid('load', {});
	}
	function searchPro() {
		var productName = $("#productName").val();
		$("#div").hide();
		$("#datagridPro").html("");
// 		console.log(employeeName+" "+employeeMobile+" "+employeeMobile);
		getProductData(employeeName,employeeMobile,productName);
	}
	
	function clearPro() {
		$('#toolbarPro input').val('');
		getProductData(employeeName,employeeMobile);
// 		datagridPro.datagrid('load', {});
	}
	
	//产品列表
	function getDetailLink(index){
		var row = $('#datagrid').datagrid('getData').rows[index];
		console.log(row.employeeName+" "+row.employeeMobile+" "+row.payment);
		employeeName = row.employeeName;
		employeeMobile = row.employeeMobile;
		$("#div").hide();
		$("#empDiv").hide();
		$("#datagridPro").html("");
		$("#totalPro").html(row.payment);
		$("#selEmp").html(employeeName);
		if(row.payment > 0){
			getProductData(employeeName,employeeMobile);
		}else{
			proComeBg();
		}
	}
	function getProductData(name,mobile,pro){
		$.post('account.do?getProductData',  
				{'employeeName':name,'employeeMobile':mobile,'productName':pro},
			    function(data) {
					var d = $.parseJSON(data);
					$('#datagridPro').datagrid({
						url : '',
						title : '',
						iconCls : 'icon-save',
						fitColumns : true,
						nowrap : false,
						border : false,
						pagination : false,
						pageSize : 10,
						pageList : [ 10 ],
						idField : 'id',
						rownumbers : false,  
						singleSelect : true,
						columns : [ [{
							field : 'id',
							title : '序列',
							hidden:true,
						},{
							field : 'productName',
							title : '产品名称',
							width : '25%',
							align : 'center',
						} ,{
							field : 'num',
							title : '销售数量',
							width : '15%',
							align : 'center',
						} ,{
							field : 'price',
							title : '产品单价',
							width : '20%',
							align : 'center',
						} ,{
							field : 'totalPrice',
							title : '产品总价', 
							width : '20%',
							align : 'center',
						},{
							field : 'receivedPayment',
							title : '销售总金额', 
							width : '20%',
							align : 'center',
						} ] ],
						onRowContextMenu : function(e, rowIndex, rowData) {
							e.preventDefault();
							$(this).datagrid('unselectAll');
							$(this).datagrid('selectRow', rowIndex);
						},
						onLoadError : function(args){
							alert("没有登录系统，或登录超时，请重新登录");
							window.top.location.href = '${pageContext.request.contextPath}/index.jsp';		
						}
					});
					$('#datagridPro').datagrid('unselectAll');
					$('#datagridPro').datagrid({data: d});
					datagridPro = $('#datagridPro').datagrid({data: d});
					/* pg = $("#datagridPro").datagrid("getPager"); 
					if(pg) {  
						instancePagination(pg,url);
					} */
			});
			$("#proDiv").show();
	}
	
	function empComeBg(){
		window.location.href="${pageContext.request.contextPath}/account.do?monthIndex&beginTime="
    		+beginTime+"&endTime="+endTime+"&month="+selMonth;
	}
	function proComeBg(){
		$("#proDiv").hide();
		$("#empDiv").show();
	}
	function sureMonth(){
		$.post('franchiseeAccount.do?comfirmOrder',{'month':'${month}','shopId':'${shopId}'},function(data){
			var d = $.parseJSON(data);
			if(d.success){
				$("#sureMBefore").hide();
				$("#sureMAfter").show();
			}
		});
	}
</script>
<style type="text/css">
</style>
</head>
<body class="easyui-layout" fit="true">
	<div id="div" region="center" border="false" style="overflow: hidden">
	    <div class="div">
	       <div class="fontBlod">
	           <label id="month"></label>月数据分析
	           <div onclick="selTime()" id="selTime" class="timeDiv">
	              <div id="datetime1" style="width:22px;border-style:none;"></div>
	              <span class="color1">其它月份</span>
	           </div>
	       </div>
	       <div class="hr hr-bottom"></div>
	       <div class="mdiv">
	           <!-- <div class="mcon">
	               <div id="num1"></div>
	               <div>扫码人数</div>
               </div>
	           <div class="mcon">
	               <div id="num2"></div>
	               <div>成交人数</div>
	           </div>
	           <div class="mcon">
	               <div id="num3"></div>
	               <div>订单数量</div>
	           </div> -->
	           <div class="mcon">
	               <div>订单销售金额</div>
	               <div id="num4"></div>
	           </div>
	           <div class="mcon">
	               <div>订单确认金额</div>
	               <div id="num5"></div>
	           </div>
	           <div class="mcon">
	               <div>门店结算金额</div>
	               <div id="num6"></div>
	           </div>
	           <div class="mcon">
	               <div>分中心结算金额</div>
	               <div id="num7"></div>
	           </div> 
	           <div class="mcon">
<!-- 	               <div style="border:1px solid red;"><div class="marginBtn">确认收款</div></div> -->
<!-- 	               <div style="border:1px solid red;"><div class="marginBtn">查看员工详情</div></div> -->
<!-- 	              <div class="blurBtn">确认收款</div> -->
<!-- 	              <div class="whiteBtn">查看员工详情</div> -->
	               <div class="marginBtn">
	                    <div id="sureMAfter">
	                          <!-- <span class="c2Angle"></span>
	                          <span>已确认款项</span> -->
	                          <img src='${pageContext.request.contextPath}/resources/css/login/img/c2.png' class='c2'><span>已确认</span>
	                    </div>
	                    <div id="sureMBefore"><input type="submit" class="blurBtn" value="业绩确认" onclick="sureMonth()"/></div>
<!-- 	               <input type="submit" class="blurBtn" value="确认收款" onclick="load()"/> -->
	               </div>
	               <div class="marginBtn bottom"><input type="submit" class="whiteBtn" value="查看员工详情" onclick="employeeDetail()"/></div>
	           </div>
	       </div>
	       <div class="hr hr-bottom"></div>
	    </div>
	</div>
	<div id="empDiv" class="empDiv" region="center" border="false" style="height:100%;">
	    <div class="contract_top font1">
			<span class="comback" onclick="empComeBg()">确认款项</span><span class="rightAngle"></span>
			<span>${month }月数据分析</span><span class="rightAngle"></span>
		</div>
		<div id="toolbar" class="" style="height: auto;">
				<table class="tableForm font1">
					<tr class="search-Height">
						<th>员工姓名</th>
						<td><input id="employeeName"></td>
						<th>手机号码</th>
						<td><input id="employeeMobile"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
<!-- 						<td style="align:right;"><input type="submit" value="返回" class="comeBg" onclick="empComeBg()"/></td> -->
					</tr>
				</table> 
		 </div>
		 <table id="datagrid" style="height:70%;"></table>
		 <div class="footBg font1 marTop">门店总销售额&nbsp;<span id="total" class="font2"></span></div>
	</div>
	<div id="proDiv" class="empDiv" region="center" border="false" style="height:100%;">
	    <div class="contract_top font1">
			<span class="comback" onclick="empComeBg()">确认款项</span><span class="rightAngle"></span>
			<span class="comback" onclick="proComeBg()">${month }月数据分析</span><span class="rightAngle"></span>
			<label id="selEmp"></label><span class="rightAngle"></span>
		</div>
		<div id="toolbarPro" class="" style="height: auto;">
				<table class="tableForm font1">
					<tr>
						<th>产品名称</th>
						<td><input id="productName"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchPro();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearPro();" href="javascript:void(0);">清空</a></td>
<!-- 						<td style="align:right;"><input type="submit" value="返回" class="comeBg" onclick="proComeBg()"/></td> -->
					</tr>
				</table> 
		 </div>
		 <table id="datagridPro" style="height:70%;"></table>
		 <div class="footBg font1 marTop">员工总销售额&nbsp;<span id="totalPro" class="font2"></span></div>
	</div>
</body>
</html>