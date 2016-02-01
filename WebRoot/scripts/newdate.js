/*

    本日历控件基于POPUP,专为解决日历控件被窗口遮盖的问题而设计


    作者信息:谢月甲,没有耳多,biisom@gmail.com,http://www.cwzb.name
    
    修改日志：

    ---------------------------------------------------------------
    20060930：增加日历数据清除功能
    20060404：对直接选择年月，做了限制
    20060324：去掉显示引用控件里的数据的功能
    20060315：完成初步的优化工作
    20060314：正试完成封装

    20060312：初步完成功能

*/

var procScript = ""+
"var td_onmoveover_color = 'green'; \n"+
"function $(e){return document.all[e];} \n"+    
"function processData(e,arg)"+
"    {"+
"        if(arg == 'c')"+
"        {"+
"            parent.Calendar.Clear();return;"+
"        }"+
"        "+
"        if(e == null)"+
"           e = event.srcElement;"+
"        "+
"        var y = parseInt($(\"year\").value);"+
"        var m = parseInt($(\"month\").value);"+
"        "+
"        var d = e.innerText.replace(/ /g,\"\");"+
"        var temp = null; "+
"        if(d.length > 0)"+
"        {"+
"            temp = y+\"-\"+m+\"-\"+d;"+
"            e.style.backgroundColor = '';"+
"        }"+
"        else if(e.tagName.toLowerCase() == 'input')"+
"            temp = y+\"-\"+m;"+
"     "+
"        if(temp != null)"+
"           parent.Calendar.Hide(temp);"+
"    }";


function PopCalendar()
{
    this.version = "0.1.06.0930";
	this.target  = null;
    
    this.show = function(refObj,showType,initYear)//3：显示所有操作,2：只显示日历操作(默认)，1：只显示年月操作
    {
		if(showType == null)
			showType = "2";
		else
			showType += "";	
		
		this.target = refObj;
			
        this._init(refObj,initYear,showType);
        
        var width = (showType==2 ? 180:200);
        var height = (showType == 1 ? 47 : 162)
        
        this._popup.show(0,refObj.offsetHeight,width,height,refObj);
        
        //var p_doc = this._popup.document;
		
		//p_doc.all["ref_val"].value  = refObj.value;	
    }
    
    this.hide = function()
    {
        this._popup.hide();
    }
    
    this._popup = null;        
    this._init  = function(refObj,initYear,showType)
    {
        if(this._popup == null)
        {
            this._popup = window.createPopup();
            
            this._popup.document.body.innerHTML = unescape(htmlCode);
            
            var bodyHTML = this._popup.document.body.outerHTML;
            this._popup.document.write("<head><style> div,table,select,td,input{font-size:9pt;font-family:宋体;} input,select{border: gray 1px solid;} </style></head>");
            
            this._popup.document.write("<script>");
            this._popup.document.write(procScript + " \n");
            this._popup.document.write(unescape(mainScript) +" \n");
            this._popup.document.write("<\/script> \n");
            
            this._popup.document.write(bodyHTML);
            
            var year = initYear;
            if(year == null)
				year = "null";
                                    
            this._popup.document.write("<script>");
            this._popup.document.write("init("+year+","+showType+"); \n");
            this._popup.document.write("<\/script> \n");
        }
    }
}




var mainScript = "//%0D%0A//%u6784%u5EFA%u65E5%u5386%u6570%u636E%0D%0A//%0D%0Afunction%20_build%28y%2Cm%29%0D%0A%7B%0D%0A%20%20%20%20if%28y%20%3D%3D%20null%29%7By%20%3D%20%24%28%22year%22%29.value%3B%7D%0D%0A%20%20%20%20if%28m%20%3D%3D%20null%29%7Bm%20%3D%20%24%28%22month%22%29.value%3B%7D%0D%0A%20%20%20%20%0D%0A%20%20%20%20var%20begin_Day%20%3D%201%3B%0D%0A%20%20%20%20var%20last_Day%20%3D%20_getLastDay%28y%2Cm%29%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20var%20begin_week%20%3D%20_getWeek%28y%2Cm%2Cbegin_Day%29%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20var%20temp%20%3D%20begin_Day%3B%0D%0A%20%20%20%20var%20cell%20%3D%20null%3B%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20for%28var%20i%3D0%3B%20i%3C6%3B%20i++%29%0D%0A%20%20%20%20%7B%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20for%28var%20j%3D0%3B%20j%3C7%3B%20j++%29%0D%0A%20%20%20%20%20%20%20%20%7B%20%20%20%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20cell%20%3D%20%24%28%22c%22+i%20+%20%22%22%20+j%29%3B%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20if%28i%20%3D%3D%200%20%26%26%20j%3Cbegin_week%29%7Bcell.innerText%20%3D%20%22%20%22%3B%7Delse%7Bif%28temp%20%3C%3D%20last_Day%29%7Bcell.innerText%20%3D%20temp%3B%20temp%20++%3B%7D%20else%7Bcell.innerText%20%3D%20%22%20%22%3B%7D%7D%0D%0A%20%20%20%20%20%20%20%20%7D%0D%0A%20%20%20%20%7D%0D%0A%7D%0D%0A%0D%0A//%0D%0A//%u6839%u636E%u5E74%u6708%2C%u83B7%u5F97%u8BE5%u4EFD%u6700%u7684%u6700%u540E%u4E00%u5929%u662F%u591A%u5C11%u53F7%0D%0D%0A//%0D%0Afunction%20_getLastDay%28y%2Cm%29%0D%0A%7B%0D%0A%20%20%20%20if%28%28m%20%3C%208%20%26%26%20m%252%20%3D%3D%201%29%20%7C%7C%20%28m%20%3E%207%20%26%26%20m%252%20%3D%3D%200%29%29%20return%2031%3B%0D%0A%20%20%20%20else%20if%28m%20%21%3D%202%29%20return%2030%3B%0D%0A%20%20%20%20else%7Bif%28%28y%254%20%3D%3D0%29%20%26%26%20%28%28y%25100%20%21%3D%200%29%7C%7C%28y%25400%20%3D%3D%200%29%29%29%20%7B%20return%2029%3B%7D%20else%20%7Breturn%2028%3B%7D%7D%0D%0A%7D%0D%0A%0D%0A//%0D%0A//%u6839%u636E%u65E5%u671F%2C%u6765%u83B7%u53D6%u5F53%u524D%u65E5%u671F%u4E3A%u661F%u671F%u51E0%0D%0D%0A//%0D%0Afunction%20_getWeek%28y%2Cm%2Cd%29%0D%0A%7B%0D%0A%20%20%20return%20new%20Date%28y%2Cm-1%2Cd%29.getDay%28%29%20%25%207%3B%0D%0A%7D%0D%0A%0D%0A//%0D%0A//%u91CD%u6784%u5E74%u4EFD%u4E0B%u62C9%u6846%0D%0D%0A//%20%0D%0Afunction%20_rebuildYear%28y%29%0D%0A%7B%0D%0A%20%20%20%20var%20maxY%20%3D%20y%20+%205%3B%0D%0A%20%20%20%20var%20minY%20%3D%20y%20-%205%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20var%20htmlText%20%3D%20%22%3Cselect%20id%3D%27year%27%20onchange%3D%27chanage%28%29%3B%27%3E%22%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20for%28var%20i%3DminY%3B%20i%3CmaxY%3B%20i++%29%0D%0A%20%20%20%20%20%20%20%20htmlText%20+%3D%22%3Coption%20value%3D%27%22+i+%22%27%3E%22+i+%22%3C/option%3E%22%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20htmlText%20+%3D%20%22%3C/select%3E%22%3B%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%24%28%22year%22%29.outerHTML%20%3D%20%20htmlText%3B%0D%0A%7D%0D%0A%0D%0A//%0D%0A//%u521D%u59CB%u5316%u65E5%u5386%u63A7%u4EF6%0D%0D%0A//%0D%0Afunction%20init%28initYear%2CshowType%29%0D%0A%7B%0D%0A%20%20%20%20var%20cell%20%3D%20null%3B%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20for%28var%20i%3D0%3B%20i%3C6%3B%20i++%29%0D%0A%20%20%20%20%7B%0D%0A%20%20%20%20%20%20%20%20for%28var%20j%3D0%3B%20j%3C7%3B%20j++%29%0D%0A%20%20%20%20%20%20%20%20%7B%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20cell%20%3D%20%24%28%22c%22+i%20+%20%22%22%20+j%29%3B%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20cell.align%20%20%20%3D%20%22center%22%3B%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20cell.onclick%20%20%20%20%20%3D%20processData%3B%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20cell.onmouseout%20%20%3D%20function%28%29%7Bthis.style.backgroundColor%20%3D%20%22%22%3B%7D%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20cell.onmouseover%20%3D%20function%28%29%7Bthis.style.backgroundColor%20%3D%20td_onmoveover_color%3B%7D%0D%0A%20%20%20%20%20%20%20%20%7D%0D%0A%20%20%20%20%7D%0D%0A%20%20%20%20%0D%0A%20%20%20%20var%20d%20%3D%20new%20Date%28%29%3B%0D%0A%20%20%20%20if%28initYear%3D%3Dnull%29%0D%0A%09initYear%20%3D%20d.getFullYear%28%29%3B%0D%0A%09%0D%0A%20%20%20%20_select%28initYear%2Cd.getMonth%28%29+1%29%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20var%20ymOk%20%3D%20%24%28%22ymOk%22%29%3B%0D%0A%09var%20body%20%3D%20%24%28%22body%22%29%3B%0D%0A%09%0D%0A%09if%28showType%20%3D%3D%20null%29%0D%0A%09%09showType%20%3D%202%3B%09%0D%0A%09%0D%0A%09switch%28showType%29%0D%0A%09%7B%0D%0A%09%09case%201%3A%0D%0A%09%09%09ymOk.style.display%20%3D%20%22inline%22%3B%0D%0A%09%09%09ymOk.disabled%20%3D%20false%3B%0D%0A%09%09%09ymOk.title%09%20%20%3D%20%22%u5355%u51FB%u53EF%u76F4%u63A5%u62E9%u5E74%u4EFD%22%3B%0D%0A%09%09%09body.style.display%20%3D%20%22none%22%3B%0D%0A%09%09%09break%3B%0D%0A%09%09%09%09%0D%0A%09%09case%203%3A%0D%0A%09%09%09ymOk.style.display%20%3D%20%22inline%22%3B%0D%0A%09%09%09ymOk.disabled%20%3D%20false%3B%0D%0A%09%09%09ymOk.title%09%20%20%3D%20%22%u5355%u51FB%u53EF%u76F4%u63A5%u62E9%u5E74%u4EFD%22%3B%0D%0A%09%09%09body.style.display%20%3D%20%22block%22%3B%0D%0A%09%09%09break%3B%0D%0A%09%09%0D%0A%09%09default%3A%09//%u5176%u5B83%u503C%u4E0E2%u4E3A%u540C%u7C7B%u578B%u663E%u793A%0D%0A%09%09%09ymOk.style.display%20%3D%20%22none%22%3B%0D%0A%09%09%09ymOk.disabled%20%3D%20true%3B%0D%0A%09%09%09ymOk.title%09%20%20%3D%20%22%u4E0D%u53EF%u76F4%u63A5%u9009%u62E9%u5E74%u6708%22%3B%0D%0A%09%09%09body.style.display%20%3D%20%22block%22%3B%0D%0A%09%09%09break%3B%0D%0A%09%7D%0D%0A%7D%0D%0A%0D%0A//%0D%0A//%u9009%u62E9%u65E5%u671F%0D%0A//%0D%0Avar%20_selected_cell%20%3D%20null%3B%0D%0A%0D%0Afunction%20_select%28y%2Cm%2Cd%29%0D%0A%7B%0D%0A%20%20%20%20_rebuildYear%28y%29%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20%24%28%22year%22%29.value%20%20%3D%20y%3B%0D%0A%20%20%20%20%24%28%22month%22%29.value%20%3D%20m%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20_build%28y%2Cm%29%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20if%28d%20%21%3D%20null%20%26%26%20d.length%20%3E%204%29%0D%0A%20%20%20%20%7B%0D%0A%09%09var%20temp%20%3D%20new%20Date%28y%2Cm%2C1%29.getDay%28%29%20-%201%3B%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20var%20row%20%3D%20parseInt%28%28parseInt%28d%29+temp%29/7%29%3B%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20var%20col%20%3D%20new%20Date%28y%2Cm%2Cd%29.getDay%28%29%3B%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20if%28_selected_cell%20%21%3D%20null%29%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20_selected_cell.style.backgroundColor%20%3D%20%22%22%3B%0D%0A%20%20%20%20%20%20%20%20%0D%0A%20%20%20%20%20%20%20%20_selected_cell%20%3D%20%24%28%22c%22+row%20+%20%22%22%20+col%29%3B%20%20%0D%0A%20%20%20%20%20%20%20%20_selected_cell.style.backgroundColor%20%3D%20%22%23ff8800%22%3B%0D%0A%20%20%20%20%7D%0D%0A%7D%0D%0A%0D%0Afunction%20select%28text%29%0D%0A%7B%09%0D%0A%09if%28text%20%3D%3D%20null%29%0D%0A%09%09text%20%3D%20%24%28%22ref_val%22%29.value%3B%0D%0A%09%09%0D%0A%09var%20temp%20%3D%20null%3B%20%0D%0A%09%0D%0A%09if%28text%20%3D%3D%20null%20%7C%7C%20text.length%20%3C%205%29%20%0D%0A%09%7B%0D%0A%09%09temp%20%3D%20new%20Date%28%29%3B%0D%0A%09%09_select%28temp.getFullYear%28%29%2Ctemp.getMonth%28%29+1%29%3B%0D%0A%09%7D%20%0D%0A%09else%20%0D%0A%09%7B%0D%0A%09%09temp%20%3D%20text%20+%20%22-%22%3B%0D%0A%09%09_select%28temp.split%28%27-%27%29%5B0%5D%2Ctemp.split%28%27-%27%29%5B1%5D%2Ctemp.split%28%27-%27%29%5B2%5D%29%3B%0D%0A%09%7D%09%0D%0A%7D%0D%0A%0D%0A//%0D%0A//%u53D8%u66F4%u65E5%u5386%u63A7%u4EF6%u7684%u6570%u636E%0D%0D%0A//%0D%0Afunction%20chanage%28e%29%0D%0A%7B%0D%0A%20%20%20%20var%20y%20%3D%20parseInt%28%24%28%22year%22%29.value%29%3B%0D%0A%20%20%20%20var%20m%20%3D%20parseInt%28%24%28%22month%22%29.value%29%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20if%28isNaN%28y%29%29%0D%0A%20%20%20%20%20%20%20%20y%20%3D%20new%20Date%28%29.getFullYear%28%29%3B%0D%0A%20%20%20%20%0D%0A%20%20%20%20switch%28e%29%0D%0A%20%20%20%20%7B%0D%0A%20%20%20%20%20%20%20%20case%20%22%3E%22%3A%20if%28m%20%3D%3D%2012%29%7By%20++%3Bm%20%3D%201%3B%7Delse%7Bm%20++%3B%7D%20break%3B%0D%0A%20%20%20%20%20%20%20%20case%20%22%3C%22%3A%20if%28m%20%3D%3D%201%29%7By%20--%3Bm%20%3D%2012%3B%7Delse%7Bm--%3B%7D%20break%3B%0D%0A%20%20%20%20%20%20%20%20case%20%22%3E%3E%22%3A%20y%20++%3B%20break%3B%0D%0A%20%20%20%20%20%20%20%20case%20%22%3C%3C%22%3A%20y%20--%3B%20break%3B%0D%0A%20%20%20%20%20%20%20%20case%20%22%3E%3E%3E%22%3A%20y%20+%3D%2010%3B%20break%3B%0D%0A%20%20%20%20%20%20%20%20case%20%22%3C%3C%3C%22%3A%20y%20-%3D%2010%3B%20break%3B%0D%0A%20%20%20%20%7D%0D%0A%20%20%20%20%0D%0A%20%20%20%20_select%28y%2Cm%29%3B%0D%0A%7D%20%20";
var htmlCode = "%3Cdiv%20align%3D%22center%22%20style%3D%22border%3A%20gray%201px%20solid%3B%20padding%3A%202px%3B%20font-size%3A%209pt%3B%20width%3A%20100%25%3B%22%3E%0D%0A%20%20%20%20%3Cdiv%20id%3D%22head%22%20style%3D%22height%3A23px%3B%22%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20onclick%3D%22chanage%28%27%3C%27%29%3B%22%20value%3D%22M%3C%22%20title%3D%22%u540E%u90001%u4E2A%u6708%22%20/%3E%0D%0A%20%20%20%20%20%20%20%20%3Cselect%20id%3D%22year%22%20onchange%3D%22chanage%28%29%3B%22%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%222006%22%3E2006%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%3C/select%3E%0D%0A%20%20%20%20%20%20%20%20%3Cselect%20id%3D%22month%22%20onchange%3D%22chanage%28%29%3B%22%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%2212%22%3E12%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%2211%22%3E11%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%2210%22%3E10%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%229%22%3E09%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%228%22%3E08%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%227%22%3E07%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%226%22%3E06%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%225%22%3E05%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%224%22%3E04%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%223%22%3E03%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%222%22%3E02%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Coption%20value%3D%221%22%3E01%3C/option%3E%0D%0A%20%20%20%20%20%20%20%20%3C/select%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20onclick%3D%22chanage%28%27%3E%27%29%3B%22%20value%3D%22%3EM%22%20title%3D%22%u524D%u8FDB1%u4E2A%u6708%22%20/%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20id%3D%22ymOk%22%20value%3D%22OK%22%20onclick%3D%22processData%28this%29%3B%22%20title%3D%22%u76F4%u63A5%u9009%u62E9%u5E74%u6708%22%20/%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20id%3D%22ymClear%22%20value%3D%22CL%22%20onclick%3D%22processData%28this%2C%27c%27%29%3B%22%20title%3D%22%u6E05%u7A7A%u65E5%u671F%22%20/%3E%0D%0A%20%20%20%20%3C/div%3E%0D%0A%20%20%20%20%3Cdiv%20id%3D%22body%22%3E%0D%0A%20%20%20%20%3Ctable%20width%3D%22100%25%22%20style%3D%22font-size%3A%209pt%3B%22%3E%0D%0A%20%20%20%20%20%20%20%20%3Cthead%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%3E%u65E5%3C/td%3E%3Ctd%3E%u4E00%3C/td%3E%3Ctd%3E%u4E8C%3C/td%3E%3Ctd%3E%u4E09%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%3E%u56DB%3C/td%3E%3Ctd%3E%u4E94%3C/td%3E%3Ctd%3E%u516D%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C/tr%3E%0D%0A%20%20%20%20%20%20%20%20%3C/thead%3E%0D%0A%20%20%20%20%20%20%20%20%3Ctbody%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c00%22%3E%3C/td%3E%3Ctd%20id%3D%22c01%22%3E%3C/td%3E%3Ctd%20id%3D%22c02%22%3E%3C/td%3E%3Ctd%20id%3D%22c03%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c04%22%3E%3C/td%3E%3Ctd%20id%3D%22c05%22%3E%3C/td%3E%3Ctd%20id%3D%22c06%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C/tr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c10%22%3E%3C/td%3E%3Ctd%20id%3D%22c11%22%3E%3C/td%3E%3Ctd%20id%3D%22c12%22%3E%3C/td%3E%3Ctd%20id%3D%22c13%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c14%22%3E%3C/td%3E%3Ctd%20id%3D%22c15%22%3E%3C/td%3E%3Ctd%20id%3D%22c16%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C/tr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c20%22%3E%3C/td%3E%3Ctd%20id%3D%22c21%22%3E%3C/td%3E%3Ctd%20id%3D%22c22%22%3E%3C/td%3E%3Ctd%20id%3D%22c23%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c24%22%3E%3C/td%3E%3Ctd%20id%3D%22c25%22%3E%3C/td%3E%3Ctd%20id%3D%22c26%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C/tr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c30%22%3E%3C/td%3E%3Ctd%20id%3D%22c31%22%3E%3C/td%3E%3Ctd%20id%3D%22c32%22%3E%3C/td%3E%3Ctd%20id%3D%22c33%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c34%22%3E%3C/td%3E%3Ctd%20id%3D%22c35%22%3E%3C/td%3E%3Ctd%20id%3D%22c36%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C/tr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c40%22%3E%3C/td%3E%3Ctd%20id%3D%22c41%22%3E%3C/td%3E%3Ctd%20id%3D%22c42%22%3E%3C/td%3E%3Ctd%20id%3D%22c43%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c44%22%3E%3C/td%3E%3Ctd%20id%3D%22c45%22%3E%3C/td%3E%3Ctd%20id%3D%22c46%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C/tr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c50%22%3E%3C/td%3E%3Ctd%20id%3D%22c51%22%3E%3C/td%3E%3Ctd%20id%3D%22c52%22%3E%3C/td%3E%3Ctd%20id%3D%22c53%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ctd%20id%3D%22c54%22%3E%3C/td%3E%3Ctd%20id%3D%22c55%22%3E%3C/td%3E%3Ctd%20id%3D%22c56%22%3E%3C/td%3E%0D%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C/tr%3E%0D%0A%20%20%20%20%20%20%20%20%3C/tbody%3E%0D%0A%20%20%20%20%3C/table%3E%0D%0A%20%20%20%20%3C/div%3E%0D%0A%20%20%20%20%3Cdiv%20id%3D%22foot%22%20align%3D%22center%22%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20onclick%3D%22chanage%28%27%3C%3C%3C%27%29%3B%22%20value%3D%2210Y%3C%22%20title%3D%22%u540E%u900010%u5E74%22%20/%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20onclick%3D%22chanage%28%27%3C%3C%27%29%3B%22%20value%3D%22Y%3C%22%20title%3D%22%u540E%u90001%u5E74%22%20/%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20onclick%3D%22chanage%28%27%3C%27%29%3B%22%20value%3D%22M%3C%22%20title%3D%22%u540E%u90001%u4E2A%u6708%22%20/%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20onclick%3D%22chanage%28%27%3E%27%29%3B%22%20value%3D%22%3EM%22%20title%3D%22%u524D%u8FDB1%u4E2A%u6708%22%20/%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20onclick%3D%22chanage%28%27%3E%3E%27%29%3B%22%20value%3D%22%3EY%22%20title%3D%22%u524D%u8FDB1%u5E74%22%20/%3E%0D%0A%20%20%20%20%20%20%20%20%3Cinput%20type%3D%22button%22%20onclick%3D%22chanage%28%27%3E%3E%3E%27%29%3B%22%20value%3D%22%3E10Y%22%20title%3D%22%u524D%u8FDB10%u5E74%22%20/%3E%0D%0A%20%20%20%20%3C/div%3E%0D%0A%20%20%20%20%3Cinput%20type%3D%22hidden%22%20id%3D%22ref_val%22%20value%3D%22null%22%3E%0D%0A%3C/div%3E";

/*
 
 有关被加转换的字符串（mainScript及htmlCode），请参考以下代码

 
  
**/
    
//mainScript::
/*

//
//构建日历数据
//
function _build(y,m)
{
    if(y == null){y = $("year").value;}
    if(m == null){m = $("month").value;}
    
    var begin_Day = 1;
    var last_Day = _getLastDay(y,m);
    
    var begin_week = _getWeek(y,m,begin_Day);
    
    var temp = begin_Day;
    var cell = null;
            
    for(var i=0; i<6; i++)
    {            
        for(var j=0; j<7; j++)
        {   
            cell = $("c"+i + "" +j);                                            
            if(i == 0 && j<begin_week){cell.innerText = " ";}else{if(temp <= last_Day){cell.innerText = temp; temp ++;} else{cell.innerText = " ";}}
        }
    }
}

//
//根据年月,获得该份最的最后一天是多少号

//
function _getLastDay(y,m)
{
    if((m < 8 && m%2 == 1) || (m > 7 && m%2 == 0)) return 31;
    else if(m != 2) return 30;
    else{if((y%4 ==0) && ((y%100 != 0)||(y%400 == 0))) { return 29;} else {return 28;}}
}

//
//根据日期,来获取当前日期为星期几

//
function _getWeek(y,m,d)
{
   return new Date(y,m-1,d).getDay() % 7;
}

//
//重构年份下拉框

// 
function _rebuildYear(y)
{
    var maxY = y + 5;
    var minY = y - 5;
    
    var htmlText = "<select id='year' onchange='chanage();'>";
    
    for(var i=minY; i<maxY; i++)
        htmlText +="<option value='"+i+"'>"+i+"</option>";
    
    htmlText += "</select>";    
                
    $("year").outerHTML =  htmlText;
}

//
//初始化日历控件

//
function init(initYear,showType)
{
    var cell = null;
            
    for(var i=0; i<6; i++)
    {
        for(var j=0; j<7; j++)
        {
            cell = $("c"+i + "" +j);                    
            cell.align   = "center";
            
            cell.onclick     = processData;            
            cell.onmouseout  = function(){this.style.backgroundColor = "";}
            cell.onmouseover = function(){this.style.backgroundColor = td_onmoveover_color;}
        }
    }
    
    var d = new Date();
    if(initYear==null)
	initYear = d.getFullYear();
	
    _select(initYear,d.getMonth()+1);
    
    var ymOk = $("ymOk");
	var body = $("body");
	
	if(showType == null)
		showType = 2;	
	
	switch(showType)
	{
		case 1:
			ymOk.style.display = "inline";
			ymOk.disabled = false;
			ymOk.title	  = "单击可直接择年份";
			body.style.display = "none";
			break;
				
		case 3:
			ymOk.style.display = "inline";
			ymOk.disabled = false;
			ymOk.title	  = "单击可直接择年份";
			body.style.display = "block";
			break;
		
		default:	//其它值与2为同类型显示
			ymOk.style.display = "none";
			ymOk.disabled = true;
			ymOk.title	  = "不可直接选择年月";
			body.style.display = "block";
			break;
	}
}

//
//选择日期
//
var _selected_cell = null;

function _select(y,m,d)
{
    _rebuildYear(y);
    
    $("year").value  = y;
    $("month").value = m;
    
    _build(y,m);
    
    if(d != null && d.length > 4)
    {
		var temp = new Date(y,m,1).getDay() - 1;
                        
        var row = parseInt((parseInt(d)+temp)/7);           
        var col = new Date(y,m,d).getDay();
                    
        if(_selected_cell != null)
            _selected_cell.style.backgroundColor = "";
        
        _selected_cell = $("c"+row + "" +col);  
        _selected_cell.style.backgroundColor = "#ff8800";
    }
}

function select(text)
{	
	if(text == null)
		text = $("ref_val").value;
		
	var temp = null; 
	
	if(text == null || text.length < 5) 
	{
		temp = new Date();
		_select(temp.getFullYear(),temp.getMonth()+1);
	} 
	else 
	{
		temp = text + "-";
		_select(temp.split('-')[0],temp.split('-')[1],temp.split('-')[2]);
	}	
}

//
//变更日历控件的数据

//
function chanage(e)
{
    var y = parseInt($("year").value);
    var m = parseInt($("month").value);
    
    if(isNaN(y))
        y = new Date().getFullYear();
    
    switch(e)
    {
        case ">": if(m == 12){y ++;m = 1;}else{m ++;} break;
        case "<": if(m == 1){y --;m = 12;}else{m--;} break;
        case ">>": y ++; break;
        case "<<": y --; break;
        case ">>>": y += 10; break;
        case "<<<": y -= 10; break;
    }
    
    _select(y,m);
}  
*/

//htmlCode::
/*
<div align="center" style="border: gray 1px solid; padding: 2px; font-size: 9pt; width: 100%;">
    <div id="head" style="height:23px;">
        <input type="button" onclick="chanage('<');" value="M<" title="后退1个月" />
        <select id="year" onchange="chanage();">
            <option value="2006">2006</option>
        </select>
        <select id="month" onchange="chanage();">
            <option value="12">12</option>
            <option value="11">11</option>
            <option value="10">10</option>
            <option value="9">09</option>
            <option value="8">08</option>
            <option value="7">07</option>
            <option value="6">06</option>
            <option value="5">05</option>
            <option value="4">04</option>
            <option value="3">03</option>
            <option value="2">02</option>
            <option value="1">01</option>
        </select>
        <input type="button" onclick="chanage('>');" value=">M" title="前进1个月" />
        <input type="button" id="ymOk" value="OK" onclick="processData(this);" title="直接选择年月" />
        <input type="button" id="ymClear" value="Clr" onclick="processData(this,'c');" title="清空日期" />
    </div>
    <div id="body">
    <table width="100%" style="font-size: 9pt;">
        <thead>
            <tr>
                <td>日</td><td>一</td><td>二</td><td>三</td>
                <td>四</td><td>五</td><td>六</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td id="c00"></td><td id="c01"></td><td id="c02"></td><td id="c03"></td>
                <td id="c04"></td><td id="c05"></td><td id="c06"></td>
            </tr>
            <tr>
                <td id="c10"></td><td id="c11"></td><td id="c12"></td><td id="c13"></td>
                <td id="c14"></td><td id="c15"></td><td id="c16"></td>
            </tr>
            <tr>
                <td id="c20"></td><td id="c21"></td><td id="c22"></td><td id="c23"></td>
                <td id="c24"></td><td id="c25"></td><td id="c26"></td>
            </tr>
            <tr>
                <td id="c30"></td><td id="c31"></td><td id="c32"></td><td id="c33"></td>
                <td id="c34"></td><td id="c35"></td><td id="c36"></td>
            </tr>
            <tr>
                <td id="c40"></td><td id="c41"></td><td id="c42"></td><td id="c43"></td>
                <td id="c44"></td><td id="c45"></td><td id="c46"></td>
            </tr>
            <tr>
                <td id="c50"></td><td id="c51"></td><td id="c52"></td><td id="c53"></td>
                <td id="c54"></td><td id="c55"></td><td id="c56"></td>
            </tr>
        </tbody>
    </table>
    </div>
    <div id="foot" align="center">
        <input type="button" onclick="chanage('<<<');" value="10Y<" title="后退10年" />
        <input type="button" onclick="chanage('<<');" value="Y<" title="后退1年" />
        <input type="button" onclick="chanage('<');" value="M<" title="后退1个月" />
        <input type="button" onclick="chanage('>');" value=">M" title="前进1个月" />
        <input type="button" onclick="chanage('>>');" value=">Y" title="前进1年" />
        <input type="button" onclick="chanage('>>>');" value=">10Y" title="前进10年" />
    </div>
    <input type="hidden" id="ref_val" value="null">
</div>
*/
//-------------------------------------------------------------------------------------------------------------
function DivCalendar()//DivCalendar()
{

	var calendar=this;

	this.calendarPad	=null;
	this.prevMonth		=null;
	this.nextMonth		=null;
	this.prevYear		=null;
	this.prevSYear		=null;
	this.nextYear		=null;
	this.nextSYear		=null;
	this.goToday		=null;
	this.calendarClose=null;
	this.calendarAbout=null;
	this.head=null;
	this.body=null;
  
	this.today=[];
	this.currentDate=[];

	this.sltDate;
	this.target;
	this.source;

	/************** 加入日历底板及阴影 *********************/

	this.addCalendarPad=function()
	{  
		document.write("<div id='divCalendarpad' style='position:absolute;top:100;left:0;width:220;height:160;display:none;'>");
		document.write("<iframe frameborder=0 height=160 width=220></iframe>");
		document.write("<div style='position:absolute;top:4;left:4;width:218;height:160;'></div>");//background-color:#336699;
		document.write("</div>");

		calendar.calendarPad = document.all.divCalendarpad;
	}

	/************** 加入日历面板 *********************/

	this.addCalendarBoard=function()
	{

		var BOARD=this;
		var divBoard=document.createElement("div");

		calendar.calendarPad.insertAdjacentElement("beforeEnd",divBoard);

		divBoard.style.cssText="font-size:9pt;font-family: 宋体;position:absolute;top:0;left:0;width:220;height:160;border:1 outset;background-color:buttonface;";//buttonface

		var tbBoard=document.createElement("table");

		divBoard.insertAdjacentElement("beforeEnd",tbBoard);

		tbBoard.style.cssText="position:absolute;top:0;left:0;width:218;height:10;font-size:9pt;font-family: 宋体;border:0px;";
		tbBoard.cellPadding=0;
		tbBoard.cellSpacing=0;

		//tbBoard.bgColor="#333333";

		/************** 设置各功能按钮的功能 *********************/

		/*********** Calendar About Button ***************/
		/*
		trRow = tbBoard.insertRow(0);

		calendar.calendarAbout=calendar.insertTbCell(trRow,0,"?","center");
		calendar.calendarAbout.onclick=function(){calendar.about();}*/
		
		
		/*********** Calendar Head ***************/
		/*********** Calendar PrevYear Button ***************/

		trRow = tbBoard.insertRow(0);

		calendar.prevYear = calendar.insertTbCell(trRow,0,"&lt;&lt;","center");
		calendar.prevYear.title="上一年";
		calendar.prevYear.onmousedown=function()
		{
			calendar.currentDate[0]--;
			calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
		}

		/*********** Calendar PrevMonth Button ***************/

		calendar.prevMonth = calendar.insertTbCell(trRow,1,"&lt;","center");
		calendar.prevMonth.title="上一月";
		calendar.prevMonth.onmousedown=function()
		{

			calendar.currentDate[1]--;

			if(calendar.currentDate[1]==0)
			{
				calendar.currentDate[1]=12;
				calendar.currentDate[0]--;

			}
			calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
		}

		/*********** Calendar Today Button ***************/

		calendar.goToday = calendar.insertTbCell(trRow,2,"今天","center",3);
		calendar.goToday.title="选择今天";

		calendar.goToday.onclick=function()
		{
			calendar.sltDate=calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2];
			calendar.target.value=calendar.sltDate;
			//calendar.hide();
			//calendar.show(calendar.target,calendar.today[0]+"-"+calendar.today[1]+"-"+calendar.today[2],calendar.source);
		   
		    var hb_date =calendar.today[0]+"-"+calendar.today[1]+"-"+calendar.today[2] ;
		    var hb_month = calendar.today[1];
		    if(hb_month<=9){
		      hb_month="0"+calendar.today[1];
		    }
		    var hb_day = calendar.today[2];
		    if(hb_day<=9){
		      hb_day = "0"+calendar.today[2];
		    }
		   
		    calendar.target.value=calendar.today[0]+"-"+hb_month+"-"+hb_day ;
		     calendar.hide();
		}

		/*********** Calendar NextMonth Butt ***************/

		calendar.nextMonth = calendar.insertTbCell(trRow,3,"&gt;","center");
		calendar.nextMonth.title="下一";
		calendar.nextMonth.onmousedown=function()
		{
			calendar.currentDate[1]++;
			if(calendar.currentDate[1]==13)
			{
				calendar.currentDate[1]=1;
				calendar.currentDate[0]++;

			}
			calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
		}

		/*********** Calendar NextYear Button ***************/

		calendar.nextYear = calendar.insertTbCell(trRow,4,"&gt;&gt;","center");
		calendar.nextYear.title="下一年";
		calendar.nextYear.onmousedown=function()
		{
			calendar.currentDate[0]++;
			calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
		
		}
		
		

		trRow = tbBoard.insertRow(1);

		var cnDateName = new Array("日","一","二","三","四","五","六");//周

		for (var i = 0; i < 7; i++) 
		{
			tbCell=trRow.insertCell(i)
			tbCell.innerText=cnDateName[i];
			tbCell.align="center";
			tbCell.width=20;
			tbCell.style.cssText="cursor:default;border:0px;background-color:#99CCCC;border:1px solid #99CCCC;";//background-color:#99CCCC;border:1px solid #99CCCC;

		}	
		
		
		/*********** Calendar Body ***************/

		trRow = tbBoard.insertRow(2);
		tbCell=trRow.insertCell(0);
		tbCell.colSpan=7;
		tbCell.height=97;
		tbCell.vAlign="top";
		//tbCell.bgColor="#F0F0F0";
		//-------------------------------

		var tbBody=document.createElement("table");
		tbCell.insertAdjacentElement("beforeEnd",tbBody);
		tbBody.style.cssText="position:relative;top:0;left:0;width:216;height:103;font-size:9pt;border:0px;";
		tbBody.cellPadding=0;
		tbBody.cellSpacing=0;
		calendar.body=tbBody;
		
		
		/*********** Calendar Prev10Year Button ***************/

		trRow = tbBoard.insertRow(3);

		calendar.prevSYear = calendar.insertTbCell(trRow,0,"&lt;&lt;&lt;","center");//
		calendar.prevSYear.title="上十年";		
		calendar.prevSYear.onmousedown=function()
		{
			calendar.currentDate[0]=parseInt(calendar.currentDate[0]) - 10;
			calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
		}

		/*********** Calendar Foot ***************/

		tbCell=trRow.insertCell(1);
		tbCell.colSpan=4;
		//tbCell.bgColor="#99CCFF";
		tbCell.align="center";
		tbCell.style.cssText = "cursor:default";
		calendar.head=tbCell;
		
		/*********** Calendar Clear Button ***************/

		tbCell=trRow.insertCell(2);

		calendar.calendarClose = calendar.insertTbCell(trRow,2,"C","center");
		calendar.calendarClose.title="清除";
		calendar.calendarClose.onclick=function(){calendar.target.value='';calendar.hide();}

		/*********** Calendar Close Button ***************/
		/*
		tbCell=trRow.insertCell(3);

		calendar.calendarClose = calendar.insertTbCell(trRow,3,"X","center");
		calendar.calendarClose.title="关闭";
		calendar.calendarClose.onclick=function(){calendar.hide();}
		*/
		
		/*********** Calendar Next10Year Button ***************/

		calendar.nextSYear = calendar.insertTbCell(trRow,3,"&gt;&gt;&gt;","center");//
		calendar.nextSYear.title="下十年";
		calendar.nextSYear.onmousedown=function()
		{
			calendar.currentDate[0]=parseInt(calendar.currentDate[0]) + 10;
			calendar.show(calendar.target,calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+calendar.currentDate[2],calendar.source);
		}
		//-----------------------------------
	}

	/************** 加入功能按钮公共样式 *********************/

	this.insertTbCell=function(trRow,cellIndex,TXT,trAlign,tbColSpan)
	{

		var tbCell=trRow.insertCell(cellIndex);
		if(tbColSpan!=undefined) tbCell.colSpan=tbColSpan;
		var btnCell=document.createElement("button");
		tbCell.insertAdjacentElement("beforeEnd",btnCell);
		btnCell.value=TXT;
		btnCell.className = '__Web_Cal';
		btnCell.style.cssText="width:100%;border:1 outset;background-color:buttonface;";//
		btnCell.onmouseover=function()
		{
			btnCell.style.cssText="width:100%;border:1 outset;background-color:#F0F0F0;";
		}

		btnCell.onmouseout=function()
		{
			btnCell.style.cssText="width:100%;border:1 outset;background-color: buttonface;";
		}

		//btnCell.onmousedown=function()
		//{
		//		btnCell.style.cssText="width:100%;border:1 inset;background-color:#F0F0F0;";
		//}

		btnCell.onmouseup=function()
		{
			btnCell.style.cssText="width:100%;border:1 outset;background-color:#F0F0F0;";
		}

		btnCell.onclick=function()
		{
			btnCell.blur();
		}

		return btnCell;
	}

	this.setDefaultDate=function()
	{
		var dftDate=new Date();

		calendar.today[0]=dftDate.getYear();
		calendar.today[1]=dftDate.getMonth()+1;
		calendar.today[2]=dftDate.getDate();
	}

	/****************** Show Calendar *********************/

	this.show=function(targetObject,defaultDate,sourceObject)
	{

		if(targetObject==undefined) 
		{
			alert("未设置目标对像. \n方法: ATCALENDAR.show(obj 目标对像,string 默认日期,obj 点击对像);\n\n目标对像:接受日期返回值的对像.\n默认日期:格式为\"yyyy-mm-dd\",缺省为当日日期.\n点击对像:点击这个对像弹出calendar,默认为目标对像.\n");
			return false;
		}
		else 
			calendar.target=targetObject;

		if(sourceObject==undefined)
			calendar.source=calendar.target;
		else 
			calendar.source=sourceObject;

		var firstDay;

		var Cells=new Array();

		if(defaultDate==undefined || defaultDate=="")
		{
			var theDate=new Array();
			calendar.head.innerText = calendar.today[0]+"-"+calendar.today[1]+"-"+calendar.today[2];
			theDate[0]=calendar.today[0]; theDate[1]=calendar.today[1]; theDate[2]=calendar.today[2];
		}
		else
		{
			var reg=/^\d{4}-\d{1,2}-\d{1,2}$/

			if(!defaultDate.match(reg))
			{
				alert("默认日期的格式不正确\n\n默认日期可接受格式为:'yyyy-mm-dd'");
				return;
			}
			var theDate=defaultDate.split("-");
			calendar.head.innerText = defaultDate;
		}

		calendar.currentDate[0]=theDate[0];
		calendar.currentDate[1]=theDate[1];
		calendar.currentDate[2]=theDate[2];
		  
		theFirstDay=calendar.getFirstDay(theDate[0],theDate[1]);
		theMonthLen=theFirstDay+calendar.getMonthLen(theDate[0],theDate[1]);

		//calendar.setEventKey();

		calendar.calendarPad.style.display="";

		var theRows = Math.ceil((theMonthLen)/7);

		//清除旧的日历;

		while (calendar.body.rows.length > 0) 
		{
			calendar.body.deleteRow(0);
		}

		//建立新的日历;

		var n=0;day=0;

		for(i=0;i<theRows;i++)
		{
			theRow=calendar.body.insertRow(i);

			for(j=0;j<7;j++)
			{
				n++;

				if(n>theFirstDay && n<=theMonthLen)
				{
					day=n-theFirstDay;
					calendar.insertBodyCell(theRow,j,day);
				}
				else
				{
					var theCell=theRow.insertCell(j);
					theCell.style.cssText="cursor:default;";//background-color:#F0F0F0;

				}

			}

		}

		//****************调整日历位置**************//

		var offsetPos=calendar.getAbsolutePos(calendar.source);//计算对像的位置;

		if((document.body.offsetHeight-(offsetPos.y+calendar.source.offsetHeight-document.body.scrollTop))<calendar.calendarPad.style.pixelHeight)
		{
			var calTop=offsetPos.y-calendar.calendarPad.style.pixelHeight;
		}
		else
			var calTop=offsetPos.y+calendar.source.offsetHeight;

		if((document.body.offsetWidth-(offsetPos.x+calendar.source.offsetWidth-document.body.scrollLeft))>calendar.calendarPad.style.pixelWidth)
		{
			var calLeft=offsetPos.x;
		}
		else
			var calLeft=calendar.source.offsetLeft+calendar.source.offsetWidth;

		//alert(offsetPos.x);

		calendar.calendarPad.style.pixelLeft=calLeft;
		calendar.calendarPad.style.pixelTop=calTop;

	}

	/****************** 计算对像的位置 *************************/

	this.getAbsolutePos = function(el)
	{
		var r = { x: el.offsetLeft, y: el.offsetTop };

		if (el.offsetParent) 
		{
			var tmp = calendar.getAbsolutePos(el.offsetParent);
			r.x += tmp.x;
			r.y += tmp.y;
		}
		return r;
	};

	//************* 插入日期单元格 **************/

	this.insertBodyCell=function(theRow,j,day,targetObject)
	{
		var theCell=theRow.insertCell(j);

		if(j==0)
			var theBgColor="#FF9999";			
		else
			var theBgColor="#FFFFFF";

		if(day==calendar.currentDate[2]) 
			var theBgColor="#CCCCCC";

		if(day==calendar.today[2]) 
			var theBgColor="#99FFCC";

		theCell.bgColor=theBgColor;
		theCell.innerText=day;
		theCell.align="center";
		theCell.width=20;
		theCell.style.cssText="border:1px solid #ffffff;cursor:hand;";//border:1 solid #CCCCCC;
		theCell.onmouseover=function()
		{
			theCell.bgColor="#FFFFCC";
			theCell.style.cssText="border:1 outset;cursor:hand;";
		}

		theCell.onmouseout=function()
		{
			theCell.bgColor=theBgColor;
			theCell.style.cssText="border:1px solid #ffffff;cursor:hand;";//border:1 solid #CCCCCC;
		}

		theCell.onmousedown=function()
		{
			theCell.bgColor="#FFFFCC";
			theCell.style.cssText="border:1 inset;cursor:hand;";
		}

		theCell.onclick=function()
		{
			if(calendar.currentDate[1].length<2) 
				calendar.currentDate[1]="0"+calendar.currentDate[1];
				
			if(day.toString().length<2) 
				day="0"+day;

			calendar.sltDate=calendar.currentDate[0]+"-"+calendar.currentDate[1]+"-"+day;
			calendar.target.value=calendar.sltDate;
			calendar.hide();
		}

	}

	/************** 取得月份的第一天为星期几 *********************/

	this.getFirstDay=function(theYear, theMonth)
	{
		var firstDate = new Date(theYear,theMonth-1,1);
		return firstDate.getDay();
	}

	/************** 取得月份共有几天 *********************/
	this.getMonthLen=function(theYear, theMonth)
	{
		theMonth--;
		var oneDay = 1000 * 60 * 60 * 24;
		var thisMonth = new Date(theYear, theMonth, 1);
		var nextMonth = new Date(theYear, theMonth + 1, 1);
		var len = Math.ceil((nextMonth.getTime() - thisMonth.getTime())/oneDay);

		return len;
	}

	/************** 隐藏日历 *********************/

	this.hide=function()
	{
		//calendar.clearEventKey();
		calendar.calendarPad.style.display="none";
	}

	/************** 从这里开始 *********************/

	this.setup=function(defaultDate)
	{
		calendar.addCalendarPad();
		calendar.addCalendarBoard();
		calendar.setDefaultDate();
	}

	/************** 关于AgetimeCalendar *********************/

	this.about=function()
	{
		var strAbout = "About WebCalendar\n\n";

		strAbout+="?\t: 关于\n";
		strAbout+="x\t: 隐藏\n";
		strAbout+="<<<\t: 上十年\n";
		strAbout+="<<\t: 上一年\n";
		strAbout+="<\t: 上一月\n";
		strAbout+="今日\t: 返回当天日期\n";
		strAbout+=">\t: 下一月\n";
		strAbout+=">>\t: 下一年\n";
		strAbout+=">>>\t: 下十年\n";
		//strAbout+="\nWebCalendar\nVersion:v1.1\nDesigned By:暂停打印 2004-03-16 afos_koo@hotmail.com\nUpdated By:没有耳多 2006-10-24 biisom@gmail.com";
		window.alert(strAbout);

	}
	calendar.setup();
}

var __Calendar_Div = new DivCalendar();
var __Calendar_Pop1 = new PopCalendar();
var __Calendar_Pop2 = new PopCalendar();
var __Calendar_Pop3 = new PopCalendar();

var Calendar = new PopCalendar();
Calendar._G_Instance = null;
Calendar._C_RefInput = null;
Calendar._Inited     = false;
Calendar.Show = function(refObj,showType,initYear)//showType,默认为:2[4:DivCalendar]
{
	if(Calendar._Inited == false)
	{
		document.attachEvent("onclick",function()
		{
			var temp = event.srcElement;
			
			if(__Calendar_Div.target != temp && temp.className !='__Web_Cal')
				__Calendar_Div.hide();
		});
		
		Calendar._Inited = true;
	}
	//-----------------------------------------------------------------------------
	
    if(typeof(refObj) == "string")
        refObj = document.all[refObj];
    
    if(showType == null)
		showType = 4;
	
	if(showType == 4)
		__Calendar_Div.show(refObj,refObj.value); 
	else
	{
		eval("Calendar._G_Instance = __Calendar_Pop" + showType);
		Calendar._G_Instance.show(refObj,showType,initYear);	
	}
}

Calendar.Hide = function(date)
{
    Calendar._G_Instance.target.value = date;
    Calendar._G_Instance.hide();
}
Calendar.Clear = function()
{
	Calendar.Hide('');
}