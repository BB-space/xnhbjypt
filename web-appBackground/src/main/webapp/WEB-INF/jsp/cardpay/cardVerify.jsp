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
				}else if(d.msg=="RESULTTWO"){
					$.messager.show({title : '提示',msg : '该卡券不存在！'});
				}else if(d.msg=="RESULTFOUR"){
					$.messager.show({title : '提示',msg : '储金券暂不支持在后台核销！'});
				}else if(d.msg=="RESULTTHREE"){
					$('input[name="itemgiveUseId"]').val(d.obj.id);	
					$('input[name="codeNumber"]').val(d.obj.codeNumber);	
					$('input[name="cardItemName"]').val(d.obj.cardItemName);	
					$('input[name="nowMoney"]').val(d.obj.money);	
					$('input[name="mobile"]').val(d.obj.username);	
					$('input[name="realname"]').val(d.obj.realName);	
				}
				
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
		 $('#employeeId').dialog('open');
        $('#employeeDatagrid').datagrid({
			url : 'cardVerify.do?erpList',
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
		if(goodsItemId==""){
			return;
		}
		if(itemgiveUseId!=""&&empId!=""&&nowMoney!=""){
			$.ajax({
				url : '${pageContext.request.contextPath}/cardVerify.do?verifyCardItem',  
				data:{itemgiveUseId:itemgiveUseId,goodsId:selectGoodsItemId,empId:empId},
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
						$('input[name="empId"]').val("");
					}else if(d.msg=="RESULTTHREE"){
						$.messager.show({title : '提示',msg : '核销失败'});	
					}else if(d.msg=="RESULTFOUR"){
						$.messager.show({title : '提示',msg : '每人只能核销亲友券一次'});
					}else if (d.msg=="RESULTFIVE"){
						$.messager.show({title : '提示',msg : '请在微信上绑定会员后使用此券'});
					}else if(d.msg=="RESULTSIX"){
						$.messager.show({title : '提示',msg : '本卡券只能在开卡门店使用'});
					}else if(d.msg=="RESULTSEVEN"){
						$.messager.show({title:'提示',msg : '亲，请您先核销储金券后即可享受本券福利哦！（小贴士：请到储金券核销门店使用本券）"'});
					}else if(d.msg=="RESULTEIGHT"){
						$.messager.show({title:'提示',msg : '本卡券只能在指定区域的规定门店中使用'});
					}else if(d.msg=="RESULTNIGHT"){
						$.messager.show({title:'提示',msg : '亲，您的储金券已经使用超额了，赶快送给好友吧~'});
					}else if(d.msg=="RESULTTEN"){
						$.messager.show({title:'提示',msg : '本卡券在赠送好友期间,您无法核销'});
					}else if(d.msg=="RESULTELEVEN"){
						$.messager.show({title:'提示',msg : '请重新选择员工核销，该员工还未在微信公众号绑定'});
					}
				}
			})
		}else{
			if(empId==""){
				$.messager.show({title : '提示',msg : '请选择员工！'});	
			}else if(selectGoodsItemId==""){
				$.messager.show({title : '提示',msg : '请选择项目！'});
			}else{
				$.messager.show({title : '提示',msg : '核销信息不全！'});
			}
			
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
						<td>项目名称</td>
						<td><input id="cardName" name="cardName" style="width:160px;" readonly="true">
							<a href="javascript:selectItems();" class="easyui-linkbutton">选择项目</a>
						</td>
						<td>护理师</td>
						<td><input id="employee" name="employee" readonly="true">
							<a href="javascript:selectEmployee();" class="easyui-linkbutton">选择员工</a>
						</td>
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
</body>
</html>