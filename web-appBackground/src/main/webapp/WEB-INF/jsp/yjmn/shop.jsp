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
	var editRow;
	var datagrid;
	var shopDialog;
	var shopForm;
	var passwrodInput;
	$(function() {
		shopForm = $("#shopForm").form();

		passwordInput = shopForm.find('[name=name]').validatebox({
			required : true
		});
			
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/yjmn.do?shopDatagrid',
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
				title : 'id',
				field : 'id',
				width : 50,
				hidden : true
			} ] ],
			columns : [ [ {
				field : 'sumCardGold',
				title : '总开卡金额',
				width : 50
			}, {
				field : 'balance',
				title : '余额',
				width : 50
			}, {
				field : 'cardItem1000',
				title : '1000储值卡',
				width : 50,
				editor : {
					type : 'numberbox',
					options : {
						min : 0,
						max : 999,
						required : true
					}
				}
			}, {
				field : 'cardItem500',
				title : '500储值卡',
				width : 50,
				editor : {
					type : 'numberbox',
					options : {
						min : 0,
						max : 999,
						required : true
					}
				}
			}, {
				field : 'countSum',
				title : '数量合计',
				width : 50
			}, {
				field : 'goldSum',
				title : '金额合计',
				width : 50
			}, {
				field : 'openCardGoal',
				title : '建议卡数量',
				width : 50
			}, {
				field : 'status',
				title : '状态',
				width : 50,
				hidden : true
			}] ],
			onClickRow : function(rowIndex, rowData) {
				//alert(rowIndex+'*&^'+rowData.id);
				 if (editRow != undefined) {
                     datagrid.datagrid("endEdit", editRow);
                 }
                 if (editRow == undefined) {
                     datagrid.datagrid("beginEdit", rowIndex);
                     editRow = rowIndex;
                 }
			},
			onAfterEdit : function(row, changes) {
				//alert(changes.id+"*"+changes.cardItem1000+"*"+changes.cardItem500);
						$.ajax({
							url : '${pageContext.request.contextPath}/yjmn.do?editYjmember',
							data : {"id":changes.id,"cardItem1000":changes.cardItem1000,"cardItem500":changes.cardItem500},
							cache : false,
							dataType : "json",
							success : function(r) {
								if (r.success) {
									$.messager.show({
										msg : r.msg,
										title : '提示'
									});
									datagrid.datagrid('unselectAll');
									datagrid.datagrid('reload');
								} else {
									$.messager.show({
										msg : '保存菜单失败!',
										title : '提示'
									});
								}
							}
						});

					
			},
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

	}
	function editYj() {
		var ids = [];
		var rows = datagrid.datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('请确认', '您要取消当前所选员工业绩目标？', function(r) {
				if (r) {
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].shopAssistant);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/yjmn.do?editYj',  
						data : {
							assistantIds : ids.join(',')
						},
						cache : false,
						dataType : "json",
						success : function(response) {
							datagrid.datagrid('unselectAll');
							datagrid.datagrid('reload');
							$.messager.show({
								title : '提示',
								msg : '取消成功！'
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要取消的员工目标！', 'error');
		}
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<div>
				<a 
					class="easyui-linkbutton" iconCls="icon-remove" onclick="editYj();"
					plain="true" href="javascript:void(0)">取消员工目标</a> 
				<a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>  


</body>
</html>