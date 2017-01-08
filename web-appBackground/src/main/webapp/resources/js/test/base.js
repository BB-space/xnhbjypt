(function(){
	
	//顶端adver渐隐
	
function FadeAdver(args){
	for(var i in args){
			this[i] = args[i];	
		}	
		this.speed = args.speed ? args.speed : 5000;	//间隔时间默认5秒
		this.sTime = args.sTime ? args.sTime : 500;	//渐进时间，默认1秒
		this.load();
		this.start();
}

FadeAdver.prototype ={
	constructor : this,
	load : function(){
		var _this = this;
		this.num = 0;	//计时器
		this.mNum = this.num+1;	//轮播计时
		this.len = this.divs.length;					
		
		//所有div设置absolute并排好index
		this.divs.each(function(num){
			var z_index = 50-num;
			$(this).css({
				"position" : "absolute",
				"left" : 0,
				"top" : 0,
				"z-index" : z_index,
				"display" : "none"	
			})
		});
		
		$(this.divs[0]).show();
		
		//所有div设置absolute并排好index
		
			
		this.btns.each(function(num){
			$(this).mouseover(function(){
				_this.show(num);	
				_this.stop();				
			}).mouseout(function(){
				_this.start();	
			});	
		});
		
		//左右按钮的使用
		if(!!this.preBtn && !!this.nextBtn){
			this.preBtn.css("z-index",60);
			this.preBtn.click(function(){
				var num = _this.num - 1;
				if(num < 0){
					num = _this.len-1;		
				}	
				_this.show(num);
			});	
			this.nextBtn.css("z-index",60);
			this.nextBtn.click(function(){
				var num = _this.num + 1;
				if(num >= _this.len){
					num = 0;		
				}	
				_this.show(num);
			});	
		}
		
		this.divs.each(function(num){
			$(this).mouseover(function(){					
				_this.stop();				
			}).mouseout(function(){
				_this.start();	
			});	
		});
	},
	show : function(num){
		if(num == this.num) return;	//同一个返回
		
		
		var _this = this;
		this.flag  = false;	//关闭控制开关
		this.btns.each(function(i){
			if(i == num){
				$(this).addClass("hover");	
			}else{
				$(this).removeClass("hover");	
			}				
		});
				
		$(this.divs[this.num]).fadeOut(this.sTime);	//旧的淡出
						
		$(this.divs[num]).fadeIn(_this.sTime);		//新的淡入
		_this.num = num;	
		_this.mNum = num+1;			
				
	},
	start : function(){
		var _this = this;					
		this.interval = setInterval(function(){					
			if(_this.mNum >= _this.len){
				_this.mNum = 0;
			}						
			_this.show(_this.mNum);								
		},this.speed);
	},
	stop : function(){
		clearInterval(this.interval);
	}	
};

window.FadeAdver = FadeAdver;
//顶端adver	

//清除所有input的value
	function ClearValue(forms){
		this.forms = forms;
		this.load();	
	}
	
	ClearValue.prototype = {
		constructor : this,
		load : function(){
			var _this = this;			
			this.forms.each(function(){
				_this.clearValue($(this));	
			});
		},
		clearValue : function(fm){			
			this.inputs = $("input.text,input.keyword",fm);
			this.textarea = $("textarea",fm);
			var _this = this;
			var dValues = [];	
			var aValues = [];		
			this.inputs.each(function(n){
				dValues[n] = $(_this.inputs[n]).val();
			});
			this.textarea.each(function(n){
				aValues[n] = $(_this.textarea[n]).html();
			});
						
			this.inputs.each(function(n){
				$(this).focus(function(){
					if($(this).val() == dValues[n]){
						$(this).val("");	
						$(this).addClass("text_hover");
					}
				});	
				$(this).blur(function(){
					if($(this).val() == ""){
						$(this).val(dValues[n]);	
						$(this).removeClass("text_hover");
					}else{
						$(this).addClass("text_hover");	
					}
				});
			});	
			this.textarea.each(function(n){
				$(this).focus(function(){
					if($(this).html() == aValues[n]){
						$(this).html("");	
						$(this).removeClass("text_hover");
					}
				});	
				$(this).blur(function(){
					if($(this).html() == ""){
						$(this).html(aValues[n]);	
						$(this).removeClass("text_hover");
					}else{
						$(this).addClass("text_hover");		
					}
				});	
			});
		}	
	};
	
	window.ClearValue = ClearValue;
	//清除所有input的value
	
	//ChangeDiv切换效果
function ChangeDiv(args){
	for(var i in args){
		this[i] = args[i];	
	}	
	this.type = this.type ? this.type : "mouseover";
	this.load();
}

ChangeDiv.prototype = {
	constructor : this,
	load : function(){
		var _this = this;
		this.btns.each(function(num){
			if(_this.type == "click"){
				$(this).click(function(){
					_this.change(num)	
				});		
			}else{
				$(this).mouseover(function(){
					_this.change(num)	
				});		
			}			
		});	
	},
	change : function(num){
		var _this = this;
		
		this.btns.each(function(n){
			if(n ==num){
				$(this).addClass("hover");		
			}else{
				$(this).removeClass("hover");		
			}				
		});
		
		this.divs.each(function(n){
			if(n ==num){
				$(this).addClass("show");		
			}else{
				$(this).removeClass("show");		
			}				
		});
	}	
};

window.ChangeDiv = ChangeDiv;
//ChangeDiv切换效果

})();

$(function(){

	new ClearValue($("form"));	//清除默认文字

	$(".ps1").focus(function(){
			var _par = $(this).parent();
			$(this).hide();
			$(".ps2",_par).show().focus();	
		});
		
		$(".ps2").blur(function(){
			var _par = $(this).parent();
			if($(this).val() == ""){
				$(this).hide();
				$(".ps1",_par).show();		
			}							
		});
	
	new ChangeDiv({
		btns : $(".lgwin_handle span"),
		divs : $(".login_win .lgwin_wrap"),
		type : "click"	
	});
		
	//登录注册弹窗
	$("#login_a").click(function(){
		$(".alert_flog").show();
//		$(".login_win").show();	
		$("#login_win").show();	
		$(".lgwin_handle .a1").click();
	});
	$("#reg_a").click(function(){
		$(".alert_flog").show();
//		$(".login_win").show();	
		$("#login_win").show();	
		$(".lgwin_handle .a2").click();
	});
	
	$(".lg_win .res").click(function(){
		$(".alert_flog").hide();
		$(".lg_win").hide();		
	});
	

	
	//发送验证码的效果
//	var getTime = 0;
//	$(".get_yz").click(function(){
//		
//		var _this = this;
//		if($(this).hasClass("yz_unable")){
//			return;	
//		}	
//		
//		$(this).addClass("yz_unable");
//		
//		var numAll = 60;
//		
//		$(this).html(numAll+"秒后重发");		
//		
//		getTime = setInterval(function(){
//			numAll--;
//			
//			if(numAll <= 0){
//				$(_this).removeClass("yz_unable");	
//				$(_this).html("发送验证码");
//				clearInterval(getTime);
//				return;
//			}
//			
//			$(_this).html(numAll+"秒后重发");	
//		},1000);
//		
//	});
	
	//ad_aside 的hover效果
	var _adindex = $(".ad_aside .hover").index();
	var _adTime = 0;	
	$(".ad_aside a").hover(function(){
		clearTimeout(_adTime);
		$(".ad_aside a").removeClass("hover");	
	},function(){
		_adTime = setTimeout(function(){
			$($(".ad_aside a")[_adindex]).addClass("hover");	
		},200);	
	});
	
	//表单验证
	$(".lg_win form").Validform({
		tiptype:3	
	});

});	