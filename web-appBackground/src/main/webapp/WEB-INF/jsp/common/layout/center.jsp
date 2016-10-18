<%@ page language="java" pageEncoding="UTF-8"%>
<script type="text/javascript" charset="UTF-8">
	var centerTabs;
	function addTabFun(opts) {
		//alert(opts.src);
		var options = $.extend({
			title : '',
			content : '<iframe src="' + opts.src + '" frameborder="0" style="border:0;width:100%;height:99.2%;"></iframe>',
			closable : true,
			iconCls : ''
		}, opts);
		if (centerTabs.tabs('exists', options.title)) {
			centerTabs.tabs('close', options.title);
		}
		centerTabs.tabs('add', options);
	};
	$(function() {
		var type=$("#userType").val();
		//alert(type);
		if(type=="4"||type=="1"){
		centerTabs = $('#centerTabs').tabs({
			border : false,
			fit : true
		});
		setTimeout(function() {
			centerTabs.tabs('add', {
				title : '首页',
				content : '<iframe src="reservation.do?homePage" frameborder="0" style="border:0;width:100%;height:99.2%;"></iframe>',
				closable : true,
				iconCls : ''
			});
		}, 0);
		}else{
			centerTabs = $('#centerTabs').tabs({
				border : false,
				fit : true
			});
			setTimeout(function() {
				var src = '';
				centerTabs.tabs('add', {
					title : '首页',
					content : '<iframe src="' + src + '" frameborder="0" style="border:0;width:100%;height:99.2%;"></iframe>',
					closable : true,
					iconCls : ''
				});
			}, 0);
		}
	});
</script>
<div id="centerTabs">
	<input type="hidden" value="${userM.userType }" id="userType">
</div>