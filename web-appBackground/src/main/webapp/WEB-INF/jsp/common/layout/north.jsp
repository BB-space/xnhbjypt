<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<script type="text/javascript" charset="UTF-8">
var websocket;
var isCreatw = false;
var title="";
var win;
var input;
var isQj = true;
var toUser="";
function initWebSocket() {
	if (window.WebSocket) {
		//alert("进入websocket");
		websocket = new WebSocket(encodeURI('ws://120.25.69.167:8090'));//正式
		//websocket = new WebSocket(encodeURI('ws://183.57.22.250:8090'));//测试
		websocket.onopen = function() {
			//连接成功
			//alert(title + '&nbsp;&nbsp;(已连接)   【现在全局对话】'+'${userM.shopId}');
			websocket.send('[join]'+'${userM.shopId}');
			//alert('发送成功！');
		}
		websocket.onerror = function() {
			//连接失败
			//alert(title + '&nbsp;&nbsp;(连接发生错误)');
		}
		websocket.onclose = function() {
			//连接断开
			//alert(title + '&nbsp;&nbsp;(已经断开连接)');
		}
		//消息接收
		websocket.onmessage = function(message) {
			//alert(message+"%"+message.data);
			var message = message.data;
			//接收用户发送的消息
			if (message == 'hello') {
				bofang();
				setTimeout('window.location.href = "${pageContext.request.contextPath}/index.do"', 7000);
			}
		}
	}
}; 
	function logout(b) {
		$.cookie("usertype", null);
		$.post('user.do?logout', function() {
			if (b) {
				window.location.href = "${pageContext.request.contextPath}/indexNew.jsp";
			} else {
				loginAndRegDialog.dialog('open');
			}
		});
	}

	function userInfo() {
		addTabFun({
			src : 'userController.do?userInfo',
			title : '个人信息'
		});
	}
	function bofang(){
		//alert("开始播放声音！");
		var myVideo=document.getElementById("audio");
		myVideo.play();
		
	}
	
	$(document).ready(function(){
		initWebSocket();
	 	
	});
	
	$(function() {
		$("#sel").change(function(){
			var companyCode=$("#sel option:selected").attr("id");
			$.ajax({
				url : '${pageContext.request.contextPath}/user.do?bgLogins',
				type : 'post',
				data : {
					companyCode:companyCode
				},
				success : function(data){
					var d = $.parseJSON(data);
					 if(d.success==true){
						window.location.href = "${pageContext.request.contextPath}/index.do";		
					}else{
						alert(d.msg);
					}
				}
			});
		});
		
	});
</script>
<!-- <div style="position: absolute; right: 0px; bottom: 0px; ">
	<a href="javascript:void(0);" class="easyui-menubutton" menu="#layout_north_kzmbMenu" iconCls="icon-help">控制面板</a><a href="javascript:void(0);" class="easyui-menubutton" menu="#layout_north_zxMenu" iconCls="icon-back">注销</a>
</div>
<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
	<div onclick="userInfo();">个人信息</div>
	<div class="menu-sep"></div>
	<div>
		<span>更换主题</span>
		<div style="width: 100px;">
			<div onclick="sy.changeTheme('default');">default</div>
			<div onclick="sy.changeTheme('gray');">gray</div>
		</div>
	</div>
</div>
<div id="layout_north_zxMenu" style="width: 100px; display: none;">
	<div onclick="loginAndRegDialog.dialog('open');">锁定窗口</div>
	<div class="menu-sep"></div>
	<div onclick="logout(true);">重新登录</div>
	<div onclick="logout(true);">退出系统</div>
</div> -->

<div style="background:rgb(59,153,204);height:90px;">
	<div style="float:left;">
		<img alt="" src="resources/img/imgshop/logohair.png" style="margin-top:0.3rem;">
	</div>
	<div style="float:right;color: #FFF;">
		<ul class="ul_app">
			<li><img alt="" src="resources/img/imgshop/logo.png" style="margin-top:0.4rem;"></li>
			<li style="margin-left:0.5rem;margin-right:0.5rem;">
			<c:choose>
			<c:when test="${userM.cityGroup!=null && userM.text=='区域门店'}">
				<div style="margin-top:20px;font-size:1rem">
				<select id="sel">
					<option  value="0" selected>请选择门店</option>
					<c:forEach items="${shopList }" var="t">
						<option value="${t.shortNumber }" id="${t.shortNumber }" <c:if test="${companyCode==t.shortNumber }">selected="selected"</c:if> >${t.shopName }</option>
					</c:forEach>
				</select>
				</div>
			</c:when>
			<c:when test="${userM.cityGroup==null&& userM.text=='区域门店'}">
				<div style="margin-top:20px;font-size:1rem">
				<select id="sel">
					<option value="0" selected>请选择门店</option>
					<c:forEach items="${shopList }" var="t">
						<option value="${t.shortNumber }" id="${t.shortNumber }" <c:if test="${companyCode==t.shortNumber }">selected="selected"</c:if> >${t.shopName }</option>
					</c:forEach>
				</select>
				</div>
			</c:when>
			<c:otherwise>
				<div style="margin-top:20px;font-size:1rem">${userM.shopName}</div>
			</c:otherwise>
			</c:choose>
				<div style="margin-top:10px;cursor: pointer;font-size:0.5rem" onclick="logout(true);">  ${userM.userName}   退出登录</div></li>
<%-- 			<li style="margin-left:0.5rem;"><div style="margin-top:30px;">【${userM.shopName}】${userM.userName}</span></div></li>
			<li style="margin-left:1rem;"><div style="margin-top:30px;cursor: pointer" onclick="logout(true);">退出登录</div></li> --%>
		</ul>
	</div>
	<div style="clear: both">
		<audio id="audio" controls="controls" style="display:none">
  		<source src="<%=request.getContextPath()%>/resources/audio/duanxintishi.mp3" type="audio/mpeg">
		</audio>
	</div>
</div>