<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script type="text/javascript">
	var datagrid;
	var giftDatagrid;
	var giftDialog;
	
	$(function() {
		giftDialog = $('#giftDialog').show().dialog({
			modal : true,
			title : '查找会员红包记录',
			top : '0px',
			buttons : [ { 
				text : '关闭',
				handler : function() {
					giftDialog.dialog('close');
				}
			} ]
		}).dialog('close');
		
	});
	
	function searchFun() {
		var mobile = $("#mobile").val();
		var beginTime = $("#beginTime").datebox('getValue');
		var endTime = $("#endTime").datebox('getValue');
		var companyCode = $("#companyCode").val();
		var companyName = $("#companyName").val();
// 		alert(mobile+"**"+beginTime+"**"+endTime);
		if(mobile == "" && beginTime == "" && endTime =="" && companyCode == "" && companyName ==""){
			$.messager.show({title:"提示",msg:"请输入查找信息！"});
			return ;
		}
		$.messager.progress({title:'请等待',msg:'加载数据中...'});
		$.post("arrival.do?datagrid",{
			"mobile":mobile,
			"beginTime":beginTime,
			"endTime":endTime,
			"companyCode":companyCode,
			"companyName":companyName
			},function(data){
			data = $.parseJSON(data);
			$.messager.progress('close');
			datagrid = $("#datagrid").datagrid({
				url : '',
				toolbar : '#toolbarAll',
				title : '',
				iconCls : 'icon-save',
				pagination : false,
				pageSize : 10,
				pageList : [ 10, 20, 30, 40, 50],
				fit : true,
				fitColumns : true,
				nowrap : false,
				border : false,
				idField : 'id',
				singleSelect : true,//单选 
				rownumbers : true,
				columns : [ [ {
					field : 'companyCode',
					title : '门店编码',
					width : 80,
				},{
					field : 'companyName',
					title : '门店名称',
					width : 130,
				},{
					field : 'docNo',
					title : '单据编号',
					width : 100,
				},{
					field : 'docDate',
					title : '单据时间',
					width : 100,
					formatter:formatterdate,
				},{
					field : 'memberMobile',
					title : '会员电话',
					width : 80,
				},{
					field : 'memberNo',
					title : '会员编码',
					width : 80,
				},{
					field : 'memberName',
					title : '会员名',
					width : 80,
				},{
					field : 'employeeMobile',
					title : '员工电话',
					width : 80,
				},{
					field : 'employeeCode',
					title : '员工编号',
					width : 80,
				},{
					field : 'employeeName',
					title : '员工名',
					width : 80,
				},{
					field : 'item',
					title : '护理项目',
					width : 100,
				},{
					field : 'card',
					title : '支付方式',
					width : 80,
				},{
					field : 'isPush',
					title : '是否满足红包',
					width : 80,
				},{
					field : 'createdatetime',
					title : '单据创建时间',
					width : 80,
					formatter:formatterdate,
				}] ],
				onRowContextMenu : function(e, rowIndex, rowData) {
					e.preventDefault();
					$(this).datagrid('unselectAll');
					$(this).datagrid('selectRow', rowIndex);
				},
				onLoadError : function(args){
					alert("没有登录系统，或登录超时，请重新登录");
					window.top.location.href = '${pageContext.request.contextPath}/index.jsp';		
				}
			});
			$('#datagrid').datagrid('unselectAll');
			$("#datagrid").datagrid('loadData',data);
			$.messager.progress('close');
		});
	}

	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' 
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	//清除数据
	function clearFun() {
		$('#toolbar input').val('');
	}
	function clearGift() {
		$('#toolbarGift input').val('');
	}
	
	//点击查找红包按钮
	function findGift(){
		giftDialog.dialog('open');
	}
	//副框查找数据
	function searchGift(){
		var mobile = $("#mobile2").val();
// 		alert("mobile:"+mobile);
		if(mobile == ""){
			$.messager.show({title:"提示",msg:"请输入查找信息！"});
			return ;
		}
		$.messager.progress({title:'请等待',msg:'加载数据中...'});
		$.post("arrival.do?giftDatagrid",{
			"mobile":mobile
			},function(data){
			data = $.parseJSON(data);
			giftDatagrid = $("#giftDatagrid").datagrid({
				url : '',
				toolbar : '#toolbarGift',
				title : '',
				iconCls : 'icon-save',
				pagination : false,
				pageSize : 10,
				pageList : [ 10, 20, 30, 40, 50],
				fit : true,
				fitColumns : true,
				nowrap : false,
				border : false,
				idField : 'id',
				singleSelect : true,//单选 
				rownumbers : true,
				columns : [ [ {
					field : 'id',
					title : 'id',
					width : 50,
					hidden : true,
				},{
					field : 'userOpenId',
					title : 'userOpenId',
					width : 50,
					hidden : true,
				},{
					field : 'mobile',
					title : '会员号码',
					width : 100,
				},{
					field : 'prizeId',
					title : '奖品id',
					width : 80,
					hidden : true,
				},{
					field : 'prizeName',
					title : '奖品名',
					width : 80,
				},{
					field : 'winningTime',
					title : '接收时间',
					width : 80,
					formatter:formatterdate,
				},{
					field : 'useEndTime',
					title : '截止日期',
					width : 80,
					formatter:formatterdate,
				},{
					field : 'useStatus',
					title : '券状态',
					width : 80,
					formatter: function(value){
						if(value == "0"){
							return '<font color="red">未使用</font>';
						}else if(value == "1"){
							return '<font color="#000">已使用</font>';
						}
						return '<font color="gray">已过期</font>';
					}
				},{
					field : 'useTime',
					title : '使用时间',
					width : 80,
					formatter:formatterdate,
				},] ],
				onRowContextMenu : function(e, rowIndex, rowData) {
					e.preventDefault();
					$(this).datagrid('unselectAll');
					$(this).datagrid('selectRow', rowIndex);
				},
				onLoadError : function(args){
					alert("没有登录系统，或登录超时，请重新登录");
					window.top.location.href = '${pageContext.request.contextPath}/index.jsp';		
				}
			});
			$('#giftDatagrid').datagrid('unselectAll');
			$("#giftDatagrid").datagrid('loadData',data);
			$.messager.progress('close');
		});
	}
	
	function formatterfunction(val,row,index){
		var str = '<input type="submit" value="确定" onclick="createGift()">';
		return str;
	}
	//选中会员信息
	function createGift(){
		var rows = memberDatagrid.datagrid('getSelections');
		if (rows.length == 0){
			$.messager.show({
				msg : '请选择一条数据后，再点击【确定】按钮',
				title : '提示'
			});
		}else if (rows.length != 1 && rows.length != 0) {
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
// 			alert(rows[0].companyCode);
			var mobile = $("#mobile3").val();
			var number = $("#number").val();
			if(confirm('确定给手机号为'+mobile+'会员，补推'+number+'个红包？')){
				$.post("arrival.do?createGift",{"mobile":mobile,"number":number,"companyCode":rows[0].companyCode},function(data){
					data = $.parseJSON(data);
					$.messager.show({title:"提示",msg:data.msg});
				});
			}else{
				$.messager.show({title:"提示",msg:"您已取消推送红包操作"});
			}
		}
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="true">
		<div id="toolbarAll" class="datagrid-toolbar" style="height: auto;">
			<fieldset style="border:1px groove #f0f0f0;background-color:#ffffff">
				<legend>推送红包条件</legend>
				<ul>
					<li>3月-4月到店活动：洗头除外，支付方式为储值或划卡；</li>
				</ul>
			</fieldset>
			<fieldset id="toolbar" style="border:1px groove #f0f0f0;background-color:#ffffff">
				<legend>需要查询的用户信息</legend>
				<table class="tableForm">
					<tr>
						<th>会员号码：</th>
					    <td><input id="mobile"></td>
					    <th>单据时间：</th>
					    <td><input name="beginTime" class="easyui-datebox" id="beginTime"/>-</td>
					    <td><input name="endTime" class="easyui-datebox" id="endTime"/></td>
					</tr>
					<tr>
					    <th>门店编码：</th>
					    <td><input name="companyCode" id="companyCode"></td>
					    <th>erp门店名：</th>
					    <td><input name="companyName" id="companyName"></td>
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
				<a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="findGift();" href="javascript:void(0);">查找会员红包</a>
		    </div>
		</div>
		<table id="datagrid"></table>
	</div>
		
	<!-- 弹框:会员红包 -->
	<div id="giftDialog" style="display: none; overflow: hidden;width:50%;height:70%;">
		  <div id="toolbarGift" class="datagrid-toolbar" style="height: auto;">
		    <fieldset>
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<th>会员号码</th>
						<td><input name="mobile2" id="mobile2"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchGift();" href="javascript:void(0);">查找</a><a
							class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="clearGift();" href="javascript:void(0);">清空</a></td>
					</tr>
				</table>
			</fieldset>
			<div>
				<a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="giftDatagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0)">取消选中</a>
			</div>
		  </div>
		<table id="giftDatagrid" height="100%"></table>
	</div>	
</body>
</html>