/**
 * 提交问题
 */
function submitQuestion() {
	var questionType = document.getElementById("questionType").value;
	var desc = document.getElementById("desc").value;
	var name = document.getElementById("name").value;
	var phone = document.getElementById("phone").value;

	if (questionType == -1) {
		document.getElementById("errorMsg").innerHTML = language["comm.error.tips.49"];
		return;
	} else {
		document.getElementById("errorMsg").innerHTML = "&nbsp;";
	}

	if (desc == "") {
		document.getElementById("errorMsg").innerHTML = language["comm.error.tips.50"];
		return;
	} else {
		document.getElementById("errorMsg").innerHTML = "&nbsp;";
	}
	if (desc.length > 200) {
		document.getElementById("errorMsg").innerHTML = language["comm.error.tips.51"];
		return;
	} else {
		document.getElementById("errorMsg").innerHTML = "&nbsp;";
	}
	if (name == "") {
		document.getElementById("errorMsg").innerHTML = language["comm.error.tips.52"];
		return;
	} else {
		document.getElementById("errorMsg").innerHTML = "&nbsp;";
	}
	if (phone == "") {
		document.getElementById("errorMsg").innerHTML = language["comm.error.tips.53"];
		return;
	} else {
		document.getElementById("errorMsg").innerHTML = "&nbsp;";
	}
	var url = "/question/submitQuestion.html?random=" + Math.round(Math.random() * 100);
	var param = {
		questionType : questionType,
		desc : desc,
		name : name,
		phone : phone
	};
	jQuery.post(url, param, function(data) {
		if (data.code == 0) {
			// 成功
			window.location.href = "/question/questionColumn.html";
		}
	},"json");
}

/**
 * 撤销
 */
function cancelQuestion(id) {
	var currentPage = document.getElementById("currentPage").value;
	var type = document.getElementById("type").value;
	var url = "/question/cancelQuestion.html?qid=" + id + "&type=" + type + "&currentPage=" + currentPage + "&random=" + Math.round(Math.random() * 100);
	window.location.href = url;
}

function messagedetail(id) {
	var $dialog = jQuery("#dialog");
	var url = "/question/messagedetail.html?random=" + Math.round(Math.random() * 100);
	var param = {
		id : id
	};
	jQuery.post(url, param, function(data) {
		if (data != null && data.result == true) {
			$dialog.html(data.content);
			$dialog.dialog({
				height : 260,
				width : 830,
				resizable : false,
				title : data.title,
				draggable : false
			});
		}
	}, "json");
}
