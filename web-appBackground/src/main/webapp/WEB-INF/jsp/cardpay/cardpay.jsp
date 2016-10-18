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
	var cardpayDialog;
	var cardpayForm;
	var belongShopType = ''; //门店属于：丝域、丝荟、微商
	var pg; 
	  
	$(function() {
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
				field : 'fldUnitPrice',
				title : '单价',
				width : 100,
				align : 'center',
			}, {
				field : 'fldQty',
				title : '数量',
				width : 100,
				align : 'center',
			}, {
				field : 'count',
				title : '合计',
				width : 100,
				align : 'center',
			}, {
				field : 'nurse',
				title : '护理师',
				width : 100,
				align : 'center',
			}, {
				field : 'nurseId',
				title : '护理师ID',
				hidden : true
			}, {
				field : 'hairStylist',
				title : '发型师',
				align : 'center',
				width : 100,
			}, {
				field : 'hairStylistId',
				title : '发型师ID',
				hidden : true
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
			},
			onLoadError : function(args){
				alert("没有登录系统，或登录超时，请重新登录");
				window.top.location.href = '${pageContext.request.contextPath}/index.jsp';		
			}
		});
		
		//监听电话输入
		$('#mobile').bind('input propertychange', function() {
			$('#fldCompanyCode').val('');
			$('#shopName').val('');
			$('#cardName').val('');
			$('#nowMoney').val('');
			belongShopType = '';
			$('#goods').combogrid('grid').datagrid({
	        	data: []
	        }); 
		});
		
		//监听会员姓名输入
		$('#realname').bind('input propertychange', function() {
			$('#fldCompanyCode').val('');
			$('#shopName').val('');
			$('#cardName').val('');
			$('#nowMoney').val('');
			belongShopType = '';
			$('#goods').combogrid('grid').datagrid({
	        	data: []
	        }); 
		});
		
		cardpayDialog = $('#cardpayDialog').show().dialog({
			modal : true,
			width : 410,
			height : 260,
			title : '编辑项目',
			top : '0px',
			left : '150px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					
					var reg = new RegExp('^([1-9][0-9]*)$');
					if(!reg.test($('#fldUnitPrice').val())){
						$.messager.show({title : '提示',msg : '请输入整数的单价价格！'});
						return;
					}
					
					var nurse = '';
					var hairStylist = '';
					if($('#nurse').combobox('getValue') != '请选择'){
						nurse = $('#nurse').combobox('getText');
					}
					if($('#hairStylist').combobox('getValue') != '请选择'){
						hairStylist = $('#hairStylist').combobox('getText');
					}
					var count = Number($('#fldUnitPrice').val())*Number($('#fldQty').val());
					var data = {
							goodsId : $('#goodsId').val(),
							fldItemName1 : $('#goods').combogrid('getValue'),   
							fldQty : $('#fldQty').val(),
							fldUnitPrice : $('#fldUnitPrice').val(),
							nurse : nurse,
							nurseId : $('#nurse').combobox('getValue'),
							hairStylist : hairStylist,
							hairStylistId : $('#hairStylist').combobox('getValue'),
							note : $('#note').val(),
							count : count
						};
					
					var v = $('#id').val();
					if(v){
						//已经有划卡项目、判断护理师、发型师、备注是否相同，相同则修改数量、不同新增
						var rows = datagrid.datagrid('getRows');
						if(rows != ''){
							for(var i =0;i<rows.length;i++){
								if(rows[i].fldItemName1==data.fldItemName1 && rows[i].nurse==data.nurse &&
										rows[i].hairStylist==data.hairStylist && rows[i].note==data.note){
									
									data.fldQty = Number(data.fldQty) + Number(rows[i].fldQty);
									data.count = Number(data.fldQty)*Number(data.fldUnitPrice);
									 var index = datagrid.datagrid('getRowIndex',rows[i]);//获取某行的行号
									 datagrid.datagrid('updateRow',{
											index: index,
											row: data
										});
									 cardpayDialog.dialog('close');
									 return;
								}
							}
							datagrid.datagrid('appendRow',data);
						}else{
							datagrid.datagrid('appendRow',data);
						} 
						
					}else {
						datagrid.datagrid('updateRow',{
							index: $('#rowIndex').val(),
							row: data
						});
					}
					cardpayDialog.dialog('close');
				}
			} ]
		}).dialog('close');
		
		$('#member_id').dialog({
			title	: '会员列表',
			width	: 560,
			height	: 400,
			top : '0px',
			left : '150px',
			modal	: true,
			closed	: true,
			buttons : [{
				text :'确定',
				handler:function(){
					var row = $('#memberdatagrid').datagrid('getSelected');
					if(row == null){
						$.messager.show({title : '提示',msg : '请选择一条会员信息！'});
			    		return;
					}					
					$("#member_id").dialog('close');
					belongShopType = row.belongShopType;
					$('#mobile').val(row.mobile);
					$('#realname').val(row.realname);
					$('#belongShop').val(row.shopName);
					$('#fldCompanyCode').val(row.fldCompanyCode);
					$('#fldMemberNo').val(row.fldMemberNo);
					if('${userM.belongShopType}'== row.belongShopType){
						return;
					}
					findGoods();
				},
			},{
				text :'取消',
				handler :function(){
					$("#member_id").dialog('close');
				}
			}]
		});	
		
		$('#userCard_id').dialog({
			title	: '卡项列表',
			width	: 560,
			height	: 400,
			top : '0px',
			left : '150px',
			modal	: true,
			closed	: true,
			buttons : [{
				text :'确定',
				handler:function(){
					var row = $('#userCarddatagrid').datagrid('getSelected');
					if(row == null){
						$.messager.show({title : '提示',msg : '请选择一张卡项！'});
			    		return;
					}					
					$("#userCard_id").dialog('close');
				    $('#shopName').val(row.fldCompanyName1);
				    $('#cardCompanyCode').val(row.fldCompanyCode);
				    $('#cardMemberCardCode').val(row.fldMemberCardCode);
				    $('#cardMemberNo').val(row.fldMemberNo);
				    $('#cardName').val(row.fldDescription1);
				    $('#nowMoney').val(row.nowMoney);
				},
			},{
				text :'取消',
				handler :function(){
					$("#userCard_id").dialog('close');
				}
			}]
		});	
		
		$('#cardToErp_id').dialog({
			title	: '卡项列表',
			width	: 560,
			height	: 400,
			top : '0px',
			left : '150px',
			modal	: true,
			closed	: true,
			buttons : [{
				text :'同步',
				handler:function(){
					var row = $('#cardToErpdatagrid').datagrid('getSelected');
					if(row == null){
						$.messager.show({title : '提示',msg : '请选择您要同步的卡项！'});
			    		return;
					}					
					//同步卡项到erp系统
					$.messager.confirm('温馨提示', '您确定要同步当前卡项到：' + $('#belongShop').val(), function(r){
						if (r){ //同步
							saveCardToErp(row);
						}
					});
				},
			},{
				text :'下次同步',
				handler :function(){
					$("#cardToErp_id").dialog('close');
					//不同步储金卡,查找erp系统储金卡
				}
			}]
		});	

		$('#guide').dialog({
			title	: '同步卡项指引',
			width	: 560,
			height	: 270,
			top : '0px',
			modal	: true,
			closed	: true,
			top : '50px',
			left : '200px',
			buttons : [{
				text :'确定',
				handler:function(){
					$("#guide").dialog('close');
				}
			}]
		});	
		
		$("#goods").combogrid({
		   panelWidth:440,
		   panelHeight:320,
		   idField:"name",
		   textField:"name",
		   fitColumns : true, 
		   pagination : true,
		   pageSize : 10,
		   pageList : [10],
		   scrollbarSize : 5,
		   columns:[[  
		         {field:'id',title:'id',hidden:true},  
		         {field:'name',title:'名称',width:240},  
		         {field:'price',title:'价格',width:50}  
		      ]],
		   onSelect: function(index,row){
			   $('#id').val(row.id);
			   $('#goodsId').val(row.id);
			   $('#fldUnitPrice').val(row.price);
			   if(row.name == '其他'){
				   $('#fldUnitPrice').removeAttr('readonly');
			   }else {
				   $('#fldUnitPrice').attr('readonly','readonly');
			   }
		   }
		});
		
		$("#nurse").combobox({
			valueField: 'id',
	        textField: 'realname',
	        url: 'cardpayBackground.do?getShopEmployee',
	        onSelect: function(record){
	        	
	        }
		});
		$("#hairStylist").combobox({
			valueField: 'id',
	        textField: 'realname',
	        onSelect: function(record){
	        	
	        }
		});
	});

	function add() {
		cardpayDialog.dialog('open');
		cardpayForm.form('clear');
		$('#fldQty').numberspinner('setValue', 1);
		var val = $('#nurse').combobox("getData");
    	for (var i in val) {
            if (val[i].userId == '${userM.id}') {
            	$("#nurse").combobox("select", val[i].id);
            }
        }
    	$('#hairStylist').combobox("loadData", val);
	}
	
	function edit() {
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
			if(rows[0].fldItemName1 == '其他'){
				cardpayForm.find('[name=fldUnitPrice]').removeAttr('readonly');
			}
			
			cardpayDialog.dialog('open');
			cardpayForm.form('clear');
			
			$('#nurse').combobox('setValue', rows[0].nurseId);
			$('#hairStylist').combobox('setValue', rows[0].hairStylistId);
			
			cardpayForm.form('load', { 
				id : '',
				rowIndex : datagrid.datagrid('getRowIndex', rows[0]),
				goodsId : rows[0].goodsId,
				fldItemName1 : $('#goods').combogrid('setValue',rows[0].fldItemName1),   
				fldUnitPrice : rows[0].fldUnitPrice,
				fldQty : rows[0].fldQty,
				note : rows[0].note
			});
		}
	}
	
	function del() {
		var rows = datagrid.datagrid("getSelections");	//获取你选择的所有行
        //循环所选的行
        for(var i =0;i<rows.length;i++){    
            var index = datagrid.datagrid('getRowIndex',rows[i]);//获取某行的行号
	        $.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					datagrid.datagrid('deleteRow',index);	//通过行号移除该行
				}
			});
        }
	}
	
	//划卡
	function cardpay(){
		
		var mobile = $('#mobile').val();
		if(mobile.length == 0){
			$.messager.show({title : '温馨提示',msg : '联系电话不能为空！'});
		}else if(!$('#nowMoney').val()){
			$.messager.show({title : '温馨提示',msg : '对不起，划卡前，请先查找出卡项！'});
			return;
		}
		//统计总金额
		var rows = datagrid.datagrid('getRows');
		if(rows == ''){
			$.messager.show({title : '温馨提示',msg : '请输入您要划卡的项目！'});
			return;
		} 
		
		var str = '[';
		var count = 0;
		for(var i =0;i<rows.length;i++){
			count += rows[i].fldUnitPrice*rows[i].fldQty;
			
	        str += '{"goodsId":"'+rows[i].goodsId +'","fldItemName1":"'+ rows[i].fldItemName1
	        	+'","fldUnitPrice":"'+ rows[i].fldUnitPrice +'","fldQty":"'+ rows[i].fldQty 
	        	+'","nurse":"'+ rows[i].nurseId +'","hairStylist":"'+ rows[i].hairStylistId +'","note":"'+ rows[i].note + '"},';
        }
		str = str.substring(0, str.length - 1);
		str += ']';
		
		if(count > $('#nowMoney').val()){
			$.messager.show({title : '温馨提示',msg : '支付需要<font style="color:red;">'+count+'</font>元，卡项余额不足！'});
			return;
		}
		
		$.messager.confirm('请确认', '本次消费总金额是 '+count+' ,您确定要划卡？', function(r) {
			if (r) {
				$.messager.progress({title:'请等待',msg:'划卡中...'});
				//生成订单
				$.ajax({
					url : "${pageContext.request.contextPath}/cardpayBackground.do?addOrderByCardPay",  
					data : {
						rows : str,
						mobile : $('#mobile').val(),
						fldCompanyCode : $('#cardCompanyCode').val(),
						fldMemberCardCode : $('#cardMemberCardCode').val(),
						fldMemberNo : $('#cardMemberNo').val()
					},
					cache : false,
					dataType : "json",
					success : function(response) {
						$.messager.progress('close');
						//$.messager.show({title : '提示',msg : '订单已生成，请等待客户微信端划卡确认！'});
						$.messager.show({title : '提示',msg : '划卡成功，订单已生成！'});
						clearFun();
					},
					error : function(XMLHttpRequest, textStatus, errorThrown){
			    		alert('没有登录系统，或登录超时，请重新登录');
			    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
					}
				});
			}
		});
	}
	
	//查找会员
	function searchMember() {
		
		var mobile = $('input[name="mobile"]')[0].value;
		var realname = $('input[name="realname"]')[0].value;
		if($.trim(mobile) == '' && $.trim(realname) == '') {
			$.messager.show({title : '提示',msg : '请至少输入一个查询条件'});
    		return;
		}
		
		$.messager.progress({title:'请等待',msg:'正在加载数据...'});
		$.post('${pageContext.request.contextPath}/cardpayBackground.do?getMemberInfo',  
			{'mobile' : $.trim(mobile),
			 'realname' : $.trim(realname),
			 'page' : 1,
			 'rows' : 10},
		    function(data) {
		    	$.messager.progress('close');
		    	
		    	if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
		    		alert('没有登录系统，或登录超时，请重新登录');
		    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
		    		return;
		    	}
		    	
		    	var d = $.parseJSON(data);
		    	if(d.total == 0) {
		    		$.messager.show({title : '提示',msg : '没有找到相关会员信息！'});
		    		return;
		    	}
		    	if(d.total == 1){
		    		$('#mobile').val(d.rows[0].mobile);
					$('#realname').val(d.rows[0].realname);
					$('#belongShop').val(d.rows[0].shopName);
					$('#fldCompanyCode').val(d.rows[0].fldCompanyCode);
					$('#fldMemberNo').val(d.rows[0].fldMemberNo);
					belongShopType = d.rows[0].belongShopType;
					
					if('${userM.belongShopType}'== belongShopType){
						return;
					} 
					findGoods();
					return;
		    	}
		    	
		        $('#member_id').dialog('open');
		        $('#memberdatagrid').datagrid({
					url : '',
					title : '',
					iconCls : 'icon-save',
					fit :true,
					fitColumns : true,
					pagination : true,
					pageSize : 10,
					pageList : [ 10 ],
					nowrap : true, //设置为 true，则把数据显示在一行里。设置为 true 可提高加载性能
					border : false,
					idField : 'id',
					rownumbers : true,  
					singleSelect : true,
					scrollbarSize : 10,
			//		striped : true, //striped（即奇偶行使用不同背景色）
					frozenColumns : [ [
	       			{
	       				title : '编号',
	       				field : 'id',
	       				hidden : true
	       			} ] ],
	       			columns : [ [{
	       				field : 'fldCompanyCode',
	       				title : '门店编号',
	       				hidden : true					
	       			},{
	       				field : 'fldMemberNo',
	       				title : '会员编号',
	       				hidden : true					
	       			},{
	       				field : 'shopName',
	       				title : '门店 ',
	       				width : 270
	       			},{
	       				field : 'mobile',
	       				title : '手机',
	       				width : 110
	       			},{
	       				field : 'realname',
	       				title : '名字',
	       				width : 110
	       			}] ],
					onRowContextMenu : function(e, rowIndex, rowData) {
						e.preventDefault();
						$(this).datagrid('unselectAll');
						$(this).datagrid('selectRow', rowIndex);
					},
					onDblClickRow : function(index, row){
						belongShopType = row.belongShopType;
						$('#mobile').val(row.mobile);
						$('#realname').val(row.realname);
						$('#belongShop').val(row.shopName);
						$('#fldCompanyCode').val(row.fldCompanyCode);
						$('#fldMemberNo').val(row.fldMemberNo);
						if('${userM.belongShopType}'== row.belongShopType){
							$("#member_id").dialog('close');
							return;
						}
						findGoods(); 
						$("#member_id").dialog('close');
					}
				});
		        
		        $('#memberdatagrid').datagrid('unselectAll');
		        $('#memberdatagrid').datagrid({data: d});
		        
		        //监听分页事件
		        pg = $("#memberdatagrid").datagrid("getPager"); 
				if(pg)  
				{  
				   $(pg).pagination({  
				       onBeforeRefresh:function(){  
				    	},  
				       onRefresh:function(pageNumber,pageSize){  
				    	   $.post('${pageContext.request.contextPath}/cardpayBackground.do?getMemberInfo',  
			    				{'mobile' : $.trim(mobile),
			    				 'realname' : $.trim(realname),
			    				 'page' : pageNumber,
			    				 'rows' : pageSize},
			    			    function(data) {
		    					 	if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
		    				    		alert('没有登录系统，或登录超时，请重新登录');
		    				    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
		    				    		return;
		    				    	}
			    			    	var d = $.parseJSON(data);
			    			    	$('#memberdatagrid').datagrid('unselectAll');
			    			    	$('#memberdatagrid').datagrid('loadData',d);
				    		});  
				        },  
				       onChangePageSize:function(){  
				        },  
				       onSelectPage:function(pageNumber,pageSize){
				    	   
				    	   $.post('${pageContext.request.contextPath}/cardpayBackground.do?getMemberInfo',  
			    				{'mobile' : $.trim(mobile),
			    				 'realname' : $.trim(realname),
			    				 'page' : pageNumber,
			    				 'rows' : pageSize},
			    			    function(data) {
			    					 if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
			    				    		alert('没有登录系统，或登录超时，请重新登录');
			    				    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
			    				    		return;
			    				    	}
			    			    	var d = $.parseJSON(data);
			    			    	$('#memberdatagrid').datagrid('unselectAll');
			    			    	$('#memberdatagrid').datagrid('loadData',d);
				    		});
				        }  
				   });  
				}
		    });
	}

	//显示用户新买未同步储金卡
	function showAppUserCard(rows){
		$('#cardToErp_id').dialog('open');
        $('#cardToErpdatagrid').datagrid({
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
				field : 'cardName',
				title : '卡项名称',
				width : 150,
			},{
				field : 'nowMoney',
				title : '卡项金额',
				width : 100,
			},{
				field : 'buyTime',
				title : '购买时间',
				hidden :true
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
        $('#cardToErpdatagrid').datagrid({
        	data: rows
        });
	}
	
	//查找卡项
	function searchSavingsCard() {
		//判断是否查出会员
		if(belongShopType == ''){
			$.messager.show({title : '提示',msg : '请先查找出会员，在查找卡项！'});
			return;
		}
		
		//判断是否跨店划卡
		if('${userM.belongShopType}' == belongShopType){
			//不能同门店划卡
			if(belongShopType == '丝域'){
				$.messager.show({title : '提示',msg : '丝域门店只能选择丝荟会员进行跨店划卡'});
			}else if(belongShopType == '丝荟'){
				$.messager.show({title : '提示',msg : '丝荟门店只能选择丝域会员进行跨店划卡'});
			}
		}else {
			getErpCard();
		}
		
/* 		if(belongShopType == '微商'){
			//指引用户1、Erp门店建会员、2、同步微商卡项、3、erp划卡
			 $('#guide').dialog('open');
			
		}else {
			//判断是否跨店划卡
			if('${userM.belongShopType}' == belongShopType){
				//不能同门店划卡
				if(belongShopType == '丝域'){
					$.messager.show({title : '提示',msg : '丝域门店只能选择丝荟会员进行跨店划卡'});
				}else if(belongShopType == '丝荟'){
					$.messager.show({title : '提示',msg : '丝荟门店只能选择丝域会员进行跨店划卡'});
				}
			}else {
				
				//查找app有没有购买的储值卡没有同步过去的，有：赠送的卡项优先排前
				$.post("${pageContext.request.contextPath}/cardpayBackground.do?getSavingsUsercard",
					{"mobile":$('input[name="mobile"]')[0].value,
					 "realname":$('input[name="realname"]')[0].value,
					 "dataFrom":"app"},
					function(data){
						var d = $.parseJSON(data);
						if(d.total != 0 ){
							$.messager.confirm('温馨提示', '您有未同步的储金卡，是否同步到ERP门店？', function(r){
								if (r){ //同步
									//显示储金卡列表页面，让用户选择同步的储金卡，选择后同步到当前
									showAppUserCard(d.rows);
									$('#cardToErpdatagrid').datagrid('unselectAll');
								}else { //不同步
									//查找ERP数据库储金卡
									getErpCard();
								}
							});
						}else {
							//没有未同步储金卡,查找erp系统储金卡
							getErpCard();
						}
				});
			}
		} */
	}

	//同步卡
	function saveCardToErp(row){
		$.messager.progress({title:'请稍等',msg:'正在同步卡项...'});
		$.post('${pageContext.request.contextPath}/cardpayBackground.do?saveCardToErp',
			{'companyCode' : $('#fldCompanyCode').val(),
			 'memberNo' : $('#fldMemberNo').val(),
			 'cardId' : row.id,
			 'belong' : belongShopType},
			function(data){
				$.messager.progress('close');
				var d = $.parseJSON(data);
				if(d.success == true){
					$("#cardToErp_id").dialog('close');
					$("#cardToErpdatagrid").datagrid('unselectAll');
					$.messager.show({title : '提示',msg : '卡项同步成功！'});
				}else {
					$.messager.show({title : '提示',msg : '卡项同步失败！'});
				}
		});
	} 
	
	//查找ERP数据库储金卡
	function getErpCard(){
		$.messager.progress({title:'请等待',msg:'正在加载数据...'});
		$.ajax({
			url : '${pageContext.request.contextPath}/cardpayBackground.do?getSavingsUsercard',  
			data : {
				mobile : $('input[name="mobile"]')[0].value,
				realname : $('input[name="realname"]')[0].value,
				dataFrom : 'erp',
				type : belongShopType
			},
			cache : false,
			success : function(data) {
				$.messager.progress('close');
				
				if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
		    		alert('没有登录系统，或登录超时，请重新登录');
		    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
		    		return;
		    	}
				
				var d = $.parseJSON(data);
				
				if(d.total == 0) {
		    		$.messager.show({title : '提示',msg : '没有找到储金卡信息！'});
		    		return;
		    	}
				
				if(d.total == 1){
					$('#cardCompanyCode').val(d.rows[0].fldCompanyCode);
					$('#cardMemberCardCode').val(d.rows[0].fldMemberCardCode);
					$('#cardMemberNo').val(d.rows[0].fldMemberNo);
				    $('#shopName').val(d.rows[0].fldCompanyName1);
				    $('#cardName').val(d.rows[0].fldDescription1);
				    $('#nowMoney').val(d.rows[0].nowMoney);
					return;
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
						field : 'fldCompanyName1',
						title : '门店 ',
						hidden : true
					},{
						field : 'fldCompanyCode',
						title : '门店编码 ',
						hidden : true
					},{
						field : 'fldMemberNo',
						title : '会员编码 ',
						hidden : true
					},{
						field : 'fldMemberCardCode',
						title : '会员卡编号',
						hidden : true
					},{
						field : 'fldDescription1',
						title : '卡项名称',
						width : 150,
						sortable : true,
					},{
						field : 'nowMoney',
						title : '卡项余额',
						width : 100,
						sortable : true,
					}] ],
					onRowContextMenu : function(e, rowIndex, rowData) {
						e.preventDefault();
						$(this).datagrid('unselectAll');
						$(this).datagrid('selectRow', rowIndex);
					},
					onDblClickRow : function(index, row){
						$("#userCard_id").dialog('close');
					    $('#shopName').val(row.fldCompanyName1);
					    $('#cardCompanyCode').val(row.fldCompanyCode);
						$('#cardMemberCardCode').val(row.fldMemberCardCode);
						$('#cardMemberNo').val(row.fldMemberNo);
					    $('#cardName').val(row.fldDescription1);
					    $('#nowMoney').val(row.nowMoney);
					}
				});
		        
		        $('#userCarddatagrid').datagrid({
		        	data: d.rows
		        });
			}
		});
	}
	
	//同步卡项到erp系统
	function cardToErp(){
		//判断是否查出会员
		if(belongShopType == ''){
			$.messager.show({title : '提示',msg : '请先查找出会员，再同步卡项！'});
			return;
		}
		
		if(belongShopType == '微商'){
			//指引用户1、Erp门店建会员、2、同步微商卡项、3、erp划卡
			$('#guide').dialog('open');
			
		}else {
			//查找app有没有购买的储值卡没有同步过去的，有：赠送的卡项优先排前
			$.post("${pageContext.request.contextPath}/cardpayBackground.do?getSavingsUsercard",
				{"mobile":$('input[name="mobile"]')[0].value,
				 "realname":$('input[name="realname"]')[0].value,
				 "dataFrom":"app"},
				function(data){
					var d = $.parseJSON(data);
					if(d.total != 0 ){
						showAppUserCard(d.rows);
						$('#cardToErpdatagrid').datagrid('unselectAll');
					}else {
						//没有未同步储金卡
						$.messager.show({title : '提示',msg : '您没有未同步的卡项！'});
					}
			});
		}
	}
	
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('loadData',{total:0,rows:[]});
	}
	
	//查找项目列表
	function findGoods(){
		$.ajax({
			url : '${pageContext.request.contextPath}/goods.do?goodsList',  
			data : {itemType:'卡项', catType:'${userM.belongShopType}' + '门店',page:1,rows:10},
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
			    $('#goods').combogrid('grid').datagrid({
		        	data: d
		        });
			  	
			  //监听分页事件
		        itempg = $("#goods").combogrid('grid').datagrid('getPager');
				if(itempg)  
				{  
				   $(itempg).pagination({  
				       onBeforeRefresh:function(){  
				    	},  
				       onRefresh:function(pageNumber,pageSize){
				    	   $.post('${pageContext.request.contextPath}/goods.do?goodsList',  
				    				{'itemType' : '卡项',
				    				 'catType' : '${userM.belongShopType}' + '门店',
				    				 'page' : pageNumber,
				    				 'rows' : pageSize},
				    			    function(data) {
				    					 if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
				    				    		alert('没有登录系统，或登录超时，请重新登录');
				    				    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
				    				    		return;
				    				    	} 
				    			    	var d = $.parseJSON(data);
				    			    	$('#goods').combogrid('grid').datagrid('unselectAll');
				    			    	$('#goods').combogrid('grid').datagrid('loadData',d);
					    		});
				        },  
				       onChangePageSize:function(){  
				        },  
				       onSelectPage:function(pageNumber,pageSize){
				    	   $.post('${pageContext.request.contextPath}/goods.do?goodsList',  
				    			{'itemType' : '卡项',
				    			 'catType' : '${userM.belongShopType}' + '门店',
			    				 'page' : pageNumber,
			    				 'rows' : pageSize},
			    			    function(data) {
			    					 if(data.indexOf('没有登录系统，或登录超时，请重新登录') > 0){
			    				    		alert('没有登录系统，或登录超时，请重新登录');
			    				    		window.top.location.href = '${pageContext.request.contextPath}/index.jsp';
			    				    		return;
			    				    	}
			    			    	var d = $.parseJSON(data);
			    			    	$('#goods').combogrid('grid').datagrid('unselectAll');
			    			    	$('#goods').combogrid('grid').datagrid('loadData',d);
				    		});
				        }  
				   });  
				}
			}
		});
	}
	
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;">
			<fieldset style="border:1px groove #f0f0f0;background-color:#ffffff">
				<legend>筛选</legend>
				<table class="tableForm">
					<tr>
						<td>联系电话</td>
						<td><input id="mobile" name="mobile">
							<input id="belongShop" name="belongShop" type="hidden">
							<input id="fldCompanyCode" name="fldCompanyCode" type="hidden">
							<input id="fldMemberNo" name="fldMemberNo" type="hidden"></td></td>
						<td>会员姓名</td>
						<td><input id="realname" name="realname"></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="searchMember();" href="javascript:void(0);">查找会员</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="searchSavingsCard();" href="javascript:void(0);">查找卡项</a>
							<!-- <a class="easyui-linkbutton" iconCls="icon-search" plain="true"
							onclick="cardToErp();" href="javascript:void(0);">同步卡项</a> --></td>
					</tr>
					<tr>
						<td>开卡门店</td>
						<td><input id="shopName" name="shopName" readonly="readonly">
							<input id="cardCompanyCode" name="cardCompanyCode" type="hidden">
							<input id="cardMemberCardCode" name="cardMemberCardCode" type="hidden">
							<input id="cardMemberNo" name="cardMemberNo" type="hidden"></td>
						<td>卡项名称</td>
						<td><input id="cardName" name="cardName" readonly="readonly"></td>
						<td>卡项余额</td>
						<td><input id="nowMoney" name="nowMoney" readonly="readonly"></td>
					</tr>
				</table>
			</fieldset>
			<div>
				 <a
					class="easyui-linkbutton" iconCls="icon-add" onclick="add();"
					plain="true" href="javascript:void(0)">新增划卡</a><a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0)">修改卡项</a><a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0)">删除卡项</a> <a
					class="easyui-linkbutton" iconCls="icon-edit"
					onclick="cardpay();" plain="true"
					href="javascript:void(0)">在线划卡</a>
			</div>
		</div>
		<table id="datagrid"></table>
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
					<td><input id="goods" name="goods"  style="width:300px;" required="true"
							data-options="editable:false" /></td>
<!-- 					<td><select id="goods" name="goods" class="easyui-combogrid" style="width:300px;" required="true"
							data-options="editable:false"></select></td> -->
				</tr>
				<tr>
					<th>单价：</th>
					<td><input id="fldUnitPrice" name="fldUnitPrice" style="width: 295px;"  
						maxlength="8" class="easyui-validatebox"  readonly="true"/></td>
				</tr>
				<tr>
					<th>数量：</th>
					<td><input id="fldQty" name="fldQty" style="width: 300px;" required="true"  
						class="easyui-numberspinner"  data-options="min:1,editable:false"/></td>
				</tr>
				<tr>
					<th>护理师：</th>
					<td><select name="nurse" id="nurse"  class="easyui-combobox" data-options="editable:false" style="width: 300px"></select></td>
				</tr>
				<tr>
					<th>发型师：</th>
					<td><select name="hairStylist" id="hairStylist"  class="easyui-combobox" data-options="editable:false" style="width: 300px"></select></td>
				</tr>
				<tr>
					<th>备注：</th>
					<td><input id="note" name="note" style="width: 295px;" maxlength="100"
						class="easyui-validatebox"/></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="member_id">
		<table id="memberdatagrid"></table>
	</div>
	<div id="userCard_id">
		<table id="userCarddatagrid"></table>
	</div>
	<div id="cardToErp_id">
		<table id="cardToErpdatagrid"></table>
	</div>
	<div id="guide">
    	<h2>您好，请您先在门店先建会员后，再进行同步。具体步骤如下：</h2>
    	    &nbsp;&nbsp;1、先在ERP系统新建会员，注意：电话号码要和当前要同步的会员一致<br><hr>
    	    &nbsp;&nbsp;2、回到当前系统，点击：查找会员<br><hr>
    	    &nbsp;&nbsp;3、点击：同步卡项，选择要同步的卡项<br><hr>
    	    &nbsp;&nbsp;4、提示同步成功之后，即可在ERP系统进行划卡<br><hr>
	</div>
</body>
</html>