<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/xheditor-1.2.2/xheditor-1.2.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/xheditor-1.2.2/xheditor_lang/zh-cn.js"></script>
<script type="text/javascript">
	var datagrid;
	var articleForm;
	var articleDialog;
	var passwordInput;
	$(function() {
		articleForm = $("#articleForm").form();
		
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/regInstruction.do?datagrid',
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
				width : 100,
				hidden : true,
			} ] ], 
			columns : [ [ {
				field : 'name',
				title : '协议名称',
				width : 200,
				align : 'center',
			}, {
				field : 'status',
				title : '状态',
				width : 30,
				align : 'center',
				formatter:function(value,row,index){
					if(value=='1'){
						return "<font style='color:green;'>右侧协议</font>";
					}else if(value=='0'){
						return "<font style='color:green;'>左侧协议</font>";
					}else{
						return "<font style='color:red;'>其他</font>";
					}
				}
			}, {
				field : 'creator',
				title : '创建人',
				width: 30,
				align : 'center'
			}, {
				field : 'createTimeStr',
				title : '创建时间',
				width : 80,
				align : 'center',
			}, {
				field : 'lastEditTimeStr',
				title : '修改时间',
				width : 80,
				align : 'center',
			}] ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
			onLoadError : function(args){
				alert("没有登录系统，或登录超时，请重新登录");
// 				window.top.location.href = '${pageContext.request.contextPath}/index.jsp';		
			}
		});
		articleDialog = $('#articleDialog').show().dialog({
			modal : true,
			title : '协议',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					$('#content').val();
					if (articleForm.find('[name=id]').val() != '') {
						articleForm.form('submit', {
							url : '${pageContext.request.contextPath}/regInstruction.do?edit',
							success : function(data) {
								try{
									var d = $.parseJSON(data);
									if (d.success) {
										articleDialog.dialog('close');
										$.messager.show({
											msg : '修改成功！',
											title : '提示'
										}); 
										datagrid.datagrid('reload');
									}else {
										articleDialog.dialog('close');
										$.messager.show({
											msg : '修改失败，请重试',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch(e) {
									articleDialog.dialog('close');
									$.messager.show({
										msg : '修改失败，请重试',
										title : '提示'
									});
									datagrid.datagrid('reload');
								}
							}
						});
					} else {
						articleForm.form('submit', {
							url : '${pageContext.request.contextPath}/regInstruction.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d.success) {
										articleDialog.dialog('close');
										$.messager.show({
											msg : '添加成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									articleDialog.dialog('close');
									$.messager.show({
										msg : '添加失败，请重试',
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
		
		$('#content').xheditor({
	        tools : 'full',
	        skin : 'default',
	        html5Upload : false,
	        upImgUrl : "${pageContext.request.contextPath}/uploadController.do?image",
	        upImgExt : "jpg,jpeg,png,gif"
	    });
	});
	
	//查找
	function searchFun() {
		datagrid.datagrid('unselectAll');
		datagrid.datagrid('load',
			{
				theme : $('#articleForm input[name=name]').val()
			});
	}
	
	function clearFun() {
		datagrid.datagrid('unselectAll');
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	
	function append() {
		articleDialog.dialog('open');
		articleForm.find('[name=name]').removeAttr('readonly');
		articleForm.form('clear');
		$("#content").val("");
	}
	var cityId;
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
			articleForm.find('[name=id]').attr('readonly', 'readonly');
			articleDialog.dialog('open');
			articleForm.form('clear');
			articleForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
				content : rows[0].content,
				status : rows[0].status
			});
			/* document.getElementById("pic1").style.display = 'block';
			$("#pic1").attr("src", rows[0].sharePhoto); */
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
						url : '${pageContext.request.contextPath}/regInstruction.do?del',  
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
<style type="text/css">
	.td{
		width:650px;
	}
	.th{
		width:10%;
	}
	.th2{
	    font-weight: bold;
	}
	.left{
	    margin-left:40px;
	}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
	
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
<!-- 			<fieldset style="border:1px groove #f0f0f0;background-color:#ffffff"> -->
<!-- 				<legend>筛选</legend> -->
<!-- 				<table class="tableForm"> -->
<!-- 					<tr> -->
<!-- 						<th>电话号码</th> -->
<!-- 						<td><input name="mobile"></td> -->
<!-- 						<td><a class="easyui-linkbutton" iconCls="icon-search" -->
<!-- 							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a -->
<!-- 							class="easyui-linkbutton" iconCls="icon-search" plain="true" -->
<!-- 							onclick="clearFun();" href="javascript:void(0);">清空</a></td> -->
<!-- 					</tr> -->
<!-- 				</table> -->
<!-- 			</fieldset> -->
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
	
	<div id="articleDialog" style="display: none; overflow: hidden;width:800px;height:600px;overflow:scroll;">
		<form id="articleForm" method="post">
			<table class="tableForm">
				<tr>
					<th class="th"></th>
					<td class="td"><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th class="th">文章主题：</th>
					<td class="td"><input id="name" name="name" style="width:100%;"
						maxlength="100" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th class="th">内容：</th>
					<td class="td">
						<textarea id="content" name="content" class="content" style="height:250px; width: 100%;">
						</textarea>
					</td>
				</tr>
				<tr>
					<th class="th">状态</th>
					<td class="td">
						<select id="status" name="status" style="width:80px;">
							  <option value="0" selected="selected">左侧协议</option>
							  <option value="1">右侧协议</option>
							  <option value="3">不显示协议</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>