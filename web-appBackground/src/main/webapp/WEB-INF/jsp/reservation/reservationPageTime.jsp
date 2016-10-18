<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<%-- <jsp:include page="../common/inc/easyui.jsp"></jsp:include> --%>
<jsp:include page="../common/inc/xheditor.jsp"></jsp:include>
<style type="text/css">
	.focus {
		background-color: rgb(59,153,204);
		color:white;
	}
	.pattern{
		width:13%;
		border:0.1rem rgb(242,242,242) solid;
		text-align:center;float:left;
	}
	#reservationTime{
	 position:absolute;
	 z-index:0;
	}
	
</style>

</head>
<body class="easyui-layout" >
	 <div id="reservationTime"  style="width:50%;top:-31em">
	 	<div style="background-color: #C0C0C0;color:#fff;height:2.5em;padding:0.2em 0.5em 0.2em 0.5em;">
			<table style="width: 100%;height:90%;">
				<tr>
					<td width="20%">预约时间</td>
					<!-- <td>
						<div align='center' style="margin-bottom: 0.5rem;">
						<input type='submit' value='确定' class='submit' onclick='submit()'/>
						<input type='button' value='取消'  class='submit' onclick='cancel()' >
						</div>
					</td> -->
					<td align="right"  width="20%" style="font-size: 2em;" id="close">×</td>
				</tr>
			</table>
	   </div>
		<div class="widget_main" style="background-color: rgb(238,238,238);">
		
 <script type="text/javascript">
 	var id="";
 	var hrs="";
 	var shijian="";
 	var riqi="";
 $(function(){
 	$("#reservationTime").hide();
 	$("#close").click(function(){//关闭日历
 		$("#reservationTime").hide();
 	});
 });
 
 function cancel(){
	 $("#reservationTime").hide();
 }
 
 function mod(x, x_div) 
{ 
	for (var i=x; i>=x_div; i -= x_div); 
	return i; 
} 

	var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth()+1;
    var day = date.getDate();
	var sig_val; 
	var begindate = new Array(0,3,3,6,1,4,6,2,5,0,3,5);  
	var Pmonth = new Array(29,31,28,31,30,31,30,31,31,30,31,30,31);
	var montharray = new Array("周日","周一","周二","周三","周四","周五","周六"); 
	sig_val =begindate[month - 1]; 
	//获得星期几
	 //for(var i=day;i<day+7;i++){
		//var val1 = mod((year + parseInt(year/4) + i + sig_val)-2,7);
		//alert(montharray[val1]);
	//}  
	//显示星期
	var dar2=mod((year + parseInt(year/4) + day+2 + sig_val)-2,7);
	var dar3=mod((year + parseInt(year/4) + day+3 + sig_val)-2,7);
	var dar4=mod((year + parseInt(year/4) + day+4 + sig_val)-2,7);
	var dar5=mod((year + parseInt(year/4) + day+5 + sig_val)-2,7);
	var dar6=mod((year + parseInt(year/4) + day+6 + sig_val)-2,7);
 
	//得到日期
    var mm=year+"-"+month+"-"+day; 
	var arr = mm.split("-");  
	var newdt1 = new Date(Number(arr[0]),Number(arr[1])-1,Number(arr[2])+1); 
	repnewdt1 =(newdt1.getMonth()+1) + "/" + newdt1.getDate(); 
	var newdt2 = new Date(Number(arr[0]),Number(arr[1])-1,Number(arr[2])+2); 
	repnewdt2 =(newdt2.getMonth()+1) + "/" + newdt2.getDate();  
	var newdt3 = new Date(Number(arr[0]),Number(arr[1])-1,Number(arr[2])+3); 
	repnewdt3 =(newdt3.getMonth()+1) + "/" + newdt3.getDate();  
	var newdt4 = new Date(Number(arr[0]),Number(arr[1])-1,Number(arr[2])+4); 
	repnewdt4 =(newdt4.getMonth()+1) + "/" + newdt4.getDate();  
	var newdt5 = new Date(Number(arr[0]),Number(arr[1])-1,Number(arr[2])+5); 
	repnewdt5 =(newdt5.getMonth()+1) + "/" + newdt5.getDate();  
	var newdt6 = new Date(Number(arr[0]),Number(arr[1])-1,Number(arr[2])+6); 
	repnewdt6 =(newdt6.getMonth()+1) + "/" + newdt6.getDate();  
	var month1=newdt1.getMonth()+1;
	var day1=newdt1.getDate();
	var month2=newdt2.getMonth()+1;
	var day2=newdt2.getDate();
	var month3=newdt3.getMonth()+1;
	var day3=newdt3.getDate();
	var month4=newdt4.getMonth()+1;
	var day4=newdt4.getDate();
	var month5=newdt5.getMonth()+1;
	var day5=newdt5.getDate();
	var month6=newdt6.getMonth()+1;
	var day6=newdt6.getDate();
	month<10?month='0'+month:month;
	day<10?day='0'+day:day;
	month1<10?month1='0'+month1:month1;
	day1<10?day1='0'+day1:day1;
	month2<10?month2='0'+month2:month2;
	day2<10?day2='0'+day2:day2;
	month3<10?month3='0'+month3:month3;
	day3<10?day3='0'+day3:day3;
	month4<10?month4='0'+month4:month4;
	day4<10?day4='0'+day4:day4;
	month5<10?month5='0'+month5:month5;
	day5<10?day5='0'+day5:day5;
	month6<10?month6='0'+month6:month6;
	day6<10?day6='0'+day6:day6;
	
	//得到时间
	function getDateArray(endDate, splitTime, count) {
		  if(!endDate) {
		    endDate = new Date();
		    endDate.setHours("21", "30", "00", "00");
		  }
		  if(!splitTime) {
		    splitTime = 30 * 60 * 1000;
		  }
		  if(!count) {
		    count= 24;
		  }
		  var endTime = endDate.getTime();
		  var mod = endTime % splitTime;
		  if(mod > 0) {
		    endTime -= mod; 
		  }
		
		  var dateArray = [];
		  while(count-- > 0) {
		    var d = new Date();
		    d.setTime(endTime - count * splitTime);
		    dateArray.push(d);
		  }
		  return dateArray;
		}
	var str="";
	document.write("<div style='margin:0 auto;width:100%;text-align:center;'>");
	document.write(
		str+="<div style='width:100%;line-height:1.5rem;font-size:0.8rem;padding-left:0.5rem'>"
		   	+"<div id='md'  onclick='show(this)' class='state pattern selected'>"
			+"<div>今天</div>"
			+"<div class='one'>"+month+"/"+day+"</div>"
			+"</div>"
			+"<div id='md' onclick='show(this)' class='state pattern'>"
			+"<div>明天</div>"
			+"<div class='one'>"+month1+"/"+day1+"</div>"
			+"</div>"
			+"<div id='md' onclick='show(this)' class='state pattern'>"
			+"<div>"+montharray[dar2]+"</div>"
			+"<div class='one'>"+month2+"/"+day2+"</div>"
			+"</div>"
			+"<div id='md' onclick='show(this)' class='state pattern'>"
			+"<div>"+montharray[dar3]+"</div>"
			+"<div class='one'>"+month3+"/"+day3+"</div>"
			+"</div>"
			+"<div id='md' onclick='show(this)' class='state pattern'>"
			+"<div>"+montharray[dar4]+"</div>"
			+"<div class='one'>"+month4+"/"+day4+"</div>"
			+"</div>"
			+"<div id='md' onclick='show(this)' class='state pattern'>"
			+"<div>"+montharray[dar5]+"</div>"
			+"<div class='one'>"+month5+"/"+day5+"</div>"
			+"</div>"
			+"<div id='md' onclick='show(this)' class='state pattern'>"
			+"<div>"+montharray[dar6]+"</div>"
			+"<div class='one'>"+month6+"/"+day6+"</div>"
			+"</div>"
		    +"</div>"
	); 
	
	//显示时间（每隔半个小时）
	var a = getDateArray();
	document.write("<div style='width:100%;margin:auto;padding-left:0.5rem'>");
	for(var i in a) {
		var myDate = a[i];
		var hour=myDate.getHours();
		var min=myDate.getMinutes();
		hour<10?hour='0'+hour:hour;
		min<10?min='0'+min:min;
		var str1="";
		document.write(
				str1+="<div id='states' onclick='showTime(this);' class='states' style='float:left;width:13%;border:0.1rem rgb(242,242,242) solid; line-height:3rem;text-align:center;'>"
				   	+hour+":"+min
				    +"</div>"
		);
		
	}
	
	
	document.write("</div><div style='clear:both;'></div></div>");
	document.write("<div style='width:100%;height:1em;'>&nbsp;</div>");
	document.write(" <div align='center'><input type='submit' value='确定' class='submit' onclick='submit()'/>");
	document.write(" <input type='button' value='取消'  class='submit' onclick='cancel()' ></div>"); 
	document.write("<div style='width:100%;height:1em;'>&nbsp;</div>");


	$(function (){//使背景变色
		$("#reservationTime").hide();
		$('.state').click(function(){
	        if ($(this).hasClass('focus')) {
	            return true;
	        } else {
	            $('.state').removeClass('focus');
	            $(this).addClass('focus');
	        }
	    });
		$('.states').click(function(){
	        if ($(this).hasClass('focus')) {
	            return true;
	        } else {
	            $('.states').removeClass('focus');
	            $(this).addClass('focus');
	        }
	    });
		
	});
	
	var rq = "";
	var sj = "";
	//显示日期
	function show(val){

		//alert(val.textContent);   //选中的值
		var result = val.textContent.replace(/[\u4E00-\u9FA5]/g,"");  //去除字符串中的中文
		var arr = result.split("/");
		rq = arr[0] + "-"+arr[1];
		//alert(rq);
	}
	//显示时间
	function showTime(val){
		//alert(val.textContent);
		sj = val.textContent;
	}

	
	function submit(){
		//比较日期大小
    	var now = new Date();
    	var year = now.getFullYear();
    	var month = now.getMonth()+1;
    	var day = now.getDate();
    	var hour=now.getHours();
    	var minute=now.getMinutes();
    	//当前日期
    	var date1 =year+"-"+month+"-"+day+" "+hour+":"+minute;  
    	//alert(hour+"**"+minute);
    	var time = year+"-"+rq+" "+sj;
    	//选择的日期
    	//var date2 = new Date(dateArr[0],dateArr[1],dateArr[2]); 
    	//alert(date1-date2);
    	var a=new Date(date1);
    	var b=new Date(time);
    	//alert(date1+"**"+time);
    	var da=b-a;
		if(rq =="" ||sj == ""){
			alert("请选择日期和时间");
			return;
		}else if(da<0){
			alert("日期必须大于当前日期");
		}else{ 
			var time = year+"-"+rq+" "+sj;
			localStorage.sel_time = time;
			$.ajax({
				url : '${pageContext.request.contextPath}/reservation.do?reservationTime',
				data : {
					time:time,
					id:id
				},
				cache : false,
				dataType : "json",
				success : function(response) {
					datagrid.datagrid('unselectAll');
					datagrid.datagrid('reload');
					 $("#reservationTime").hide();
					$.messager.show({
						title : '提示',
						msg : '确认预约成功！'
					});
				}
			});   
			//window.location.href ="${pageContext.request.contextPath}/reservation.do?reservationTime&time="+time+"&id="+id;
		}
	}
	
	var yr="";
	var nyr="";
	var arr="";
	function setTime(val){
		/* var tempArr = val.split(",");
		reserTimes=tempArr[1];*/
		//alert(val);
		arr=val.split(" ");
		nyr=arr[0];
		hrs=arr[1]; 
		//alert(nyr);
		//alert(hrs);
		var mins=hrs.split(":");
		shijian=mins[0]+":"+mins[1];
		//alert(shijian);
		$.each($(".states"), function(i) { 
			var s=$(".states")[i];
			//alert(s.textContent); 
		    if(s.textContent==shijian){
		    	if ($(s).hasClass('focus')) {
		            return true;
		        } else {
		            $('.states').removeClass('focus');
		            $(s).addClass('focus');
		            //console.info(s);
		        }
		    }        
		}); 
		var nyrs=nyr.split("-");
		var riqis=nyrs[1]+"/"+nyrs[2];
		//alert(riqis);
		$.each($(".one"), function(i) { 
			var s=$(".one")[i];
			if(s.textContent==riqis){
				if ($(s).parent(".state").hasClass('focus')) {
		            return true;
		        } else {
		        	$(".state").removeClass('focus');
		        	$(s).parent(".state").addClass('focus');
		        }
		    }    
		});
	       
	     rq=nyrs[1]+"-"+nyrs[2];
		sj=shijian;
	}
	
</script> 

	</div>
</div>
	
</body>
</html>