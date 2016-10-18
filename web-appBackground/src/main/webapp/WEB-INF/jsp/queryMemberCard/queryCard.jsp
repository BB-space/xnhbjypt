<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menunew.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var commonDialog;
	var commonForm;
	$(function() {
		commonForm = $('#commonForm').form();
		commonDialog = $('#commonDialog').show().dialog({
			modal : true,
			title : '信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (commonForm.find('[name=id]').val() != '') {
						commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/queryMemberCard.do?editQueryCard',
							success : function(data) {
								commonDialog.dialog('close');
								var obj = jQuery.parseJSON(data);
								if(obj.success==true){
									$.messager.show({
										msg : '编辑成功！',
										title : '提示'
									});
								}else{
									$.messager.show({
										msg : '编辑失败！',
										title : '提示'
									});
								}
								datagrid.datagrid('reload');
							}
						});
					} else {
						/* commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/queryMemberCard/add.do',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										commonDialog.dialog('close');
										$.messager.show({
											msg : '创建成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									$.messager.show({
										msg : '名称已存在！',
										title : '提示'
									});
								}
							}
						}); */
					} 
				}
			} ]
		}).dialog('close');

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/queryMemberCard.do?queryCardDatagrid',
			toolbar : '#toolbar',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			queryParams : {username:'null'},
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			singleSelect:true,
			idField : 'id',
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 50,
				hidden : false,
				checkbox : true
			},{
				field : 'username',
				title : '手机',
				width : 100,
			} ] ],
			columns :[[{
				field : 'name',
				title : '名称',
				width : 50
			},{
				field : 'qctype',
				title : '来源',
				width : 50,
				formatter : function(value,row,index){
					if(value=='cardown'){
						return "自己购买"
					}else if(value=="cardrec"){
						return "好友转赠所得";
					}else if(value=="qyqown"){
						return "自己购买";
					}else if(value=="qyqrec"){
						return "好友转赠所得";
					}else if(value=='zpfwown'){
						return "自己购买";
					}
				}
			},{
				field : 'status',
				title : '状态',
				width : 30,
				formatter : function(value,row,index){
					if(row.qctype=='cardown'){
						if(value=='0'){
							return "未使用";
						}else if(value=='1'){
							return "转赠未接收";
						}else if(value=='2'){
							return "转赠已接收";
						}else if(value=='3'){
							return "已核销";
						}
					}else if(row.qctype=='cardrec'){
						if(value=='0'){
							return "未核销";
						}else if(value=='3'){
							return "已核销";
						}
					}else if(row.qctype=='zpfwown'){
						if(value=='0'){
							return "未使用";
						}else if(value=='3'){
							return "已核销";
						}
					}else if(row.qctype=='qyqown'){
						if(value=='0'){
							return "未转赠";
						}else if(value=='1'){
							return "转赠未接收";
						}else if(value=='2'){
							return "转赠已接收";
						}else if(value=='3'){
							return "转赠已核销";
						}
					}else if (row.qctype=='qyqrec'){
						if(value=='1'){
							return "未核销";
						}else if(value=='2'){
							return "已核销";
						}
						
					}
				}
			},{
				field : 'receiveTime',
				title : '获得时间',
				width : 50
			},{
				field : 'deadlines',
				title : '过期时间',
				width : 50
			},{
				field : 'shopName',
				title : '核销门店',
				width : 100
			},{
				field :'scanStaffName',
				title : '核销员工',
				width : 50
			},{
				field :'scanMobile',
				title : '核销手机',
				width : 50
			},{
				field : 'useTime',
				title : '核销时间',
				width : 100
			},{
				field : 'codeNumber',
				title : '二维码编号',
				width : 100
			},{
				field : 'isOnline',
				title : '线上/线下',
				width : 50
			}]]
		});

	});
	
	//设置显示时间
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	function append() {
		commonForm.form('clear');
		commonDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		commonForm.find('[name=name]').removeAttr('readonly');
	}

	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length != 1 && rows.length != 0) {
			var names = [];
			for (var i = 0; i < rows.length; i++) {
				names.push(rows[i].name);
			}
			$.messager.show({
				msg : '只能择一个商品进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '个商品',
				title : '提示'
			});
		} else if (rows.length == 1) {
			commonDialog.dialog('open');
			commonForm.form('clear');
			$.post("city.do?cityList",{"provinceId":rows[0].provinceId},callbackCity);
			 
			$.post("shop.do?shopList",{"cityId":rows[0].cityId},callbackShop);
			commonForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
				shopName : rows[0].shopName,
				status : rows[0].status,
				deadlines : rows[0].deadlines,
				shopName : rows[0].shopName,
				provinceId :rows[0].provinceId,
				cityId : rows[0].cityId,
				username : rows[0].username,
				qctype : rows[0].qctype
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
						url : '${pageContext.request.contextPath}/queryMemberCard/del.do',
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

	function searchFun() {
		var username = $('#toolbar input[name=username]').val();
		if(username!=""){
			datagrid.datagrid('load',{
				username : $('#toolbar input[name=username]').val(),
			});
		}else{
			$.messager.alert('提示','请输入会员手机','error');
		}
	}
	function clearFun() {
		$('#toolbar input[name!="selbt"]').val('');
		datagrid.datagrid('load', {username:'null'});
	}
	function reloadFun(){
		datagrid.datagrid('reload');
	}
	
	//城市
	function callbackCity(data) {
		var data = eval("(" + data + ")");
		var rows = datagrid.datagrid('getSelections');
		var city = $("#city");
		  city.empty();
		 for ( var i = 0; i < data.length; i++) {
			 //alert(data[i].cityName);
			 if(data[i].id==rows[0].cityId){
				 //alert(data[i].id+"**"+rows[0].cityId);
				 city.append("<option value=" + data[i].id + " selected='selected' >"+ data[i].cityName + "</option>");
			 }else{
				 city.append("<option value=" + data[i].id + ">"+ data[i].cityName + "</option>");
			 }
		  }
	}
	
	//门店
	function callbackShop(data) {
		var data = eval("(" + data + ")");
		var rows = datagrid.datagrid('getSelections');
		var shop = $("#shop");
		  shop.empty();
		 for ( var i = 0; i < data.length; i++) {
			 //alert(data[i].shopName);
			 if(data[i].id==rows[0].shopId){
				 //alert(data[i].id+"**"+rows[0].shopId);
				 shop.append("<option value=" + data[i].id + " selected='selected' >"+ data[i].shopName + "</option>");
			 }else{
				 shop.append("<option value=" + data[i].id + ">"+ data[i].shopName + "</option>");
			 }
		  }
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<div id="toolbar" class="datagrid-toolbar"
			style="height: auto; display: none;">
			<fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<td>会员手机：</td>
						<td><input name="username"/></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">增加</a> --> <!-- <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> -->
					<c:if test="${userM.roleId=='9a81adcf-7373-3d3b-911d-594edb7002b1' 
					|| userM.roleId=='8d4e66b7-fec7-5cce-8f32-ceea2058e974'}">
						<a class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
						plain="true" href="javascript:void(0);">编辑</a>
					</c:if>
					<a class="easyui-linkbutton" iconCls="icon-edit" onclick="reloadFun();"
					plain="true" href="javascript:void(0);">刷新</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="commonDialog" style="display: none; overflow: hidden;">
		<form id="commonForm" method="post" enctype="multipart/form-data">
			<table class="tableForm">
				<input name="id" type="hidden" ly="readonly" />
				<input name="username" type="hidden" ly="readonly" />
				<input name="qctype" type="hidden" ly="readonly" />
				<tr>
					<th>卡券名称</th>
					<td>
						<input name="name" class="easyui-textbox" type="text" data-options="required:true" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>过期时间</th>
					<td>
						<input name="deadlines" class="easyui-datetimebox" type="text" data-options="required:true" />
					</td>
				</tr>
				<tr>
					<th>省份</th> 
					<td><select name="provinceId" id="province" 
					 onchange="province1()" style="width: 175px"></select></td>
				</tr>
				<tr>
					<th>城市</th> 
					<td><select name="cityId" id="city" onchange="city1()"  
					 style="width: 175px"></select></td>
				</tr>
				<tr>
					<th>核销门店</th>
					<td>
					<select id="shop" 
							name="shopId" style="width: 175px"></select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>