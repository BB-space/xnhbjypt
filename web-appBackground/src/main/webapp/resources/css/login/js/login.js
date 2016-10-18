$(function(){
	var bodyWidth = Number(window.innerWidth);
	var bodyHeight = Number(window.innerHeight);
	if(bodyWidth == '' || bodyWidth == 'undefined' || bodyWidth == null) {
		bodyWidth = 1600;
	}
	if(bodyHeight == '' || bodyHeight == 'undefined' || bodyHeight == null) {
		bodyHeight = 900;
	}
	console.log("bodyWidth="+bodyWidth+",bodyHeight="+bodyHeight);
	$("body").css('height',bodyHeight+"px");
});
function setSysName(){
	var logoWidth = $("#logo").width();
	var headHight = $("#heading").height();
	$("#sysName").css('width',logoWidth+"px");
	$("#sysName").css('height',headHight+"px");
	$("#sysNsapn").css('width',logoWidth+"px");
	$("#sysNsapn").css('height',headHight+"px");
	$("#sysNsapn").css('line-height',headHight+"px");
	
	var width = $("#sysName").width();
	var height = $("#sysName").height();
	console.log("logoWidth="+logoWidth+",headHight="+headHight+",height="+height+",width="+width);
	
	var footHight = $("#footing").height();
	var footWidth = $("#footing").width();
	$("#banquan").css('width',footWidth+"px");
	$("#banquan").css('height',footHight+"px");
	$("#banquan").css('line-height',footHight+"px");
	
	$("#loginBox").css('margin-top',headHight);
}
function agree(){
	window.location.href="joinUser.do?registerUpload";
}
function regAudit(){
	window.location.href="joinUser.do?registerAudit";
}
function joinLogin(){
	window.location.href="/ykt";
}