<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var awardDialog;
	var awardForm;
	var passwrodInput;
	$(function() {
		awardForm = $("#awardForm").form();

		passwordInput = awardForm.find('[name=name]').validatebox({
			required : true
		});
		awardDialog = $('#awardDialog').show().dialog({
			modal : true,
			title : '添加奖品',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (awardForm.find('[name=id]').val() != '') {
						awardForm.form('submit', {
							url : '${pageContext.request.contextPath}/award.do?edit',
							success : function(data) {
								awardDialog.dialog('close');
								$.messager.show({
									msg : '修改奖品成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else { 
						awardForm.form('submit', {
							url : '${pageContext.request.contextPath}/award.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										awardDialog.dialog('close');
										$.messager.show({
											msg : '添加奖品成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									awardDialog.dialog('close');
									$.messager.show({
										msg : '添加奖品失败！',
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
			url : '${pageContext.request.contextPath}/award.do?datagrid',
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
				field : 'grade',
				title : '奖品等级',
				width : 50,
			} ,{
				field : 'name',
				title : '奖品名称',
				width : 100,
			} ,{
				field : 'price',
				title : '价值',
				width : 50,
			} ,{
				field : 'content',
				title : '内容', 
				width : 300,
			} ,{
				field : 'photo',
				title : '照片',
				width : 100,
			} ,{
				field : 'drawOne',
				title : '抽一次中奖概率',
				width : 100,
			} ,{
				field : 'drawTen',
				title : '十连抽中奖概率',
				width : 100,
			} ,{
				field : 'usedBeginTime',
				title : '有效期开始时间',
				width : 100,
				formatter:formatterdate,
			} ,{
				field : 'usedEndTime',
				title : '有效期结束时间',
				width : 100,
				formatter:formatterdate,
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
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	function append() {
		awardDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		awardForm.find('[name=name]').removeAttr('readonly');
		awardForm.form('clear');
	}

	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length != 1 && rows.length != 0) {
			var names = [];
			for (var i = 0; i < rows.length; i++) {
				names.push(rows[i].name);
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
			awardForm.find('[name=id]').attr('readonly', 'readonly');
			awardDialog.dialog('open');
			awardForm.form('clear');
			awardForm.form('load', {
				id : rows[0].id,
				grade : rows[0].grade,
				name : rows[0].name,
				content : rows[0].content,
				price : rows[0].price,
				photo : rows[0].photo,
				drawOne : rows[0].drawOne,
				drawTen : rows[0].drawTen,
				usedBeginTime : rows[0].usedEndTime,
				usedEndTime : rows[0].usedEndTime,
				
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
						url : '${pageContext.request.contextPath}/award.do?del',  
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
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0)">增加</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">编辑</a><a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="awardDialog" style="display: none; overflow: hidden;width:400px;min-height:380px;">
		<form id="awardForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>奖品等级：</th>
					<td><select class="easyui-combobox" name="grade" style="width:200px;" required="true">
						    <option value="特等奖">特等奖</option>
						    <option value="一等奖">一等奖</option>
						    <option value="二等奖">二等奖</option>
						    <option value="三等奖">三等奖</option>
						    <option value="幸运奖">幸运奖</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>奖品名称：</th>
					<td><input name="name" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>价值：</th>
					<td><input name="price" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" /></td>
				</tr>
				<tr>
					<th>内容：</th>
					<td><textarea rows="5" cols="40" name="content" class="textarea easyui-validatebox"></textarea></td>
				</tr>
				<tr>
					<th>照片：</th>
					<td><textarea cols="40" rows="5" name="photo" class="textarea easyui-validatebox"></textarea></td>
				</tr>
				<tr>
					<th>抽一次中奖概率：</th>
					<td><input name="drawOne" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>十连抽中奖概率：</th>
					<td><input name="drawTen" style="width: 200px;"
						maxlength="30" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>有效期开始时间：</th>
					<td><input name="usedBeginTime" class="easyui-datetimebox"/></td>
				</tr>
				<tr>
					<th>有效期结束时间：</th>
					<td><input name="usedEndTime" class="easyui-datetimebox"/></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>