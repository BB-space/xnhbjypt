<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>


<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var userDialog;
	var userForm;
	var passwordInput;
	var userRoleDialog;
	var userRoleForm;
	
	$(function() {

		userForm = $('#userForm').form();

		passwordInput = userForm.find('[name=password]').validatebox({
			required : true
		});

// 		$('[name=roleId]').combotree({
// 			url : '${pageContext.request.contextPath}/role/tree.do',
// 			animate : false,
// 			lines : !sy.isLessThanIe8(),
// 			checkbox : true,
// 			multiple : true,
// 			onLoadSuccess : function(node, data) {
// 				var t = $(this);
// 				if (data) {
// 					$(data).each(function(index, d) {
// 						if (this.state == 'closed') {
// 							t.tree('expandAll');
// 						}
// 					});
// 				}
// 			}
// 		});

// 		userRoleDialog = $('#userRoleDialog').show().dialog({
// 			modal : true,
// 			title : '批量编辑用户角色',
// 			buttons : [ {
// 				text : '编辑',
// 				handler : function() {
// 					userRoleForm.submit();
// 				}
// 			} ]
// 		}).dialog('close');

// 		userRoleForm = $('#userRoleForm').form({
// 			url : '${pageContext.request.contextPath}/member.do?editUsersRole',
// 			success : function(data) {
// 				var d = $.parseJSON(data);
// 				if (d) {
// 					userRoleDialog.dialog('close');
// 					$.messager.show({
// 						msg : '批量修改用户角色成功！',
// 						title : '提示'
// 					});
// 					datagrid.datagrid('reload');
// 				}
// 			}
// 		});

		userDialog = $('#userDialog').show().dialog({
			modal : true,
			title : '客服信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (userForm.find('[name=id]').val() != '') {
						//if(!checkDatas())return;
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/customer.do?edit',
							success : function(data) {
								userDialog.dialog('close');
								$.messager.show({
									msg : '客服编辑成功！',
									title : '提示'
								});
								datagrid.datagrid('reload');
							}
						});
					} else {
						//if(!checkData()) return;
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/customer.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d.obj=="3") {
										userDialog.dialog('close');
										$.messager.show({
											msg : '客服创建成功！',
											title : '提示',
										});
										datagrid.datagrid('reload');
									}else if (d.obj=="1") {
										$.messager.show({
											msg : '用户名已存在！',
											title : '提示',
										});
									}else if (d.obj=="2") {
										$.messager.show({
											msg : '输入的电话号码已存在！',
											title : '提示'
									});
									}
								} catch (e) {
									$.messager.show({
										msg : '客服名称已存在！',
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
			url : '${pageContext.request.contextPath}/customer.do?datagrid',
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
				checkbox : true
			}, {
				field : 'userName',
				title : '客服名',
				width : 100,
				sortable : true
			} ] ],
			columns : [ [ {
				field : 'password',
				title : '密码',
				width : 100,
				hidden : true
			},{
				field : 'realname',
				title : '真实姓名',
				width : 100,
				sortable : true
			},{
				field : 'userLevel',
				title : '会员等级',
				width : 100,
				sortable : true
			/* }, {
				field : 'position',
				title : '职务',
				width : 100,
				sortable : true */
			},{
				field : 'nowCoin',
				title : '当前拥有金币',
				width : 100,
				sortable : true
			}, {
				field : 'totalCoin',
				title : '总金币',
				width : 100,
				sortable : true
			}, {
				field : 'mobile',
				title : '手机',
				width : 100,
				sortable : true
			},{
				field : 'address',
				title : '地址',
				width : 100,
				sortable : true
			}, {
				field : 'experience',
				title : '经验值',
				width : 100,
				sortable : true
			},{
				field : 'shopName',
				title : '门店',
				width : 100,
				sortable : true
			}, {
				field : 'totalCoin',
				title : '总金币',
				width : 100,
				sortable : true
			},{
				field : 'avatar',
				title : '图片',
				width : 100,
				formatter:function(value,row,index){
					return '<img src="'+value+'" style=" width: 50px; height: 50px;"/>';
				}
			} ] ],
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

	function append() {
		userDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		userForm.find('[name=name]').removeAttr('readonly');
		userForm.form('clear');
	}

	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length != 1 && rows.length != 0) {
			var names = [];
			for (var i = 0; i < rows.length; i++) {
				names.push(rows[i].name);
			}
			$.messager.show({
				msg : '只能择一个用户进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '个用户',
				title : '提示'
			});
		} else if (rows.length == 1) {
			document.getElementById("pic").style.display = 'block';
			passwordInput.validatebox({
				required : false
			});
			userForm.find('[name=name]').attr('readonly', 'readonly');
			userDialog.dialog('open');
			userForm.form('clear');
			$("#pic").attr("src",rows[0].avatar);
			$("#avatar").val(rows[0].avatar);
			//alert(rows[0].province+'*'+rows[0].city+'*'+rows[0].store+'*'+rows[0].createdatetime+'*'+rows[0].type);
			userForm.form('load', {
				userName : rows[0].userName,
				id : rows[0].id,
				position : rows[0].position,
				idCard : rows[0].idCard,
				realname : rows[0].realname,
				shopId : rows[0].shopId,
				mobile : rows[0].mobile,
				email : rows[0].email,
				oldShopId : rows[0].oldShopId,
				sex : rows[0].sex,
				address : rows[0].address,
				qq : rows[0].qq,
				pic : rows[0].avatar,
			});
		}
	}
	
// 	function editRole() {
// 		var ids = [];
// 		var rows = datagrid.datagrid('getSelections');
// 		if (rows.length > 0) {
// 			for (var i = 0; i < rows.length; i++) {
// 				ids.push(rows[i].id);
// 			}
// 			userRoleForm.find('input[name=userIds]').val(ids.join(','));
// 			userRoleDialog.dialog('open');
// 		} else {
// 			$.messager.alert('提示', '请选择要编辑的记录！', 'error');
// 		}
// 	}

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
						url : '${pageContext.request.contextPath}/staff.do?del',
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
		datagrid.datagrid('load',
				{
					userName : $('#toolbar input[name=userName]').val(),
					shopId : $('#toolbar input[name=shopId]').val(),
					position : $('#toolbar input[name=position]').val()

				});
	}
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	
	function changePicUrl( ) {
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
	
	//添加时，检查数据格式是否正确
	function checkData(){
		var sex=$("input[name='sex']:checked").val();
		var userPassword=$("#userPassword").val();
		var email=$("#email").val();
		var pattern = /\b(^['_A-Za-z0-9-]+(\.['_A-Za-z0-9-]+)*@([A-Za-z0-9-])+(\.[A-Za-z0-9-]+)*((\.[A-Za-z0-9]{2,})|(\.[A-Za-z0-9]{2,}\.[A-Za-z0-9]{2,}))$)\b/;
		var idCard=$("#idCard").val();
		var card=/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
		var mobile=$("#mobile").val();
		var phone=/^1[3|4|5|8][0-9]\d{4,8}$/;
		var qq=$("#qq").val();
		var qqNumber=/^\d{5,11}$/;
		//alert(idCard);
		if(userPassword==""||userPassword==null){
			alert("密码不能为空！");
			return false;
		}
		if(idCard=="" || idCard==null){
			alert("身份证号不能为空！");
			return false;
		}
		if(!card.test(idCard)){
			alert("身份证格式不正确！");
			return false;
		}
		if(sex==""||sex==null){
			alert("请选择性别！");
			return false;
		}
		if(mobile=="" || mobile==null){
			alert("手机号不能为空！");
			return false;
		}
		if(!phone.test(mobile)){
			alert("手机号格式不正确！");
			return false;
		}
		if(email=="" || email==null){
			alert("邮箱不能为空！");
			return false;
		}
		if(!pattern.test(email)){
			alert("邮箱格式不正确！");
			return false;
		}
		if(qq=="" || qq==null){
			alert("qq号不能为空！");
			return false;
		}
		if(!qqNumber.test(qq)){
			alert("qq号的格式不正确！");
			return false;
		}
		return true;
	}
	
	//编辑时，检查数据格式是否正确
	function checkDatas(){
		var sex=$("input[name='sex']:checked").val();
		var email=$("#email").val();
		var pattern = /\b(^['_A-Za-z0-9-]+(\.['_A-Za-z0-9-]+)*@([A-Za-z0-9-])+(\.[A-Za-z0-9-]+)*((\.[A-Za-z0-9]{2,})|(\.[A-Za-z0-9]{2,}\.[A-Za-z0-9]{2,}))$)\b/;
		var idCard=$("#idCard").val();
		var card=/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
		var mobile=$("#mobile").val();
		var phone=/^1[3|4|5|8][0-9]\d{4,8}$/;
		var qq=$("#qq").val();
		var qqNumber=/^\d{5,11}$/;
		//alert(idCard);
		if(idCard=="" || idCard==null){
			alert("身份证号不能为空！");
			return false;
		}
		if(!card.test(idCard)){
			alert("身份证格式不正确！");
			return false;
		}
		if(sex==""||sex==null){
			alert("请选择性别！");
			return false;
		}
		if(mobile=="" || mobile==null){
			alert("手机号不能为空！");
			return false;
		}
		if(!phone.test(mobile)){
			alert("手机号格式不正确！");
			return false;
		}
		if(email=="" || email==null){
			alert("邮箱不能为空！");
			return false;
		}
		if(!pattern.test(email)){
			alert("邮箱格式不正确！");
			return false;
		}
		if(qq=="" || qq==null){
			alert("qq号不能为空！");
			return false;
		}
		if(!qqNumber.test(qq)){
			alert("qq号的格式不正确！");
			return false;
		}
		return true;
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
						<th>客服名</th>
						<td><input name="userName"></td>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">增加</a> <!-- <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> --> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="userDialog" style="display: none; overflow: hidden;width:350px">
		<form id="userForm" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden"/></td>
				</tr>
				<tr>
					<th>客服名</th>
					<td><input name="userName" class="easyui-validatebox"
						required="true" /></td>
				</tr>
				<tr title="如果不更改密码,请留空!">
					<th>登录密码</th>
					<td><input name="userPassword" id="userPassword" type="password" /></td>
				</tr>
				<!-- <tr>
					<th>职务</th>
					<td><input name="position" /></td>
				</tr> -->
				<tr>
					<th>身份证</th>
					<td><input name="idCard" id="idCard"/></td>
				</tr>
				<tr>
					<th>真实姓名</th>
					<td><input name="realname" /></td>
				</tr>
				<tr>
					<th>性别</th>
					<td><input type="radio" name="sex" value="男" checked="checked"/>男
						<input type="radio" name="sex" value="女"/>女
					</td>
				</tr>
				<tr>
					<th>门店ID</th>
					<td><select id="shopId" class="easyui-combobox"  
							name="shopId"  
							data-options="  
							url:'${pageContext.request.contextPath}/shop.do?getTestAll',  
 							required:true, 
 							valueField:'id', 
							width :'155px', 
							textField:'shopName'">  
							</select></td>
				</tr>
				<tr>
					<th>手机</th>
					<td><input name="mobile" id="mobile" class="easyui-validatebox"
						required="true"/></td>
				</tr>
				<tr>
					<th>邮箱</th>
					<td><input name="email" id="email"/></td>
				</tr>
<!-- 				<tr> -->
<!-- 					<th>以前所在门店</th> -->
<!-- 					<td><input name="oldShopId"  /></td> -->
<!-- 				</tr> -->
				<tr>
					<th>地址</th>
					<td><input name="address" /></td>
				</tr>
				<tr>
					<th>QQ</th>
					<td><input name="qq" id="qq"/></td>
				</tr>
				<tr>
					<th>照片</th>
					<td>
						<input id="file" type="file" name="files" onchange="changePicUrl()">
						<input type="hidden" name="avatar" id="avatar">
						<img name="pic" id="pic" alt="" src=""
						style="display:none; width: 50px; height: 50px;">
					</td>
				</tr>
			</table>
		</form>
	</div>

	

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="append();" iconCls="icon-add">增加</div>
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>
</body>
</html>