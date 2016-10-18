<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/websocket/jquery.WebSocket.js"></script>

<script type="text/javascript">
	var datagrid;
	var cityDialog;
	var cityForm;
	var passwrodInput;
	var websocket;
	var isCreatw = false;
	var title="";
	var win;
	var input;
	var isQj = true;
	var toUser="";
	//初始话WebSocket
 	function initWebSocket() {
		if (window.WebSocket) {
			//websocket = new WebSocket(encodeURI('ws://183.57.22.250:8090'));//测试
			websocket = new WebSocket(encodeURI('ws://120.25.69.167:8090'));//正式
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
				}
			}
		}
	}; 
	
/* 	var ws = new $.websocket({  
        protocol : "websocket_msg/serverSocket?message_to="+message_to+"&message_me="+message_me,  
        domain : "192.168.7.50",  
        port : "8887",  
        onOpen:function(event){    
            showMessage("已成功登录");  
        },    
        onError:function(event){
             alert("error:"+ event)  
        },    
        onMessage:function(result){    
            receiveMessage(result);  
        },  
        onClose:function(event){
            ws = null;  
        }  
    }); */
	
	$(function() {
		
		cityForm = $("#cityForm").form();

		passwordInput = cityForm.find('[name=name]').validatebox({
			required : true
		});
		cityDialog = $('#cityDialog').show().dialog({
			modal : true,
			title : '添加城市',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (cityForm.find('[name=id]').val() != '') {
						cityForm.form('submit', {
							url : '${pageContext.request.contextPath}/city.do?edit',
							success : function(data) {
								cityDialog.dialog('close');
								$.messager.show({
									msg : '修改城市成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						cityForm.form('submit', {
							url : '${pageContext.request.contextPath}/city.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										cityDialog.dialog('close');
										$.messager.show({
											msg : '添加城市成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									cityDialog.dialog('close');
									$.messager.show({
										msg : '添加城市失败！',
										title : '提示'
									});
									datagrid.datagrid('reload');
								}
							}
						});
					}
				}
			} ]
		}).dialog('close');
			
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/city.do?datagrid',
			toolbar : '#toolbar',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'id',
			singleSelect : true,//单选 
			rownumbers : true,
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 50,
				hidden : true,
			} ] ],
			columns : [ [ {
				field : 'cityName',
				title : '城市',
				width : 100,
			},{
				field : 'cityNumber',
				title : '城市架构编码',
				width : 100,
			}, {
				field : 'provinceId',
				title : '省份',
				width : 100,
				hidden : true,
			},{
				field : 'status',
				title : '预约状态',
				width : 100,
				formatter:function(value,row,index){
					if(value=='1'){
						return "已开通";
					}else if(value=='0'){
						return "未开通";
					}
				}
			},{
				field : 'seq',
				title : '序列号',
				width : 100,
			}] ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});

	});
	function append() {
		cityDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		cityForm.find('[name=name]').removeAttr('readonly');
		cityForm.form('clear');
		initWebSocket();
	}

	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length != 1 && rows.length != 0) {
			var names = [];
			for (var i = 0; i < rows.length; i++) {
				names.push(rows[i].title);
			}
			$.messager.show({
				msg : '只能择一条数据 进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '条数据',
				title : '提示'
			});
		} else if (rows.length == 1) {
			passwordInput.validatebox({
				required : false
			});
			cityForm.find('[name=id]').attr('readonly', 'readonly');
			cityDialog.dialog('open');
			cityForm.form('clear');
			cityForm.form('load', { 
				id : rows[0].id,
				provinceId : rows[0].provinceId,   
				cityName : rows[0].cityName, 
				seq : rows[0].seq,
			});
		}
	}
	function del() {
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/city.do?del',  
						data : {
							ids : ids.join(',')
						},
						cache : false,
						dataType : "json",
						success : function(response) {
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('reload');
							$.messager.show({
								title : '提示',
								msg : '删除成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
	}
	function bofang(){
		//alert("开始播放声音！");
		var myVideo=document.getElementById("audio");
		myVideo.play();
	}
	function fasong(){
		var user=$("#shop").val();
		alert(user);
		websocket.send("[toUserMessage]"+user+",hello");
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0)">增加</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">编辑</a><a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>  

	<div id="cityDialog" style="display: none; overflow: hidden;">
		<form id="cityForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				</tr>
				<tr><td align="right" class="tdleft">省：</td> 
				<td><select name="provinceId" id="province" onchange="province1()" ></select></td> </tr>
					<tr><td align="right" class="tdleft"> 市：</td> 
					<td><select name="cityId" id="city" onchange="city1()" style="width: 70px"></select></td>
					</tr>
				<tr>
					<th>门店：</th>
					<td><select  name="shopId" id="shop" class="area selects" 
                              style="width: 90%;height:32px; margin-top:0.1rem;border:none;
                              background-color: rgb(229,229,229);color:rgb(169,169,169);">
                              		<option value="0">请选择所属门店</option>  
                              </select> </td>
				</tr>
				<tr>
					<th>播放提示音</th>
					<td>
						<button onclick="fasong()">发送</button>
					</td>
				</tr>
				<tr>
					<th>提示音：</th>
					<td><audio id="audio" controls="controls" style="display:none">
  							<source src="<%=request.getContextPath()%>/resources/audio/tishi.mp3" type="audio/mpeg">
						</audio></td>
				</tr>
				<tr>
					<th>播放提示音</th>
					<td>
						<button onclick="bofang()">播放</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>