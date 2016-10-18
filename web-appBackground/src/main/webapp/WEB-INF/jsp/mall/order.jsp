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
	$(function(){
		$.post("${pageContext.request.contextPath}/order.do?logisticsList",null,function(data){
			var data = eval("(" + data + ")");
			var logistics = $("#logistics");
			logistics.empty();
			logistics.append("<option value=0>请选择</option>");
			for(var i = 0 ; i < data.length ; i++) {
				logistics.append("<option value=" + data[i].code + ">" + data[i].company + "</option>");
			}
		});
		 $('#orderItem').dialog({
				title	: '订单商品明细',
				width	: 960,
				height	: 500,
				modal	: true,
				closed	: true,
				buttons : [{
					text :'确定',
					handler:function(){
						$("#orderItem").dialog('close');
						var row = $('#datagrid').datagrid('getSelected');
						$("#title").val(row.title);
						$(".topTable").show();
						$("#wrapper").val(row.wrapper);
						//String prefix = "newsController.do?detail&id=";
						$("#address").val("newsController.do?detail&id="+row.id);  
					},
				},{
					text :'取消',
					handler :function(){
						$("#news_id").dialog('close');
					}
				}]
			});	
	});
	$(function() {
		commonForm = $('#commonForm').form();
		commonDialog = $('#commonDialog').show().dialog({
			modal : true,
			title : '订单信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (commonForm.find('[name=id]').val() != '') {
						commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/order/edit.do',
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
							url : '${pageContext.request.contextPath}/order/add.do',
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
			url : '${pageContext.request.contextPath}/order/datagrid.do',
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
			singleSelect:true,
			idField : 'id',
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 50,
				hidden : false,
				checkbox : true
			},{
				field : 'orderNo',
				title : '订单编号',
				width : 100,
				formatter : function(value,row,index){
					return '<a onclick="orderItemList(\''+row.id+'\')">'+value+'</a>';
				}
			} ] ],
			columns :[[{
				field : 'username',
				title : '用户',
				width : 20,
			},{
				field : 'status',
				title : '付款状态',
				width : 20,
				formatter : function(value, rowData, rowIndex) {
					if (value == 0) {
						return "待付款";
					} else if (value == 1) {
						return "已付款";
					}
				}
			},{
				field : 'deliveryStatus',
				title : '发货状态',
				width : 20,
				formatter : function(value, rowData, rowIndex) {
					if (value == 0) {
						return "待发货";
					} else if (value == 1) {
						return "已发货";
					}else if (value==2){
						return "已收货";
					}else {
						return "未处理";
					}
				}
			}, {
				field : 'amount',
				title : '总额',
				width : 20,
			},{
				field : 'totalScore',
				title : '积分',
				width : 20
			} ,{
				field : 'sendName',
				title : '收货人',
				width : 50,
			}, {
				field : 'sendAddress',
				title : '收货地址',
				width : 50,
			}, {
				field : 'sendPhone',
				title : '联系方式',
				width : 50,
			}, {
				field : 'remarks',
				title : '备注',
				width : 50,
			}, {
				field : 'orderTime',
				title : '创建时间',
				width : 50,
				formatter:function(value,row,index){  
                    return sy.fdate(new Date(value));
				}
			}, {
				field : 'orderPayTime',
				title : '付款时间',
				width : 50,
				formatter:function(value,row,index){
					if(value!=null){
						return sy.fdate(new Date(value));						
					}
				}
			}, {
				field : 'waybill',
				title : '运单号',
				width : 50,
			} , {
				field : 'logistics',
				title : '物流公司',
				width : 50,
			} ] ]
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
				msg : '只能择一个订单进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '个商品',
				title : '提示'
			});
		} else if (rows.length == 1) {
			commonDialog.dialog('open');
			commonForm.form('clear');
			commonForm.form('load', {
				id : rows[0].id,
				orderNo : rows[0].orderNo,
				amount : rows[0].amount,
				totalScore : rows[0].totalScore,
				sendName : rows[0].sendName,
				sendAddress : rows[0].sendAddress,
				sendPostcode : rows[0].sendPostcode,
				sendPhone : rows[0].sendPhone,
				remarks : rows[0].remarks,
				status : rows[0].status,
				waybill : rows[0].waybill, 
			});
		}
	}

	function del() {
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager
					.confirm(
							'请确认',
							'您要删除当前所选项目？',
							function(r) {
								if (r) {
									for (var i = 0; i < rows.length; i++) {
										ids.push(rows[i].id);
									}
									$
											.ajax({
												url : '${pageContext.request.contextPath}/order/del.do',
												data : {
													ids : ids.join(',')
												},
												cache : false,
												dataType : "json",
												success : function(response) {
													datagrid
															.datagrid('unselectAll');
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
		datagrid.datagrid('load', {
			orderNo : $('#toolbar input[name=orderNo]').val(),
			status : $('#toolbar select[name=status]').val(),
			deliveryStatus : $("#toolbar select[name=deliveryStatus]").val()
		});
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	function reloadFun() {
		datagrid.datagrid('reload');
	}
	function orderItemList(value){
		//alert(value);return false;
		$('#orderItem').dialog('open');
		 $('#orderItemDatagrid').datagrid({
				url : '${pageContext.request.contextPath}/orderItem/datagrid.do?orderId='+value,
				toolbar : '#orderItemToolbar',
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
				rownumbers : true,  
				singleSelect : true,
				frozenColumns : [ [
				{
					title : '编号',
					field : 'id',
					width : 50,
					hidden : true,
				} ] ], 
				columns : [ [{
					field : 'orderId',
					title : '订单Id',
					width : 100,
					sortable : true,					
				},{
					field : 'goodsNo',
					title : '商品编号',
					width : 100,
				},{
					field : 'goodsName',
					title : '商品名称',
					width : 100
				},{
					field : 'price',
					title : '单价',
					width : 100,
					sortable : true,
				},{
					field : 'integral',
					title : '积分',
					width : 100,
					sortable : true,
				},{
					field : 'quantity',
					title : '数量',
					width : 100
				},{
					field : 'amount',
					title : '总额',
					width : 100
				},{
					field : 'totalScore',
					title : '总积分',
					width : 100
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
						<td>付款状态</td>
						<td>
							<select name="status" id="dvs">
								<option value="">---请选择---</option>
								<option value="0">待付款</option>
								<option value="1">已付款</option>
							</select>
						</td>
						<td>发货状态</td>
						<td>
							<select name="deliveryStatus" id="">
								<option value="">---请选择---</option>
								<option value="0">待发货</option>
								<option value="1">已发货</option>
								<option value="2">已收货</option>
							</select>
						</td>
						<td>订单编号</td>
						<td><input name="orderNo"/></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">增加</a> --><!--  <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> --> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a><a
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
		<form id="commonForm" method="post">
			<table class="tableForm">
				<tr>
					<th>ID</th>
					<td><input name="id" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>订单编号</th>
					<td>
						<input name="orderNo" class="easyui-textbox" type="text" data-options="required:true" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>总额</th>
					<td><input name="amount" class="easyui-textbox" type="text" data-options="required:true"/></td>
				</tr>
				<tr>
					<th>积分</th>
					<td><input name="totalScore" class="easyui-textbox" type="text" data-options="required:true"/></td>
				</tr>
				<tr>
					<th>收货人</th>
					<td><input name="sendName" class="easyui-textbox" type="text" data-options="required:true"/></td>
				</tr>
				<tr>
					<th>收货地址</th>
					<td><input name="sendAddress" class="easyui-textbox" type="text" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>收货邮编</th>
					<td><input name="sendPostcode" class="easyui-textbox" type="text"/></td>
				</tr>
				<tr>
					<th>收货联系方式</th>
					<td><input name="sendPhone" class="easyui-textbox" type="text" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>订单状态</th>
					<td>
						<select name="status">
							<option value="0">待付款</option>
							<option value="1">已付款</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>备注</th>
					<td><input name="remarks" class="easyui-textbox" type="text" /></td>
				</tr>
				<tr>
					<th>运单号</th>
					<td><input name="waybill" class="easyui-textbox" type="text" /></td>
				</tr>
				<tr>
					<th>物流公司</th>
					<td><select name="logistics" id="logistics" style="width: 150px"></select></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="orderItem">
		<div id="orderItemToolbar" class="datagrid-toolbar"
			style="height: auto; display: none;">
			<fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<td>订单编号</td>
						<td><input name="orderNo"/></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">增加</a> --> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a><a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="reloadFun();"
					plain="true" href="javascript:void(0);">刷新</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="orderItemDatagrid"></table> 
	</div>
</body>
</html>