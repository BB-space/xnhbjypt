<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

.upload{font-size:14px;display:inline-block;padding:4px;vertical-align:middle; background:#E6E6E6; position:relative; overflow:hidden;color: #4d4d4d} 
.upload:hover{color:#4d4d4d} 
.upload:visited{color:#4d4d4d} 
.upload input{position:absolute; right:0; top:0; font-size:100px; opacity:0; filter:alpha(opacity=0);}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.cookie.js"></script>
<link rel="stylesheet" href="resources/css/login/css/login.css"/>
<link rel="stylesheet" href="resources/css/login/css/reg.css"/>
<script type="text/javascript" src="resources/css/login/js/login.js"></script>
<!-- <script type="text/javascript" src="resources/css/login/js/uploadPreview.js"></script> -->
<script type="text/javascript" src="resources/js/ajaxfileupload.js"></script>
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
					<li><span>1</span>信息填写</li>
					<li><span>2</span>签署协议</li>
					<li class="lispec"><span class="lispanspec">3</span>资料上传</li>
					<li><span>4</span>等待审核</li>
					<li><span>5</span>注册成功</li>
				</ul>
				</div>
				<form id="leftForm" method="post" enctype="multipart/form-data">
					<div class="theLoginArea" id="loginBoxReg" style="margin-top:28px;">
						<p style="position: relative;">
							<label for="LoginForm_idCard"><i>*</i>法人身份证：</label> <input
								placeholder="请上传法人身份证" name="LoginForm[idCard]"
								<c:if test="${not empty cm.idCardPhoto}">value="身份证图片已选择"</c:if> 
								id="LoginForm_idCard" type="text" maxlength="255" readonly="readonly"/> 
							<a href="javascript:void(0)" class="upload">
							    <input type="file" id="idCardFile" value="浏览" name="myfiles" onchange="changePicUrl1();"/>选择图片
							</a>
							<span></span>
							<i class="LoginForm_password_limit">法人身份证需要正反面盖公章</i>
						</p>
						<p id="deleFront" style="position: relative;height:48px;">
							<label for="LoginForm_isLegalPerson"><i>*</i>收款人：</label>
							<input	placeholder="" id="LoginForm_isLegalPerson" name="LoginForm[isLegalPerson]"
							<c:if test="${empty cm.isLegalPerson}">checked="checked"</c:if>
							<c:if test="${cm.isLegalPerson=='1'}">checked="checked"</c:if>  type="radio" value="1" onclick="showDelegation();" style="width:38px;" /><ids style="color:#666;font-size:14px;">法人</ids> 
							<input	placeholder="" id="LoginForm_isLegalPerson" name="LoginForm[isLegalPerson]"
							<c:if test="${cm.isLegalPerson=='0'}">checked="checked"</c:if>  type="radio" value="0" onclick="showDelegation();" style="width:38px;" /><ids style="color:#666;font-size:14px;">非法人</ids>
							<i class="itip">非法人收付款帐号需要上传委托收款涵</i>
						</p>
						<p id="delediv" style="position: relative;display: none">
							<label for="LoginForm_delegation"></label>
							<input placeholder="请上传委托收款涵" name="LoginForm[delegation]"
							<c:if test="${not empty cm.delegationPhoto}">value="委托收款涵图片已选择"</c:if> 
								id="LoginForm_delegation" type="text" maxlength="255" readonly="readonly"/>
							<a href="javascript:void(0)" class="upload">
							    <input type="file" id="delegationFile" name="myfiles" value="浏览" onchange="changePicUrl2();" />选择图片
							</a>
						</p>
						<p style="position: relative;height:48px;">
							<label for="LoginForm_receiveType"><i>*</i>收款帐号：</label>
							<input	placeholder="" id="LoginForm_receiveType" name="LoginForm[receiveType]"
							<c:if test="${empty cm.receiveType}">checked="checked"</c:if>
							<c:if test="${cm.receiveType=='0'}">checked="checked"</c:if>  type="radio" value="0" onclick="showReceive();" style="width:38px;" /><ids style="color:#666;font-size:14px;">银行卡</ids> 
							<%-- <input	placeholder="" id="LoginForm_receiveType" name="LoginForm[receiveType]"
							<c:if test="${cm.receiveType=='1'}">checked="checked"</c:if>  type="radio" value="1" onclick="showReceive();" style="width:38px;" /><ids style="color:#666;font-size:14px;">支付宝</ids> --%>
							<i class="itip"></i>
						</p>
						<p id="receiveDiv1" style="position: relative;height:48px;">					
							<label for=""></label>
							<i class="iaccount">开户姓名</i><input placeholder="请输入分中心负责人或店长姓名" name="LoginForm[openName]" value="${cm.openName}"
								id="LoginForm_openName" class="openInput1" type="text" maxlength="20" style="width:310px;margin-left:4px;padding:4px 0px 4px 0px"/>
							<%-- <i class="iaccount">开户银行</i><input placeholder="请输入开户银行" name="LoginForm[openBank]" value="${cm.openBank}"
								id="LoginForm_openBank" class="openInput2" type="text" maxlength="100" style="width:120px;margin-left:4px;padding:4px 0px 4px 0px"/> --%>
						</p>
						<p id="receiveDiv3" style="position:ralative;height:48px;">
							<label for="LoginForm_openBank"></label>
							<i class="iaccount">开户银行</i><input placeholder="请输入开户银行" name="LoginForm[openBank]" value="${cm.openBank}"
								id="LoginForm_openBank" class="openInput2" type="text" maxlength="100" style="width:310px;margin-left:4px;padding:4px 0px 4px 0px"/>
						</p>
						<p id="receiveDiv2" style="position:ralative;height:48px;">
							<label for="LoginForm_openAccount"></label>
							<i class="iaccount">开户帐号</i><input placeholder="请输入银行卡帐号" name="LoginForm[openAccount]" value="${cm.openAccount}"
								id="LoginForm_openAccount" class="openInput3" type="text" maxlength="25" style="width:310px;margin-left:4px;padding:4px 0px 4px 0px"/>
							<span>请输入开户帐号</span>
						</p>
						<%-- <p id="receiveDiv3" style="position:ralative;height:48px;display: none">
							<label for="LoginForm_alipayAccount"></label>
							<i class="iaccount">支付宝帐号</i><input placeholder="请输入支付宝帐号" name="LoginForm[alipayAccount]" value="${cm.alipayAccount}"
								id="LoginForm_alipayAccount" type="text" maxlength="150" style="width:294px;margin-left:4px;padding:4px 0px 4px 0px"/>
							<span>请输入支付宝帐号</span>
						</p> --%>
						<p style="position: relative;">
							<label for="LoginForm_alipayAccount"><i>*</i>支付宝账号：</label> <input
								placeholder="请输入分中心负责人或店长支付宝帐号" name="LoginForm[alipayAccount]"
								id="LoginForm_alipayAccount" type="text" maxlength="255" value="${cm.alipayAccount}"/> <span>请填写支付宝账号</span>
						</p>
						<p style="position: relative;">
							<label for="LoginForm_businessLicense"><i></i>营业执照：</label> <input
								placeholder="" name="LoginForm[businessLicense]"
								<c:if test="${not empty cm.licensePhoto}">value="营业执照图片已选择"</c:if> 
								id="LoginForm_businessLicense" type="text" maxlength="255" readonly="readonly"/>
							<a href="javascript:void(0)" class="upload">
							    <input type="file" id="licenseFile" name="myfiles" value="浏览" onchange="changePicUrl3();" />选择图片
							</a>
							<i class="LoginForm_password_limit">营业执照需要盖公章</i>
						</p>
						<p style="position: relative;">
							<label for="LoginForm_subcenterPhoto"><i></i>负责人授权涵：</label> <input
								placeholder="请上传分中心负责人授权涵" name="LoginForm[businessLicense]"
								<c:if test="${not empty cm.subcenterPhoto}">value="分中心负责人授权涵已选择"</c:if>
								id="LoginForm_subcenterPhoto" type="text" maxlength="255" readonly="readonly"/>
							<a href="javascript:void(0)" class="upload">
							    <input type="file" id="subcenterFile" name="myfiles" value="浏览" onchange="changePicUrl4();" />选择图片
							</a>
							<i class="LoginForm_password_limit">营业执照需要盖公章</i>
						</p>
						<p style="position: relative;" id="shopControl" >
							<label for="LoginForm_shopInfo"><i></i>门店信息：<br><br><br></label> 
							<textarea id="LoginForm_shopInfo" name="LoginForm[shopInfo]" rows="3" cols="" placeholder="请补充店名、地址、区域、店长姓名、电话等详细信息"
							 style="width:350px;margin-top:10px;resize:none;padding:4px;">${cm.shopInfo}</textarea>     
							<span>请补充门店信息等</span>
						</p>
						<p style="position: relative;margin-top:5%;">
							<label for="LoginForm_submit"></label> <input
								placeholder="" class="theSubmitNext theSubmitNextColorGray" 
								id="LoginForm_submit" type="button" value="下一步"/>
						</p>
						<p style="position: relative;">
							<p style="padding-left:130px;padding-bottom:20px;margin-top:20px;font-size:14px;">如有疑问，请在微信公众号“丝域养发馆总部”留言</p>
						</p>
					</div>
				</form>
			</div>
		</div>
	</div>
	<input type="hidden" id="p1" value="${cm.idCardPhoto}">
	<input type="hidden" id="p2" value="${cm.delegationPhoto}">
	<input type="hidden" id="p3" value="${cm.licensePhoto}">
	<input type="hidden" id="p3" value="${cm.subcenterPhoto}">
	<!-- <div id="imgdiv"><img id="imgShow" width="100" height="100" style="border: 0;"/></div> -->
	<script type="text/javascript">
		var state = '${state}';
		var editStatus = '${editStatus}';
		var isLegalPerson = '${cm.isLegalPerson}';
		var simg1=false,simg2=false,simg3=true,simg4=true,s1=false,s2=false,s3=false,s4=false;
		 function ajaxFileUpload(fileId){
			//开始上传文件时显示一个图片,文件上传完成将图片隐藏
			//$("#loading").ajaxStart(function(){$(this).show();}).ajaxComplete(function(){$(this).hide();});
			//执行上传文件操作的函数
			$.ajaxFileUpload({
				//处理文件上传操作的服务器端地址(可以传参数,已亲测可用)
				url:'${pageContext.request.contextPath}/joinUser.do?fileUpload',
				secureuri:false,                       //是否启用安全提交,默认为false 
				fileElementId:fileId,           //文件选择框的id属性
				dataType:'text',                       //服务器返回的格式,可以是json或xml等
				success:function(data, status){        //服务器响应成功时的处理函数
					console.log(data);
					console.log(data.indexOf("0`"));
					console.log(data.indexOf("2`"));
					console.log(data.indexOf("3`"));
					if(data.indexOf("0`")=='60'||data.indexOf("0`")=='6'){     //0表示上传成功(后跟上传后的文件路径),1表示失败(后跟失败描述)
						//$("img[id='uploadImage']").attr("src", data.substring(2));
						//$('#result').html("图片上传成功<br/>");
						if(fileId=="idCardFile"){
							var photo = data.substring(data.indexOf("0`")+2,data.indexOf("</pre>"));
							$("#p1").val(photo);
							simg1=true;
							changeUpColor();
						}else if(fileId=="delegationFile"){
							var photo = data.substring(data.indexOf("0`")+2,data.indexOf("</pre>"));
							$("#p2").val(photo);
							simg2=true;
							changeUpColor();
						}else if(fileId=="licenseFile"){
							var photo = data.substring(data.indexOf("0`")+2,data.indexOf("</pre>"));
							$("#p3").val(photo);
							simg3=true;
							changeUpColor();
						}else if(fileId=="subcenterFile"){
							var photo = data.substring(data.indexOf("0`")+2,data.indexOf("</pre>"));
							$("#p4").val(photo);
							simg4=true;
							changeUpColor();
						}
						//alert("上传成功");
					}else if(data.indexOf("2`")=='62'|| data.indexOf("2`")=='8'){
						alert("请上传.jpg、.png、.jpeg格式的 图片");
					}else if(data.indexOf("3`")=='63'||data.indexOf("3`")=='9'){
						alert("请上传不超过5M大小的图片");
					}else{
						//$('#result').html('图片上传失败，请重试！！');
						alert("上传失败");
					}
				},
				error:function(data, status, e){ //服务器响应失败时的处理函数
					//$('#result').html('图片上传失败，请重试！！');
					alert("图片上传失败，请重试！");
				}
			});
		}
		 
		function showDelegation(){
			if (document.getElementById('LoginForm_isLegalPerson').checked==true) {
				document.getElementById('delediv').style.display='none';
				document.getElementById('deleFront').style.heigth='60'+'px';			
			} else {
				document.getElementById('delediv').style.display='block';
			}
		};
		function showReceive(){
			/* if (document.getElementById('LoginForm_receiveType').checked==true) {
				document.getElementById('receiveDiv1').style.display='block';
				document.getElementById('receiveDiv2').style.display='block';
				document.getElementById('receiveDiv3').style.display='none';
			} else {
				document.getElementById('receiveDiv3').style.display='block';
				document.getElementById('receiveDiv1').style.display='none';
				document.getElementById('receiveDiv2').style.display='none';
			} */
		};
		function changePicUrl1( ) {
			var dFile = document.getElementById('idCardFile');
			document.getElementById("LoginForm_idCard").value="法人身份证图片已选择";
			document.getElementById("LoginForm_idCard").style.color="#4d4d4d";
			ajaxFileUpload("idCardFile");
			
// 			var dImg = document.getElementById('pic1');
// 			if (dFile.files) {
// 				console.log(dFile.files);
// 				document.getElementById("pic1").style.display = 'block';
// 				dImg.src = window.URL.createObjectURL(dFile.files[0]);
// 			} else if (dFile.value.indexOf('\\') > -1
// 				|| dFile.value.indexOf('\/') > -1) {
// 					dImg.src = dFile.value;
// 					alert();
// 			}
		
		}
		function changePicUrl2(){
			var dFile = document.getElementById('delegationFile');
			document.getElementById("LoginForm_delegation").value="委托收款涵图片已选择";
			document.getElementById("LoginForm_delegation").style.color="#4d4d4d";
			ajaxFileUpload("delegationFile");
			
		}
		
		function changePicUrl3(){
			var dFile = document.getElementById('licenseFile');
			document.getElementById("LoginForm_businessLicense").value="营业执照图片已选择";
			document.getElementById("LoginForm_businessLicense").style.color="#4d4d4d";
			ajaxFileUpload("licenseFile");
			
		}
		
		function changePicUrl4(){
			var dFile = document.getElementById('subcenterFile');
			document.getElementById("LoginForm_subcenterPhoto").value="营业执照图片已选择";
			document.getElementById("LoginForm_subcenterPhoto").style.color="#4d4d4d";
			ajaxFileUpload("subcenterFile");
			
		}
		
		$(function() {
			if(editStatus=='1'){
				simg1=true,simg2=true,simg3=true,simg4=true,s1=true,s2=true,s3=true,s4=true;
				$("#LoginForm_submit").removeClass("theSubmitNextColorGray");
				$("#LoginForm_submit").addClass("theSubmitNextColorBlue");
				$("#LoginForm_submit").click(function(){
					regAudit();
				})
				if(isLegalPerson==0){
					$("#delediv").css("display","block");
				}
			}
			
			$('input[name="LoginForm[alipayAccount]"]').focus(function(){
				 
			}).blur(function(){
                 if($(this).val()==''){
                	$(this).next().css("display","inline-block").text("请输入支付宝帐号！").removeClass('regColor1').addClass("regColor2");
                	ok1=false;
                	s4=false;
                	changeBtnColorGray();
                 }else{
                	 $(this).next().css("display","inline-block").text("正确").addClass('regColor1');
                	 ok1=true;
                	 s4=true;
                	 changeUpColor();
                 }
           });
			$('.openInput1').focus(function(){
				
			}).blur(function(){
                 if($(this).val()==''){
                	s1=false;
                	changeBtnColorGray();
                 }else{
                	 s1=true;
                	 changeUpColor();
                 }
           });
			$('.openInput2').focus(function(){
				
			}).blur(function(){
                 if($(this).val()==''){
                	s2=false;
                	changeBtnColorGray();
                 }else{
                	 s2=true;
                	 changeUpColor();
                 }
           });
			$('.openInput3').focus(function(){
				
			}).blur(function(){
                 if($(this).val()==''){
                	s3=false;
                	changeBtnColorGray();
                 }else{
                	 s3=true;
                	 changeUpColor();
                 }
           });
		})
		
		function changeBtnColorGray(){
			$("#LoginForm_submit").removeClass("theSubmitNextColorBlue");
			$("#LoginForm_submit").addClass("theSubmitNextColorGray");
		}
		
		function changeUpColor(){
			var LoginForm_isLegalPerson = $("input[name='LoginForm[isLegalPerson]']:checked").val();
			var LoginForm_receiveType = $("input[name='LoginForm[receiveType]']:checked").val();
			//alert(LoginForm_isLegalPerson+","+LoginForm_receiveType);
			console.log(simg1+","+simg2+","+simg3+","+s1+","+s2+","+s3+","+s4);
			if(LoginForm_isLegalPerson=='1'){
				if(LoginForm_receiveType=='0'){
					if(simg1&&s1&&s2&&s3&&s4){
						$("#LoginForm_submit").removeClass("theSubmitNextColorGray");
						$("#LoginForm_submit").addClass("theSubmitNextColorBlue");
						$("#LoginForm_submit").click(function(){
							regAudit();
						})
					}
				}
				if(LoginForm_receiveType=='1'){
					if(simg1&&s4){
						$("#LoginForm_submit").removeClass("theSubmitNextColorGray");
						$("#LoginForm_submit").addClass("theSubmitNextColorBlue");
						$("#LoginForm_submit").click(function(){
							regAudit();
						})
					}
				}
				
			}
			if(LoginForm_isLegalPerson=='0'){
				if(LoginForm_receiveType=='0'){
					if(simg1&&simg2&s1&&s2&&s3&s4){
						$("#LoginForm_submit").removeClass("theSubmitNextColorGray");
						$("#LoginForm_submit").addClass("theSubmitNextColorBlue");
						$("#LoginForm_submit").click(function(){
							regAudit();
						})
					}
				}
				if(LoginForm_receiveType=='1'){
					if(simg1&&s4){
						$("#LoginForm_submit").removeClass("theSubmitNextColorGray");
						$("#LoginForm_submit").addClass("theSubmitNextColorBlue");
						$("#LoginForm_submit").click(function(){
							regAudit();
						})
					}
				}
				
			}
		}
		
		function regAudit(){
			$("#LoginForm_submit").attr('disabled', 'disabled');
			var LoginForm_isLegalPerson = $("input[name='LoginForm[isLegalPerson]']:checked").val();
			var LoginForm_receiveType = $("input[name='LoginForm[receiveType]']:checked").val();
			var LoginForm_openName = $("#LoginForm_openName").val();
			var LoginForm_openBank = $("#LoginForm_openBank").val();
			var LoginForm_openAccount = $("#LoginForm_openAccount").val();
			var LoginForm_alipayAccount = $("#LoginForm_alipayAccount").val();
			var LoginForm_shopInfo = $("#LoginForm_shopInfo").val();
			var idCardPhoto = $("#p1").val();
			var delegationPhoto = $("#p2").val();
			var licensePhoto = $("#p3").val();
// 			console.log(LoginForm_isLegalPerson+","+LoginForm_receiveType+","+LoginForm_openName+","+LoginForm_openBank
// 					+","+LoginForm_openAccount+","+LoginForm_alipayAccount+","+LoginForm_shopInfo);
			
			var jsonStr = {isLegalPerson:LoginForm_isLegalPerson,receiveType:LoginForm_receiveType,openName:LoginForm_openName,
					openBank:LoginForm_openBank,openAccount:LoginForm_openAccount,alipayAccount:LoginForm_alipayAccount,shopInfo:LoginForm_shopInfo,
					idCardPhoto:idCardPhoto,delegationPhoto:delegationPhoto,licensePhoto:licensePhoto};
			if(LoginForm_isLegalPerson=='1'){
				if(idCardPhoto==null||idCardPhoto==""){
					alert("请上传法人身份证");
					return false;
				}
// 				if(licensePhoto==null||licensePhoto==""){
// 					alert("请上传营业执照");
// 					return false;
// 				}
			}else if(LoginForm_isLegalPerson=='0'){
				if(idCardPhoto==null||idCardPhoto==""){
					alert("请上传法人身份证");
					return false;
				}
				if(delegationPhoto==null||delegationPhoto==""){
					alert("请上传委托收款涵");
					return false;
				}
// 				if(licensePhoto==null||licensePhoto==""){
// 					alert("请上传营业执照");
// 					return false;
// 				}
			}
			if(LoginForm_receiveType=='0'){
				if(LoginForm_openName==null||LoginForm_openName==""||LoginForm_openBank==null
					||LoginForm_openBank==""||LoginForm_openAccount==null||LoginForm_openAccount==""){
					alert("请填完银行卡信息");
					return false;
				}
				if(LoginForm_alipayAccount==null||LoginForm_alipayAccount==""){
					alert("请填写支付宝帐号");
					$("#LoginForm_submit").removeAttr('disabled');
					return false;
				}
			}else if(LoginForm_receiveType=='1'){
				if(LoginForm_alipayAccount==null||LoginForm_alipayAccount==""){
					alert("请填写支付宝帐号");
					return false;
				}
			}
// 			if(LoginForm_shopInfo==null||LoginForm_shopInfo==""){
// 				alert("请补充填写门店相关信息");
// 				return false;
// 			}
			console.log(jsonStr);
			if(state!=null&&state!=""){//edit
				$.ajax({
					url : "${pageContext.request.contextPath}/joinUser.do?registerup",
					type : 'post',
					data : jsonStr,
					success : function(data){
						var obj = $.parseJSON(data);
						console.log(obj);
						if(obj.obj==1){
							window.location.href="joinUser.do?registerAudit";
						}else if(obj.obj==2){
							alert("手机号重复,上传失败");
						}else if(obj.obj==4){
							alert("登录失效，请重新登陆后修改");
						}else{
							alert("资料上传有误，请返回信息上传重新填写");
						}
					},
					error : function(data){
						
					}
				});
				$("#LoginForm_submit").removeAttr('disabled');
			}else{
				$.ajax({
					url : "${pageContext.request.contextPath}/joinUser.do?registerSubmit",
					type : 'post',
					data : jsonStr,
					success : function(data){
						var obj = $.parseJSON(data);
						console.log(obj);
						if(obj.obj==1){
							window.location.href="joinUser.do?registerAudit";
						}else if(obj.obj==2){
							alert("手机号重复,上传失败");
						}else{
							alert("资料上传有误，请返回信息上传重新填写");
						}
					},
					error : function(data){
						
					}
				});
				$("#LoginForm_submit").removeAttr('disabled');
			}
		}
		LoginForm_businessLicense.oninput = function(){
		       alert();
		   }
	</script>
</body>
</html>