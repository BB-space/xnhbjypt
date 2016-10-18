<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menunew.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
	var datagrid;
	var cardpayDialog;
	var cardpayForm;
	var passwrodInput;
	var openId;
	var belongShop;
	$(function() {
	
		$('#goodsItemId').dialog({
			title	: '',
			width	: 960,
			height	: 500,
			modal	: true,
			closed	: true,
			buttons : [{
				text :'确定',
				handler:function(){
					$("#goodsItemId").dialog('close');
					var row = $('#goodsItemDatagrid').datagrid('getSelected');
					$('input[name="cardName"]').val(row.name);	
					$('input[name="goodsItemId"]').val(row.id);		
				},
			},{
				text :'取消',
				handler :function(){
					$("#goodsItemId").dialog('close');
				}
			}]
		});
		$('#employeeId').dialog({
			title	: '',
			width	: 960,
			height	: 500,
			modal	: true,
			closed	: true,
			buttons : [{
				text :'确定',
				handler:function(){
					$("#employeeId").dialog('close');
					var row = $('#employeeDatagrid').datagrid('getSelected');
					console.log(row);
					$('input[name="employee"]').val(row.realname);	
					$('input[name="empId"]').val(row.id);//userinformation id	
				},
			},{
				text :'取消',
				handler :function(){
					$("#employeeId").dialog('close');
				}
			}]
		});
		
		$('#userCard_id').dialog({
			title	: '用户剩余可核销卡券列表',
			width	: 560,
			height	: 400,
			top : '0px',
			left : '150px',
			modal	: true,
			closed	: true
			/* buttons : [{
				text :'确定',
				handler:function(){
					var row = $('#userCarddatagrid').datagrid('getSelected');
					if(row == null){
						$.messager.show({title : '提示',msg : '请选择一张卡项！'});
			    		return;
					}					
					$("#userCard_id").dialog('close');
				},
			},{
				text :'取消',
				handler :function(){
					$("#userCard_id").dialog('close');
				}
			}]*/
		});
		
		cardpayForm = $("#cardpayForm").form();
		datagrid = $('#datagrid').datagrid({
			url : '',
			title : '',
			iconCls : 'icon-save',
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'goodsId',
			singleSelect : true,//单选 
		//	rownumbers : true,
			frozenColumns : [ [ {
				title : '物品编号',
				field : 'goodsId',
				width : 100,
				hidden : true,
			} ] ], 
			columns : [ [ {
				field : 'fldItemName1',
				title : '划卡项目',
				width : 100,
				align : 'center',
			}, {
				field : 'nurse',
				title : '护理师',
				width : 100,
				align : 'center',
			}, {
				field : 'hairStylist',
				title : '发型师',
				align : 'center',
				width : 100,
			}, {
				align : 'center',
				field : 'fldQty',
				title : '数量',
				width : 100,
				align : 'center',
			}, {
				field : 'fldUnitPrice',
				title : '单价',
				width : 100,
				align : 'center',
			}, {
				field : 'note',
				title : '备注',
				align : 'center',
				width : 100
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
		
		passwordInput = cardpayForm.find('[name=name]').validatebox({
			required : true
		});
	});
	
	//按手机查找可核销卡券
	function searchItem(){
		var searchMobile = $('input[name="searchMobile"]')[0].value;
		if(searchMobile==""){
			$.messager.show({title : '提示',msg : '请输入会员手机号！'});
			return ;
		}
		//getCardItem();
		$.ajax({
			url : '${pageContext.request.contextPath}/cardVerify.do?cardItemList',  
			data : {
				mobileNo : searchMobile,
			},
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				console.log(d);
				if(d.rows==null){
					$.messager.show({title : '提示',msg : '查找会员失败，请重新输入手机号'});
					$('input[name="itemgiveUseId"]').val('');	
					$('input[name="codeNumber"]').val('');	
					$('input[name="cardItemName"]').val('');	
					$('input[name="nowMoney"]').val('');	
					$('input[name="mobile"]').val('');	
					$('input[name="realname"]').val('');
					return ;
				}
				$('#userCard_id').dialog('open');
				$('#userCarddatagrid').datagrid({
					url : '',
					title : '',
					iconCls : 'icon-save',
					//fit : true,
					fitColumns : true,
					nowrap : false,
					border : false,
					idField : 'id',
					rownumbers : true,  
					singleSelect : true,
					frozenColumns : [ [
					{
						title : '编号',
						field : 'id',
						width : 50,
						hidden : true,
					} ] ],
					columns : [ [{
						field : 'itemName',
						width:200,
						title : '卡券名称',
						fit:true
					},{
						field : 'itemMoney',
						width:100,
						title : '卡券金额',
						fit:true,
					},{
						field : 'status',
						width:100,
						title : '卡券状态',
						fit:true,
						formatter:function(value,row,index){
							if(value==0){
								return "未核销"
							}
						}
					},{
						field : 'mobile',
						width : 150,
						title : '会员手机',
						fit : true
					},{
						field : 'deadlines',
						width : 200,
						title : '过期日期',
						fit : true
					}] ],
					onRowContextMenu : function(e, rowIndex, rowData) {
						e.preventDefault();
						$(this).datagrid('unselectAll');
						$(this).datagrid('selectRow', rowIndex);
					},
					onDblClickRow : function(index, row){
						$("#userCard_id").dialog('close');
						//$('input[name="codeNumber"]').val(d.obj.codeNumber);
						//console.log(row);
						$.ajax({
							url : '${pageContext.request.contextPath}/cardVerify.do?isGenerateUse',  
							data : {
								id : row.id,
							},
							cache : false,
							success : function(data) {
								var d = $.parseJSON(data);
								console.log(d);
								$('input[name="itemgiveUseId"]').val(d.obj.id);	
								$('input[name="codeNumber"]').val(d.obj.codeNumber);	
								$('input[name="cardItemName"]').val(d.obj.cardItemName);	
								$('input[name="nowMoney"]').val(d.obj.money);	
								$('input[name="mobile"]').val(d.obj.username);	
								$('input[name="realname"]').val(d.obj.realName);
							}
						})
					}
				});
			  	$('#userCarddatagrid').datagrid({
		        	data: d.rows
		        });
			}
		});
			
	}
	
	//查找卡券详情
	function searchItemgiveUse(){
		var codeNumber = $('input[name="codeNumber"]')[0].value;
		if(codeNumber==""){
			$.messager.show({title : '提示',msg : '请输入卡券编号！'});
			return ;
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/cardVerify.do?getSavingsItemgiveUse',  
			data : {
				codeNumber : codeNumber,
			},
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				console.log(d);
				if(d.msg=='RESULTONE'){
					$.messager.show({title : '提示',msg : '该卡券已使用过！'});
					//$('input[name="searchMobile"]').val('');	
					$('input[name="itemgiveUseId"]').val('');	
					//$('input[name="codeNumber"]').val('');	
					$('input[name="cardItemName"]').val('');	
					$('input[name="nowMoney"]').val('');	
					$('input[name="mobile"]').val('');	
					$('input[name="realname"]').val('');
				}else if(d.msg=="RESULTTWO"){
					$.messager.show({title : '提示',msg : '该卡券不存在！'});
					//$('input[name="searchMobile"]').val('');	
					$('input[name="itemgiveUseId"]').val('');	
					//$('input[name="codeNumber"]').val('');	
					$('input[name="cardItemName"]').val('');	
					$('input[name="nowMoney"]').val('');	
					$('input[name="mobile"]').val('');	
					$('input[name="realname"]').val('');
				}else if(d.msg=="RESULTFOUR"){
					$.messager.show({title : '提示',msg : '储金券暂不支持在后台核销！'});
					//$('input[name="searchMobile"]').val('');	
					$('input[name="itemgiveUseId"]').val('');	
					//$('input[name="codeNumber"]').val('');	
					$('input[name="cardItemName"]').val('');	
					$('input[name="nowMoney"]').val('');	
					$('input[name="mobile"]').val('');	
					$('input[name="realname"]').val('');
				}else if(d.msg=="RESULTTHREE"){
					$('input[name="itemgiveUseId"]').val(d.obj.id);	
					$('input[name="codeNumber"]').val(d.obj.codeNumber);	
					$('input[name="cardItemName"]').val(d.obj.cardItemName);	
					$('input[name="nowMoney"]').val(d.obj.money);	
					$('input[name="mobile"]').val(d.obj.username);	
					$('input[name="realname"]').val(d.obj.realName);
					$('input[name="searchMobile"]').val(d.obj.username);
				}
			},error:function(data){
				$.messager.alert({title : '提示',msg : '请重新输入二维码编号'});
			}
		});
	}

	//查找项目
	function selectItems(){
		$('#goodsItemId').dialog('open');
        $('#goodsItemDatagrid').datagrid({
			url : 'cardVerify.do?goodsItemList',
			toolbar : '',
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
			rownumbers : true,  
			singleSelect : true,
			frozenColumns : [ [
			{
				title : '编号',
				field : 'id',
				width : 50,
				hidden : true,
			} ] ],
			columns : [ [ {
				field : 'catName',
				title : '类别',
				width : 100,
				align : 'center',
			},{
				align : 'center',
				field : 'name',
				title : '划卡项目',
				width : 100,
				align : 'center',
			}, {
				field : 'price',
				title : '单价',
				width : 100,
				align : 'center',
			}] ],
		});
	}
	
	//选择员工
	function selectEmployee(){
		 var shopId = $("#shop").val();
		 $('#employeeId').dialog('open');
		 $('#employeeDatagrid').datagrid({
			url : 'cardVerify.do?erpList&type=1&shopId='+shopId,
			toolbar : '',
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
			rownumbers : true,  
			singleSelect : true,
			frozenColumns : [ [
			{
				title : '编号',
				field : 'id',
				width : 50,
				hidden : true,
			} ] ],
			columns : [ [ {
				field : 'shopName',
				title : '门店',
				width : 100,
				align : 'center',
			},{
				field : 'realname',
				title : '员工名字',
				width : 100,
				align : 'center',
			},{
				align : 'center',
				field : 'mobile',
				title : '手机',
				width : 100,
				align : 'center',
			}] ],
		});
	}

	//核销卡
	function chargeCardItem(){
		var itemgiveUseId = $("#itemgiveUseId").val();
		var selectGoodsItemId = $("#selectGoodsItemId").val();
		var empId = $("#empId").val();
		var cardItemName = $("#cardItemName").val();
		var nowMoney = $("#nowMoney").val();
		var shopId = $("#shop").val();
		if(shopId==""||empId==""){
			$.messager.show({title : '提示',msg : '未选择门店或员工'});
			return;
		}
		if(itemgiveUseId!=""&&empId!==""&&shopId!=""&&nowMoney!=""){
			$.ajax({
				url : '${pageContext.request.contextPath}/cardVerify.do?verifyCardItem',  
				data:{itemgiveUseId:itemgiveUseId,goodsId:selectGoodsItemId,empId:empId,type:'all',shopId:shopId},
				cache : false,
				success:function(data){
					var d = $.parseJSON(data);
					if(d.msg=='RESULTONE'){
						$.messager.show({title : '提示',msg : '卡券已过期，核销失败'});					
					}else if(d.msg=="RESULTTWO"){
						$.messager.show({title : '提示',msg : '核销成功'});
						$('input[name="cardItemName"]').val("");	
						$('input[name="nowMoney"]').val("");	
						$('input[name="mobile"]').val("");
						$('input[name="realname"]').val("");	
						$('input[name="cardName"]').val("");	
						$('input[name="employee"]').val("");
						$('input[name="provinceId"]').empty();
						$('input[name="cityId"]').empty();
						$('input[name="shopId"]').empty();
						$('input[name="empId"]').val("");
					}else if(d.msg=="RESULTTHREE"){
						$.messager.show({title : '提示',msg : '核销失败'});	
					}else if(d.msg=="RESULTFOUR"){
						$.messager.show({title : '提示',msg : '每人只能核销亲友券一次'});
					}else if(d.msg=="RESULTFIVE"){
						$.messager.show({title : '提示',msg : '该员工未绑定，无法完成核销操作'});
					}else if (d.msg=="RESULTSIX"){
						$.messager.show({title : '提示',msg : '请在微信上绑定会员后使用此券'});
					}
				}
			})
		}else{
			$.messager.show({title : '提示',msg : '核销信息不全！'});
		}
		
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<fieldset>
				<legend>筛选</legend>
				<input type="hidden" id="itemgiveUseId" name="itemgiveUseId" readonly="readonly"><!--  -->
				<input type="hidden" id="selectGoodsItemId" name="goodsItemId" readonly="readonly"><!-- 项目id -->
				<input type="hidden" id="empId" name="empId" readonly="readonly"><!-- 护理师id -->
				<table class="tableForm">
					<tr>
						<td>联系电话</td>
						<td><input id="searchMobile" name="searchMobile"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="searchItem();" href="javascript:void(0);">查找卡券</a></td>
						<td>(输入会员手机号选择可核销的卡券)</td>
						<td colspan="4"></td>
					</tr>
					<tr>
						<td>卡项编码</td>
						<td><input id="codeNumber" name="codeNumber"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="searchItemgiveUse();" href="javascript:void(0);">查找卡项</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" 
							onclick="chargeCardItem();">划卡</a></td>
						<td colspan="4"></td>
					</tr>
					<tr>
						<td>卡项名称</td>
						<td><input id="cardItemName" name="cardItemName" readonly="readonly" style="width:160px;"> 
						</td>
						<td>卡项余额</td>
						<td><input id="nowMoney" name="nowMoney" readonly="readonly"></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>联系电话</td>
						<td><input id="mobile" name="mobile" readonly="readonly"></td>
						<td>会员姓名</td>
						<td><input id="realname" name="realname" readonly="readonly"></td>
						<td>备注</td>
						<td><input id="note" name="note" maxlength="10" style="width:200px;"></td>
						<td colspan="3"></td>
					</tr>
					<tr>
						<td>项目名称</td>
						<td><input id="cardName" name="cardName" style="width:160px;">
							<a href="javascript:selectItems();" class="easyui-linkbutton">选择项目</a>
						</td>
						<td colspan="6"></td>
					</tr>
					<tr>
						<td>所属门店</td>
						<td colspan="5">
							<select name="provinceId" id="province" onchange="province1()" style="width: 155px"></select>
							<select name="cityId" id="city" onchange="city1()" style="width: 155px"></select>
							<select id="shop" name="shopId" style="width: 155px"></select>
							护理师
							<input id="employee" name="employee" readonly="readonly">
							<a href="javascript:selectEmployee();" class="easyui-linkbutton">选择员工</a>
						</td>
					</tr>
				</table>
			</fieldset>
<!-- 			<div> -->
<!-- 				 <a -->
<!-- 					class="easyui-linkbutton" iconCls="icon-add" onclick="add();" -->
<!-- 					plain="true" href="javascript:void(0)">新增划卡</a><a -->
<!-- 					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();" -->
<!-- 					plain="true" href="javascript:void(0)">修改卡项</a><a -->
<!-- 					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();" -->
<!-- 					plain="true" href="javascript:void(0)">删除卡项</a> <a -->
<!-- 					class="easyui-linkbutton" iconCls="icon-edit" -->
<!-- 					onclick="cardpay();" plain="true" -->
<!-- 					href="javascript:void(0)">卡项核销</a> -->
<!-- 			</div> -->
		</div>
<!-- 		<table id="datagrid"></table> -->
	</div>  

	<div id="cardpayDialog" style="display: none; overflow: hidden;">
		<form id="cardpayForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input id="id" name="id" type="hidden" /></td>
					<td><input id="goodsId" name="goodsId" type="hidden" /></td>
					<td><input id="rowIndex" name="rowIndex" type="hidden" /></td>
				</tr>
				<tr>
					<th>划卡项目：</th>
					<td><select id="goods" name="goods" class="easyui-combogrid" style="width:300px;" required="true"
							data-options="editable:false"></select></td>
				</tr>
				<tr>
					<th>单价：</th>
					<td><input id="fldUnitPrice" name="fldUnitPrice" style="width: 300px;"  
						maxlength="8" class="easyui-validatebox"  readonly="true"/></td>
				</tr>
				<tr>
					<th>数量：</th>
					<td><input id="fldQty" name="fldQty" style="width: 300px;" required="true"  
						class="easyui-numberspinner"  data-options="min:1,editable:false"/></td>
				</tr>
				<tr>
					<th>护理师：</th>
					<td><input id="nurse" name="nurse" style="width: 300px;" maxlength="30"
						class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>发型师：</th>
					<td><input id="hairStylist" name="hairStylist" style="width: 300px;" maxlength="30"
						class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>备注：</th>
					<td><input id="note" name="note" style="width: 300px;" maxlength="100"
						class="easyui-validatebox"/></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="member_id">
		<table id="memberdatagrid"></table>
	</div>
	<!-- 卡项 -->
	<div id="goodsItemId">
		<table id="goodsItemDatagrid"></table>
	</div>
	<!-- 护理师 -->
	<div id="employeeId">
		<table id="employeeDatagrid"></table>
	</div>
	<!-- 产品券，服务券 -->
	<div id="userCard_id">
		<table id="userCarddatagrid"></table>
	</div>
</body>
</html>