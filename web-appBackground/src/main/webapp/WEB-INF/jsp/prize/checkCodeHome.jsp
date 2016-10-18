<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript">
	var editRow;
	var datagrid;
	var editDialog;
	var editForm;
	
	$(function() {
		editForm = $("#editForm").form();
		editDialog = $('#editDialog').show().dialog({
			modal : true,
			title : '修改备注',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					editForm.form('submit', {
						url : '${pageContext.request.contextPath}/checkCode.do?editNote',
						success : function(data) {
							editDialog.dialog('close');
							$.messager.show({
								msg : '修改备注成功！',
								title : '提示'
							});
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('reload');
						}
					});
				}
			} ]
		}).dialog('close');
		
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/checkCode.do?checkCodeDatagrid',
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
				width : 80,
			}, {
				field : 'mobile',
				title : '手机号码',
				width : 80,
			}, {
				field : 'nickName',
				title : '姓名',
				width : 80,
			}, {
				field : 'cardName',
				title : '卡券名称',
				width : 100,
			}, {
				field : 'status',
				title : '状态',
				width : 80,
				formatter: function(value){
					if(value == "0"){
						return '<font color="red">未核销</font>';
					}
					return '<font color="green">已核销</font>';
				}
			}, {
				field : 'note',
				title : '备注',
				width : 200,
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

		$("#city").combobox({
	        onSelect: function(record){
	        	$("#shopId").combobox('clear');	
	        	if (record.value != "0") {
	    			var cityName = record.value;
	    			$.post("checkCode.do?shopList", {
	    				"cityName" : cityName
	    			}, callback);
	    		} else {
	    			$("#shopId").combobox('loadData', {});
	    		}
	        }
		});
		
		$("#shopId").combobox({
			valueField: 'id',
	        textField: 'shopName'
		});
	});

	//加载城市列表
	function callback(data){
		var data = eval("(" + data + ")");
		$("#shopId").combobox("loadData", data);
	}
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' 
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	//查找验证码
	function searchFun() {
		
		var code = $("#checkCode").val();
		
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
	
	//核销验证码
	function checkCode() {
		if(!checkData()){
			return;
		}
		
		var mobile = $("#mobile").val();
		if(mobile.length != 11){
			$.messager.show({title : '提示',msg : '请输入正确的电话号码！'});
			return ;
		}
		
		var shopId = $("#shopId").combobox('getValue');
		if(shopId.length == 0){
			$.messager.show({title : '提示',msg : '请选择核销门店'});
			return;
		}
		
		$.post('${pageContext.request.contextPath}/checkCode.do?edit',  
				{'checkCode' : $("#checkCode").val(),
				 'mobile' : $("#mobile").val(),
				 'shopId' : shopId,
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
	
	//检查数据
	function checkData(){
		var checkCode = $("#checkCode").val();
		if(checkCode.length == 0){
			$.messager.show({title : '提示',msg : '验证码不能为空'});
			return false;
		}
		
		var status = $("#status").val();
		if(status == "已核销"){
			$.messager.show({title : '提示',msg : '验证码已核销'});
			return false;
		}
		return true;
	}
	
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			if((rows[0].status == '0')){
				editDialog.dialog('open');
				editForm.form('clear');
				editForm.form('load', { 
					id : rows[0].id,
					checkCode : rows[0].checkCode,
					checkCodeShow : rows[0].checkCode,
					note : rows[0].note,
				});
			}else {
				$.messager.show({title : '提示',msg : '验证码已核销'});
				datagrid.datagrid('unselectAll');
			}
			
		}
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
						<th>城市</th>
						<td><select id="city" name="city" style="width: 155px;" 
							 class="easyui-combobox" data-options="editable:false">
							<option value="请选择" selected="selected">请选择</option>
							<option value="珠海市">珠海市</option>
							<option value="中山市">中山市</option>
							<option value="佛山市">佛山市</option>
							<option value="顺德市">顺德市</option>
							<option value="广州市">广州市</option>
							<option value="深圳市">深圳市</option>
							<option value="海口市">海口市</option>
						 </select></td>
						<th>门店</th>
						<td><select name="shopId" id="shopId" style="width: 155px;"
							class="easyui-combobox" data-options="editable:false">
							</select></td>
					</tr>
					<tr>
						<th>姓名</th>
						<td><input name="nickName" id="nickName" disabled="disabled"></td>
						<th>卡券名称</th>
						<td><input name="cardName" id="cardName" disabled="disabled"></td>
						<th>状态</th>
						<td><input name="status" id="status" disabled="disabled"></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">编辑</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>  
	
	<div id="editDialog" style="display: none; overflow: hidden;">
		<form id="editForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>验证码：</th>
					<td><input name="checkCodeShow" style="width: 400px;" disabled="disabled"/></td>
					<td><input name="checkCode" style="width: 400px;" type="hidden"  /></td>
				</tr>
				<tr>
					<th>备注：</th>
					<td><input name="note" style="width: 400px;" id="note"
						maxlength="300" class="easyui-validatebox" required="true" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>