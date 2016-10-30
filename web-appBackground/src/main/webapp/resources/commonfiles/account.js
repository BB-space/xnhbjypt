/**
 * 提交btc提现表单
 */
function submitWithdrawBtcForm(coinName) {
	var withdrawAddr = trim(document.getElementById("withdrawAddr").value);
	var withdrawAmount = trim(document.getElementById("withdrawAmount").value);
	var tradePwd = trim(document.getElementById("tradePwd").value);
	var minwithdrawbtc = trim(document.getElementById("minwithdrawbtc").value);
	var maxwithdrawbtc = trim(document.getElementById("maxwithdrawbtc").value);
	var totpCode = 0;
	var phoneCode = 0;
	var symbol = document.getElementById("symbol").value;
	if (document.getElementById("btcbalance") != null && document.getElementById("btcbalance").value == 0) {
		alertTipsSpan(language["comm.error.tips.54"]);
		return;
	} else {
		clearTipsSpan();
	}
	if (withdrawAddr == "") {
		alertTipsSpan(language["comm.error.tips.55"]);
		return;
	} else {
		clearTipsSpan();
	}
	var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
	if (!reg.test(withdrawAmount)) {
		alertTipsSpan(language["comm.error.tips.56"]);
		return;
	} else {
		clearTipsSpan();
	}
	if (withdrawAmount < 0.1) {
		alertTipsSpan(language["comm.error.tips.57"].format(0.1,coinName));
		return;
	} else {
		clearTipsSpan();
	}
	if (tradePwd == "") {
		alertTipsSpan(language["comm.error.tips.58"]);
		return;
	} else {
		clearTipsSpan();
	}
	if (document.getElementById("withdrawTotpCode") != null) {
		totpCode = trim(document.getElementById("withdrawTotpCode").value);
		if (!/^[0-9]{6}$/.test(totpCode)) {
			alertTipsSpan(language["comm.error.tips.59"]);
			return;
		} else {
			document.getElementById("modifyResultTips").innerHTML = "&nbsp;";
		}
	}
	if (document.getElementById("withdrawPhoneCode") != null) {
		phoneCode = trim(document.getElementById("withdrawPhoneCode").value);
		if (!/^[0-9]{6}$/.test(phoneCode)) {
			alertTipsSpan(language["comm.error.tips.60"]);
			return;
		} else {
			document.getElementById("modifyResultTips").innerHTML = "&nbsp;";
		}
	}
	if (document.getElementById("withdrawTotpCode") == null && document.getElementById("withdrawPhoneCode") == null) {
		document.getElementById("modifyResultTips").innerHTML = language["comm.error.tips.61"];
		return;
	}
	var url = "/account/withdrawBtcSubmit.html?random=" + Math.round(Math.random() * 100);
	var param = {
		withdrawAddr : withdrawAddr,
		withdrawAmount : withdrawAmount,
		tradePwd : tradePwd,
		totpCode : totpCode,
		phoneCode : phoneCode,
		symbol : symbol
	};
	jQuery.post(url, param, function(result) {
		if (result != null) {
			if(result.code == -13||result.code == -14||result.code == -18||result.code == -11){
				document.getElementById("modifyResultTips").innerHTML =result.msg;
			}else if (result.code == 0) {
				document.getElementById("withdrawBtcButton").disabled = "true";
				window.location.href = "/account/withdrawBtc.html?symbol=" + symbol + "&success=1";
			}else{
				alertTipsSpan(result.msg);
			} 
		}
	});
}

function closeEmailAlert() {
	var symbol = document.getElementById("symbol").value;
	dialogBoxHidden();
	document.getElementById("emailAlert").style.display = "none";
	window.location.href = "/account/withdrawBtc.html?symbol=" + symbol + "&success";
}

function clearTipsSpan() {
	document.getElementById("modifyResultTips").innerHTML = "&nbsp;";
}

function alertTipsSpan(tips) {
	document.getElementById("modifyResultTips").innerHTML = tips;
}

/**
 * 鼠标点击显示
 */
function onclickbox(e) {
	var banknumber = document.getElementById("withdrawAccountAddr").value;
	document.getElementById("displayBankNumberAddr").innerHTML = banknumber;
	if (language["comm.error.tips.62"] == banknumber) {
		document.getElementById("withdrawAccountAddr").value = "";
	}
	if (document.getElementById("outType") != null) {
		var type = document.getElementById("outType").value;
		if (type == 1)
			document.getElementById("displayBankNumberAddr").style.display = "";
	}
}

function moveclickbox(e) {
	var banknumber = document.getElementById("displayBankNumberAddr").innerHTML;
	document.getElementById("withdrawAccountAddr").value = banknumber;
	document.getElementById("displayBankNumberAddr").style.display = "none";
	if (banknumber == "") {
		document.getElementById("withdrawAccountAddr").value = language["comm.error.tips.62"];
	}
}

function onkeyupbox(e) {
	var banknumber = document.getElementById("withdrawAccountAddr").value;
	banknumber = banknumber.replace(new RegExp(" ", "gm"), '');
	banknumber = plusSpace(banknumber);
	document.getElementById("displayBankNumberAddr").innerHTML = banknumber;
	document.getElementById("withdrawAccountAddr").value = banknumber;
}

function onclickbox2(e) {
	var banknumber = document.getElementById("withdrawAccountAddr2").value;
	document.getElementById("displayBankNumberAddr2").innerHTML = banknumber;
	if (language["comm.error.tips.62"] == banknumber) {
		document.getElementById("withdrawAccountAddr2").value = "";
	}
	if (document.getElementById("outType") != null) {
		var type = document.getElementById("outType").value;
		if (type == 1)
			document.getElementById("displayBankNumberAddr2").style.display = "";
	}
}

function moveclickbox2(e) {
	var banknumber = document.getElementById("displayBankNumberAddr2").innerHTML;
	document.getElementById("withdrawAccountAddr2").value = banknumber;
	document.getElementById("displayBankNumberAddr2").style.display = "none";
	if (banknumber == "") {
		document.getElementById("withdrawAccountAddr2").value = language["comm.error.tips.62"];
	}
}

function onkeyupbox2(e) {
	var banknumber = document.getElementById("withdrawAccountAddr2").value;
	banknumber = banknumber.replace(new RegExp(" ", "gm"), '');
	banknumber = plusSpace(banknumber);
	document.getElementById("displayBankNumberAddr2").innerHTML = banknumber;
	document.getElementById("withdrawAccountAddr2").value = banknumber;
}

function plusSpace(banknumber) {
	var length = banknumber.length;
	var newbanknumber = "";
	if (length > 4) {
		var size = parseInt(length / 4);
		for ( var i = 0; i < size; i++) {
			var start = i * 4;
			var end = (i + 1) * 4;
			if ((i + 1) * 4 > length) {
				end = length;
			}
			var str = banknumber.substring(start, end);
			newbanknumber += str + " ";
		}
		if (length % 4 != 0) {
			newbanknumber += banknumber.substring(size * 4, length);
		} else {
			var endstr = newbanknumber.substring(newbanknumber.length - 1, newbanknumber.length);
			if (endstr == " ") {
				newbanknumber = newbanknumber.substring(0, newbanknumber.length - 1);
			}
		}
	} else {
		return banknumber;
	}
	return newbanknumber;
}

/**
 * 修改比特币提现地址
 */
function modifyWithdrawBtcAddr() {
	if (document.getElementById("isEmptyAuth").value == 1) {
		bindAuth();
		return;
	}
	dialogBoxShadow(false);
	addMoveEvent("dialog_title_btcaddr", "dialog_content_btcaddr");
	document.getElementById("withdrawBtcAddrDiv").style.display = "";
	document.getElementById("withdrawBtcAddr").focus();
	document.getElementById("withdrawBtcAddrTips").innerHTML = "";
	document.getElementById("withdrawBtcAddr").value = "";
	if (document.getElementById("withdrawBtcAddrCode") != null) {
		document.getElementById("withdrawBtcAddrCode").value = "";
	}
	document.getElementById("withdrawBtcAddr").focus();
	callbackEnter(submitWithdrawBtcAddrForm);
}

function closeWithdrawBtcAddr() {
	dialogBoxHidden();
	document.getElementById("withdrawBtcAddrDiv").style.display = "none";
}

function submitWithdrawBtcAddrForm(coinName) {
	var withdrawAddr = trim(document.getElementById("withdrawBtcAddr").value);
	var withdrawBtcAddrTotpCode = 0;
	var withdrawBtcAddrPhoneCode = 0;
	var symbol = document.getElementById("symbol").value;
	if (withdrawAddr == "") {
		document.getElementById("withdrawBtcAddrTips").innerHTML = language["comm.error.tips.63"];
		return;
	} else {
		document.getElementById("withdrawBtcAddrTips").innerHTML = "";
	}
	var start = withdrawAddr.substring(0, 1);
	if (withdrawAddr.length < 10 || withdrawAddr.length > 50) {
		document.getElementById("withdrawBtcAddrTips").innerHTML = language["comm.error.tips.64"].format(coinName);
		return;
	}
	if (document.getElementById("withdrawBtcAddrTotpCode") != null) {
		withdrawBtcAddrTotpCode = trim(document.getElementById("withdrawBtcAddrTotpCode").value);
		if (!/^[0-9]{6}$/.test(withdrawBtcAddrTotpCode)) {
			document.getElementById("withdrawBtcAddrTips").innerHTML = language["comm.error.tips.65"];
			document.getElementById("withdrawBtcAddrTotpCode").value = "";
			return;
		} else {
			document.getElementById("withdrawBtcAddrTips").innerHTML = "";
		}
	}
	if (document.getElementById("withdrawBtcAddrPhoneCode") != null) {
		withdrawBtcAddrPhoneCode = trim(document.getElementById("withdrawBtcAddrPhoneCode").value);
		if (!/^[0-9]{6}$/.test(withdrawBtcAddrPhoneCode)) {
			document.getElementById("withdrawBtcAddrTips").innerHTML = language["comm.error.tips.66"];
			document.getElementById("withdrawBtcAddrPhoneCode").value = "";
			return;
		} else {
			document.getElementById("withdrawBtcAddrTips").innerHTML = "";
		}
	}
	var url = "/user/modifyWithdrawBtcAddr.html?random=" + Math.round(Math.random() * 100);
	var param = {
		withdrawAddr : withdrawAddr,
		totpCode : withdrawBtcAddrTotpCode,
		phoneCode : withdrawBtcAddrPhoneCode,
		symbol : symbol
	};
	jQuery.post(url, param, function(result) {
		if (result != null) {
			if (result.code == -1) {
				bindAuth();
			} else if (result.code == -4) {
				document.getElementById("withdrawBtcAddrTips").innerHTML = result.msg;
			} else if (result.code == -2) {
				document.getElementById("withdrawBtcAddrTips").innerHTML = result.msg;
				document.getElementById("withdrawBtcAddrTotpCode").value = "";
			} else if (result.code == -3) {
				document.getElementById("withdrawBtcAddrTips").innerHTML = result.msg;
				document.getElementById("withdrawBtcAddrPhoneCode").value = "";
			} else if (result.code == 0) {
				closeWithdrawBtcAddr();
				window.location.href = "/account/withdrawBtc.html";
			}
		}
	},"json");
}

function cancelWithdrawCny(outId) {
	if (confirm(language["comm.error.tips.67"])) {
		var url = "/account/cancelWithdrawCny.html?random=" + Math.round(Math.random() * 100);
		var param = {
			outId : outId
		};
		jQuery.post(url, param, function(data) {
			window.location.href = "/account/withdrawCny.html";
		});
	}
}
function cancelWithdrawBtc(id) {
	if (confirm(language["comm.error.tips.67"])) {
		var url = "/account/cancelWithdrawBtc.html?random=" + Math.round(Math.random() * 100);
		var param = {
			id : id
		};
		jQuery.post(url, param, function(data) {
			window.location.reload(true);
		});
	} else {
		return false;
	}
}

function checkPayee(payee) {
	payee = payee.replace(new RegExp("　", "gm"), '');
	payee = payee.replace(/^\s+|\s+$/g, "");
	var re = new RegExp();
	re = /^[0-9]/;
	if (re.test(payee)) {
		document.getElementById("addrMsgSpan").innerHTML = language["comm.error.tips.68"];
		return;
	} else {
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
}

function showUpadteAddress(outType, addressType) {
	if (document.getElementById("anthtrade").value == 0) {
		bindAuth();
		return;
	}
	if (outType == 2) {
		
	} else {
		document.getElementById("openBankTypeAddrLi").style.display = "";
		var onkeyupboxFun = function(e) {
			onkeyupbox(e);
		};
		var onclickboxFun = function(e) {
			onclickbox(e);
		};
		var moveclickboxFun = function(e) {
			moveclickbox(e);
		};
		var onkeyupboxFun2 = function(e) {
			onkeyupbox2(e);
		};
		var onclickboxFun2 = function(e) {
			onclickbox2(e);
		};
		var moveclickboxFun2 = function(e) {
			moveclickbox2(e);
		};
		document.getElementById("withdrawAccountAddr").onkeyup = onkeyupboxFun;
		document.getElementById("withdrawAccountAddr2").onkeyup = onkeyupboxFun2;
	}
	dialogBoxShadow(false);
	addMoveEvent("dialog_title_CnyAddress", "dialog_content_CnyAddress");
	document.getElementById("withdrawCnyAddress").style.display = "";
	document.getElementById("outType").value = outType;
	document.getElementById("addressType").value = addressType;
	if (document.getElementById("addressPhoneCode") != null) {
		document.getElementById("addressPhoneCode").value = "";
	}
	if (document.getElementById("addressTotpCode") != null) {
		document.getElementById("addressTotpCode").value = "";
	}
	document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
}

function closeAddress() {
	dialogBoxHidden();
	document.getElementById("withdrawCnyAddress").style.display = "none";
}
var secs = 121;
function sendWithdrawCnyAddressMsgCode(type) {
	var msgType = 0;
	if (document.getElementById("WithdrawCnyAddressMsgCodeBtnSign") != null) {
		msgType = document.getElementById("WithdrawCnyAddressMsgCodeBtnSign").value;
	}
	if (msgType == 1) {
		document.getElementById("WithdrawCnyAddressMsgCodeBtn").disabled = true;
		for ( var num = 1; num <= secs; num++) {
			window.setTimeout("updateCnyAddrNumber(" + num + ")", num * 1000);
		}
	}
	var url = "/user/sendMsg.html?random=" + Math.round(Math.random() * 100);
	var param = {
		type : type,
		msgType : msgType
	};
	jQuery.post(url, param, function(data) {
		if (data.code == 0) {
			if (msgType != 1) {
				document.getElementById("WithdrawCnyAddressMsgCodeBtn").disabled = true;
				for ( var num = 1; num <= secs; num++) {
					window.setTimeout("updateCnyAddrNumber(" + num + ")", num * 1000);
				}
			}
		} else{
			document.getElementById("addrMsgSpan").innerHTML =data.msg;
		}
	},"json");
}
function updateCnyAddrNumber(num) {
	if (secs == num) {
		document.getElementById("WithdrawCnyAddressMsgCodeBtn").disabled = false;
		document.getElementById("WithdrawCnyAddressMsgCodeBtn").value = language["comm.error.tips.33"];
	} else {
		var printnr = secs - num;
		document.getElementById("WithdrawCnyAddressMsgCodeBtn").value = language["comm.error.tips.32"].format(printnr);
	}
}
function submitWithdrawCnyAddress(type) {
	var cnyOutType = parseFloat(document.getElementById("cnyOutType").value);
	var openBankTypeAddr = document.getElementById("openBankTypeAddr").value;
	var withdrawAccount = trim(document.getElementById("withdrawAccountAddr").value);
	var address = trim(document.getElementById("address").value);
	var totpCode = 0;
	var phoneCode = 0;
	var type = document.getElementById("addressType").value;

	var regType = new RegExp("^[0-9]*$");
	if (!regType.test(cnyOutType)) {
		document.getElementById("addrMsgSpan").innerHTML = language["comm.error.tips.69"];
		return;
	} else {
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
	if (cnyOutType == 1 && openBankTypeAddr == -1) {
		document.getElementById("addrMsgSpan").innerHTML = language["comm.error.tips.70"];
		return;
	} else {
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
	if (withdrawAccount == "" || withdrawAccount.length > 200 || withdrawAccount == language["comm.error.tips.62"]) {
		document.getElementById("addrMsgSpan").innerHTML = language["comm.error.tips.71"];
		return;
	} else {
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
	var withdrawAccount2 = trim(document.getElementById("withdrawAccountAddr2").value);
	if (withdrawAccount != withdrawAccount2) {
		document.getElementById("addrMsgSpan").innerHTML = language["comm.error.tips.72"];
		return;
	} else {
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
	if (address == "" || address.length > 300) {
		document.getElementById("addrMsgSpan").innerHTML = language["comm.error.tips.73"];
		return;
	} else {
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
	if (document.getElementById("addressTotpCode") != null) {
		totpCode = trim(document.getElementById("addressTotpCode").value);
		if (!/^[0-9]{6}$/.test(totpCode)) {
			document.getElementById("addrMsgSpan").innerHTML = language["comm.error.tips.65"];
			document.getElementById("addressTotpCode").value = "";
			return;
		} else {
			document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
		}
	}
	if (document.getElementById("addressPhoneCode") != null) {
		phoneCode = trim(document.getElementById("addressPhoneCode").value);
		if (!/^[0-9]{6}$/.test(phoneCode)) {
			document.getElementById("addrMsgSpan").innerHTML = language["comm.error.tips.66"];
			document.getElementById("addressPhoneCode").value = "";
			return;
		} else {
			document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
		}
	}
	var url = "/user/updateOutAddress.html?random=" + Math.round(Math.random() * 100);
	jQuery.post(url, {
		type : type,
		cnyOutType : cnyOutType,
		account : withdrawAccount,
		openBankType : openBankTypeAddr,
		totpCode : totpCode,
		phoneCode : phoneCode,
		address : address
	}, function(result) {
		if (result != null) {
			 if (result.code == 0) {
					window.location.href = "/account/withdrawCny.html?outCnyType=" + cnyOutType;
			 } else{
				document.getElementById("addrMsgSpan").innerHTML = result.msg;
			}
		}
	});
}


// //////////////////////////////////////////////////////////////////////////////////////////
// /////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////
/**
 * 验证人民币提现金额 modify by hank
 */
function withdrawAmountBlur(tipElement_id, withdrawAmount_id) {
	var tipElement = document.getElementById(tipElement_id);
	var withdrawAmount = parseFloat(document.getElementById(withdrawAmount_id).value);

	var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
	if (!reg.test(withdrawAmount)) {
		tipElement.innerHTML = language["comm.error.tips.74"];
		return;
	} else {
		tipElement.innerHTML = "";
	}
	var url = "/account/withdrawAmountBlur.html?random=" + Math.round(Math.random() * 100);
	var min = document.getElementById("min_double").value;
	var max = document.getElementById("max_double").value;
	var param = {
		withdrawAmount : withdrawAmount
	};
	jQuery.post(url, param, function(data) {
		if (data.code == 0||data.code == "0") {
			return;
		}else{
			tipElement.innerHTML = data.msg
		}
	},"json");
}

function cancelWithdrawcny(id) {
	var url = "/account/cancelWithdrawcny.html?random=" + Math.round(Math.random() * 100);
	var param = {
		id : id
	};
	jQuery.post(url, param, function(data) {
		window.location.reload(true);
	});
}

/*
 * 验证虚拟币提现数量是否余额不足
 */
function withdrawBtcAmountBlur(tipElement_id, withdrawAmount_id, symbol) {
	var tipElement = document.getElementById(tipElement_id);
	var withdrawAmount = parseFloat(document.getElementById(withdrawAmount_id).value);
	var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
	if (!reg.test(withdrawAmount)) {
		tipElement.innerHTML = language["comm.error.tips.75"];
		return;
	} else {
		tipElement.innerHTML = "";
	}
	var url = "/account/withdrawBtcAmountBlur.html?random=" + Math.round(Math.random() * 100);
	var param = {
		withdrawAmount : withdrawAmount,
		symbol : symbol
	};
	jQuery.post(url, param, function(data) {
		if (data.code == -3) {
			tipElement.innerHTML = data.msg;
		}
	});
}

/**
 * 提交cny提现表单 modify by hank
 */
function submitWithdrawCnyForm(tipElement_id) {
	var tipElement = document.getElementById(tipElement_id);
	var withdrawBalance = trim(document.getElementById('withdrawBalance').value);
	var tradePwd = trim(document.getElementById("tradePwd").value);
	var totpCode = 0;
	var phoneCode = 0;
	var min = document.getElementById("min_double").value;
	var max = document.getElementById("max_double").value;
	tipElement.innerHTML = "";
	if (document.getElementById("cnyadd") != null) {
		tipElement.innerHTML = language["comm.error.tips.76"];
		return;
	}
	var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
	if (!reg.test(withdrawBalance)) {
		tipElement.innerHTML = language["comm.error.tips.74"];
		return;
	}
	if (parseFloat(withdrawBalance) < parseFloat(min)) {
		tipElement.innerHTML = language["comm.error.tips.77"].format(min);
		return;
	}
	if (parseFloat(withdrawBalance) > parseFloat(max)) {
		tipElement.innerHTML = language["comm.error.tips.78"].format(max);
		return;
	}
	if (tradePwd == "" || tradePwd.length > 200) {
		tipElement.innerHTML = language["comm.error.tips.79"];
		return;
	}
	if (document.getElementById("withdrawTotpCode") != null) {
		totpCode = trim(document.getElementById("withdrawTotpCode").value);
		if (!/^[0-9]{6}$/.test(totpCode)) {
			tipElement.innerHTML = language["comm.error.tips.80"];
			return;
		}

	}
	if (document.getElementById("withdrawPhoneCode") != null) {
		phoneCode = trim(document.getElementById("withdrawPhoneCode").value);
		if (!/^[0-9]{6}$/.test(phoneCode)) {
			tipElement.innerHTML = language["comm.error.tips.81"];
			return;
		}
	}
	if (document.getElementById("withdrawTotpCode") == null && document.getElementById("withdrawPhoneCode") == null) {
		tipElement.innerHTML = language["comm.error.tips.82"];
		return;
	}
	var url = "/account/withdrawCnySubmit.html?random=" + Math.round(Math.random() * 100);
	var param = {
		tradePwd : tradePwd,
		withdrawBalance : withdrawBalance,
		phoneCode : phoneCode,
		totpCode : totpCode
	};
	jQuery.post(url, param, function(result) {
		if (result != null) {
			if (result.code == 0||result.code == "0") {
				alertTipsSpan("");
				document.getElementById("withdrawCnyButton").disabled = "true";
				window.location.href = "/account/withdrawCny.html?success";
			}else{
					alertTipsSpan(result.msg);
			}
		}
	},"json");
}