<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript">
	var datagrid;
	var meetDialog;
	var meetForm;
	var passwordInput;
	
	var belong = '${belong}';
// 	alert(belong);
	var siyu=false,sihui=false;
	if(belong == "siyu"){
		sihui = true;
	}else if(belong == "sihui"){
		siyu = true;
	}
	
	$(function() {
		meetForm = $("#meetForm").form();

		passwordInput = meetForm.find('[name=name]').validatebox({
			required : true
		});
		meetDialog = $('#meetDialog').show().dialog({
			modal : true,
			title : '验证码核销',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (meetForm.find('[name=id]').val() != '') {
						meetForm.form('submit', {
							url : '${pageContext.request.contextPath}/meeting.do?edit',
							success : function(data) {
								var d = $.parseJSON(data);
// 								alert(d.success);
								if (d.success) {
									meetDialog.dialog('close');
									$.messager.show({
										msg : '核销成功！',
										title : '提示'
									});
									datagrid.datagrid('reload');
								}else{
									$.messager.show({
										msg : '核销失败！',
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
			url : '${pageContext.request.contextPath}/meeting.do?datagrid',
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
			columns : [ [{
				field : 'codeNum',
				title : '验证码',
				width : 100,
				align : 'center',
			},{
				field : 'siyu',
				title : '丝域使用状态',
				width : 100,
				hidden: siyu,
				align : 'center',
				formatter:function(value,row,index){
					if(value=='1'){
						return "<font style='color:red;'>已使用</font>";
					}else if(value=='0'){
						return "<font style='color:green;'>未使用</font>";
					}
				}
			},{
				field : 'syUseTime',
				title : '使用时间',
				width : 100,
				hidden : siyu,
				align : 'center',
				formatter:formatterdate,
			}/* ,{
				field : 'syStaffOpenId',
				title : '核销员工',
				width : 100,
				hidden : siyu
			} */,{
				field : 'syShopId',
				title : '丝域核销门店',
				width : 100,
				align : 'center',
				hidden : siyu
			},{
				field : 'sihui',
				title : '丝荟使用状态',
				width : 100,
				align : 'center',
				hidden : sihui,
				formatter:function(value,row,index){
					if(value=='1'){
						return "<font style='color:red;'>已使用</font>";
					}else if(value=='0'){
						return "<font style='color:green;'>未使用</font>";
					}
				}
			},{
				field : 'shUseTime',
				title : '使用时间',
				width : 100,
				hidden : sihui,
				align : 'center',
				formatter:formatterdate,
			}/* ,{
				field : 'shStaffOpenId',
				title : '丝荟核销员工',
				width : 100,
				hidden : sihui
			} */,{
				field : 'shShopId',
				title : '丝荟核销门店',
				width : 100,
				align : 'center',
				hidden : sihui
			},{
				field : 'createTime',
				title : '创建时间',
				align : 'center',
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
// 			alert(rows[0].siyu+" **"+rows[0].sihui);
			if(belong == "siyu"){
				$("#sihuiTR").hide();
				if(rows[0].siyu == "1"){
					$.messager.show({
						msg : '该验证码已核销，不可操作！',
						title : '提示'
					}); 
					return;
				}
			}
			if(belong == "sihui"){
				$("#siyuTR").hide();
				if(rows[0].sihui == "1"){
					$.messager.show({
						msg : '该验证码已核销，不可操作！',
						title : '提示'
					}); 
					return;
				}
			}
			meetForm.find('[name=id]').attr('readonly', 'readonly');
			meetDialog.dialog('open');
			meetForm.form('clear');
			meetForm.form('load', {
				id : rows[0].id,
				codeNum : rows[0].codeNum,
			});
			if(belong == "siyu"){
				$("#siyu").val(1);
			}
			if(belong == "sihui"){
				$("#sihui").val(1);
			}
		}
	}

	//查找
	function searchFun() {
		datagrid.datagrid('load',
				{
			codeNum : $('#toolbar input[name=codeNum]').val()
				});
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
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
						<th>验证码</th>
						<td><input name="codeNum" id="codeNum"></td>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">核销</a><a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="meetDialog" style="display: none; overflow: hidden;width:250px;height:150px;">
		<form id="meetForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th>&nbsp;验证码：</th>
					<td><input name="codeNum" style="width: 130px;"class="easyui-validatebox" disabled="true"/></td>
				</tr>
			</table>
			<table id="siyuTR">
			    <tr>
					<th>使用状态：</th>
					<td><select name="siyu" id="siyu" style="width: 130px;" class="easyui-validatebox" required="true">
					      <option value="1">已使用</option>
					    </select>
					</td>
				</tr>
			</table>
			<table id="sihuiTR">
			    <tr>
					<th>使用状态：</th>
					<td><select name="sihui" id="sihui" style="width: 130px;" class="easyui-validatebox" required="true">
					      <option value="1">已使用</option>
					    </select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>