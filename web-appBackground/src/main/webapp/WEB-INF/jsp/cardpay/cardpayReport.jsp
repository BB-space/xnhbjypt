<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var reportDialog;
	var reportForm;
	var passwrodInput;
	$(function() {
		
		reportForm = $("#reportForm").form();

		passwordInput = reportForm.find('[name=name]').validatebox({
			required : true
		});
		reportDialog = $('#reportDialog').show().dialog({
			modal : true,
			title : '添加门店',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (reportForm.find('[name=id]').val() != '') {
						//alert("***"+reportForm.find('[name=id]').val());
						reportForm.form('submit', {
							url : '${pageContext.request.contextPath}/report.do?edit',
							success : function(data) {
								reportDialog.dialog('close');
								$.messager.show({
									msg : '修改门店成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else {
						reportForm.form('submit', {
							url : '${pageContext.request.contextPath}/report.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										reportDialog.dialog('close');
										$.messager.show({
											msg : '添加门店成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									reportDialog.dialog('close');
									$.messager.show({
										msg : '添加门店失败！',
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
		//	url : '${pageContext.request.contextPath}/cardPayReport.do?datagrid',
			url : '',
		//	toolbar : '#toolbar',
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
				field : 'mobile',
				title : '会员电话',
				width : 100,
				align : 'center',
			}, {
				field : 'shopName',
				title : '开卡门店',
				width : 100,
				hidden : true,
				align : 'center',
			}, {
				field : 'cardName',
				title : '卡项',
				width : 100,
				hidden : true,
				align : 'center',
			}, {
				field : 'goodsName',
				title : '划卡项目',
				width : 10,
				hidden : true,
				align : 'center',
			}, {
				field : 'quantity',
				title : '数量',
				width : 100,
				align : 'center',
			}, {
				field : 'price',
				title : '单价',
				width : 100,
				align : 'center',
			/* }, {
				field : 'code',
				title : '折扣',
				width : 100, */
			},{
				field : 'amount',
				title : '金额',
				width : 100,
				align : 'center',
			},{
				field : 'nurse',
				title : '护理师',
				width : 100,
				align : 'center',
			},{
				field : 'hairStylist',
				title : '发型师',
				width : 100,
				align : 'center',
			},{
				field : 'createDateTime',
				title : '消费时间',
				width : 100,
				align : 'center',
			},{
				field : 'orderNo',
				title : '订单编号',
				width : 100,
				align : 'center',
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

	function edit() {
		$("#QRCode").html(" ");
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
			reportForm.find('[name=id]').attr('readonly', 'readonly');
			reportDialog.dialog('open');
			reportForm.form('clear');
			reportForm.form('load', { 
				id : rows[0].id,
				provinceId : rows[0].provinceId,   
				cityId : rows[0].cityId,
				reportName : rows[0].reportName,
				shortName : rows[0].shortName,
				shortNumber : rows[0].shortNumber,
				reportNumber : rows[0].reportNumber,
				phone : rows[0].phone,
				address : rows[0].address,
				code : rows[0].code,
				minimumEarlyWorking : rows[0].minimumEarlyWorking,
				minimumNightWorking : rows[0].minimumNightWorking,
				forDay : rows[0].forDay,
				holiday : rows[0].holiday
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
						url : '${pageContext.request.contextPath}/report.do?del',  
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
	
	//查找
	function searchFun() {
		datagrid.datagrid('load',
				{
					reportName : $('#toolbar input[name=reportName]').val()
				});
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<!-- <div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<th>门店名称</th>
						<td><input name="reportName"></td>
					</tr>
					<tr>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">编辑</a><a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div> -->
		<table id="datagrid"></table>
	</div>  
</body>
</html>