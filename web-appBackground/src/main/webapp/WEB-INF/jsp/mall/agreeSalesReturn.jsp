<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
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
			title : '退货信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (commonForm.find('[name=id]').val() != '') {
						if(!check())return;
						commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/agreeSalesReturn/edit.do',
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
							url : '${pageContext.request.contextPath}/agreeSalesReturn/add.do',
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
			url : '${pageContext.request.contextPath}/agreeSalesReturn/datagrid.do',
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
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 50,
				hidden : false,
				checkbox : true
			},{
				field : 'orderNo',
				title : '退款订单',
				width : 150,
				formatter : function(value,row,index){
					return "<a href='${pageContext.request.contextPath}/agreeSalesReturn/salesReturnItem.do?id="+row.id+"&orderId="+row.orderId+"'>"+value+"</a>";
				}
			} ] ],
			columns :[[{
				field : 'userName',
				title : '客户',
				width : 50
			},{
				field : 'goodsName',
				title : '产品',
				width : 50
			},{
				field : 'reason',
				title : '退款原因',
				width : 100,
				formatter : function(value,rowData,rowIndex){
					if(value==1){
						return "收到商品破损";
					}else if(value==2){
						return "商品错发/漏发";
					}else if(value==3){
						return "商品需要维护";
					}else if(value==4){
						return "发票问题";
					}else if(value==5){
						return "收到商品与描述不符";
					}else if(value==6){
						return "商品质量问题";
					}else if(value==7){
						return "未按约定时间发货";
					}else{
						return "其他";
					}
				}
			},{
				field : 'isNotReceived',
				title : '是否收到货',
				width : 100,
				formatter : function(value,rowData,rowIndex){
					if(value==1){
						return "还没有收到货，要求退款";
					}else if(value==2){
						return "已收到货，要求退款";
					}
				}
			},{
				field : 'isNotReturns',
				title : '是否退货',
				width : 50,
				formatter : function(value,rowData,rowIndex){
					if(value==1){
						return "我要退货";
					}else if(value==2){
						return "不用退货";
					}
				}
			},{
				field : 'money',
				title : '退款金额',
				width : 50
			},{
				field : 'state',
				title : '退款说明',
				width : 50
			},{
				field : 'refundDatetime',
				title : '退款时间',
				width : 100,
				formatter : showDate
			},{
				field : 'uploadDocuments',
				title : '上传凭证',
				width : 50,
				align : 'center',
				formatter:function(value,row,index){
					return '<img src="'+row.uploadDocuments+'" style=" width: 40px; height: 40px;"/>';
				}
			}]]
		});

	});
	
	function showDate(val){
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
				msg : '只能择一个条目进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '个条目',
				title : '提示'
			});
		} else if (rows.length == 1) {
			//alert(rows[0].id);
			//alert(rows[0].goodsName);
			//commonForm.find('[name=id]').attr('readonly', 'readonly');
			commonDialog.dialog('open');
			commonForm.form('clear');
			commonForm.form('load', {
				id : rows[0].id,
				userId : rows[0].userId,
				goodsId : rows[0].goodsId,
				goodsReceived : rows[0].goodsReceived
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
						url : '${pageContext.request.contextPath}/agreeSalesReturn/del.do',
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
		//alert("11");
		datagrid.datagrid('load',{
			reason : $('#toolbar #reason').val()
		});
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	function reloadFun(){
		datagrid.datagrid('reload');
	}
	
	function check(){
		var goodsReceived=$("#goodsReceived").val();
		if(goodsReceived==null || goodsReceived==""){
			alert("请选择收没收到货物！");
			return false;
		}else{
			return true;
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
						<td>退款原因</td>
						<td>
							<select name="reason" id="reason">
								<option value="1">收到商品破损</option>
								<option value="2">商品错发/漏发</option>
								<option value="3">商品需要维修</option>
								<option value="4">发票问题</option>
								<option value="5">收到商品与描述不符</option>
								<option value="6">商品质量问题</option>
								<option value="7">未按约定时间发</option>
								<option value="8">其他</option>
							</select>
						</td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
			<!-- 
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">增加</a>
			 --> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> 
				<a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a>
				<a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="reloadFun();"
					plain="true" href="javascript:void(0);">刷新</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="commonDialog" style="display: none; overflow: hidden;">
		<form id="commonForm" method="post" >
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden"/></td>
				</tr>
				<tr>
					<th></th>
					<td><input name="userId"  readonly="readonly" type="hidden"/></td>
				</tr>
				<tr>
					<th></th>
					<td>
						<input name="goodsId" readonly="readonly" type="hidden"/>
					</td>
				</tr>
				
				<tr>
					<th>是否收到货</th>
					<td>
						<select name="goodsReceived" id="goodsReceived" style="width:150px;">
							<option value="1" selected="selected">收到</option>
							<option value="2">没有收到</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>