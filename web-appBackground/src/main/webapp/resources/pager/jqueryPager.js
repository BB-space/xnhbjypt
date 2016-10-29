$(document).ready(function() {
			$(".item_page ul li:gt(9)").hide();//初始化，前面4条数据显示，其他的数据隐藏。
			var total_q = $(".item_page ul li").index() + 1;//总数据
			var current_page = 10;//每页显示的数据  
			var current_num = 1;//当前页数 
			var total_page = Math.ceil(total_q / current_page);//总页数  
			var next = $(".next");//下一页
			var prev = $(".prev");//上一页
			$(".total_show").text(total_q);
			$(".page_count_show").text(total_page);  
			$(".total").text(total_page);//显示总页数
			$(".current_page").text(current_num);//当前的页数

			//next_page
			$(".next").click(function() {
				if (current_num == total_page) {
					return false;//如果大于总页数就禁用下一页
				} else {
					$(".current_page").text(++current_num);//点击下一页的时候当前页数的值就加1
					$.each($('.item_page ul li'), function(index, item) {
						var start = current_page * (current_num - 1);//起始范围
						var end = current_page * current_num;//结束范围
						if (index >= start && index < end) {//如果索引值是在start和end之间的元素就显示，否则就隐
							$(this).show();
						} else {
							$(this).hide();
						}
					});
				}
			});
			//pre_page
			$(".prev").click(function() {
				if (current_num == 1) {
					return false;
				} else {
					$(".current_page").text(--current_num);
					$.each($('.item_page ul li'), function(index, item) {
						var start = current_page * (current_num - 1);//起始范围
						var end = current_page * current_num;//结束范围
						if (index >= start && index < end) {//如果索引值是在start和end之间的元素就显示，否则就隐藏
							$(this).show();
						} else {
							$(this).hide();
						}
					});
				}
			});
			//home_page
			$(".home_page").click(function() {
				$(".total").text(total_page);
				current_num = 1;
				$(".current_page").text(current_num);
				$(".item_page ul li:lt(9)").show();
				$(".item_page ul li:gt(9)").hide();
				
			});
			//end_page
			$(".end_page").click(function() { 
				var remainder = total_q%current_page;
				//alert(remainder);
				var endShowNum  = total_q-remainder;
				current_num = total_page;
				$(".current_page").text(current_num);
				$.each($('.item_page ul li'), function(index, item) {
					var start = current_page * (total_page - 1);//起始范围
					var end = total_q;//结束范围
					if (index >= start && index < end) {//如果索引值是在start和end之间的元素就显示，否则就隐藏
						$(this).show();
					} else {
						$(this).hide();
					}
				});

			})
		});