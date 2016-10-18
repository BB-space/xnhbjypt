<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>丝域电商系统</title>
<style type="text/css">
.top {
	width: 100%;
	height: 7rem;
	background-color: rgb(55, 151, 202);
}
.container{
	background: none !important;
}
.main {
	background: url("resources/img/imgshop/loginbg.png") no-repeat;
	height: 799px;
}
.ul_login {
	margin: 1rem;
	padding: 0;
}
.ul_login li {
	list-style: none;
	line-height: 50px;
}
a {
	color: rgb(90, 181, 255);
	text-decoration: none;
}
a:hover {
	color: rgb(90, 181, 255);
}
a:VISITED {
	color: rgb(90, 181, 255);
	text-decoration: none;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.cookie.js"></script>
<link rel="stylesheet" href="resources/css/login/css/login.css"/>
<link rel="stylesheet" href="resources/css/login/css/reg.css"/>
<script type="text/javascript" src="resources/css/login/js/login.js"></script>
</head>
<body onload="setSysName()">
	<div class="heading" id="heading">
		<div class="box"><div><span><img src="resources/css/login/img/LOGO.png" id="logo"/></span></div></div>
		<div class="box"><div><span><img src="resources/css/login/img/login_r.png"/></span></div></div>
	</div>
	<div class="container" id="container">
		<div class="sysName">
			<div id="sysJoinName">
				<span id="sysJoinNsapn">丝域加盟商注册</span>
			</div>
		</div>
		<div class="theCenterBox" style="">
			<div class="theLoginBox">
				<div style="margin-top:30px;">
				<ul class="regUl">
					<li class="lispec"><span class="lispanspec">1</span>信息填写</li>
					<li><span>2</span>签署协议</li>
					<li><span>3</span>资料上传</li>
					<li><span>4</span>等待审核</li>
					<li><span>5</span>注册成功</li>
				</ul>
				</div>
				<form id="leftForm" action="" method="post">
					<div class="theLoginArea" id="loginBoxReg" style="margin-top:28px">
						<p style="position: relative;">
							<label for="LoginForm_realname"><i>*</i>姓名：</label> <input
								placeholder="请输入分中心负责人姓名或店长姓名" name="LoginForm[realname]"
								id="LoginForm_realname" type="text" maxlength="255" value="${cm.realname }"/> <span>请填写真实姓名</span>
						</p>
						<p style="position: relative;">
							<label for="LoginForm_password"><i>*</i>密码：</label> <input
								placeholder="" name="LoginForm[password]"
								id="LoginForm_password" type="password" maxlength="16" value="${cm.pwd }"/> <span>请输入您的密码</span>
							<i class="LoginForm_password_limit">6-16个字符，区分大小写</i>
						</p>
						<p style="position: relative;">
							<label for="LoginForm_checksum"><i>*</i>确认密码：</label> <input
								placeholder="" name="LoginForm[checksum]"
								id="LoginForm_checksum" type="password" value="${cm.pwd}" /> <span>请确认您的密码</span>
						</p>
						<p style="position: relative;">
							<label for="LoginForm_role"><i>*</i>角色选择：</label>
							<%-- <input	placeholder="" id="LoginForm_role" name="role" <c:if test="${empty cm.userType}">checked="checked"</c:if>   <c:if test="${cm.userType=='10'}">checked="checked"</c:if> type="radio" value="10" onclick="showShop();" style="width:38px;" /><ids style="color:#666;font-size:14px;">店长</ids> --%>
							<input	placeholder="" id="LoginForm_role" name="role" <c:if test="${empty cm.userType}">checked="checked"</c:if> <c:if test="${cm.userType=='13'}">checked="checked"</c:if> type="radio" value="13" onclick="showShop();" style="width:38px;" /><ids style="color:#666;font-size:14px;">丝域商家 </ids> 
						</p>
						<p style="position: relative;">
							<label for="LoginForm_mobile"><i>*</i>手机号码：</label> <input
								placeholder="此手机号是登录丝域电商系统的帐号" name="LoginForm[mobile]" maxlength="11"
								id="LoginForm_mobile" type="text" value="${cm.mobile}" <c:if test="${not empty cm.mobile}">readonly="readonly"</c:if> /> <span class="lm1">请填写手机号码</span>
						</p>
						<p style="position: relative;">
							<label for="LoginForm_area"><i>*</i>区域：</label> 
							<select id="province" onchange="province1()" style="min-width: 120px;">
								<option>请选择省份</option>
							</select>
							<select id="city" style="min-width:120px;">
								<option>请选择城市</option>
							</select>
							<span style="margin-left:112px;">请选择区域</span>
						</p>
						<p style="position: relative;">
							<label for="LoginForm_address"><i>*</i>详细地址：</label> <input
								placeholder="填写对账单的收货地址" name="LoginForm[address]"
								id="LoginForm_address" type="text" value="${cm.address}" /> <span>请输入详细地址</span>
						</p>
						<%-- <p style="position: relative;" id="shopControl">
							<label for="LoginForm_shopName"><i>*</i>门店名称：</label> <input
								placeholder="" name="LoginForm[shopName]"
								id="LoginForm_shopName" type="text" value="${cm.shopName}" /> <span>请输入门店名称</span>
						</p> --%>
						<p style="position: relative;">
							<label for="LoginForm_Next"></label> <input
								placeholder="" class="theSubmitNext theSubmitNextColorGray"
								id="LoginForm_Next" type="button" value="下一步" /> <span></span>
						</p>
						<p style="position: relative;">
							<p style="padding-left:130px;margin-top:20px;font-size:14px;">如有疑问，请在微信公众号“丝域养发馆总部”留言</p>
						</p>
						<input type="hidden" name="id" id="id" value="${cm.regId}">
					</div>
				</form>
			</div>
			<!-- <div style="clearfix:both"></div>
			<p style="text-align: center;margin-top:2px;">如有疑问，请在微信公众号“丝域养发馆总部”留言</p> -->
		</div>
		
	</div>
	<!-- <script type="text/javascript" src="resources/js/menunew.js"></script> -->
	<script type="text/javascript">
		var ok1=false,ok2=false,ok3=false,ok4=false,ok5=false,ok6=false,ok7=false;
		var state='${state}';
		var cmobile = '${cm.mobile}';
		var editStatus = '${editStatus}';
		function showShop(){
			if (document.getElementById('LoginForm_role').checked == true) {
				document.getElementById('shopControl').style.display='block';
			} else {
				document.getElementById('shopControl').style.display='none';
			}
		};
		$(function() {
			if(editStatus=='1'){
				ok1=true,ok2=true,ok3=true,ok4=true,ok5=true,ok6=false,ok7=true;
			}
			//验证姓名
			$('input[name="LoginForm[realname]"]').focus(function(){
				 
			}).blur(function(){
                 if(!$(this).val().match(/^[\u4e00-\u9fa5]{1,10}$/)){
                	$(this).next().css("display","inline-block").text("姓名格式不正确！").removeClass('regColor1').addClass("regColor2");
                	ok1=false;
                	changeBtnColorGray();
                 }else{
                	 $(this).next().css("display","inline-block").text("正确").addClass('regColor1');
                	 ok1=true;
                	 changeBtnColor();
                 }
           });
			//验证密码
			$('input[name="LoginForm[password]"]').focus(function(){
				 
			}).blur(function(){
				var LoginForm_checksum = $("#LoginForm_checksum").val();
				
                 if($(this).val().length < 6 || $(this).val().length >16 || $(this).val()==''){
                     $(this).next().css("display","inline-block").text("密码应该为6-16位之间").removeClass('regColor1').addClass("regColor2");
                     ok2=false;
                     changeBtnColorGray();
                 }else if(LoginForm_checksum!=""&&LoginForm_checksum==$(this).val()){
                	 $(this).next().css("display","inline-block").text("正确").removeClass('regColor2').addClass('regColor1');
                	 $('input[name="LoginForm[checksum]"]').next().css("display","inline-block").text('正确').removeClass('regColor2').addClass("regColor1");
                     ok2=true;
                     changeBtnColorGray();
                 }else if(LoginForm_checksum!=""&&LoginForm_checksum!=$(this).val()){
                	 $(this).next().css("display","inline-block").text("输入秘密不一致").removeClass('regColor1').addClass('regColor2');
                	 $('input[name="LoginForm[checksum]"]').next().css("display","inline-block").text('输入密码不一致').removeClass('regColor1').addClass("regColor2");
                	 ok2=false;
                	 changeBtnColor();
                 }else{
                	 $(this).next().css("display","inline-block").text("").removeClass('regColor1').addClass('regColor2');
                	 ok2=false;
                	 changeBtnColor();
                 }
                 
           });
			//验证确认密码
            $('input[name="LoginForm[checksum]"]').focus(function(){

            }).blur(function(){
            	if($(this).val().length < 6 || $(this).val().length >16 || $(this).val()==''){
                    $(this).next().css("display","inline-block").text("密码应该为6-16位之间").removeClass('regColor1').addClass("regColor2");
                    ok2=false;
                    changeBtnColorGray();
                }else if($(this).val() == $('input[name="LoginForm[password]"]').val()){
	                $(this).next().css("display","inline-block").text('正确').removeClass('regColor2').addClass("regColor1");
	                $('input[name="LoginForm[password]"]').next().css("display","inline-block").text('正确').removeClass('regColor2').addClass("regColor1");
	                ok2=true;
	                changeBtnColor();
	            }else{
	                $(this).next().text('输入的密码不一致').removeClass('regColor1').addClass('regColor2');
	                ok2=false;
	                changeBtnColorGray();
	            }
      		});
			//验证手机
        	$('input[name="LoginForm[mobile]"]').focus(function(){
				
			}).blur(function(){
				if (!$(this).val().match(/^(((1[0-9]{1}[0-9]{1})|159|153)+\d{8})$/)) { 
					$(this).next().css("display","inline-block").text("手机号码格式不正确！").removeClass('regColor1').addClass("regColor2");
					ok3=false;
					changeBtnColorGray();
				}else{
					
					if(state==null||state==""){
// 						$.post('${pageContext.request.contextPath}/user.do?findUser',{mobile:$(this).val()},function(data){
// 							var obj = $.parseJSON(data);
// 							if(obj.success){
// 								//console.log(1111);
// 								$(".lm1").css("display","inline-block").text("手机号码已经存在！").removeClass('regColor1').addClass("regColor2");
// 								ok3=false;
// 								changeBtnColorGray();
// 							}else{
// 								 $(".lm1").css("display","inline-block").text("正确").addClass('regColor1');
// 			                	 ok3=true;
// 			                	 changeBtnColor();
// 							}
// 						})
 							$(".lm1").css("display","inline-block").text("正确").addClass('regColor1');
							ok3=true;
		                	changeBtnColor();
					}else{
						$(".lm1").css("display","inline-block").text("正确").addClass('regColor1');
	                	 ok3=true;
	                	 changeBtnColor();
					}
                	
                 }
           });
			//验证地址
        	$('input[name="LoginForm[address]"]').focus(function(){
				 
			}).blur(function(){
				if ($(this).val().length<1) {
					$(this).next().css("display","inline-block").text("请输入联系地址！").removeClass('regColor1').addClass("regColor2");
					ok4=false;
					changeBtnColorGray();
				}else{
                	 $(this).next().css("display","inline-block").text("正确").addClass('regColor1');
                	 ok4=true;
                	 changeBtnColor();
                 }
           });
			//验证门店名称
        	$('input[name="LoginForm[shopName]"]').focus(function(){
				
			}).blur(function(){
				if ($(this).val().length<1) { 
					$(this).next().css("display","inline-block").text("请输入详细门店名称！").removeClass('regColor1').addClass("regColor2");
					 ok5=false;
					 changeBtnColorGray();
				}else{
                	 $(this).next().css("display","inline-block").text("正确").addClass('regColor1');
                	 ok5=true;
                	 changeBtnColor();
                 }
           });
			$("#city").focus(function(){
				
			}).blur(function(){
				if($(this).val()!='0'&&$(this).val()!='请选择城市'){
					ok6=true;
					changeBtnColor();
				}else{
					$("#city").next().css("display","none").text("请选择区域！").removeClass('regColor1').removeClass("regColor2");
					ok6=false;
					changeBtnColorGray();
				}
			})
			
			function changeBtnColorGray(){
				$("#LoginForm_Next").removeClass("theSubmitNextColorBlue");
				$("#LoginForm_Next").addClass("theSubmitNextColorGray");
				$("#LoginForm_Next").unbind("click");
			}
			function changeBtnColor(){
				var LoginForm_role = $("input[name='role']:checked").val();
				if(LoginForm_role=='10'){
					if(ok1&&ok2&&ok3&&ok4&&ok5&&ok6){
						$("#LoginForm_Next").removeClass("theSubmitNextColorGray");
						$("#LoginForm_Next").addClass("theSubmitNextColorBlue");
						$("#LoginForm_Next").click(function(){
							regUpload();
						});
					}else{
						$("#LoginForm_Next").removeClass("theSubmitNextColorBlue");
						$("#LoginForm_Next").addClass("theSubmitNextColorGray");
					}
				}else if(LoginForm_role=='13'){
					if(ok1&&ok2&&ok3&&ok4&&ok6){
						$("#LoginForm_Next").removeClass("theSubmitNextColorGray");
						$("#LoginForm_Next").addClass("theSubmitNextColorBlue");
						$("#LoginForm_Next").click(function(){
							regUpload();
						});
					}else{
						$("#LoginForm_Next").removeClass("theSubmitNextColorBlue");
						$("#LoginForm_Next").addClass("theSubmitNextColorGray");
					}
				}else{
					$("#LoginForm_Next").removeClass("theSubmitNextColorBlue");
					$("#LoginForm_Next").addClass("theSubmitNextColorGray");
				}
				
			}
		});
                     
		function regUpload(){
			$("input").blur();
			var LoginForm_realname = $("#LoginForm_realname").val();
			var LoginForm_password = $("#LoginForm_password").val();
			var LoginForm_role = $("input[name='role']:checked").val();
			var LoginForm_mobile = $("#LoginForm_mobile").val();
			var province = $("#province").val();
			var city = $("#city").val();
			var LoginForm_address = $("#LoginForm_address").val();
			var LoginForm_shopName = $("#LoginForm_shopName").val();
			var id = $("#id").val();
			console.log(LoginForm_realname+","+LoginForm_password+","+LoginForm_role+","+LoginForm_mobile
					+","+province+","+city+","+LoginForm_address+","+LoginForm_shopName);
			if(city!=0&&city!='请选择城市'&&city!=null){
				ok6=true;
			}else{
				$("#city").next().css("display","inline-block").text("请选择区域！").removeClass('regColor1').addClass("regColor2");
				return false;
			}
			if(state!=null&&state!=""){
				LoginForm_mobile=cmobile;
			}
			if(!(id!=null&&id!="")){
				id = null;
			}
			if(LoginForm_role==10){
				if(ok1&&ok2&&ok3&&ok4&&ok5){
					var jsonStr = {id:id,realname:LoginForm_realname,password:LoginForm_password,userType:LoginForm_role,
							mobile:LoginForm_mobile,provinceId:province,cityId:city,address:LoginForm_address,shopName:LoginForm_shopName}
					$.post('${pageContext.request.contextPath}/joinUser.do?registerFirst',jsonStr,function(data){
						var obj = $.parseJSON(data);
						if(obj.success){
							if(state!=null&&state!=""){
								window.location.href="joinUser.do?registerUpload&state=0";
							}else{
								//window.location.href="joinUser.do?registerUpload";
								window.location.href="joinUser.do?instruct";
							}
						}else{
							alert("资料上传有误");
						}
					});
				}else{
					alert("请填写完整信息")
				}
			}else if(LoginForm_role==13){
				if(ok1&&ok2&&ok3&&ok4){
					var jsonStr = {id:id,realname:LoginForm_realname,password:LoginForm_password,userType:LoginForm_role,
							mobile:LoginForm_mobile,provinceId:province,cityId:city,address:LoginForm_address,shopName:LoginForm_shopName}
					$.post('${pageContext.request.contextPath}/joinUser.do?registerFirst',jsonStr,function(data){
						var obj = $.parseJSON(data);
						if(obj.success){
							if(state!=null&&state!=""){
								window.location.href="joinUser.do?registerUpload&state=0";
							}else{
								//window.location.href="joinUser.do?registerUpload";
								window.location.href="joinUser.do?instruct";
							}
						}else{
							alert("资料上传有误");
						}
					});
				}else{
					alert("请填写完整信息")
				}
			}
			//window.location.href="joinUser.do?registerUpload";
		}
		
		/************province*************/
		 function province1(){
			  var province = $("#province");
			  if(province.val() != "0"){
				var provinceId = province.val();
			   $.post("city.do?cityList",{"provinceId":provinceId},callback2);
			  }else{
			   //当用户没有选择省份的时候，就将市区下拉列表框中原有的“请选择”字样删除。
			   $("#city").empty();
			  }
			  //当用户进行一次省市县的操作后，再次选择省份的时候，后面的县区里面如果有值就要清空
			  var shop = $("#shop");
			  shop.empty();
		 }
		
		 //市区
		 function callback2(data) {
		  var data = eval("(" + data + ")");
		  var city = $("#city");
		  city.empty();
		  city.append("<option value=0>请选择城市</option>");
		  for ( var i = 0; i < data.length; i++) {
			  city.append("<option value=" + data[i].id + ">"+ data[i].cityName + "</option>");
		  }
		 }
		 
		 //当选中市区名称后，查询对应的门店名称
		 function city1(){
		  var city = $("#city");
		  if(city.val() != "0"){ 
			  var cityId = city.val();
			  $.post("shop.do?shopList",{"cityId":cityId},callback3);
		  }else{
		   //当用户没有选择市区的时候，就将门店下拉列表框中原有的“请选择”字样删除。
		   $("#shop").empty();
		  }
		 }
		 
		 //门店
		 function callback3(data) {
		  var data = eval("(" + data + ")");
		  var shop = $("#shop");
		  shop.empty();
		  shop.append("<option value=0>请选择门店</option>");
		  for ( var i = 0; i < data.length; i++) {
			  shop.append("<option value=" + data[i].id + ">"+ data[i].shopName + "</option>");
		  }
		 }
		 
		function findProvince(){
			$.post("${pageContext.request.contextPath}/province.do?provinceList", null,function(data) {
				console.log(typeof data);
				  var data = eval("(" + data + ")");
				 var province = $("#province");
				  province.empty();
				  province.append("<option value=0>请选择省份</option>");
				  for ( var i = 0; i < data.length; i++) {
					  province.append("<option value=" + data[i].id + ">"+ data[i].provinceName + "</option>");
				  }
			});
		}
		
		 
		function selectValue(sId,value){  
		    var s = document.getElementById(sId);  
		    var ops = s.options;  
		    for(var i=0;i<ops.length; i++){  
		        var tempValue = ops[i].value;  
		        if(tempValue == value)  
		        {  
		            ops[i].selected = true;  
		        }  
		    }  
		} 
		
		$(document).ready(function(){
			setTimeout(findProvince(),5000);
			 //findProvince();
			 //subcenter1();
		});
	</script>
</body>
</html>