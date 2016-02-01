$.fn.chkCss=function(){
 var browser=$.browser.msie;
 $(this).css("display","none");
 $(this).next().addClass("lblCss");
 this.each(function(){
   var _this=this;
   var _label=$(_this).next();
   if(_this.checked==true) _label.addClass("chked");
   _label.bind("click",function(){
	 if(_this.checked==true){
	   if(browser) _this.checked=false;
	   _label.removeClass("chked");
	 }
	 else{
	   if(browser) _this.checked=true;
	   _label.addClass("chked");
	 }
   });
 });
};