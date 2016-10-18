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
	$(function() {
		winningUserForm = $("#winningUserForm").form();

		passwordInput = winningUserForm.find('[name=name]').validatebox({
			required : true
		});
		winningUserDialog = $('#winningUserDialog').show().dialog({
			modal : true,
			height : 450,
			title : '添加中奖用户',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if($('#prizeSettingId').combobox('getValue') == ''){
						$.messager.show({title : '提示',msg : '奖项不可为空！'});
						return;
					}
					
					var from = $('#from').val();
					var to = $('#to').val();
					
					if(from == ''){
						$.messager.show({title : '提示',msg : '开始名次不可为空！'});
						return;
					}
					if(to == ''){
						$.messager.show({title : '提示',msg : '结束名次不可为空！'});
						return;
					}
					if(parseInt(from) > parseInt(to)){
						$.messager.show({title : '提示',msg : '开始名次不可以大于结束名次！'});
						return;
					}
					
					$.messager.confirm('温馨提示', '您确定要设置第'+ $('#from').val()+'名到第'+$('#to').val()+'名的奖品为'+
							$('#prizeSettingId').combobox('getText')+'？', function(r){
						if (r){ 
							$.messager.progress({title:'请等待',msg:'保存数据中...'});
							winningUserForm.form('submit', {
								url : '${pageContext.request.contextPath}/winningUser.do?add',
								success : function(data) {
									$.messager.progress('close');
									try {
										var d = $.parseJSON(data);
										if (d.success) {
											winningUserDialog.dialog('close');
											$.messager.show({
												msg : '赠送的券和推送消息已成功推送给用户！',
												title : '提示'
											});
											datagrid.datagrid('reload');
										}else {
											$.messager.show({title : '提示',msg : '您所添加的数据已经存在'});
										}
									} catch (e) {
										winningUserDialog.dialog('close');
										$.messager.show({
											msg : '添加中奖用户失败！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								}
							});
						}else { 
							
						}
					});
				}
			} ]
		}).dialog('close');
			
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/winningUser.do?winningUserDatagrid',
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
				field : 'rank',
				title : '排名',
				width : 50,
			} ,{
				field : 'nickName',
				title : '昵称',
				width : 100,
			} ,{
				field : 'score',
				title : '投票数',
				width : 100,
			} ,{
				field : 'mobile',
				title : '手机号码',
				width : 100,
			} ,{
				field : 'openId',
				title : 'openId',
				width : 100,
				hidden : true
			} ,{
				field : 'prizeName',
				title : '奖项',
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
		
		$("#prizeSettingId").combobox({
			valueField: 'id',
	        textField: 'prizeName',
	        url: 'prizeSetting.do?prizeSettingList',
	        onSelect: function(record){
	        }
		});

		$('#rankDatagrid').datagrid({
			url : '',
			title : '',
			iconCls : 'icon-save',
			fit :false,
			fitColumns : true,
			pagination : true,
			pageSize : 10,
			pageList : [ 10 ],
			nowrap : true, //设置为 true，则把数据显示在一行里。设置为 true 可提高加载性能
			border : false,
			idField : 'id',
			rownumbers : false,  
			singleSelect : true,
			scrollbarSize : 10,
			frozenColumns : [ [
   			{
   				title : '编号',
   				field : 'id',
   				hidden : true
   			} ] ],
   			columns : [ [{
   				field : 'rank',
   				title : '名次',
   				width : 40
   			},{
   				field : 'nickName',
   				title : '昵称',
   				width : 40
   			},{
   				field : 'score',
   				title : '投票数',
   				width : 40
   			},{
   				field : 'mobile',
   				title : '手机',
   				width : 50
   			}/* ,{
   				field : 'companyName',
   				title : '门店',
   				width : 120
   			} */] ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
			}
		}); 
		
		//监听分页事件
        pg = $("#rankDatagrid").datagrid("getPager"); 
		if(pg)  
		{  
		   $(pg).pagination({  
		       onBeforeRefresh:function(){  
		    	},  
		       onRefresh:function(pageNumber,pageSize){  
		    	   $('#rankDatagrid').datagrid('unselectAll');
		    	   getData(pageNumber);
		        },  
		       onChangePageSize:function(){  
		        },  
		       onSelectPage:function(pageNumber,pageSize){
			   	   $('#rankDatagrid').datagrid('unselectAll');
		    	   getData(pageNumber);
		    	  
			  }  
		   });  
		}
	});
	
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
		winningUserForm.form('clear');
		$('#rankDatagrid').datagrid('loadData',{total:0,rows:[]});
		
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
			winningUserForm.find('[name=id]').attr('readonly', 'readonly');
			winningUserDialog.dialog('open');
			winningUserForm.form('clear');
			winningUserForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
				price : rows[0].price,
				introduce : rows[0].introduce
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
						url : '${pageContext.request.contextPath}/winningUser.do?del',  
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
	
	//查找
	function searchFun(){
		
		var from = $('#from').val();
		var to = $('#to').val();
		
		if(from == ''){
			$.messager.show({title : '提示',msg : '开始名次不可为空！'});
			return;
		}
		if(to == ''){
			$.messager.show({title : '提示',msg : '结束名次不可为空！'});
			return;
		}
		
		if(parseInt(from) > parseInt(to)){
			$.messager.show({title : '提示',msg : '开始名次不可以大于结束名次！'});
			return;
		}
		getData(1);
	}
	
	function getData(page){
		$.messager.progress({title:'请等待',msg:'加载数据中...'});
		$.post('${pageContext.request.contextPath}/winningUser.do?rankDatagrid',  
			{'from' : $('#from').val(),
			 'to' : $('#to').val(),
			 'page' : page,
			 'rows' : 10},
		    function(data) {
				$.messager.progress('close');
			 	if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
		    		alert('没有登录系统，或登录超时，请重新登录');
		    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
		    		return;
		    	}
		    	var d = $.parseJSON(data);
		    	$('#rankDatagrid').datagrid('unselectAll');
		    	$('#rankDatagrid').datagrid('loadData',d);
    	}); 
	}
	
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0)">增加</a><!--  <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">编辑</a> --><a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="winningUserDialog" style="display: none; overflow: hidden;">
		<form id="winningUserForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input id="id" name="id" type="hidden" /></td>
				</tr>
				<tr>
					<th>设置奖项：</th>
					<td><select name="prizeSettingId" id="prizeSettingId" required="true" class="easyui-combobox" data-options="editable:false"
					  style="width: 210px"></select></td>
				</tr>
				<tr>
					<th>名次：</th>
					<td><input id="from" name="from" required="true" class="easyui-numberspinner" data-options="min:1">
						至:<input id="to" name="to" required="true" class="easyui-numberspinner" data-options="min:1"></td>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
						plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a></td>
				</tr>
			</table>
		</form>
			<table id="rankDatagrid" height="85%"></table>
	</div>
</body>
</html>