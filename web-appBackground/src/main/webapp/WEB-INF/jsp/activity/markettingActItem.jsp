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
		$('#catId').combotree( {
			//获取数据URL
			url : '${pageContext.request.contextPath}/category/tree.do',
			//选择树节点触发事件
			onSelect : function(node) {
				//返回树对象
				var tree = $(this).tree;
				//选中的节点是否为叶子节点,如果不是叶子节点,清除选中
				var isLeaf = tree('isLeaf', node.target);
				if (!isLeaf) {
					//清除选中
					$('#catId').combotree('clear');
				}
				$('#goodsId').combobox({    
				    url:'${pageContext.request.contextPath}/goods/findGoodsByCat.do?id='+node.id,    
				    valueField:'id',    
				    textField:'name'   
				}); 
			},
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
		});
		
		commonForm = $('#commonForm').form();
		commonDialog = $('#commonDialog').show().dialog({
			modal : true,
			title : '活动信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (commonForm.find('[name=id]').val() != '') {
						commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/markettingActItem/edit.do',
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
							url : '${pageContext.request.contextPath}/markettingActItem/add.do',
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
									datagrid.datagrid('reload');
								}
							}
						});
					}
				}
			} ]
		}).dialog('close');
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/markettingActItem/datagrid.do?actId=${actId}',
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
				formatter : function(value,rowData,rowIndex){
					return rowIndex+1;
				}
			},{
				field : 'goodsName',
				title : '名称',
				width : 100,
			} ] ],
			columns :[[{
				field : 'price',
				title : '原价(元)',
				width : 50
			},{
				field : 'downPrice',
				title : '减价(元)',
				width : 50
			},{
				field : 'discount',
				title : '折扣(%)',
				width : 50
			}]]
		});
	});
	function append() {
		commonForm.form('clear');
		commonDialog.dialog('open');
		commonForm.find('[name=name]').removeAttr('readonly');
		commonForm.find('[name=actId]').val('${actId}');
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
				goodsName : rows[0].goodsName,
				catId : rows[0].catId,
				goodsId : rows[0].goodsId,
				discount : rows[0].discount,
				downPrice : rows[0].downPrice
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
						url : '${pageContext.request.contextPath}/markettingActItem/del.do',
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
						<td>名称</td>
						<td><input name="name"/></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">增加</a> <a
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
		<table id="datagrid"></table>
	</div>
	
	<div id="commonDialog" style="display:none;overflow: hidden;">
		<form id="commonForm" method="post">
			<table class="tableForm">
				<tr>
					<th>ID</th>
					<td><input name="id" readonly="readonly" /></td>
				</tr>
				<input name="actId" value="${actId}" type="hidden">
				<tr>
					<th>商品分类</th>
					<td>
						<input id="catId" name="catId" type="easyui-validatebox" required="true" 
						style="width:200px;">
					</td>
				</tr>
				<tr>
					<th>活动商品</th>
					<td>
						<select class="easyui-combobox" id="goodsId" name="goodsId" style="width:120px;">
						</select>
					</td>
				</tr>
				<tr>
					<th>折扣</th>
					<td>
						<input  name="discount" onchange="checkField(this.value)">%
					</td>
				</tr>
				<tr>
					<th>可抵价格</th>
					<td>
						<input id="downPrice" name="downPrice">元
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		function checkField(val){
			var txt2 = $("#goodsId").combobox("getValue");
			$.post('${pageContext.request.contextPath}/goods/getDownPrice.do',
			    {goodsId:txt2,dst:val},
				function(data){
					var obj = $.parseJSON(data);
					$("#downPrice").val(obj.RESULT);
				}
			)
		}
	</script>
	</script>
</body>
</html>