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

	function cancelReservations(){
		var rows = datagrid.datagrid('getSelections');
		id=rows[0].id;
 		//alert(id);
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
		//alert(val);
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
	var reserveDialog;
	var passwordInput;
	var reserveForm;
	
	$(function() {
		$("#container").load("reservation.do?homePageSure",null,null); 
		timeForm = $('#timeForm').form();
		
		passwordInput = timeForm.find('[name=password]').validatebox({
			required : true
		});
		
		reserveDialog= $('#reserveDialog').show().dialog({
			modal : true,
			title : '添加预约',
			top : '0px',
			buttons : [ { 
				text : '确定',
				handler : function() {
					if (reserveForm.find('[name=id]').val() != '') {
						reserveForm.form('submit', {
							url : '${pageContext.request.contextPath}/subCenterController.do?editSubCenter',
							success : function(data) {
								reserveDialog.dialog('close');
								$.messager.show({
									msg : '修改预约成功！',
									title : '提示'
								}); 
								datagrid.datagrid('unselectAll');
								datagrid.datagrid('reload');
							}
						});
					} else { 
						reserveForm.form('submit', {
							url : '${pageContext.request.contextPath}/reservation.do?addReserve',
							success : function(data) {
								try {
									var d = $.parseJSON(data);
									if (d) {
										reserveDialog.dialog('close');
										$.messager.show({
											msg : '添加预约成功！',
											title : '提示'
										});
										datagrid.datagrid('reload');
									}
								} catch (e) {
									reserveDialog.dialog('close');
									$.messager.show({
										msg : '添加预约失败！',
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
		
		//页面显示数据
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/reservation.do?datagrid',
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
			/* }, {
				field : 'memberName',
				title : '会员名',
				width : 100,
				sortable : true  */
			} ] ],
			columns : [ [ {
				field : 'mobile',
				title : '会员电话',
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
			/*  },{
				field : 'we',
				title : '操作',
				align : 'center',
				width : 100,
				formatter : function(value,row,index){
					return "<div><span onclick='reservation()' style='padding-right:1rem;'>确认预约</span>"
						+"<span onclick='cancelReservations()'> 取消预约</span></div>";
				} */
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
		alert( $('#toolbar input[name=reservationTime]').val());
		datagrid.datagrid('load',
		{
			reservationTime :  $('#toolbar input[name=reservationTime]').val(),
		});
	}
	
	function append() {
		reserveDialog.dialog('open');
		passwordInput.validatebox({
			required : true
		});
		reserveForm.find('[name=mobile]').removeAttr('readonly');
		reserveForm.form('clear');
	}



</script>
</head>
<body class="easyui-layout" fit="true" style="padding: 0px; margin: 0px;">
	<div style="width: 100%;height:100%;">
	<div style="width: 49%;height:100%;float: left;border:1px rgb(221,221,221) solid;">
		
		<jsp:include page="/WEB-INF/jsp/reservation/homePageSure.jsp"/>
		<!-- <div id="container"></div> -->
	</div>
	<div region="center"  style="margin-left: 50%;width: 50%;height:100%;border:1px rgb(211,211,211) solid;">
		<div style="height: auto; display: none;" id="toolbar" class="datagrid-toolbar" >
			<fieldset>
				<legend>会员预约</legend>
				<div>
				<a
					class="easyui-linkbutton" iconCls="icon-edit" onclick="reservation();"
					plain="true" href="javascript:void(0);">确认预约</a> <a
					class="easyui-linkbutton" iconCls="icon-remove" onclick="cancelReservations();"
					plain="true" href="javascript:void(0);">取消预约</a> <!-- <a
					class="easyui-linkbutton" iconCls="icon-add" onclick="append();"
					plain="true" href="javascript:void(0);">新增预约</a> --> <a
					class="easyui-linkbutton" iconCls="icon-undo"
					onclick="datagrid.datagrid('unselectAll');" plain="true"
					href="javascript:void(0);">取消选中</a>
			</div>
			</fieldset>
		</div>
			
		<table id="datagrid" ></table>
	

	</div>
	<!-- 添加预约框 -->
	<%-- <div id="reserveDialog" style="display: none; overflow: hidden;">
		<form id="reserveForm" method="post">
			<table class="tableForm">
				<tr>
					<th></th>
					<td><input name="id" readonly="readonly" type="hidden" /></td>
				</tr>

				<tr>
					<th>预约者</th>
					<td><input name="name" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" required="true" /></td>
				</tr> 
				<tr>
					<th>预约电话</th>
					<td><input name="mobile" style="width: 200px;" maxlength="30"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<th>预约时间</th>
					<td><input name="reservationTime" class="easyui-datetimebox" style="width: 204px;" maxlength="30"
						data-options="required:true,showSeconds:false"  id="reservationTime"/></td>
				</tr>
				<tr>
					<th>预约项目</th>
					<td>
						<select id="productId" class="easyui-combobox"  
							name="productId"  
							data-options="  
							url:'${pageContext.request.contextPath}/reservation.do?product', 
							valueField:'id',  
							textField:'name',
							width:'200px'"></select>
					</td>
				</tr>
				
			</table>
		</form>
	</div> --%>
	</div>
	<jsp:include page="/WEB-INF/jsp/reservation/reservationTime.jsp"></jsp:include>
</body>
</html>