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
	
	$(function() {
		$('#cc').combobox({selectOnNavigation:$(this).is(':checked')});
		commonForm = $('#commonForm').form();
		commonDialog = $('#commonDialog').show().dialog({
			modal : true,
			title : '活动信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (commonForm.find('[name=id]').val() != '') {
						commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/markettingActivity/edit.do',
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
							url : '${pageContext.request.contextPath}/markettingActivity/add.do',
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
			url : '${pageContext.request.contextPath}/markettingActivity/datagrid.do',
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
				field : 'name',
				title : '名称',
				width : 100,
				formatter : function(value,rowData,rowIndex){
					return '<a href="${pageContext.request.contextPath}/markettingActItem/markettingActItem.do?actId='+rowData.id+'">'+value+'</a>';
				}
			} ] ],
			columns :[[{
				field : 'actStartDate',
				title : '开始时间',
				width : 20,
				formatter : function(value){
					return formatDate(value);	
				}
			},{
				field : 'actEndDate',
				title : '结束时间',
				width : 20,
				formatter : function(value){
					return formatDate(value);
				}
			},{
				field : 'source',
				title : '来源',
				width : 20,
			},{
				field : 'userType',
				title : '会员类型',
				width : 20,
			},{
				field : 'superPosition',
				title : '可叠加',
				width : 20,
			},{
				field : 'targetMarket',
				title : '目标市场',
				width : 20,
			},{
				field : 'actType',
				title : '活动类型',
				width : 20,
			},{
				field : 'groupQty',
				title : '搭配件数',
				width : 20,
			}]]
		});

	});

	function append() {
		commonForm.form('clear');
		commonDialog.dialog('open');
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
				msg : '只能择一个商品进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '个商品',
				title : '提示'
			});
		} else if (rows.length == 1) {
			commonDialog.dialog('open');
			commonForm.form('clear');
			commonForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
				actStartDate : formatDate(rows[0].actStartDate),
				actEndDate : formatDate(rows[0].actEndDate),
				source : rows[0].source,
				userType : rows[0].userType,
				superPosition : rows[0].superPosition,
				targetMarket : rows[0].targetMarket,
				actType : rows[0].actType,
				groupQty : rows[0].groupQty,
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
						url : '${pageContext.request.contextPath}/markettingActivity/del.do',
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
	function formatDate(value){
		var date = new Date(value);
		var y = 1900+date.getYear();
		var m = 1+date.getMonth();
		var d = date.getDate();
		var h = date.getHours();
		var min = date.getMinutes();
		var sec = date.getSeconds();
		var text=y+"-"+m+"-"+d+" "+h+":"+min+":"+sec;
		return text;
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

	<div id="commonDialog" style="display: none; overflow: hidden;">
		<form id="commonForm" method="post">
			<table class="tableForm">
				<tr>
					<th>ID</th>
					<td><input name="id" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>活动名称</th>
					<td>
						<input name="name" class="easyui-textbox" type="text" data-options="required:true" />
					</td>
				</tr>
				<tr>
					<th>开始时间</th>
					<td><input name="actStartDate" class="easyui-datetimebox" type="text" data-options="required:true"/></td>
				</tr>
				<tr>
					<th>结束时间</th>
					<td><input name="actEndDate" class="easyui-datetimebox" type="text" data-options="required:true"/></td>
				</tr>
				<tr>
					<th>来源于</th>
					<td>
						<input name="source" class="easyui-textbox" type="text" data-options="required:true" />
					</td>
				</tr>
				<tr>
					<th>会员类型</th>
					<td>
						<input name="userType" class="easyui-textbox" type="text" data-options="required:true" />
					</td>
				</tr>
				<tr>
					<th>允许可叠加</th>
					<td>
						<select id="cc" name="superPosition">
							<option value="0">不允许叠加</option>
							<option value="1">允许叠加</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>目标市场</th>
					<td>
						<select id="cc" class="easyui-combobox" name="targetMarket">
							<option value="1">珠海</option>
							<option value="2">广州</option>
						</select>
						活动封面图片
						<input type="file" name="actCover">
					</td>
				</tr>
				<tr>
					<th>活动类型</th>
					<td>
						<select id="actType" class="easyui-combobox" name="actType">
							<option value="搭配减价">搭配减价</option>
							<option value="专享特价">专享特价</option>
							<option value="优惠券">优惠券</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>搭配件数</th>
					<td><input class="easyui-numberbox" precision="0" name="groupQty"></input>件
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>