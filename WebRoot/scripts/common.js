$(document).ready(function(){
	$('.view1 ul li a').click(function(){
		$('.view1 ul li a').removeClass('hover');
		$(this).toggleClass('hover');
	});
	$('.leftLine3 ul li a').click(function(){
		$('.leftLine3 ul li a').removeClass('hover');
		$(this).toggleClass('hover');
	});
	$('.SubMenu ul li a').click(function(){
		$('.SubMenu ul li a').removeClass('hover');
		$(this).toggleClass('hover');
	});
	/*
	$('.view1 ul li a, .leftLine3 ul li a').hover(
		function(){
			if($(this).is('.hover')){}
			else{
				$(this).addClass('hover');
			}
	},
		function(){
			$(this).addClass('hover');
	}
	);
	*/
});

//add obj id="cwin" name="cwin" onload="Javascript:SetCwinHeight(this)"
function SetCwinHeight(obj){
	var cwin=obj;
	if (document.getElementById){
    if (cwin && !window.opera){
		if (cwin.contentDocument && cwin.contentDocument.body.offsetHeight)
        cwin.height = cwin.contentDocument.body.offsetHeight+50;
      	else if(cwin.Document && cwin.Document.body.scrollHeight)
        cwin.height = cwin.Document.body.scrollHeight;
		}
	}
}

$(function() {
	$(".TopMenu").tabs();
	$("input[name='infectant_id']").chkCss();
	$(".tableSty1 table tr").hover(
		function(){
			$(this).addClass("hover");
		},function(){
			$(this).removeClass("hover");
			}
		);
	$(".tableSty1 table th").hover(
		function(){
			$(this).addClass("thh");
		},function(){
			$(this).removeClass("thh");
			}
		);
});