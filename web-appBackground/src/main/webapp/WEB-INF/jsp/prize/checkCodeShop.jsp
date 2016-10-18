<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript">
	var datagrid;
	var checkCodeDialog;
	var checkCodeForm;
	var passwrodInput;
	
	$(function() {
		
		checkCodeForm = $("#checkCodeForm").form();
			
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/checkCode.do?datagrid',
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
				field : 'checkCode',
				title : '验证码',
				width : 100,
			}, {
				field : 'mobile',
				title : '手机号码',
				width : 100,
			}, {
				field : 'nickName',
				title : '姓名',
				width : 100,
			}, {
				field : 'cardName',
				title : '卡券名称',
				width : 100,
			}, {
				field : 'status',
				title : '状态',
				width : 100,
				formatter: function(value){
					if(value == "0"){
						return '<font color="red">未核销</font>';
					}
					return '<font color="green">已核销</font>';
				}
			}, {
				field : 'createDateTime',
				title : '获取验证码时间',
				width : 100,
				formatter:formatterdate,
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
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' 
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	//查找
	function searchFun() {
		
		var code = $("#checkCode").val();
		console.info(code);
		
		if(code.length < 0){
			$.messager.show({title : '提示',msg : '请输入验证码！'});
			return;
		}
		
		$.post('${pageContext.request.contextPath}/checkCode.do?getCheckCode',  
				{'code' : $("#checkCode").val()},
			    function(data) {
				 	if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
			    		alert('没有登录系统，或登录超时，请重新登录');
			    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
			    		return;
			    	}
			    	var d = $.parseJSON(data);

			    	console.info(d);
			    	
			    	if(d.msg == "1"){
			    		$.messager.show({title : '提示',msg : '找不到验证码对应信息'});
			    		return;
			    	}
			    	
			    	$("#mobile").val(d.obj.mobile);
			    	$("#nickName").val(d.obj.nickName);
			    	$("#cardName").val(d.obj.cardName);
			    	
			    	if(d.obj.status == 0){
				    	$("#status").val("未核销");
			    	}else{
				    	$("#status").val("已核销");
			    	}
			    	
	    	}); 
	}
	
	function checkCode() {
		
		var status = $("#status").val();
		if(status == "已核销"){
			$.messager.show({title : '提示',msg : '验证码已核销'});
			return;
		}
		
		var mobile = $("#mobile").val();
		console.info(mobile);
		if(mobile.length != 11){
			$.messager.show({title : '提示',msg : '请输入正确的电话号码！'});
			return ;
		}
		
		$.post('${pageContext.request.contextPath}/checkCode.do?edit',  
				{'checkCode' : $("#checkCode").val(),
				 'mobile' : $("#mobile").val(),
				 'note' : $("#note").val()	},
			    function(data) {
				 	if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
			    		alert('没有登录系统，或登录超时，请重新登录');
			    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
			    		return;
			    	}
				 	var d = $.parseJSON(data);
					if(d.msg == '0'){
						$.messager.show({title : '提示',msg : '核销失败，找不到验证码对应信'});
					}else {
						$.messager.show({title : '提示',msg : '核销成功'});
				    	$('#toolbar input').val('');
						datagrid.datagrid('load', {});
					}
	    	}); 
		
	}
	
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<th>验证码</th>
						<td><input name="checkCode" id="checkCode"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="checkCode();" href="javascript:void(0);">核销</a></td>
					</tr>
					<tr>
						<th>手机号码</th>
						<td><input name="mobile" id="mobile" ></td>
						<th>姓名</th>
						<td><input name="nickName" id="nickName" disabled="disabled"></td>
						<th>卡券名称</th>
						<td><input name="cardName" id="cardName" disabled="disabled"></td>
						<th>状态</th>
						<td><input name="status" id="status" disabled="disabled"></td>
					</tr>
				</table>
			</fieldset>
		</div>
		<table id="datagrid"></table>
	</div>  
	
</body>
</html>