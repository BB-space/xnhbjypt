<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<jsp:include page="../common/inc/xheditor.jsp"></jsp:include>
<style type="text/css">
.tableForm tr td{
	line-height: 35px;
}
</style>

<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var goodsDialog;
	var goodsForm;
	var passwordInput;
	
	$(function() {
		
	
		$('#catId').combotree( {
			//获取数据URL
			url : '${pageContext.request.contextPath}/category/tree.do',
			//选择树节点触发事件
			onSelect : function(node) {
				//返回树对象
				var tree = $(this).tree;
				//选中的节点是否为叶子节点,如果不是叶子节点,清除选中
				var isLeaf = tree('isLeaf', node.target);
				console.log(node.id);
				if (!isLeaf) {
					//清除选中
					$('#catId').combotree('clear');
				}
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
		
	
	 
		
		
		goodsForm = $('#goodsForm').form();
	
		/* goodsDialog = $('#goodsDialog').show().dialog({
			modal : true,
			title : '商品信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (goodsForm.find('[name=id]').val() != '') {
						goodsForm.form('submit', {
							url : '${pageContext.request.contextPath}/goods/edit.do',
							success : function(data) {
								goodsDialog.dialog('close');
								$.messager.show({
									msg : '商品编辑成功！',
									title : '提示'
								});
								datagrid.datagrid('reload');
							}
						});
					} else {
						goodsForm.form('submit', {
							url : '${pageContext.request.contextPath}/goods/add.do',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										goodsDialog.dialog('close');
										$.messager.show({
											msg : '商品创建成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									$.messager.show({
										msg : '商品名称已存在！',
										title : '提示'
									});
								}
							}
						});
					}
				}
			} ]
		}).dialog('close'); */
	

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/goods/datagrid.do',
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
				checkbox : true,
				hidden : false,
			},{
				field : 'goodsNo',
				title : '商品编号',
				width : 100,
			},{
				field : 'name',
				title : '商品名称',
				width : 100,
			} ] ],
			columns : [ [{
				field : 'catId',
				title : '类别id',
				width : 10,
				hidden : true
			},{
				field : 'catName',
				title : '类别',
				width : 30
			},{
				field : 'price',
				title : '价格',
				width : 15,
			},{
				field : 'integral',
				title : '积分',
				width : 15,
			},{
				field : 'kcQuantity',
				title : '库存',
				width : 15,
			},{
				field : 'itemType',
				title : '物品类别',
				width : 30
			},{
				field : 'showStatus',
				title : '显示',
				width : 30,
				formatter : function(value, rowData, rowIndex) {
					if(value==1){return "显示";}else if(value==0){return "不显示";}
				}
			},{
				field : 'status',
				title : '状态',
				width : 50,
				formatter : function(value,rowData,rowIndex){
					if(value==1){return "上架";}
					else if(value==0){return "下架";}
				}
			},{
				field : 'specification',
				title : '规格',
				width : 50,
			},{
				field : 'weight',
				title : '重量',
				width : 50,
			},{
				field : 'tag',
				title : '标签',
				width : 50,
			},{
				field : 'pictures',
				title : '图片',
				width : 50,
				align : 'center',
				formatter:function(value,row,index){
					return '<img src="'+row.pictures+'" style=" width: 40px; height: 40px;"/>';
				}
			},{
				field : 'createDatetime',
				title : '创建时间',
				width : 100,
				formatter:formatterdate
			}]]
		});
	
	});


	function append() {
		/**
		goodsForm.form('clear');
		goodsDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		goodsForm.find('[name=name]').removeAttr('readonly');
		**/
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
			//alert(rows[0].id+"\t"+rows[0].name);
			window.location.href="${pageContext.request.contextPath}/goods.do?editPage&ids="+rows[0].id;
			//window.location.href="${pageContext.request.contextPath}/goods.do?refreEdit&ids="+rows[0].id;
		
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
						url : '${pageContext.request.contextPath}/goods/del.do',
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
	
	function changePicUrl() {
			var dFile = document.getElementById('file');
			var dImg = document.getElementById('pic');
			if (dFile.files) {
				document.getElementById("pic").style.display = 'block';
				dImg.src = window.URL.createObjectURL(dFile.files[0]);
			} else if (dFile.value.indexOf('\\') > -1
					|| dFile.value.indexOf('\/') > -1) {
				dImg.src = dFile.value;
			}  
		
	}
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
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
						<td>商品名称</td>
						<td><input name="name"/></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add"  onclick="append();"
					plain="true" href="${pageContext.request.contextPath}/goods.do?getAll">增加</a> <a
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

	<div id="goodsDialog" style="display: none; overflow: hidden;width:1200px;min-height:400px;">
		<form id="goodsForm" method="post" enctype="multipart/form-data">
			<table class="tableForm">
				<tr>
					<th>商品ID</th>
					<td><input name="id" readonly="readonly" /></td>
					<th>商品类别</th>
					<td>
						<input id="catId" name="catId" type="easyui-validatebox" required="true" 
						style="width:150px;">
					</td>
					<th>商品名称</th>
					<td><input name="name" class="easyui-textbox" type="text" data-options="required:true" /></td>
					<th>商品编号</th>
					<td>
					<input name="goodsNo" type="easyui-validatebox" class="easyui-textbox" data-options="required:true"/>
					</td>
					<th>物品类别</th>
					<td>
						<select name="itemType" class="easyui-combobox" required="true" style="width:150px;">
							<option value="物品">物品</option>
							<option value="卡项">卡项</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>价格</th>
					<td><input name="price" class="easyui-textbox" type="text" data-options="required:true"/></td>
					<th>积分</th>
					<td><input name="integral" class="easyui-textbox" type="text" data-options="required:true"/></td>
					<th>库存数量</th>
					<td><input name="kcQuantity" class="easyui-textbox" type="text"/></td>
					<th>上架/下架</th>
					<td>
						<select class="easyui-combobox" name="status" style="width:150px;">
							<option value="1">上架</option>
							<option value="0">下架</option>
						</select>
					</td>
					<th>显示</th>
					<td>
					<select class="easyui-validatebox" name="showStatus" data-options="required:true" style="width:150px;">
							<option value="1">显示</option>
							<option value="0">隐藏</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>规格</th>
					<td><input name="specification" class="easyui-textbox" type="text" data-options="required:true"/></td>
					<th>重量</th>
					<td>
					<input name="weight" type="easyui-validatebox" class="easyui-textbox" data-options="required:true"/>
					</td>
					<th>商品描述</th>
					<td>
						<input name="description" class="easyui-textbox" data-options="required:true,multiline:true" style="height:60px;"/>
					</td>
					<th>功效</th>
					<td><input name="efficacy" class="easyui-textbox" data-options="multiline:true" style="height:60px;"/></td>
					<th>用法</th>
					<td><input name="usages" class="easyui-textbox" data-options="multiline:true" style="height:60px;"/></td>
				</tr>
				<tr>
					<th>标签</th>
					<td><input name="tag" class="easyui-textbox" data-options="multiline:true" style="height:60px;"/></td>
					<th>出货规则</th>
					<td>
						<select name="deliveryRulesId" id="deliveryRules" style="width: 100px">
							<option value="1">圆通</option>
							<option value="0">免运费</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>图片</th>
					<td>
						<input id="file" type="file" name="files" onchange="changePicUrl()">
						<img name="pic" id="pic" alt="" src=""
						style="display: none; width: 200px; height: 200px;">
					</td>
				
						<td class="td1">内容：</td>
						<td colspan="8">
				            <textarea id="content" name="content" class="content" style="height:300px; width: 100%;">
				            </textarea>
						</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>