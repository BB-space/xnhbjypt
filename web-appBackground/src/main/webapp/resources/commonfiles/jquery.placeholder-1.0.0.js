/*
 * jQuery placeholder, fix for IE6,7,8,9
 * @author LY
 * @since 20160304.1.0.0
 */
var JPlaceHolder = {
	// 检测
	_check : function() {
		return 'placeholder' in document.createElement('input');
	},
	// 初始化
	init : function() {
		if (!this._check()) {
			this.fix();
		}
	},
	// 修复
	fix : function() {
		jQuery(':input[placeholder]').each(function(index, element) {
			var self = this, $self = jQuery(this); 
			self.onfocus = function() {
				var placeholder = jQuery(this).attr('placeholder') || ''; 
				var tips = jQuery(this).attr('tips') || '';
				if (tips == "password") {
					jQuery(this).attr('type',"password"); 
				}
				if (this.value == placeholder) {
					this.value = '';
					this.style.color = "";
				}
			}
			self.onblur = function() {
				var placeholder = jQuery(this).attr('placeholder') || ''; 
				var type = jQuery(this).attr('type') || '';
				if (this.value == '') {
					if (type == "password") {
						jQuery(this).attr('type',"text"); 
						jQuery(this).attr("tips", "password");
					}
					this.value = placeholder;
					this.style.color = "grey";
				}
			}
			if ($self.attr('type') == "password") {
				$self.attr('type',"text") ;
				$self.attr("tips", "password");
			}
			self.value = $self.attr('placeholder') || '';
			self.style.color = "grey";
		});
	}
};
// 执行
jQuery(function() {
	JPlaceHolder.init();
});