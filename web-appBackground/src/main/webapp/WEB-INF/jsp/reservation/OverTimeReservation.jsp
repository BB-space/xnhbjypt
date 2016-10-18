<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/inc/meta.jsp"></jsp:include>
<jsp:include page="../common/inc/easyui.jsp"></jsp:include>
<script src="<%=request.getContextPath()%>/resources/js/menu.js" charset="UTF-8" type="text/javascript"></script>

<style type="text/css">
	 
.reserTop{
		font-size: 1.5rem;
		margin: 0.2rem;
	}
	.submit{
	width: 5em;
	height: 2em;
	background-color:rgb(59,153,204);
	color:white;
	margin-top: 0.2rem;
	}
	
	.font{
		font-size: 0.8rem;
		text-align: center;
	}
	.stamp{
		width: 40%;
		margin: 1rem 2rem;
		border:1px red solid;
	}
	.submitCancel{
	width: 5em;
	height: 2em;
	background-color:#808080;
	color:white;
	margin-top: 0.2rem;
	}
</style>
<script type="text/javascript">
	var reserTimes="";
	function cancelReservation(){
		var rows = datagrid.datagrid('getSelections');
		id=rows[0].id;
		 $.messager.confirm('请确认', '您确定要取消此预约吗？', function(data){
			if(data){
				$.ajax({
					url : '${pageContext.request.contextPath}/reservation.do?addCancelReservations',
					data : {
						ids : id
					},
					cache : false,
					dataType : "json",
					success : function(response) {
						datagrid.datagrid('unselectAll');
						datagrid.datagrid('reload');
						$.messager.show({
							title : '提示',
							msg : '取消预约成功！'
						});
					}
				});
				//window.location.href="reservation.do?addCancelReservations&ids="+id;
			}
		}); 
	}
	
	
 	//获取窗口的高度 
 	var windowHeight; 
 	//获取窗口的宽度 
 	var windowWidth; 
 	//获取弹窗的宽度 
 	var popWidth; 
 	//获取弹窗高度 
 	var popHeight; 
 	function init(){ 
 		windowHeight=$(window).height(); 
 		windowWidth=$(window).width(); 
 		popHeight=$(".window").height(); 
 		popWidth=$(".window").width(); 
 	} 
	
	//弹出预约时间
 	 function reservation(){
 		init(); 
 		var rows = datagrid.datagrid('getSelections');
 		id=rows[0].id;
 		reserTimes=rows[0].reservationTime;
 		/* var tempArr = val.split(",");
 		id = tempArr[0];
 		reserTimes=tempArr[1]; */
 		//计算弹出窗口的左上角Y的偏移量 
 		var popY=(windowHeight-popHeight)/200; 
 		var popX=(windowWidth-popWidth)/4; 
 		//设定窗口的位置 
 		$("#reservationTime").css("top",popY).css("left",popX)	
 			.show(); 
 		var date = new Date(reserTimes);
 		var val=date.Format("yyyy-MM-dd hh:mm:ss");
 		setTime(val);
 		//window.location.href = "reservation.do?reservationTime&id="+id;
 	} 
	
	
    //将时间转换成yyyy-MM-dd
     Date.prototype.Format = function (fmt) {
        var o = {
            "M+": this.getMonth() + 1, //月份 
            "d+": this.getDate(), //日 
            "h+": this.getHours(), //小时 
            "m+": this.getMinutes(), //分 
            "s+": this.getSeconds(), //秒 
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
            "S": this.getMilliseconds() //毫秒 
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };

    
    //触发日历控件
    function onSelect(date){
    	//比较日期大小
    	var now = new Date();
    	var year = now.getFullYear();
    	var month = now.getMonth()+1;
    	var day = now.getDate();
    	//当前日期
    	var date1 = new Date(year,month,day);  
    	
    	date=date.Format("yyyy-MM-dd");
    	var dateArr = date.split('-'); 
    	//选择的日期
    	var date2 = new Date(dateArr[0],dateArr[1],dateArr[2]);  
    	/* alert(date1);
    	alert(date2); */
		if(date1>date2){
			alert("日期必须大于当前日期");
		} else{
	    	//window.location.href = "reservation.do?reservationTime&id="+id;
		} 
	}
    
    var datagrid;
	var passwordInput;
	var reservationDialog;
	var reservationForm;
	
	$(function() {
		reservationForm = $('#reservationForm').form();

		passwordInput = reservationForm.find('[name=name]').validatebox({
			required : true
		});
		
	reservationDialog = $('#reservationDialog').show().dialog({
			modal : true,
			title : '预约信息',
			top : '0px',
			buttons : [ {
				text : '确定',
				handler : function() {
					if (reservationForm.find('[name=id]').val() != '') {
						reservationForm.form('submit', {
							url : '${pageContext.request.contextPath}/reservation.do?editDescribes',
							success : function(data) {
								reservationDialog.dialog('close');
								$.messager.show({
									msg : '预约编辑成功！',
									title : '提示'
								});
								datagrid.datagrid('reload');
							}
						});
					} 
				}
			} ]  
		}).dialog('close'); 
		
		//页面显示数据
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/reservation.do?datagridOverTime',
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
			singleSelect : true,//单选 
			rownumbers : true,
			idField : 'id',
			frozenColumns : [ [ {                               
				title : 'id',
				field : 'id',
				width : 50,
				hidden : true
			}, {
				field : 'shopName',
				title : '预约门店',
				width : 150,
				sortable : true 
			} ] ],
			columns : [ [ {
				field : 'mobile',
				title : '预约手机',
				width : 100,
				sortable : true
			},{
				field : 'productName',
				title : '预约项目',
				width : 100,
				sortable : true
			},{
				field : 'reservationTime',
				title : '预约时间',
				width : 100,
				formatter:formatterdate
			},{
				field : 'createDateTime',
				title : '创建时间',
				width : 100,
				formatter:formatterdate
			},{
				field : 'describes',
				title : '备注',
				width : 100,
				sortable : true
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
	
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate()+' '+date.getHours()+':'+date.getMinutes()+':'+date.getSeconds();
		}
	}
	
	//查找
	function searchFun() {
		//alert($('#reservationStatus').val());
		datagrid.datagrid('load',
		{
			mobile :  $('#toolbar input[name=mobile]').val(),
			reservationStatus :  $('#reservationStatus').val(),
			startTime : $('#toolbar input[comboname=startTime]').datetimebox('getValue'),
			endTime : $('#toolbar input[comboname=endTime]').datetimebox('getValue'),
		});
	}

	//清空
	function clearFun() {
		$('#toolbar input').val('');
		datagrid.datagrid('load', {});
	}
	
	//删除预约
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
						url : '${pageContext.request.contextPath}/reservation.do?deleteReservation',
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
	
	//编辑备注
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length != 1 && rows.length != 0) {
			var names = [];
			for (var i = 0; i < rows.length; i++) {
				names.push(rows[i].id);
			}
			$.messager.show({
				msg : '只能择一个用户进行编辑！您已经选择了【' + names.join(',') + '】'
						+ rows.length + '个预约项目',
				title : '提示'
			});
		} else if (rows.length == 1) {
			passwordInput.validatebox({
				required : false
			});
			reservationForm.find('[name=id]').attr('readonly', 'readonly');
			reservationDialog.dialog('open');
			reservationForm.form('clear');
			//alert(rows[0].describes);
			reservationForm.form('load', {
				id : rows[0].id,
				describes : rows[0].describes
			});
		}
	}

	
</script>
</head>
<body class="easyui-layout" fit="true" >
	<div region="center" border="false" style="overflow: hidden" >
		<div style="height: auto; display: none;" id="toolbar" class="datagrid-toolbar" >
			<fieldset>
				<legend>会员预约</legend>
				<div>
				<a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="reservation();"
					plain="true" href="javascript:void(0);">确认预约</a> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="cancelReservation();"
					plain="true" href="javascript:void(0);">取消预约</a> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="del();"
					plain="true" href="javascript:void(0);">删除记录</a> <a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="edit();"
					plain="true" href="javascript:void(0);">编辑预约</a><a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
			</fieldset>
			</div>
			
		<table id="datagrid"></table>
	</div>
	<div id="reservationDialog" style="display: none; overflow: hidden;">
		<form id="reservationForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" id="id" readonly="readonly" type="hidden"/></td>
				</tr>
				<tr>
					<th>备注</th>
					<td><!-- <input name="describes" id="describes" style="width: 300px"/> -->
						<textarea rows="3" cols="5"  name="describes" id="describes" 
						style="width: 200px"></textarea>
					</td>
				</tr>
				
			</table>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/jsp/reservation/reservationPageTime.jsp"></jsp:include>
</body>
</html>