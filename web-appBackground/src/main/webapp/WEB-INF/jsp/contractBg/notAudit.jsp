<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menunew.js" charset="UTF-8" type="text/javascript"></script>
<style type="text/css">
.auditBtn , .rejectBtn{ 
	padding:2px 12px;
	border-radius:10px;
	margin-left:10px;
	color:#FFF;
	border: 1px solid #5AABE7;
	text-decoration: none;
	z-index: 999;
}
.auditBtn{
	background-color: #5AABE7;
}
.rejectBtn{
	border: 1px solid #5AABE7;
	color:#5AABE7;
}
.viewBtn{
	color:#5AABE7;
	text-decoration: none;
}

/* .datagrid-row{
	height:30px !important;
} */
.tableForm{
	margin-top:10px;
	margin-bottom:10px;
	margin-left:10px;
}
.tableForm tr td{
	padding:0 5px;
}

#rejectDiv {
	 position:absolute;
	 left:338px;
	 top:91px;
	 width:520px;
	 height:280px;
	 z-index:999999;
	 box-shadow: 0 2px 16px #ccc, 0 0 1px #ccc, 0 0 1px #ccc;
	 background:#FFF; 
}
#rejectDiv p{
	font-weight: bold;
	text-align: center;
}
</style>
<script type="text/javascript" charset="UTF-8">
	var datagrid;
	var commonDialog;
	var commonForm;
	$(function() {
		$("#rejectDiv").hide();
		
		commonForm = $('#commonForm').form();
		commonDialog = $('#commonDialog').show().dialog({
			modal : true,
			title : '信息',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (commonForm.find('[name=id]').val() != '') {
						commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/queryMemberCard.do?editQueryCard',
							success : function(data) {
								commonDialog.dialog('close');
								var obj = jQuery.parseJSON(data);
								if(obj.success==true){
									$.messager.show({
										msg : '编辑成功！',
										title : '提示'
									});
								}else{
									$.messager.show({
										msg : '编辑失败！',
										title : '提示'
									});
								}
								datagrid.datagrid('reload');
							}
						});
					} else {
						/* commonForm.form('submit', {
							url : '${pageContext.request.contextPath}/queryMemberCard/add.do',
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
						}); */
					} 
				}
			} ]
		}).dialog('close');

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/contract.do?datagridNotAudit',
			toolbar : '#toolbar',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			queryParams : {username:'null'},
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
				hidden : true,
				checkbox : false
			},{
				field : 'createTime',
				title : '申请时间',
				width : 80,
				formatter : formatterdate
			} ] ],
			columns :[[{
				field : 'realname',
				title : '申请人姓名',
				width : 50,
				align : 'center'
			},{
				field : 'mobile',
				title : '手机号码',
				width : 50,
				align : 'center'
			},{
				field : 'userType',
				title : '申请身份',
				width : 50,
				align : 'center',
				formatter : function(value,row,index){
					if(value=='10'){
						return '店长';
					}else if(value=='13'){
						return '加盟商';
					}
				}
			},{
				field : 'shopName',
				title : '门店名称',
				width : 50,
				align : 'center'
			},{
				field : 'shopArea',
				title : '店铺区域',
				width : 50,
				align : 'center'
			},{
				field : 'a',
				title : '确认申请',
				width : 50,
				height: 30,
				align : 'center',
				formatter:function(value,row,index){
					var rs=null;
					console.log(row);
					if(row.auditStatus==0){
						rs= '<a class="auditBtn" href="javascript:void(0);" onclick="audit(\''+row.id+'\');"><span>通过</span></a>'
						+'<a class="rejectBtn" href="javascript:void(0);" onclick="reject(\''+row.id+'\',\''+row.auditFailNote+'\');"><span>拒绝</span></a>';
					}else if(row.auditStatus==1){
						rs="<img src='${pageContext.request.contextPath}/resources/css/login/img/c2.png' style=';width:14px;height:14px;vertical-align:middle'>"
						+"<a style='margin-left:6px;'><span>已通过</span></a>";
					}else if(row.auditStatus==2){
						rs="<img src='${pageContext.request.contextPath}/resources/css/login/img/c1.png' style=';width:14px;height:14px;vertical-align:middle'>"
							+"<a style='margin-left:6px;'><span>已拒绝</span></a>";
					}
					return rs;
				}
			},{
				field : 'b',
				title : '操作',
				width : 50,
				align : 'center',
				formatter:function(value,row,index){
					return '<p style="text-align:center"><a class="viewBtn" href="javascript:void(0)" onclick="viewDetail(\''+row.id+'\');">查看申请详情</a></p>';
				}
			}]]
		});

	});
	
	//设置显示时间
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()//+' '+date.getHours()//+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	function append() {
		commonForm.form('clear');
		commonDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
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
			$.post("city.do?cityList",{"provinceId":rows[0].provinceId},callbackCity);
			 
			$.post("shop.do?shopList",{"cityId":rows[0].cityId},callbackShop);
			commonForm.form('load', {
				id : rows[0].id,
				name : rows[0].name,
				shopName : rows[0].shopName,
				status : rows[0].status,
				deadlines : rows[0].deadlines,
				shopName : rows[0].shopName,
				provinceId :rows[0].provinceId,
				cityId : rows[0].cityId,
				username : rows[0].username,
				qctype : rows[0].qctype
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
						url : '${pageContext.request.contextPath}/queryMemberCard/del.do',
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
		var realname = $('#toolbar input[name=realname]').val();
		var shopName = $('#toolbar input[name=shopName]').val();
		if(realname!="" || shopName){
			datagrid.datagrid('load',{
				realname : $('#toolbar input[name=realname]').val(),
				shopName : $('#toolbar input[name=shopName]').val(),
			});
		}else{
			$.messager.alert('提示','请输入查询条件','error');
		}
	}
	function clearFun() {
		$('#toolbar input[name!="selbt"]').val('');
		datagrid.datagrid('load', {username:'null'});
	}
	function reloadFun(){
		datagrid.datagrid('reload');
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
	
	function audit(id){
		$.ajax({
			url : 'contract.do?audit',
			data : {
				id : id
			},
			cache : false,
			dataType : "json",
			success : function(response) {
				datagrid.datagrid('unselectAll');
				datagrid.datagrid('reload');
				$.messager.show({
					title : '提示',
					msg : '审核成功！'
				});
			}
		});
	}
	
	function reject(id,auditFailNote){
		$("#rejectDiv").show();
		$("#auditFailNote").val(auditFailNote);
		$("#cfmBtn").bind("click",function(){
			confirm(id);
        });
	}
	
	function viewDetail(id){
		window.location.href="contract.do?auditDetail&id="+id;
	}
	
	function confirm(id){
		var note = $("#auditFailNote").val();
		$.ajax({
			url : 'contract.do?reject',
			data : {
				id : id,
				auditFailNote : note
			},
			cache : false,
			dataType : "json",
			success : function(response) {
				datagrid.datagrid('unselectAll');
				datagrid.datagrid('reload');
				$.messager.show({
					title : '提示',
					msg : '审核成功！'
				});
				$("#rejectDiv").hide();
			}
		});
	}
	
	function cancel(id){
		$("#rejectDiv").hide();
	}
	
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<div id="toolbar" class="datagrid-toolbar"
			style="height: auto; display: none;">
			<!-- <fieldset>
				<legend>筛选</legend> -->
				<table class="tableForm">
					<tr>
						<td>员工姓名：</td>
						<td><input name="realname"/></td>
						<td>门店：</td>
						<td><input name="shopName"/></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchFun();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearFun();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			<!-- </fieldset> -->
			<div>
				<!-- <a class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">增加</a> --> <!-- <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除</a> -->
					<%-- <c:if test="${userM.roleId=='9a81adcf-7373-3d3b-911d-594edb7002b1' 
					|| userM.roleId=='8d4e66b7-fec7-5cce-8f32-ceea2058e974'}">
						<a class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
						plain="true" href="javascript:void(0);">编辑</a>
					</c:if>
					<a class="easyui-linkbutton" iconCls="icon-edit" onclick="reloadFun();"
					plain="true" href="javascript:void(0);">刷新</a> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a> --%>
			</div>
		</div>
		<table id="datagrid"></table>
	</div>

	<div id="commonDialog" style="display: none; overflow: hidden;">
		<form id="commonForm" method="post" enctype="multipart/form-data">
			<table class="tableForm">
				<input name="id" type="hidden" ly="readonly" />
				<input name="username" type="hidden" ly="readonly" />
				<input name="qctype" type="hidden" ly="readonly" />
				<tr>
					<th>卡券名称</th>
					<td>
						<input name="name" class="easyui-textbox" type="text" data-options="required:true" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>过期时间</th>
					<td>
						<input name="deadlines" class="easyui-datetimebox" type="text" data-options="required:true" />
					</td>
				</tr>
				<tr>
					<th>省份</th> 
					<td><select name="provinceId" id="province" 
					 onchange="province1()" style="width: 175px"></select></td>
				</tr>
				<tr>
					<th>城市</th> 
					<td><select name="cityId" id="city" onchange="city1()"  
					 style="width: 175px"></select></td>
				</tr>
				<tr>
					<th>核销门店</th>
					<td>
					<select id="shop" 
							name="shopId" style="width: 175px"></select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="rejectDiv">
		<p>请填写拒绝原因</p>
		<textarea id="auditFailNote" rows="8" cols="" style="resize:none;width:440px;text-align: left;margin-left:40px;padding:8px 4px;" 
			placeholder="请填写拒绝原因，可以说明哪些资料不符合等内容"></textarea>
		<div style="text-align: center;margin-top:30px;">
			<a class='auditBtn' href='javascript:void(0);' id="cfmBtn"><span>确认</span></a>  
			<a class='rejectBtn' href='javascript:void(0);' onclick='cancel();'><span>取消</span></a> 
		</div>
	</div>
</body>
</html>