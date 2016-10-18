<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript" charset="UTF-8">
var editRow;
var treegrid;
$(function() {

	treegrid = $('#treegrid').treegrid({
		url : '${pageContext.request.contextPath}/mallBanner/treegrid.do',
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
			text : '增加',
			iconCls : 'icon-add',
			handler : function() {
				append();
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
			title : '类别名称',
			width : 150,
			editor : {
				type : 'validatebox',
				options : {
					required : true
				}
			},
			formatter : function(value) {
				if (value) {
					return sy.fs('<span title="{0}">{1}</span>', value, value);
				}
			}
		} ] ],
		columns : [ [ {
			field : 'description',
			title : '描述',
			width : 100,
			editor : {
				type : 'text'
			}
		}, {
			field : 'seq',
			title : '排序',
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
			field : 'parentId',
			title : '上级资源',
			width : 150,
			hidden : true,
			formatter : function(value, rowData, rowIndex) {
				return rowData.parentText;
			},
			editor : {
				type : 'combotree',
				options : {
					url : '${pageContext.request.contextPath}/category/tree.do',
					animate : false,
					lines : !sy.isLessThanIe8(),
					onLoadSuccess : function(node, data) {
						var t = $(this);
						if (data) {
							$(data).each(function(index, d) {
								if (this.state == 'closed') {
									t.tree('expandAll');
								}
							});
						}
					}
				}
			}
		}, {
			field : 'row',
			title : '编辑',
			width : 50,
			align : 'center',
			formatter:function(value,row,index){    
				if(row.text !="banner广告"&& row.text !="banner商品"){
                	var s = '<a href="javascript:;" onclick="editRow(\''+row.id+'\')"><img src="${pageContext.request.contextPath}/resources/img/editBtn.png"/></a> ';
				}
                return s;    
  			 } , 				
		}, {
			field : 'index',
			title : '删除',          
			width : 50, 
			align : 'center',
			formatter:function(value,row,index){ 
				var id = row.id;
				if(row.text !="banner广告"&& row.text !="banner商品"){
               		 var s = '<a href="" onclick="delRow(\''+id+'\')"><img src="${pageContext.request.contextPath}/resources/img/deleteBtn.png"/></a> ';
				}
                return s; 
	       } , 
		}] ],
		onLoadSuccess : function(row, data) {
			var t = $(this);
			if (data) {
				$(data).each(function(index, d) {
					if (this.state == 'closed') {
						t.treegrid('expandAll');
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
	window.location.href="${pageContext.request.contextPath}/mallBanner/addMallBanner.do";
}
function editRow(id){
	window.location.href="${pageContext.request.contextPath}/mallBanner/editMallBanner.do?id="+id;
}
function delRow(id) {
	if (confirm('你确定要删除该记录?如果该记录有子类会一同删除')) {
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/mallBanner/del.do',
			data : "id=" + id,
			success : function(data) {
				var resp = $.parseJSON(data);
				if (resp.success == true) {
					var node = $('#treeGrid').treegrid(
						'getSelected');
					if (node) {	$('#treeGrid').treegrid('reload', node.code);}
				} else {
					alert('删除失败！');
				}
			}
		});
	} else {
		return false;
	}
}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<table id="treegrid"></table>
	</div>
</body>
</html>