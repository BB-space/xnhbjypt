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
			url : '${pageContext.request.contextPath}/article.do?datagrid',
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
				field : 'theme',
				title : '文章主题',
				width : 200,
				align : 'center',
			}, {
				field : 'useState',
				title : '状态',
				width : 30,
				align : 'center',
				formatter:function(value,row,index){
					if(value=='1'){
						return "<font style='color:green;'>使用中</font>";
					}else if(value=='0'){
						return "<font style='color:red;'>未使用</font>";
					}
				}
			}, {
				field : 'createTimeStr',
				title : '创建时间',
				width : 80,
				align : 'center',
			}, {
				field : 'lastUpdateTimeStr',
				title : '修改时间',
				width : 80,
				align : 'center',
			}, {
				field : 'articleType',
				title : '类型',
				width: 30,
				align : 'center'
			},{
				field : 'savingsCardName',
				title : '活动卡券',
				width : 50,
				align : 'center'
			}, {
				field : 'hseq',
				title : 'h5顺序',
				width: 30,
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
					if (articleForm.find('[name=id]').val() != '') {
						articleForm.form('submit', {
							url : '${pageContext.request.contextPath}/article.do?edit',
							success : function(data) {
								try{
									var d = $.parseJSON(data);
									if (d.success) {
										articleDialog.dialog('close');
										$.messager.show({
											msg : '修改文章成功！',
											title : '提示'
										}); 
										datagrid.datagrid('reload');
									}else {
										articleDialog.dialog('close');
										$.messager.show({
											msg : '修改文章失败，请重试',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch(e) {
									articleDialog.dialog('close');
									$.messager.show({
										msg : '修改文章失败，请重试',
										title : '提示'
									});
									datagrid.datagrid('reload');
								}
							}
						});
					} else {
// 						alert($('#content').val());
// 						$('#content').val();
						var sci = articleForm.find('[name=savingsCardId]').val();
						if(sci==null){
							return false;
						}
						articleForm.form('submit', {
							url : '${pageContext.request.contextPath}/article.do?add',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
// 									alert(d.success);
									if (d.success) {
										articleDialog.dialog('close');
										$.messager.show({
											msg : '添加文章成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									articleDialog.dialog('close');
									$.messager.show({
										msg : '添加文章失败，请重试',
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
		
		$("#cc").combogrid({
			   panelWidth:220,
			   required:true,
			   editable:false,
			   idField:"id",
			   textField:"name",
			   url:"${pageContext.request.contextPath}/article.do?getCombogrid",
			   columns:[[  
			         {field:'id',title:'ID',width:250,hidden:true},
			         {field:'name',title:'卡项名称',width:100},  
			         {field:'buyMoney',title:'价格',width:100},  
			      ]]
			  });
		//省
		$.post('${pageContext.request.contextPath}/province.do?provinceList',{},function(data){
			var data = eval("(" + data + ")");
			var province = $("#province");
			province.empty();
			for ( var i = 0; i < data.length; i++) {
				province.append("<option value=" + data[i].id + ">"+ data[i].provinceName + "</option>");
			} 
		});
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
				theme : $('#articleForm input[name=theme]').val()
			});
	}
	
	function clearFun() {
		datagrid.datagrid('unselectAll');
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	
	function append() {
		document.getElementById("pic1").style.display = 'none';
		$("#pic1").attr("src", "");
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
			if(rows[0].shopId != ""){
				$.post("article.do?findShop",{"shopId":rows[0].shopId},function(data){
					var data = $.parseJSON(data);
// 					console.log(data);
					$("#province").val(data.obj.provinceId);
					cityId = data.obj.cityId;
					$.post("city.do?cityList",{"provinceId":data.obj.provinceId},callbackGetCity);
					$.post("shop.do?shopList",{"cityId":data.obj.cityId},callbackGetShop);
				});
			}
			articleDialog.dialog('open');
			articleForm.form('clear');
			articleForm.form('load', {
				id : rows[0].id,
				theme : rows[0].theme,
				content : rows[0].content,
				useState : rows[0].useState,
				shareTitle : rows[0].shareTitle,
				shareContent : rows[0].shareContent,
				sharePhoto : rows[0].sharePhoto,
				articleType : rows[0].articleType,
				hseq : rows[0].hseq,
				savingsCardId : rows[0].savingsCardId,
				shopId : rows[0].shopId
			});
			document.getElementById("pic1").style.display = 'block';
			$("#pic1").attr("src", rows[0].sharePhoto);
		}
	}
	
	function province1(){
		var province = $("#province").val();
		if(province != ""){
			$.post("city.do?cityList",{"provinceId":province},callbackCity);
		}
	}
	function city1(){
		var city = $("#city").val();
		if(city != ""){
			$.post("shop.do?shopList",{"cityId":city},callbackShop);
		}
	}
	//城市
	function callbackCity(data) {
		var data = eval("(" + data + ")");
		var city = $("#city");
		city.empty();
		for ( var i = 0; i < data.length; i++) {
		    city.append("<option value=" + data[i].id + ">"+ data[i].cityName + "</option>");
		}
	}
	function callbackGetCity(data) {
		var data = eval("(" + data + ")");
		var city = $("#city");
		city.empty();
// 		var rows = datagrid.datagrid('getSelections');
		for ( var i = 0; i < data.length; i++) {
		    if(data[i].id==cityId){
		    	city.append("<option value=" + data[i].id + " selected='selected' >"+ data[i].cityName + "</option>");
			 }else{
				 city.append("<option value=" + data[i].id + ">"+ data[i].cityName + "</option>");
			 }
		}
	}
	//门店
	function callbackShop(data) {
		var data = eval("(" + data + ")");
		var shop = $("#shop");
		shop.empty();
		for ( var i = 0; i < data.length; i++) {
			shop.append("<option value=" + data[i].id + ">"+ data[i].shopName + "</option>");
		}
	}
	function callbackGetShop(data) {
		var data = eval("(" + data + ")");
		var shop = $("#shop");
		shop.empty();
		var rows = datagrid.datagrid('getSelections');
		for ( var i = 0; i < data.length; i++) {
			 if(data[i].id==rows[0].shopId){
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
						url : '${pageContext.request.contextPath}/article.do?del',  
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
	function changePicUrl1( ) {
		var dFile = document.getElementById('file1');
		var dImg = document.getElementById('pic1');
		if (dFile.files) {
			document.getElementById("pic1").style.display = 'block';
			dImg.src = window.URL.createObjectURL(dFile.files[0]);
		} else if (dFile.value.indexOf('\\') > -1
			|| dFile.value.indexOf('\/') > -1) {
				dImg.src = dFile.value;
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
		<form id="articleForm" method="post" enctype="multipart/form-data">
			<table class="tableForm">
				<tr>
					<th class="th"></th>
					<td class="td"><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr>
					<th class="th">文章主题：</th>
					<td class="td"><input id="theme" name="theme" style="width:100%;"
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
					<th class="th">分享标题：</th>
					<td class="td"><input id="shareTitle" name="shareTitle" style="width:100%;" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th class="th">分享内容：</th>
					<td class="td">
						<textarea id="shareContent" name="shareContent" class="content" style="height:25px; width: 100%;">
						</textarea>
					</td>
				</tr>
				<tr>
					<th class="th">分享图片：</th>
					<td class="td">
						<input id="file1" type="file" name="files" onchange="changePicUrl1()">
						<img name="pic" id="pic1" alt="" src="" style="display:none; width: 50px; height: 50px;">
					</td>
				</tr>
				<tr>
				    <td colspan="2">
				        <span class="th2">&nbsp;文章类型：</span>
						<select id="articleType" name="articleType" style="width:80px;">
							  <option value="软文">软文</option>
							  <option value="h5">h5</option>
						</select>
						<span class="th2 left">状态：</span>
						<select id="useState" name="useState" style="width:80px;">
							  <option value="0" selected="selected">不使用</option>
							  <option value="1">使用</option>
						</select>
						 <span id="hshow" class="th2 left hhide">h5序号<input class="hseq" type="number" name="hseq" min="1" max="100" style="width:60px;" />
						 </span><span style="color:red">h5必填</span>
					</td>
				</tr> 
				<tr>
					<th class="th">活动项目：</th>
					<td class="td">
					    <select id="cc" name="savingsCardId">
						</select>
					</td>
				</tr>
				<tr>
					<th>省：</th> 
					<td><select name="provinceId" id="province" 
					 onchange="province1()" style="width: 130px"></select></td>
				</tr>
				<tr>
				    <th>城市：</th>
				    <td><select name="cityId" id="city" onchange="city1()"  
					 style="width: 130px"></select></td>
				</tr>
				<tr>
					<th>门店：</th>
					<td><select name="shopId" id="shop" style="width: 150px"></select></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>