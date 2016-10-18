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
	var websocketDialog;
	var websocketForm;
	var passwrodInput;
	$(function() {
		websocketForm = $("#websocketForm").form();

		passwordInput = websocketForm.find('[name=name]').validatebox({
			required : true
		});
		websocketDialog = $('#websocketDialog').show().dialog({
			modal : true,
			title : '修改目标',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (websocketForm.find('[name=id]').val() != '') {
						websocketForm.form('submit', {
							url : '${pageContext.request.contextPath}/yjmn.do?editYjmember',
							success : function(data) {
								websocketDialog.dialog('close');
								$.messager.show({
									msg : '修改城市成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						websocketForm.form('submit', {
							url : '${pageContext.request.contextPath}/websocket.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										websocketDialog.dialog('close');
										$.messager.show({
											msg : '添加城市成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									websocketDialog.dialog('close');
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
			
/* 		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/yjmn.do?websocketDatagrid',
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
				field : 'member',
				title : '会员编号',
				width : 100,
				editor : {
					type : 'text'
				}
			},{
				field : 'memberName',
				title : '会员名称',
				width : 100,
				editor : {
					type : 'text'
				}
			},{
				field : 'card',
				title : '开卡项目',
				width : 300,
				editor : {
					type : 'text'
				}
			},{
				field : 'openCardGoal',
				title : '开卡目标',
				width : 300,
				
			}, {
				field : 'cardItem300',
				title : '300储值卡目标数量',
				width : 100,
				editor : {
					type : 'numberbox',
					options : {
						min : 0,
						max : 999,
						required : true
					}
				}
			},{
				field : 'cardItem500',
				title : '500储值卡目标数量',
				width : 100,
				editor : {
					type : 'numberbox',
					options : {
						min : 0,
						max : 999,
						required : true
					}
				}
			},{
				field : 'cardItem1000',
				title : '1000储值卡目标数量',
				width : 100,
				editor : {
					type : 'numberbox',
					options : {
						min : 0,
						max : 999,
						required : true
					}
				}
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
		}); */

	});
	function start() {
		$.ajax({
			url : '${pageContext.request.contextPath}/webSocket.do?startWebSocket',
			type : 'post',
			success : function(data){
				var d = $.parseJSON(data);
 				$.messager.show({
					title : '提示',
					msg : d.msg
				}); 
			}
		});


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
			websocketForm.find('[name=id]').attr('readonly', 'readonly');
			websocketDialog.dialog('open');
			websocketForm.form('clear');
			websocketForm.form('load', { 
				id : rows[0].id,
				cardItem300 : rows[0].cardItem300,   
				cardItem500 : rows[0].cardItem500, 
				cardItem1000 : rows[0].cardItem1000,
				memberName : rows[0].memberName,
				card : rows[0].card,
				member : rows[0].member
			});
		}
	}
	function del() {

	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="start();"
					plain="true" href="javascript:void(0)">启动websocket服务</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">设置该会员目标</a><a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>  

	<div id="websocketDialog" style="display: none; overflow: hidden;">
		<form id="websocketForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>会员编号：</th>
					<td><input name="member" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" readonly="readonly"  /></td>
				</tr>
				<tr>
					<th>会员名称：</th>
					<td><input name="memberName" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" readonly="readonly"  /></td>
				</tr>
				<tr>
					<th>开卡项目：</th>
					<td><input name="card" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" readonly="readonly"  /></td>
				</tr>
				<tr>
					<th>300储值卡目标数量：</th>
					<td><input name="cardItem300" style="width: 200px;"
						maxlength="30" class="easyui-easyui-numberbox" required="true" min="0" max="100" /></td>
				</tr>
				<tr>
					<th>500储值卡目标数量：</th>
					<td><input name="cardItem500" style="width: 200px;"
						maxlength="30" class="easyui-easyui-numberbox" required="true" min="0" max="100" /></td>
				</tr>
				<tr>
					<th>1000储值卡目标数量：</th>
					<td><input name="cardItem1000" style="width: 200px;"
						maxlength="30" class="easyui-easyui-numberbox" required="true" min="0" max="100" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>