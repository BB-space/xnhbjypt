var drx = $.extend({}, drx);/* 全局对象 */
 //当选中一个省份后，查询对应的市区名称
 function province1(){

  var province = $("#province");
  if(province.val() != "0"){
	var provinceId = province.val();
   $.post("city.do?cityList",{"provinceId":provinceId},callback2);
  }else{
   //当用户没有选择省份的时候，就将市区下拉列表框中原有的“请选择”字样删除。
   $("#city").empty();
  }
  //当用户进行一次省市县的操作后，再次选择省份的时候，后面的县区里面如果有值就要清空
  var shop = $("#shop");
  shop.empty();
 }
 
 //市区
 function callback2(data) {
  var data = eval("(" + data + ")");
  var city = $("#city");
  city.empty();
  city.append("<option value=0>请选择城市</option>");
  for ( var i = 0; i < data.length; i++) {
	  city.append("<option value=" + data[i].id + ">"+ data[i].cityName + "</option>");
  }
 }
 
 //当选中市区名称后，查询对应的门店名称
 function city1(){
  var city = $("#city");
  if(city.val() != "0"){ 
	  var cityId = city.val();
	  $.post("shop.do?shopList",{"cityId":cityId},callback3);
  }else{
   //当用户没有选择市区的时候，就将门店下拉列表框中原有的“请选择”字样删除。
   $("#shop").empty();
  }
 }
 
 //门店
 function callback3(data) {
  var data = eval("(" + data + ")");
  var shop = $("#shop");
  shop.empty();
  shop.append("<option value=0>请选择门店</option>");
  for ( var i = 0; i < data.length; i++) {
	  shop.append("<option value=" + data[i].id + ">"+ data[i].shopName + "</option>");
  }
 }
 
function findProvince(){
	$.post("province.do?provinceList", null,function(data) {
		  var data = eval("(" + data + ")");
		  var province = $("#province");
		  province.empty();
		  province.append("<option value=0>请选择省份</option>");
		  for ( var i = 0; i < data.length; i++) {
			  province.append("<option value=" + data[i].id + ">"+ data[i].provinceName + "</option>");
		  }
		 });
}

function subcenter1(){
	$.post("subcenter.do?subcenterList", null,function(data) {
		  var data = eval("(" + data + ")");
		  var subcenter = $("#subcenter");
		  subcenter.empty();
		  subcenter.append("<option value=0>请选择</option>");
		  for ( var i = 0; i < data.length; i++) {
			  subcenter.append("<option value=" + data[i].id + ">"+ data[i].subcenterName + "</option>");
		  }
		 });
}
 
function selectValue(sId,value){  
    var s = document.getElementById(sId);  
    var ops = s.options;  
    for(var i=0;i<ops.length; i++){  
        var tempValue = ops[i].value;  
        if(tempValue == value)  
        {  
            ops[i].selected = true;  
        }  
    }  
} 

 $(document).ready(function(){
	 findProvince();
	 subcenter1();
	});