<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
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
							url : '${pageContext.request.contextPath}/deliveryManage/edit.do',
							success : function(data) {
								commonDialog.dialog('close');
								$.messager.show({
									msg : '编辑成功！',
									title : '提示'
								});
								datagrid.datagrid('reload');
							}
						});
					} else {
						commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/deliveryManage/add.do',
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
						});
					}
				}
			} ]
		}).dialog('close');

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/deliveryApp/datagridUnDelivery.do',
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
			singleSelect:false,
			idField : 'id',
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 50,
				hidden : false,
				checkbox : true
			},{
				field : 'deliveryNumber',
				title : '出库申请单号',
				width : 100,
			} ] ],
			columns :[[{
				field : 'userId',
				title : '用户',
				width : 100,
			},{
				field : 'orderNo',
				title : '订单号',
				width : 20,
			},{
				field : 'orderTime',
				title : '下单时间',
				width : 50,
				formatter:function(value,row,index){
					return sy.fdate(new Date(value));
				}
			},{
				field : 'orderPayTime',
				title: '付款时间',
				width :50,
				formatter:function(value,row,index){
					return sy.fdate(new Date(value));
				}
			},{
				field : 'deliveryStatus',
				title : '状态',
				width : 50,
				formatter: function(value,row,index){
					if(value==0){
						return "待发货";
					}else if(value==1){
						return "已发货";
					}
				}
			}]],
			checkOnSelect: true,
			selectOnCheck: true,
			onLoadSuccess:function(data){       
				//console.log(data);
				if(data){
					$.each(data.rows, function(index, item){
						if(item.checked){
							$('#datagrid').datagrid('checkRow', index);
						}
					});
				}
			} 
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
			commonForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
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
						url : '${pageContext.request.contextPath}/deliveryManage/del.do',
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
		datagrid.datagrid('load',{
			name : $('#toolbar input[name=name]').val()
		});
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	function reloadFun(){
		datagrid.datagrid('reload');
	}
	
	function getCheck(){ 
		var checkedItems = $('#datagrid').datagrid('getChecked');
		var names = [];
		$.each(checkedItems, function(index, item){
			names.push(item.id);
		});
		console.log(names.join(","));
		$.post("${pageContext.request.contextPath}/deliveryManage/generateBill.do",{ids:names.join(",")},function(data){
			
		})
	 	window.location.href="${pageContext.request.contextPath}/deliveryManage/deliveryManage.do";
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
						<td>收款确认日期</td>
						<td>
							<input  class="easyui-datetimebox" style="width:200px">至
							<input  class="easyui-datetimebox" style="width:200px">
						</td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
					<div style="float:right">
<!-- 				<input type="button" id="ButonGetCheck" value="确认选择" /> -->
				<button onclick="window.location.href='${pageContext.request.contextPath}/deliveryManage/deliveryManage.do'">>>返回</button>
				</div>
			</fieldset>
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" id="ButonGetCheck"
					plain="true" href="javascript:getCheck();">生成发货单</a><a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="reloadFun();"
					plain="true" href="javascript:void(0);">刷新</a><a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="commonDialog" style="display: none; overflow: hidden;">
		<form id="commonForm" method="post">
			<table class="tableForm">
				<tr>
					<th>ID</th>
					<td><input name="id" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>名称</th>
					<td>
						<input name="name" class="easyui-textbox" type="text" data-options="required:true" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>