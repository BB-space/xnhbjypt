function submitOnLineForm(ele) {
	var sbank = jQuery('input[name="bank_input_bankcode"]:radio:checked').val();// jQuery('#inputbankcode dt input[name="bank_input_bankcode"]:checked ').val();//document.getElementById("sbank").value;
	var type = document.getElementById("finType").value;
	//最小充值金额
	var minMoney = document.getElementById("minRecharge").value;
	var money = 0;
	if (sbank == "") {
		okcoinAlert("请选择银行", "", null);
		return;
	}
	money = document.getElementById("diyMoney").value;
	
	if (Number(money) < Number(minMoney) || isNaN(money)) {
		okcoinAlert("最小充值金额为" + minMoney + "元", "", null);
		return;
	}
	var typeParam = "";
	var url = "";
	if (type == 1) {// 丰付支付
		url = "/onlinepay/isppay.html?random="+ Math.round(Math.random() * 100);
	} else {
	
	}
	jQuery.ajax({
         type: 'post',
         url: url,
         async: false,
         data:{"money":money,"type":type,"sbank":sbank},
         dataType: "json",
         success: function(jsonObj) {
             if (jsonObj.status == 0||jsonObj.status == "0") {
            	document.write(jsonObj.msg)
            	setInterval(function(){
            		window.location.href=window.location.href;
            	},1500)
                 isLink = false;
             } else {
            	 okcoinAlert(jsonObj.msg, "", null);
                 isLink = false;
             }
         },
         error: function() {
             alert('发生未知错误，请稍候再试？');
             isLink = false;
         }
     });
     return isLink;
 
}
function submitFinForm() {
	var sbank = document.getElementById("sbank").value;
	var type = document.getElementById("finType").value;
	var random = document.getElementById("random").value;

	var minMoney = document.getElementById("minRecharge").value;

	var money = 0;
	if (sbank == "") {
		okcoinAlert(language["comm.error.tips.83"], "", null);
		return;
	}
	money = document.getElementById("diyMoney").value;
	if (money.toString().indexOf(".") != -1) {
		money = money.toString().split(".")[0];
		money = money + (random.substring(1));
	} else {
		money = money + (random.substring(1));
	}
	if (Number(money) < Number(minMoney) || isNaN(money)) {
		okcoinAlert(language["comm.error.tips.84"].format(minMoney), "", null);
		return;
	}
	var bankID = -1;
	var typeParam = "";
	if (type == 1) {// 支付宝网银
		var bankRadio = document.getElementsByName("bankID");
		if (bankRadio != null) {
			var i;
			for (i = 0; i < bankRadio.length; i++) {
				if (bankRadio[i].checked) {
					bankID = bankRadio[i].value;
				}
			}
		}
		if (bankID == -1) {
			okcoinAlert(language["comm.error.tips.83"], "", null);
			return;
		}
		typeParam = "&frp=" + bankID;
	} else if (type == 2 || type == 3 || type == 4 || type == 6) {// 支付宝手动
		var url = "/account/alipayManual.html?random=" + Math.round(Math.random() * 100);
		var param = {
			money : money,
			type : type,
			sbank : sbank
		};
		jQuery.post(url, param, function(result) {
			if (result != null) {
				if (result.code == -1) {
					okcoinAlert(result.msg, "", null);
				} else if (result.code == -2) {
					okcoinAlert(result.msg, "", null);
				}
				if (type == 3) {//支付宝
					document.getElementById("tips1").innerHTML = language["comm.error.tips.85"];
					//document.getElementById("tips2").innerHTML = language["comm.error.tips.86"];
					document.getElementById("tips3").innerHTML = language["comm.error.tips.87"];
					///document.getElementById("tips2title").innerHTML = language["comm.error.tips.88"];
					document.getElementById("tips2ul").style.display = "";
					document.getElementById("alipayhandDiv").style.display = "none";
					document.getElementById("tips2bank").style.display = "none";
					
					document.getElementById("alipayManualMoney").innerHTML = result.money;
					document.getElementById("subMoney").innerHTML = result.money;
					document.getElementById("alipayManualInfo").innerHTML = result.tradeId;
					document.getElementById("desc").innerHTML = result.tradeId;
					document.getElementById("alipayhandDiv").style.display = "";
					document.getElementById("finButton").style.display = "none";
					document.getElementById("moneyDiv").style.display = "none";
					document.getElementById("alypayName").innerHTML = result.fownerName;
					document.getElementById("alypayNumber").innerHTML = result.fbankNumber;
					document.getElementById("rfbankAddress").innerHTML = result.fbankAddress;
					refTenbody();
				} else if (type == 4) {//网银
					//document.getElementById("tips1").innerHTML = language["comm.error.tips.89"];
					document.getElementById("tips2").innerHTML = language["comm.error.tips.90"];
					document.getElementById("tips3").innerHTML = language["comm.error.tips.91"];
					//document.getElementById("tips2ul").style.display = "none";
					document.getElementById("alipayhandDiv").style.display = "";
					
					document.getElementById("bankMoney").innerHTML = result.money;
					document.getElementById("subMoney").innerHTML = result.money;
					document.getElementById("bankInfo").innerHTML = result.tradeId;
					document.getElementById("desc").innerHTML = result.tradeId;
					document.getElementById("alipayhandDiv").style.display = "";
					document.getElementById("finButton").style.display = "none";
					document.getElementById("moneyDiv").style.display = "none";
					document.getElementById("fownerName").innerHTML = result.fownerName;
					document.getElementById("fbankNumber").innerHTML = result.fbankNumber;
					document.getElementById("fbankAddress").innerHTML = result.fbankAddress;
					refTenbody();
				}
				document.getElementById("specificStepBackground").className = "specificStepBackground2";
				document.getElementById("specificStepHintText2").className="specificStepText specificStepSel"
			}
			document.getElementById("rfownerName").innerHTML = result.fownerName;
			document.getElementById("rfbankNumber").innerHTML = result.fbankNumber;
			document.getElementById("rfbankAddress").innerHTML = result.fbankAddress;
		});
		return;
	}
	document.getElementById("finTipsDiv").style.display = "";
	dialogBoxShadow();
	var finButton = document.getElementById("finButton");
	finButton.target = "_blank";
	finButton.href = "/account/pay/jump.html?type=" + type + "&money=" + money + typeParam;
}

function closeFinTipsDiv() {
	dialogBoxHidden();
	document.getElementById("finTipsDiv").style.display = "none";
}

function showDiyMoney(type) {
	if (type == 6) {
		document.getElementById("diyMoney").style.display = "";
		document.getElementById("randomSpan").style.display = "";
	} else {
		document.getElementById("diyMoney").style.display = "none";
		document.getElementById("randomSpan").style.display = "none";
	}
}
function clearDiyMoney() {
	var diyMoney = document.getElementById("diyMoney").value;
	if (language["comm.error.tips.92"] == diyMoney) {
		document.getElementById("diyMoney").value = "";
	}
}

function changebank(id) {
	jQuery("#banks").find("label").each(function() {
		jQuery(this).removeClass(" current");
	});
	jQuery("#label_" + id).addClass(" current");
}
var bankId = document.getElementsByName("bankID");
for ( var i = 0; i < bankId.length; i++) {
	bankId[i].onclick = function() {
		changebank(this.id);
	};
}

function moreBanks() {
	document.getElementById("li_Bank12").style.display = "";
	document.getElementById("li_Bank14").style.display = "";
	document.getElementById("li_Bank15").style.display = "";
	document.getElementById("li_Bank16").style.display = "";
	document.getElementById("li_Bank19").style.display = "";
	document.getElementById("moreBanks").style.display = "none";
}
/**
 * 支付宝人工操作 返回修改金额
 */
function backModifyMoney() {
	document.getElementById("alipayhandDiv").style.display = "none";
	document.getElementById("finButton").style.display = "";
	document.getElementById("moneyDiv").style.display = "";
	document.getElementById("specificStepBackground").className = "specificStepBackground1";
}

function submitPaymentInformation() {
	var type = document.getElementById("finType").value;
	var des = language["comm.error.tips.93"];
	if (type == 4) {
		des = language["comm.error.tips.93"];
	} else if (type == 3) {
		des = language["comm.error.tips.94"];
	}
	var callback = {
		okBack : function() {
			document.getElementById("alipayhandDiv").style.display = "none";
			document.getElementById("blankRemittance").style.display = "";
			document.getElementById("specificStepBackground").className = "specificStepBackground3";
			document.getElementById("specificStepHintText3").className="specificStepText specificStepSel"
		}
	}
	okcoinAlert(des, true, callback);
}

function submitTransferAccounts() {
	var bank = document.getElementById("fromBank").value;
	var account = document.getElementById("fromAccount").value;
	var payee = document.getElementById("fromPayee").value;
	var phone = document.getElementById("fromPhone").value;
	var obj = document.getElementsByName("fromType");
	var type = "";
	for ( var i = 0; i < obj.length; i++) {
		if (obj.item(i).checked) {
			type = obj.item(i).getAttribute("value");
			break;
		} else {
			continue;
		}
	}
	var desc = document.getElementById("desc").innerHTML;
	if (bank == "" || account == "" || payee == "" || phone == "" || type == "" || desc == "") {
		okcoinAlert(language["comm.error.tips.95"], "", null);
		return;
	}
	var url = "/account/rechargeCnySubmit.html?random=" + Math.round(Math.random() * 100);
	var param = {
		bank : bank,
		account : account,
		payee : payee,
		phone : phone,
		type : type,
		desc : desc
	};
	jQuery.post(url, param, function(result) {
		if (result != null) {
			if (result.code == -2) {
				okcoinAlert(result.msg, "", null);
			} else if (result.code == 0) {
				document.getElementById("blankRemittance").style.display = "none";
				document.getElementById("TransferAccountsComplete").style.display = "block";
				document.getElementById("riskArea4").style.display = "";
				refTenbody();
				document.getElementById("specificStepBackground").className = "specificStepBackground4";
				document.getElementById("specificStepHintText4").className="specificStepText specificStepr specificStepSel"
			} else if (result.code == -3) {
				okcoinAlert(result.msg, "", null);
			}
		}
	});
}

function updateFinTransactionReceive(fid, money, bank, bankNo, receiveName) {
	document.getElementById("rfownerName").innerHTML = bank;
	document.getElementById("rfbankNumber").innerHTML = receiveName;
	document.getElementById("rfbankAddress").innerHTML = bankNo;
	document.getElementById("subMoney").innerHTML = money;
	document.getElementById("desc").innerHTML = fid;
	document.getElementById("finButton").style.display = "none";
	document.getElementById("moneyDiv").style.display = "none";
	document.getElementById("alipayhandDiv").style.display = "none";
	document.getElementById("blankRemittance").style.display = "";
	document.getElementById("TransferAccountsComplete").style.display = "none";
	document.getElementById("specificStepBackground").className = "specificStepBackground3";
}

function cancelRechargeCNY(id) {
	var callback = {
		okBack : function() {
			var url = "/account/cancelRechargeCnySubmit.html?random=" + Math.round(Math.random() * 100);
			var param = {
				id : id
			};
			jQuery.post(url, param, function(result) {
				if (result != null) {
					window.location.reload(true);
				}
			});
		},
		noBack : function() {
			return false;
		}
	};
	okcoinAlert(language["comm.error.tips.96"], true, callback);
}

function refTenbody() {
	var currentPage = document.getElementById("currentPage").value;
	var url = "/account/refTenbody.html?currentPage=" + currentPage + "&random=" + Math.round(Math.random() * 100);
	jQuery("#Tenbody").load(url, null, function(data) {
	});
}