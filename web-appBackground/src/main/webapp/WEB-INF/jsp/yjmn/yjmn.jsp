<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript" charset="UTF-8">
	var editRow;
	var treegrid;
	var iconData = [ {
		iconcls : 'icon-man',
		text : '默认图标'
	}, {
		iconcls : 'icon-add',
		text : 'icon-add'
	}, {
		iconcls : 'icon-edit',
		text : 'icon-edit'
	}, {
		iconcls : 'icon-remove',
		text : 'icon-remove'
	}, {
		iconcls : 'icon-save',
		text : 'icon-save'
	}, {
		iconcls : 'icon-cut',
		text : 'icon-cut'
	}, {
		iconcls : 'icon-ok',
		text : 'icon-ok'
	}, {
		iconcls : 'icon-no',
		text : 'icon-no'
	}, {
		iconcls : 'icon-cancel',
		text : 'icon-cancel'
	}, {
		iconcls : 'icon-reload',
		text : 'icon-reload'
	}, {
		iconcls : 'icon-search',
		text : 'icon-search'
	}, {
		iconcls : 'icon-print',
		text : 'icon-print'
	}, {
		iconcls : 'icon-help',
		text : 'icon-help'
	}, {
		iconcls : 'icon-undo',
		text : 'icon-undo'
	}, {
		iconcls : 'icon-redo',
		text : 'icon-redo'
	}, {
		iconcls : 'icon-back',
		text : 'icon-back'
	}, {
		iconcls : 'icon-sum',
		text : 'icon-sum'
	}, {
		iconcls : 'icon-tip',
		text : 'icon-tip'
	} ];
	$(function() {
		
		treegrid = $('#treegrid').treegrid({
			url : '${pageContext.request.contextPath}/yjmn.do?treegrid',
			toolbar : [ {
				text : '展开',
				iconCls : 'icon-redo',
				handler : function() {
					var node = treegrid.treegrid('getSelected');
					if (node) {
						treegrid.treegrid('expandAll', node.id);
					} else {
						treegrid.treegrid('expandAll');
					}
				}
			}, '-', {
				text : '折叠',
				iconCls : 'icon-undo',
				handler : function() {
					var node = treegrid.treegrid('getSelected');
					if (node) {
						treegrid.treegrid('collapseAll', node.id);
					} else {
						treegrid.treegrid('collapseAll');
					}
				}
			}, '-', {
				text : '刷新',
				iconCls : 'icon-reload',
				handler : function() {
					editRow = undefined;
					treegrid.treegrid('reload');
				}
			}, '-', {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					if (editRow) {
						treegrid.treegrid('endEdit', editRow.id);
					}
				}
			}, '-', {
				text : '取消编辑',
				iconCls : 'icon-undo',
				handler : function() {
					if (editRow) {
						treegrid.treegrid('cancelEdit', editRow.id);
						editRow = undefined;
					}
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					treegrid.treegrid('unselectAll');
				}
			}, '-' ],
			title : '',
			iconCls : 'icon-save',
			fit : true,
			fitColumns : true,
			nowrap : true,
			animate : false,
			border : false,
			idField : 'id',
			treeField : 'text',
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 50,
				hidden : true
			}, {
				field : 'text',
				title : '名称',
				width : 100
			} ] ],
			columns : [ [{
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
			},  {
				field : 'parentText',
				title : '上级菜单',
				width : 80,
				hidden : true
			}, {
				field : 'status',
				title : '状态',
				width : 50,
				hidden : true
			} ] ],
			onClickRow : function(row) {
				if (editRow) {
					alert("***"+editRow.id);
					treegrid.treegrid('endEdit', editRow.id);
				} else {
					alert("$$$"+row.id);
					treegrid.treegrid('beginEdit', row.id);
					editRow = row;
				}
			},
			onAfterEdit : function(row, changes) {
				alert(row);
				if (row.parentId != row.id) {
					if(row.status=='0'){
						$.ajax({
							url : '${pageContext.request.contextPath}/yjmn.do?edit',
							data : row,
							cache : false,
							dataType : "json",
							success : function(r) {
								if (r.success) {
									$.messager.show({
										msg : r.msg,
										title : '提示'
									});
									parent.tree.tree('reload');
									editRow = undefined;
								} else {
									$.messager.show({
										msg : '保存菜单失败!',
										title : '提示'
									});
								}
							}
						});
					}else{
						treegrid.treegrid('cancelEdit', editRow.id);
						editRow = undefined;
						$.messager.show({
							msg : '保存失败，不能编辑店员!',
							title : '提示'
						});
					}
					
				} else {
					$.messager.show({
						msg : '保存失败，上级菜单不可以是自己!',
						title : '提示'
					});
				}
			},
			onContextMenu : function(e, row) {
				e.preventDefault();
				$(this).treegrid('unselectAll');
				$(this).treegrid('select', row.id);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
			onLoadSuccess : function(row, data) {
				var t = $(this);
				if (data) {
					$(data).each(function(index, d) {
						if (this.state == 'closed') {
							t.treegrid('collapseAll');
						}
					});
				}
			},
			onExpand : function(row) {
				treegrid.treegrid('unselectAll');
			},
			onCollapse : function(row) {
				treegrid.treegrid('unselectAll');
			}
		});

	});

	function edit() {
		alert("&^%");
		if (editRow) {
			$.messager.show({
				msg : '您没有结束之前编辑的数据，请先保存或取消编辑！',
				title : '提示'
			});
		} else {
			var node = treegrid.treegrid('getSelected');
			if (node && node.id) {
				treegrid.treegrid('beginEdit', node.id);
				editRow = node;
			}
		}
	}
	function append() {
		if (editRow) {
			$.messager.show({
				msg : '您没有结束之前编辑的数据，请先保存或取消编辑！',
				title : '提示'
			});
		} else {
			var node = treegrid.treegrid('getSelected');
			var data = [ {
				id : sy.UUID(),
				text : '新菜单',
				src : '',
				seq : 999,
				parentId : (node ? node.id : '')
			} ];
			var opts = {
				parent : data[0].parentId,
				data : data
			};
			$.ajax({
				url : '${pageContext.request.contextPath}/yjmn.do?add',
				data : data[0],
				cache : false,
				dataType : "json",
				success : function(r) {
					if (r.success) {
						treegrid.treegrid('append', opts);
						treegrid.treegrid('beginEdit', data[0].id);
						editRow = data[0];
					} else {
						$.messager.show({
							msg : '添加菜单失败!',
							title : '提示'
						});
					}
				}
			});
		}
	}
	function remove() {
		var node = treegrid.treegrid('getSelected');
		if (node) {
			treegrid.treegrid('expandAll', node.id);
		} else {
			treegrid.treegrid('expandAll');
		}
		treegrid.treegrid('selectAll');
		var nodes = treegrid.treegrid('getSelections');
		for (var i = 0; i < nodes.length; i++) {
			alert(nodes[i].text);
		}
	}
</script>
</head>
<body class="easyui-layout" fit="true" >
	<div region="center" border="false" style="overflow: hidden;">
		<table id="treegrid" style="width:700px;height:250px"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="append();" iconCls="icon-add">增加</div>
		<div onclick="remove();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>
</body>
</html>