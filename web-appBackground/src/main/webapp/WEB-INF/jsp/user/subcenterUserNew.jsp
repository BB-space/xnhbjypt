<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menuUser.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var userDialog;
	var userForm;
	var passwordInput;
	
	/** 
	 * combobox和combotree模糊查询 
	 */  
	(function(){  
	    //combobox可编辑，自定义模糊查询  
	    $.fn.combobox.defaults.editable = true;  
	    $.fn.combobox.defaults.filter = function(q, row){  
	        var opts = $(this).combobox('options');  
	        return row[opts.textField].indexOf(q) >= 0;  
	    };  
	    //combotree可编辑，自定义模糊查询  
	    $.fn.combotree.defaults.editable = true;  
	    $.extend($.fn.combotree.defaults.keyHandler,{  
	        up:function(){  
	            console.log('up');  
	        },  
	        down:function(){  
	            console.log('down');  
	        },  
	        enter:function(){  
	            console.log('enter');  
	        },  
	        query:function(q){  
	            var t = $(this).combotree('tree');  
	            var nodes = t.tree('getChildren');  
	            for(var i=0; i<nodes.length; i++){  
	                var node = nodes[i];  
	                if (node.text.indexOf(q) >= 0){  
	                    $(node.target).show();  
	                } else {  
	                    $(node.target).hide();  
	                }  
	            }  
	            var opts = $(this).combotree('options');  
	            if (!opts.hasSetEvents){  
	                opts.hasSetEvents = true;  
	                var onShowPanel = opts.onShowPanel;  
	                opts.onShowPanel = function(){  
	                    var nodes = t.tree('getChildren');  
	                    for(var i=0; i<nodes.length; i++){  
	                        $(nodes[i].target).show();  
	                    }  
	                    onShowPanel.call(this);  
	                };  
	                $(this).combo('options').onShowPanel = opts.onShowPanel;  
	            }  
	        }  
	    });  
	})(jQuery);
	
	$(function() {

		userForm = $('#userForm').form();
		passwordInput = userForm.find('[name=password]').validatebox({
			required : true
		});

		$('[id=subcenterId]').combotree({
			url : '${pageContext.request.contextPath}/subcenter/tree.do',
			animate : false,
			lines : !sy.isLessThanIe8(),
			checkbox : true,
			multiple:true,
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
		
		//添加或编辑
		userDialog = $('#userDialog').show().dialog({
			modal : true,
			title : '会员信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					var subcenters = $('[id=subcenterId]').combotree('getValues');
					console.log("subcenters="+subcenters);
					if (userForm.find('[name=id]').val() != '') {
						/* if(!checkData())return; */
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/subcenterUser.do?edit&subcenters='+subcenters,
							success : function(data) {
								var d = $.parseJSON(data);
								if(d.success==true){
									userDialog.dialog('close');
									$.messager.show({
										msg : d.msg,
										title : '提示',
									});
									datagrid.datagrid('reload');
								}else{
									$.messager.show({
										msg : d.msg,
										title : '提示'
									});
								}
							}
						});
					} else {
						userForm.form('submit', {
							url : '${pageContext.request.contextPath}/subcenterUser.do?add&subcenters='+subcenters,
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										userDialog.dialog('close');
										$.messager.show({
											msg : '用户创建成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									
								}
							}
						});
					}
				}
			} ]
		}).dialog('close');

		//页面显示数据
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/subcenterUser.do?datagrid',
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
				title : '用户名',
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
				width : 50,
				sortable : true
			},{
				field : 'mobile',
				title : '手机',
				width : 100,
				sortable : true
			},{
				field : 'subcenter',
				title : '分管分中心',
				width : 400,
				sortable : true
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
			passwordInput.validatebox({
				required : false
			});
			
			
			$.post("city.do?cityList",{"provinceId":rows[0].provinceId},callbackCity);
			
			$.post("shop.do?shopList",{"cityId":rows[0].cityId},callbackShop);
			 
			userForm.find('[name=name]').attr('readonly', 'readonly');
			userDialog.dialog('open');
			userForm.form('clear');
			//alert(rows[0].provinceId+'*'+rows[0].cityId+'*'+rows[0].shopName);
			userForm.form('load', {
				userName : rows[0].userName,
				id : rows[0].id,
				realname : rows[0].realname,
				shopId : rows[0].shopId,
				mobile : rows[0].mobile
			});
		}
	}
	
	//城市
	function callbackCity(data) {
		var data = eval("(" + data + ")");
		var rows = datagrid.datagrid('getSelections');
		var city = $("#city");
		  city.empty();
		 for ( var i = 0; i < data.length; i++) {
			 //alert(data[i].cityName);
			 if(data[i].id==rows[0].cityId){
				 //alert(data[i].id+"**"+rows[0].cityId);
				 city.append("<option value=" + data[i].id + " selected='selected' >"+ data[i].cityName + "</option>");
			 }else{
				 city.append("<option value=" + data[i].id + ">"+ data[i].cityName + "</option>");
			 }
		  }
	}
	
	//门店
	function callbackShop(data) {
		var data = eval("(" + data + ")");
		var rows = datagrid.datagrid('getSelections');
		var shop = $("#shop");
		  shop.empty();
		 for ( var i = 0; i < data.length; i++) {
			 //alert(data[i].shopName);
			 if(data[i].id==rows[0].shopId){
				 //alert(data[i].id+"**"+rows[0].shopId);
				 shop.append("<option value=" + data[i].id + " selected='selected' >"+ data[i].shopName + "</option>");
			 }else{
				 shop.append("<option value=" + data[i].id + ">"+ data[i].shopName + "</option>");
			 }
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
						url : '${pageContext.request.contextPath}/member.do?del',
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
	function searchFun() {
		datagrid.datagrid('load',
				{
					userName : $('#toolbar input[name=userName]').val(),
					shopName : $('#toolbar input[name=shopName]').val(),
					position : $('#toolbar input[name=position]').val()
				});
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
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
						<th>用户名称</th>
						<td><input name="userName"></td>
					<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				 <!-- <a class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> -->
					<a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0)">增加</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="userDialog" style="display: none; overflow: hidden;width:350px;">
		<form id="userForm" method="post"  enctype="multipart/form-data">
			<table>
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden"/></td>
				</tr>
				<tr>
					<th>登录名称</th>
					<td><input id="userName" name="userName" class="easyui-validatebox"
						required="true" />
					</td>
				</tr>
				<tr title="如果不更改密码,请留空!">
					<th>登录密码</th>
					<td><input name="userPassword" type="password" /></td>
				</tr>
				<tr>
					<th>真实姓名</th>
					<td><input name="realname" /></td>
				</tr>
				<tr>
					<th>手机</th>
					<td><input name="mobile"  id="mobile" class="easyui-validatebox"
						required="true" /></td>
				</tr>
				<tr>
					<th>分管分中心</th>
					<td><input id="subcenterId" name="subcenterId" style="width: 156px;"></input></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>