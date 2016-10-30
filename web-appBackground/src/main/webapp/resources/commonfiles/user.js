function submitUserinfoForm() {
	var nickName = document.getElementById("nikeName").value;
	nickName = nickName.replace(/^\s*(.*?)[\s\n]*$/g, '$1');
	if (nickName.length > 20) {
		okcoinAlert(language["comm.error.tips.111"]);
		return;
	}
	var okcoin = nickName.toLowerCase().indexOf("okcoin");
	if (okcoin != -1) {
		okcoinAlert(language["comm.error.tips.112"]);
		return;
	}
	document.getElementById("userinfoForm").submit();
}

function submitAddressForm() {
	var faddress = document.getElementById("faddress").value;
	faddress = faddress.replace(/^\s*(.*?)[\s\n]*$/g, '$1');
	if (faddress.length > 100) {
		okcoinAlert(language["comm.error.tips.113"]);
		return;
	}
	var okcoin = faddress.toLowerCase().indexOf("okcoin");
	if (okcoin != -1) {
		okcoinAlert(language["comm.error.tips.114"]);
		return;
	}
	document.getElementById("userinfoForm").submit();
}

var fowTime = 5;
function resetPasswordForEmail() {
	var regu = /^[0-9]{6}$/;
	var re = new RegExp(regu);
	var validateCodeType = 0;
	var phoneCode = 0;
	var totpCode = 0;

	var newPassword = document.getElementById("newPassword").value;
	var newPassword2 = document.getElementById("newPassword2").value;
	var passwordType = document.getElementById("passwordType").value;
	var msg = isPassword(newPassword);
	if (msg != "") {
		document.getElementById("msg1").innerHTML = msg;
		return;
	} else {
		document.getElementById("msg1").innerHTML = "";
	}
	if (newPassword != newPassword2) {
		document.getElementById("msg2").innerHTML = language["comm.error.tips.116"];
		document.getElementById("newPassword2").value = "";
		return;
	} else {
		document.getElementById("msg2").innerHTML = "";
	}
	if (document.getElementById("phoneCode") != null) {
		phoneCode = trim(document.getElementById("phoneCode").value);
		if (!re.test(phoneCode)) {
			document.getElementById("msg3").style.display = "";
			document.getElementById("msg3").innerHTML = language["comm.error.tips.124"];
			return;
		} else {
			document.getElementById("msg3").innerHTML = "&nbsp;";
			document.getElementById("msg3").style.display = "none";
		}
	}
	if (document.getElementById("totpCode") != null) {
		totpCode = trim(document.getElementById("totpCode").value);
		if (!re.test(totpCode)) {
			document.getElementById("totpCodeTips").innerHTML = language["comm.error.tips.98"];
			return;
		} else {
			document.getElementById("totpCodeTips").innerHTML = "&nbsp;";
		}
	}
	var fid = document.getElementById("fid").value;
	var ev_id = document.getElementById("ev_id").value;
	var newuuid = document.getElementById("newuuid").value;
	var url = "/validate/resetPassword.html?random=" + Math.round(Math.random() * 100);
	var param = {
		validateCodeType : validateCodeType,
		totpCode : totpCode,
		phoneCode : phoneCode,
		newPassword : newPassword,
		newPassword2 : newPassword2,
		passwordType : passwordType,
		fid : fid,
		ev_id : ev_id,
		newuuid : newuuid
	};
	jQuery.post(url, param, function(data) {
		if (data.code == -1) {
			okcoinAlert(data.msg);
		} else if (data.code == -2) {
			document.getElementById("msg1").innerHTML = data.msg;
		} else if (data.code == -3) {
			document.getElementById("msg2").innerHTML = data.msg;
			document.getElementById("newPassword2").value = "";
		} else if (data.code == -4) {
			document.getElementById("msg1").innerHTML = data.msg;
			document.getElementById("newPassword").value = "";
			document.getElementById("newPassword2").value = "";
		} else if (data.code == -5) {
			okcoinAlert(data.msg);
		} else if (data.code == -6) {
			okcoinAlert(data.msg);
		} else if (data.code == -8) {
			document.getElementById("msg3").innerHTML = data.msg;
			document.getElementById("totpCode").value = "";
			document.getElementById("msg3").style.display = "none";
		} else if (data.code == -9) {
			document.getElementById("msg3").innerHTML = data.msg;
			document.getElementById("msg3").style.display = "block";			
			document.getElementById("phoneCode").value = "";
		} else if (data.code == 0) {
			window.location.href = "/validate/reset.html?type=2";
		}
	},"json");
}

function isPassword(pwd) {
	var desc = "";
	if (pwd == "") {
		desc = language["comm.error.tips.17"];
	} else if (pwd.length < 6) {
		desc = language["comm.error.tips.3"];
	} else if (pwd.length > 16) {
		desc = language["comm.error.tips.18"];
	}
	return desc;
}

function updateNumberRestPwd(num) {
	if (num == secs) {
		document.getElementById("msgCodeBtn").disabled = false;
		if (document.getElementById("validatePhoneNumber") != null) {
			document.getElementById("validatePhoneNumber").disabled = false;
		}
		document.getElementById("msgCodeBtn").value = language["comm.error.tips.33"];
	} else {
		var printnr = secs - num;
		document.getElementById("msgCodeBtn").value = language["comm.error.tips.32"].format(printnr);
	}
}

function queryEmail() {
	var email = document.getElementById("uemail").value;
	if (!checkEmail(email) && !checkMobile(email)) {
		document.getElementById("emailMsg").innerHTML = language["comm.error.tips.1"];
		return;
	} else {
		document.getElementById("emailMsg").innerHTML = "&nbsp;";
	}
	var url = "/validate/queryEmail.html?random=" + Math.round(Math.random() * 100);
	var param = {
		uemail : email
	};
	jQuery.post(url, param, function(data) {
		if (data.code == 0) {
			window.location.href = "/validate/resetPhonePwd.html?phone=" + email;
		} else if (data.code == 1) {
			window.location.href = "/validate/sendMailBack.html";
		} else if (data.code == 2) {
			window.location.href = "/validate/sendmailphoneback.html?phone=" + email;
		} else {
			document.getElementById("emailMsg").innerHTML = data.msg;
		}
	},"json");
}

function validateIdentity() {
	var realName = document.getElementById("realName").value;
	var identityType = document.getElementById("identityType").value;
	var identityNo = document.getElementById("identityNo").value;
	if (realName == "") {
		document.getElementById("errorMessage").innerHTML = language["comm.error.tips.115"];
		return;
	} else {
		document.getElementById("errorMessage").innerHTML = "&nbsp;";
	}
	var realName2 = document.getElementById("realName2").value;
	if (realName != realName2) {
		document.getElementById("errorMessage").innerHTML = language["comm.error.tips.116"];
		return;
	} else {
		document.getElementById("errorMessage").innerHTML = "&nbsp;";
	}
	if (identityNo == "") {
		document.getElementById("errorMessage").innerHTML = language["comm.error.tips.117"];
		return;
	} else {
		document.getElementById("errorMessage").innerHTML = "&nbsp;";
	}
	if (!validateIdenNo(true)) {
		return;
	} else {
		document.getElementById("errorMessage").innerHTML = "&nbsp;";
	}
	document.getElementById("validateIdentityForm").submit();
}

function checkRealName() {
	var realName = document.getElementById("realName").value;
	var realName2 = document.getElementById("realName2").value;
	if (realName != realName2) {
		document.getElementById("errorMessage").innerHTML = language["comm.error.tips.116"];
	}
}

function showApiApplyBlock() {
	dialogBoxShadow();
	document.getElementById("ApiApplyBlock").style.display = "";
}

function closeApiApplyBlock() {
	dialogBoxHidden();
	document.getElementById("ApiApplyBlock").style.display = "none";
	window.location.href = "/user/api.html";
}

// 身份证号码验证
var lastIdenNo = "";
var lastidenStatus = false;
function validateIdenNo(force) {
	var isRealName = document.getElementById("isRealName").value;
	if(isRealName=="false"){
		return true;
	}
	var idenNo = document.getElementById("identityNo").value;
	if (lastIdenNo == idenNo && !force) {
		return lastidenStatus;
	}
	lastIdenNo = idenNo;
	var idenType = document.getElementById("identityType").value;
	var nameStr = document.getElementById("realName").value;
	if (!nameStr || nameStr.length <= 0) {
		document.getElementById("errorMessage").innerHTML = language["comm.error.tips.120"];
		nameStr = "";
	}
	if (identityType == 0) {
		var isIDCard = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
		var re = new RegExp(isIDCard);
		if (!re.test(identityNo)) {
			document.getElementById("errorMessage").innerHTML = language["comm.error.tips.118"];
			return lastidenStatus
		}
	} else {
		if (identityNo.length <= 15) {
			document.getElementById("errorMessage").innerHTML = language["comm.error.tips.119"];
			return lastidenStatus
		}
	}
	var reqUrl = "/validate/identity.html?t=" + Math.round(Math.random() * 100);
	jQuery.ajax({
		type : 'post',
		url : reqUrl,
		async : false,
		dataType : 'json',
		data : {
			"idenType" : idenType,
			"idenNo" : idenNo,
			"name" : nameStr
		},
		success : function(data) {
			if (data.code == -1) {
				lastidenStatus = false;
				document.getElementById("errorMessage").innerHTML = data.msg;
			} else {
				document.getElementById("errorMessage").innerHTML = "&nbsp;";
				lastidenStatus = true;
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			lastidenStatus = false;
			document.getElementById("errorMessage").innerHTML = language["comm.error.tips.121"];
		}
	});
	return lastidenStatus;
}

var phonesecs = 121;
function sendPhonCode() {
	var fphone = document.getElementById("fphone").value;
	var imgcode = document.getElementById("oldPhoneCode").value;
	if (!checkMobile(fphone)) {
		showerrortips("updatePhoneinfoTips", language["comm.error.tips.122"]);
		return;
	}
	if (!/^.{4}$/.test(imgcode)) {
		showerrortips("updatePhoneinfoTips", language["comm.error.tips.22"]);
		return;
	}
	var url = "/validate/sendPhoneMsg.html?random=" + Math.round(Math.random() * 100);
	document.getElementById("msgCodeBtn").disabled = true;
	for ( var num = 1; num <= phonesecs; num++) {
		window.setTimeout("updateNumberphoneRestPwd(" + num + ")", num * 1000);
	}
	var param = {
		phone : fphone,
		code : imgcode
	};
	jQuery.post(url, param, function(data) {
		if (data.code == 0) {
			closeimagecodeDiv();
			document.getElementById("msgCodeBtn").disabled = true;
			for ( var num = 1; num <= phonesecs; num++) {
				window.setTimeout("updateNumberphoneRestPwd(" + num + ")", num * 1000);
			}
		} else {
			showerrortips("updatePhoneinfoTips", data.msg);
		}
	},"json");
}

function updateNumberphoneRestPwd(num) {
	if (num == secs) {
		document.getElementById("msgCodeBtn").disabled = false;
		document.getElementById("msgCodeBtn").value = language["comm.error.tips.33"];
	} else {
		var printnr = secs - num;
		document.getElementById("msgCodeBtn").value = language["comm.error.tips.32"].format(printnr);
	}
}
var fowTime = 5;
function resetPassword() {
	var regu = /^[0-9]{6}$/;
	var re = new RegExp(regu);
	var validateCodeType = 0;
	var phoneCode = 0;
	var totpCode = 0;
	var fphone = document.getElementById("fphone").value;
	if (!checkMobile(fphone)) {
		okcoinAlert(language["comm.error.tips.122"]);
		return;
	}
	var newPassword = document.getElementById("newPassword").value;
	var newPassword2 = document.getElementById("newPassword2").value;
	var passwordType = document.getElementById("passwordType").value;
	var msg = isPassword(newPassword);
	if (msg != "") {
		document.getElementById("msg1").innerHTML = msg;
		return;
	} else {
		document.getElementById("msg1").innerHTML = "";
	}
	if (newPassword != newPassword2) {
		document.getElementById("msg2").innerHTML = language["comm.error.tips.21"];
		document.getElementById("newPassword2").value = "";
		return;
	} else {
		document.getElementById("msg2").innerHTML = "";
	}
	if (document.getElementById("phoneCode") != null) {
		phoneCode = trim(document.getElementById("phoneCode").value);
		if (!re.test(phoneCode)) {
			document.getElementById("msg3").innerHTML =language["comm.error.tips.124"];
			return;
		} else {
			document.getElementById("msg3").innerHTML ="";
		}
	}
	if (document.getElementById("totpCode") != null) {
		totpCode = trim(document.getElementById("totpCode").value);
		if (!re.test(totpCode)) {
			document.getElementById("totpCodeTips").innerHTML = language["comm.error.tips.98"];
			return;
		} else {
			document.getElementById("totpCodeTips").innerHTML = "&nbsp;";
		}
	}
	var url = "/validate/resetPhonePassword.html?random=" + Math.round(Math.random() * 100);
	var param = {
		phone : fphone,
		totpCode : totpCode,
		phoneCode : phoneCode,
		newPassword : newPassword,
		newPassword2 : newPassword2
	};
	jQuery.post(url, param, function(data) {
		if (data.code == -1) {
			okcoinAlert(data.msg);
		} else if (data.code == -2) {
			document.getElementById("msg1").innerHTML = data.msg;
		} else if (data.code == -3) {
			document.getElementById("msg2").innerHTML = data.msg;
			document.getElementById("newPassword2").value = "";
		} else if (data.code == -4) {
			document.getElementById("msg1").innerHTML = data.msg;
			document.getElementById("newPassword").value = "";
			document.getElementById("newPassword2").value = "";
		} else if (data.code == -5) {
			okcoinAlert(data.msg);
		} else if (data.code == -6) {
			okcoinAlert(data.msg);
		} else if (data.code == -8) {
			document.getElementById("totpCodeTips").innerHTML = data.msg;
			document.getElementById("totpCode").value = "";
		} else if (data.code == -9) {
			document.getElementById("msg3").innerHTML = data.msg;
			document.getElementById("phoneCode").value = "";
		} else if (data.code == 0) {
			window.location.href = "/validate/reset.html?type=2";
		}
	});
}

function showimagecodeDiv() {
	document.getElementById("imagecodeDiv").style.display = "";
	dialogBoxShadow(false);
	addMoveEvent("updatePhone_title_auth", "updatePhone_content_auth");
}
function closeimagecodeDiv() {
	dialogBoxHidden();
	document.getElementById("imagecodeDiv").style.display = "none";
}
