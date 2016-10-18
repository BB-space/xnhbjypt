<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var shopDialog;
	var shopForm;
	var passwrodInput;
	
	$(function() {
		shopForm = $("#shopForm").form();

		passwordInput = shopForm.find('[name=name]').validatebox({
			required : true
		});
		shopDialog = $('#shopDialog').show().dialog({
			modal : true,
			title : '添加门店',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (shopForm.find('[name=id]').val() != '') {
						if(!checkData())return;
 						//alert("***"+shopForm.find('[name=id]').val());
						shopForm.form('submit', {
							url : '${pageContext.request.contextPath}/shop.do?edit',
							success : function(data) {
								shopDialog.dialog('close');
								$.messager.show({
									msg : '修改门店成功！',
									title : '提示'
								}); 
								datagrid.datagrid('reload');
							}
						});
					} else {
						if(!checkData())return;
                        $("#id").val($("#shopSeq").val());
						shopForm.form('submit', {
							url : '${pageContext.request.contextPath}/shop.do?addshop',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										shopDialog.dialog('close');
										$.messager.show({
											msg : '添加门店成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									shopDialog.dialog('close');
									$.messager.show({
										msg : '添加门店失败！',
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
			url : '${pageContext.request.contextPath}/shop.do?datagrid',
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
				field : 'shopName',
				title : '门店',
				width : 100,
			}, {
				field : 'provinceId',
				title : '省份',
				width : 100,
				hidden : true,
			}, {
				field : 'cityId',
				title : '城市',
				width : 100,
				hidden : true,
			}, {
				field : 'shortNumber',
				title : '短编码',
				width : 10,
				hidden : true,
			}, {
				field : 'phone',
				title : '电话',
				width : 100,
			}, {
				field : 'address',
				title : '地址',
				width : 200,
			/* }, {
				field : 'code',
				title : '二维码',
				width : 100, */
			},{
				field : 'shortName',
				title : '门店简称',
				width : 100,
			},{
				field : 'shopType',
				title : '门店类型',
				width : 100,
			},{
				field : 'cityName',
				title : '所属城市',
				width : 100,
			},{
				field : 'belong',
				title : '所属门店',
				width : 100,
			},{
				field : 'seq',
				title : '排序',
				width : 100,
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
		$("#QRCode").html(" ");
		$("#shopSeqTR").hide();
		shopDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		shopForm.find('[name=name]').removeAttr('readonly');
		shopForm.form('clear');
	}

	var click = 0;
	function edit() {
		click = 1;
		$("#QRCode").html(" ");
		$("#shopSeqTR").hide();
		var rows = datagrid.datagrid('getSelections');
		if (rows.length != 1 && rows.length != 0) {
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
			  $.post("city.do?cityList",{"provinceId":rows[0].provinceId},callbackCity);
			
			shopForm.find('[name=id]').attr('readonly', 'readonly');
			shopDialog.dialog('open');
			shopForm.form('clear');
			shopForm.form('load', { 
				id : rows[0].id,
				provinceId : rows[0].provinceId,   
				cityId : rows[0].cityId,
				subcenterId : rows[0].subcenterId, 
				shopName : rows[0].shopName,
				shortName : rows[0].shortName,
				shortNumber : rows[0].shortNumber,
				shopNumber : rows[0].shopNumber,
				phone : rows[0].phone,
				address : rows[0].address,
				code : rows[0].code,
				minimumEarlyWorking : rows[0].minimumEarlyWorking,
				minimumNightWorking : rows[0].minimumNightWorking,
				forDay : rows[0].forDay,
				holiday : rows[0].holiday,
				shopType :rows[0].shopType,
				seq : rows[0].seq,
				belong :rows[0].belong,
				isReserve :rows[0].isReserve,
				meiTuanId :rows[0].meiTuanId
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
						url : '${pageContext.request.contextPath}/shop.do?del',  
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
					shopName : $('#toolbar input[name=shopName]').val(),
					shopType : $('#toolbar input[name=shopType]').val(),
					cityName : $('#toolbar input[name=cityName]').val()
				});
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	
	function createQRCode() {
		var id = $("#id").val();
		$.post("${pageContext.request.contextPath}/shop.do?createQRCode&id="+id,null,function(data){
			var shopid = data.replace("\"","").replace("\"","");
			$("#QRCode").html('<img style="width:100px;height:100px;" src="${pageContext.request.contextPath}/resources/img/shop/'+shopid+'.png"/>');
			$("#shopid").val(shopid);
		});
	}
	
	function checkData(){
		var shopType = $("#shopType option:selected").text();
		if(shopType==""){
			 alert("请选择门店类型！");
			 return false;
		 }
		var province=$("#province").val();
		//var city=$("#city").val();
		var shopid=$("#shopid").val();
// 		alert(shopid);
		if(province==""||province==null){
			alert("请选择省份！");
			return false;
		}
		if(click == 0){
			if($("#shopType option:selected").text() == "加盟"){
				if($("#shopSeq").val() == ""){
					alert("请输入加盟门店编号！");
					return false;
				}
			}
		}
		if(shopid==""||shopid==null){
			alert("请点击生成二维码！");
			return false;
		}
		/* if(city=="" || city==null){
			alert("请选择城市！");
			return false;
		}
		 */
		return true;
	} 
	
	function change(){
		if($("#shopType option:selected").text() == "加盟"){
			$("#shopSeqTR").show();
		}else{
			$("#shopSeqTR").hide();
		}
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
						<th>门店名称</th>
						<td><input name="shopName"></td>
						<th>门店类型</th>
						<td><input name="shopType"></td>
						<th>城市</th>
						<td><input name="cityName"></td>
					</tr>
					<tr>
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

	<div id="shopDialog" style="display: none; overflow: hidden;">
		<form id="shopForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" id="id" readonly="readonly" type="hidden" /></td>
				</tr>
				<tr><td align="right" class="tdleft">省：</td> 
				<td><select name="provinceId" 
				 id="province" onchange="province1()" style="width: 200px"></select></td> </tr>
					<tr><td align="right" class="tdleft"> 市：</td> 
					<td><select name="cityId" id="city" 
					  style="width: 200px"></select></td>
					</tr>
					<tr><td align="right" class="tdleft">分中心：</td> 
					<td><select name="subcenterId" id="subcenter"  style="width: 200px"></select></td>
					
				</tr>
				<tr>
					<th>所属门店：</th>
					<td><select id="belong" class="easyui-combobox" name="belong" data-options="editable:false" 
							 style="width:200px;" required="true" >
							    <option value="丝域">丝域</option>
							    <option value="丝荟">丝荟</option>
							</select></td>
				</tr>
				<tr>
					<th>门店：</th>
					<td><input name="shopName" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" required="true" /></td>
				
					<th>门店简称：</th>
					<td><input name="shortName" style="width: 200px;" maxlength="30"
						class="easyui-validatebox"  /></td>
				</tr>
				<tr>
					<th>门店架构编码：</th>
					<td><input name="shopNumber" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" /></td>
						<th>门店短编码：</th>
					<td><input name="shortNumber" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" /></td>
				</tr>
				<tr>
					<th>序列号：</th>
					<td><input name="seq" style="width: 200px;" maxlength="30" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>门店电话：</th>
					<td><input name="phone" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" required="true" /></td>
				
					<th>门店地址：</th>
					<td><input name="address" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>门店类型：</th>
					<td>
						<select name="shopType" id="shopType" style="width: 200px;" maxlength="30" required="true" onchange="change()">
						   <option value="直营">直营</option>
					       <option value="加盟">加盟</option>
					    </select>
					</td>
					<th>开通预约：</th>
					<td>
						<select name="isReserve" id="isReserve" class="easyui-combobox" style="width: 200px;" maxlength="30" required="true">
						   <option value="1">开通</option>
					       <option value="0">不开通</option>
					    </select>
					</td>
				</tr>
				<tr id="shopSeqTR">
				    <th>加盟门店编号：</th>
					<td><input id="shopSeq" style="width:200px;" class="easyui-validatebox"/></td>
				</tr>
				 <tr>
					<th>门店最少上早班人数：</th>
					<td><input name="minimumEarlyWorking" style="width: 200px;" maxlength="30"
						class="easyui-validatebox"/></td>
				
					<th>门店最少上晚班人数：</th>
					<td><input name="minimumNightWorking" style="width: 200px;" maxlength="30"
						class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>早晚班循环天数：</th>
					<td><input name="forDay" style="width: 200px;" maxlength="30"
						class="easyui-validatebox"/></td>
				
					<th>每月员工休假天数：</th>
					<td><input name="holiday" style="width: 200px;" maxlength="30"
						class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>美团商户ID</th>
					<td><input name="meiTuanId" style="width: 200px;" maxlength="30"
						class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>二维码：</th>
					<td>
						<input type="button" value="生成二维码" onclick="createQRCode()" />
						<input name="shopid" id="shopid" readonly="readonly" type="hidden" />
						<span id="QRCode"></span>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>