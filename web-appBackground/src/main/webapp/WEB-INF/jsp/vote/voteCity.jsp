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
	var winningUserDialog;
	var winningUserForm;
	var rankDatagrid;
	$(function() {
		winningUserForm = $("#winningUserForm").form();

		passwordInput = winningUserForm.find('[name=name]').validatebox({
			required : true
		});
		winningUserDialog = $('#winningUserDialog').show().dialog({
			modal : true,
			height : 450,
			title : '添加活动区域',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (winningUserForm.find('[name=id]').val() != '') {
						winningUserForm.form('submit', {
							url : '${pageContext.request.contextPath}/voteCity.do?edit',
							success : function(data) {
								winningUserDialog.dialog('close');
								$.messager.show({
									msg : '修改成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else {
						winningUserForm.form('submit', {
							url : '${pageContext.request.contextPath}/voteCity.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d.success) {
										winningUserDialog.dialog('close');
										$.messager.show({
											msg : '添加活动区域成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}else {
										$.messager.show({title : '提示',msg : '您所添加的数据已经存在'});
									}
								} catch (e) {
									winningUserDialog.dialog('close');
									$.messager.show({
										msg : '添加活动区域失败！',
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
			url : '${pageContext.request.contextPath}/voteCity.do?datagrid',
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
			singleSelect : false,//单选 
			rownumbers : true,
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 50,
				hidden : true,
			} ] ],
			columns : [ [ {
				field : 'voteTypeId',
				title : 'voteTypeId',
				width : 50,
				hidden : true
			} ,{
				field : 'voteType',
				title : '活动名称',
				width : 100,
			} ,{
				field : 'cityId',
				title : 'cityId',
				width : 100,
				hidden : true
			} ,{
				field : 'cityName',
				title : '城市',
				width : 70,
			} ,{
				field : 'status',
				title : '开放',
				width : 100,
				formatter : function(value, rowData, rowIndex){
					if (value == '1') {
						return '显示';
					}else if (value == '0'){
						return '不显示';
					}
				}
			},{
				field : 'countVotes',
				title : '数量',
				width : 100,
			} ,{
				field : 'createDateTime',
				title : '创建时间',
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
		
		$("#voteTypeId").combobox({
			valueField: 'id',
	        textField: 'name',
	        url: 'voteCity.do?voteCityList',
	        onSelect: function(record){
	        }
		});

		rankDatagrid = $('#rankDatagrid').datagrid({
			url : '${pageContext.request.contextPath}/city.do?cityDatagrid',
			toolbar : '#toolbarCity',
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
			singleSelect : false,//单选 
			rownumbers : true,
			frozenColumns : [ [
   			{
   				title : '编号',
   				field : 'id',
   				hidden : true
   			} ] ],
   			columns : [ [{
   				field : 'cityName',
   				title : '城市',
   				width : 100
   			},{
				field : 'operate',
				title : '操作',
				width : 100,
				formatter:formatterfunction,
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
	function formatterfunction(val,row,index){
		var str = '<input type="submit" value="确定" onclick="selectCity()">';
		return str;
	}
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' 
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	function append() {
		winningUserDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		winningUserForm.find('[name=name]').removeAttr('readonly');
		$('#rankDatagrid').datagrid();
	}

	//第二个框选中城市
	function selectCity(){
		var rows = rankDatagrid.datagrid('getSelections');
		if (rows.length == 0){
			$.messager.show({
				msg : '请选择一条数据后，再点击【确定】按钮',
				title : '提示'
			});
		}else if (rows.length != 1 && rows.length != 0) {
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
			winningUserForm.form('load', {
				cityId : rows[0].id,
				cityName :rows[0].cityName,
				countVotes : 0
			});
		}
	}
	//第一个框编辑
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
			winningUserForm.find('[name=id]').attr('readonly', 'readonly');
			winningUserDialog.dialog('open');
			winningUserForm.form('clear');
			winningUserForm.form('load', {
				id : rows[0].id,
				cityId : rows[0].cityId,
				cityName : rows[0].cityName,
				countVotes : rows[0].countVotes,
				voteTypeId : rows[0].voteTypeId,
				voteType : rows[0].voteType
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
						url : '${pageContext.request.contextPath}/voteCity.do?del',  
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
	
	//主框查找
	function searchFun(){
		datagrid.datagrid('load',
				{
			voteTypeId : $('#toolbar input[name=voteTypeId]').val()
				});
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	//副框查找
	function searchCity(){
		rankDatagrid.datagrid('load',
				{
			        cityName : $('#toolbarCity input[name=cityName]').val()
				});
	}
	function clearCity() {
		$('#toolbarCity input').val('');
		rankDatagrid.datagrid('load', {});
	}
	
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<th>活动：</th>
					    <td><select name="voteTypeId" id="voteTypeId" class="easyui-combobox" data-options="editable:false" style="width:150px;"></select></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0)">增加</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">编辑</a> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="winningUserDialog" style="display: none; overflow: hidden;width:430px;">
		<form id="winningUserForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input id="id" name="id" type="hidden" /></td>
				</tr>
				<tr>
				    <th>活动：</th>
					<td><select name="voteTypeId" id="voteTypeId" required="true" class="easyui-combobox" data-options="editable:false" style="width:100px;"></select></td>
					<th></th>
					<td><input id="cityId" name="cityId" type="hidden"/></td>
					<th>城市：</th>
					<td><input name="cityName" id="cityName" readonly="readonly" class="easyui-validatebox" required="true" style="width:80px;"/></td>
					<th>奖品数量：</th>
					<td><input name="countVotes" id="countVotes" class="easyui-validatebox" required="true" style="width:50px;"/></td>
				</tr>
			</table>
		</form>
		<div id="toolbarCity" class="datagrid-toolbar" style="height: auto;">
		    <fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<th>城市名</th>
						<td><input name="cityName"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchCity();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearCity();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="rankDatagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
			<table id="rankDatagrid" height="100%"></table>
	</div>
</body>
</html>