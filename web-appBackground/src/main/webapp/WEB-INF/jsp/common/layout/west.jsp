<%@ page language="java" pageEncoding="UTF-8"%>
<style>
#menuTree{
	overflow:hidden;
	color:#999999;
}
#m-scroll{
	width:100%;
	height:100%;
	overflow-y:scroll;
	padding-right:17px;
	background:#1A1A1A;
}
ul li div{
	padding:10px 0;
}
.cNode-bg{
	background:#000;
	color:#fff;
}
</style>
<script type="text/javascript" charset="UTF-8">
	var tree;
	$(function() {
		tree = $('#tree').tree({
			url : '${pageContext.request.contextPath}/menu/backgroundTree.do',
			animate : false,
			lines : !sy.isLessThanIe8(),
			onClick : function(node) {
				$("li[class='cNode-bg']").removeClass("cNode-bg");
				var chooseNode = $(".tree-node-selected").closest('ul').closest('li');
				chooseNode.addClass("cNode-bg");
				if (node.attributes && node.attributes.src && node.attributes.src != '') {
					var href;
					if (/^\//.test(node.attributes.src)) {/*以"/"符号开头的,说明是本项目地址*/
						href = node.attributes.src.substr(1);
						$.messager.progress({
							text : '请求数据中....',
							interval : 100
						});
					} else {
						href = node.attributes.src;
					}
					addTabFun({
						src : href,
						title : node.text
					});
				} else {
					addTabFun({
						src : 'test/err.jsp',
						title : 'hello'
					});
				}
			},
			onLoadSuccess : function(node, data) {
				var t = $(this);
				if (data) {
					$(data).each(function(index, d) {
						if (this.state == 'closed') {
							t.tree('collapseAll');
						}
					});
				}
			},
			iconCls:'icon-save'
		});

	});
	function collapseAll() {
		var node = tree.tree('getSelected');
		if (node) {
			tree.tree('collapseAll', node.target);
		} else {
			tree.tree('collapseAll');
		}
	}
	function expandAll() {
		var node = tree.tree('getSelected');
		if (node) {
			tree.tree('expandAll', node.target);
		} else {
			tree.tree('expandAll');
		}
	}
</script>
<div class="easyui-panel" fit="true" border="false">
	<div class="easyui-accordion" fit="true" border="false">
		<!-- <div title="系统菜单" iconCls="icon-tip">
			<div class="easyui-layout" fit="true">
				<div region="north" border="false" style="overflow: hidden;">
					<a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-redo" onclick="expandAll();">展开</a><a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-undo" onclick="collapseAll();">折叠</a><a href="javascript:void(0);" class="easyui-linkbutton" plain="true" iconCls="icon-reload" onclick="tree.tree('reload');">刷新</a>
					<hr style="border-color: #fff;" />
				</div>
				<div region="center" border="false">
					<ul id="tree" style="margin-top: 5px;"></ul>
				</div>
			</div>
		</div> -->
		<div region="center" border="false" id="menuTree">
			<div id="m-scroll">
				<ul id="tree" style="margin-top: 5px;"></ul>
			</div>
		</div>
	</div>
</div>