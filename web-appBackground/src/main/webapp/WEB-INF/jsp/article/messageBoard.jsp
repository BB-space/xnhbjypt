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
			url : '${pageContext.request.contextPath}/messageBoard.do?datagrid',
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
				width : 50,
				hidden : true,
			} ] ], 
			columns : [ [ {
				field : 'topic',
				title : '主题',
				width : 50,
				align : 'cneter'
			},{
				field : 'nickname',
				title : '留言用户',
				width : 50,
				align : 'center',
			}, {
				field : 'content',
				title : '内容',
				width : 100,
				align : 'center'
			}, {
				field : 'status',
				title : '状态',
				width : 50,
				align : 'center',
				formatter:function(value,row,index){
					if(value=='1'){
						return "<font style='color:green;'>已审核</font>";
					}else if(value=='0'){
						return "<font style='color:red;'>未审核</font>";
					}else if(value=='2'){
						return "<font style='color:red;'>审核未通过</font>";
					}
				} 
			},{
				field : 'createDatetime',
				title : '创建时间',
				width : 50,
				align : 'center',
				formatter : function(value){
					return formatDate(value);
				}
			},{
				field : 'auditDatetime',
				title : '审核时间',
				width : 50,
				align : 'center',
				formatter : function(value){
					return formatDate(value);
				}
			},{
				field : 'replyContent',
				title : '回复',
				width : 100,
				align : 'center'
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
			title : '文章',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					$('#content').val();
					$('#replyContent').val();
					if (articleForm.find('[name=id]').val() != '') {
						articleForm.form('submit', {
							url : '${pageContext.request.contextPath}/messageBoard.do?edit',
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
// 						alert($('#content').val());
// 						$('#content').val();
						articleForm.form('submit', {
							url : '${pageContext.request.contextPath}/messageBoard.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
// 									alert(d.success);
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
		
		$('.content').xheditor({
	        tools : 'Cut,Copy,Paste,Pastetext,|,Source,Fullscreen,About',
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
				topic : $('#articleForm input[name=topic]').val()
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
				fromOpenId : rows[0].fromOpenId,
				content : rows[0].content,
				status : rows[0].status,
				replyContent : rows[0].replyContent
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
						url : '${pageContext.request.contextPath}/messageBoard.do?del',  
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
	function formatDate(value){
		if(value!=null){
		var date = new Date(value);
		var y = 1900+date.getYear();
		var m = 1+date.getMonth();
		var d = date.getDate();
		var h = date.getHours();
		var min = date.getMinutes();
		var sec = date.getSeconds();
		var text=y+"-"+m+"-"+d+" "+h+":"+min+":"+sec;
		return text;
		}else {
			return null;
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
</style>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
	
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<!-- <fieldset style="border:1px groove #f0f0f0;background-color:#ffffff">
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<th>活动主题</th>
						<td><input name="topic"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset> -->
			<div>
				<!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
				plain="true" href="javascript:void(0)">增加</a> --> <a
				class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
				plain="true" href="javascript:void(0)">编辑</a><a
				class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
				plain="true" href="javascript:void(0)">删除</a> 
				<a class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
				plain="true" href="javascript:void(0)">审核</a><a
				class="easyui-linkbutton" iconCls="icon-undo"
				onclick="datagrid.datagrid('unselectAll');" plain="true"
				href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>
	
	<div id="articleDialog" style="display: none; overflow: hidden;width:800px;height:580px;">
		<form id="articleForm" method="post">
			<table class="tableForm">
				<tr>
					<th class="th"></th>
					<td class="td"><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th class="th">留言openId：</th>
					<td class="td"><input id="fromOpenId" name="fromOpenId" style="width:100%;"
						maxlength="100" class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th class="th">内容：</th>
					<td class="td">
						<textarea id="content" name="content" class="content" style="height:100px; width: 100%;">
						</textarea>
					</td>
				</tr>
				<tr>
					<th class="th">状态：</th>
					<td class="td">
						<select id="useState" name="status">
							<option value="0" selected="selected">未审核</option>
							<option value="1">已审核</option>
							<option value="2">审核未通过</option>
						</select>
					</td>
				</tr>
				<tr>
					<th class="th">回复内容：</th>
					<td class="td">
						<textarea id="replyContent" name="replyContent" class="content" style="height:100px; width: 100%;">
						</textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>