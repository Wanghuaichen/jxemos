

function f_css(obj,css){
  	//history.back()
  	obj.className=css;
}



function f_back(){
  	history.back();
}


function f_go_page(i){
 	form1.page.value=i;
 	form1.submit();
}

 function f_ajf_show(ids){
   	var arr=ids.split(",");
   	var i,num=0;
	var obj = null;
   	num=arr.length;
   	for(i=0;i<num;i++){
    obj = document.getElementById(arr[i]);
    obj.style.display='';  
}
}

 function f_ajf_hide(ids){
   	var arr=ids.split(",");
  	var i,num=0;
	var obj = null;
   	num=arr.length;
   	for(i=0;i<num;i++){
    obj = document.getElementById(arr[i]);
    obj.style.display='none';  
}
}


function getobj(s_id){
   var obj = document.getElementById(s_id);
   if(obj==null){alert("对象不存在,id="+s_id);return;}
   return obj;
}


function ajfAjaxRequest(url) {
    // branch for native XMLHttpRequest object
    if(url.indexOf("?")>0){
             url = url+"&"+Math.random();
    }else{
              url = url+"?&"+Math.random();
   }
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
        
        req.onreadystatechange = requestHandler;
        req.open("GET", url, false);
    
       // req.send(null);
 req.send();

  return;
    // branch for IE/Windows ActiveX version
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
        if (req) {
          
            req.onreadystatechange = requestHandler;
            req.open("GET", url, false);

        
            req.send();
        }
    }
          

}

function requestHandler() {

   
   
/*
   if (req.readyState == 0)  {alert("init");}
    if (req.readyState == 1)  {alert("read");}
    if (req.readyState == 2)  {alert("read done");}
  if (req.readyState == 3)  {alert("active");}
*/
    if (req.readyState == 4) {
        // only if "OK"
          if (req.status == 404) {
                 alert("找不到请求页面\n"+req.statusText);
                return;
           }

        if (req.status == 200) {
   try{        

   js = req.responseText;
   eval(js);

   }catch(e){
     alert(e.message+"\n\n"+js);
	  return;
   }

         } else {
           alert("请求页面时发生错误\n" +req.statusText+"\n"+req.responseText);
                
         }
    }
}













//----------
function go2(url){
window.location=url;
}
//------------
function f_isTimestamp(v){
var flag=0;
flag=f_isDatetime(v);
if(flag>0){return 1;}
var regex = /^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}.[0-9]{1,9}$/;
if(regex.test(v)){flag=1;}else{flag=0;}
return flag;
}
//-------------
//------------
function f_isDatetime(v){
var flag=0;
flag=f_isDate(v);
if(flag>0){return 1;}
var regex = /^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}$/;
if(regex.test(v)){flag=1;}else{flag=0;}
return flag;
}
//-------------
//-------------
function f_isDate(v){
var flag=0;
var regex = /^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$/;
if(regex.test(v)){flag=1;}else{flag=0;}
return flag;
}
//-------------
function f_checkRegex(rule,v){
flag=0;
var rule="^"+rule+"$";
var regex = new RegExp(rule); 
if(regex.test(v)){flag=1}else{flag=0;}
return flag;
}
//------------------
function f_checkStringLength(rule,v){
var flag=0;
var len = 0;
v=f_trim(v);
len = v.length;
var arr = rule.split(",");
var min=arr[0];
var max=arr[1];
if(len>=min && len<=max){flag=1;}else{flag=0;}
return flag;
}
//-------------------
function f_checkPrecision(s,v){

var flag=0;
v = Number(v);
//alert("number is "+v);
if(v<0){v=v*(-1);}
var arr = s.split(",");
var leftNum=arr[0];
var rightNum=arr[1];

var il = 0;
var ir = 0;

var ipos =0;

var sv = v+"";

var ilen = sv.length;

ipos = sv.indexOf(".");
//alert("ipos="+ipos+",ilen="+ilen+",sv="+sv);
if(ipos<0){
il=ilen;
if(il<=leftNum){return true;}else{return false;}
}//end if(ipos<0)

if(ipos==0){
ir=ilen-1;
if(ir<=rightNum){return true;}else{return false;}
}//end if(ipos==0)

if(ipos>0){
il=ipos;
ir=ilen-ipos-1;
if(il<=leftNum && ir<=rightNum){return true;}else{return false;}
}//end if(ipos>0)

}
//-----------
function f_checkMinAndMax(s,v){
var flag=0;
v = Number(v);
var arr = s.split(",");
var min=arr[0];
var max=arr[1];
if(v>=min && v<=max){flag=1;}else{flag=0;}
if(flag>0){return true;}else{return false;}
}
//------------
//--------
function f_isNumber(s){
var s=s+"";
var flag=0;
var regex1 = /^[\-]{0,1}[0-9]{1,50}$/;
var regex2 = /^.[0-9]{1,50}$/;
var regex3 = /^[\-]{0,1}[0-9]{1,50}.[0-9]{1,50}$/;
if(regex1.test(s) || regex2.test(s) || regex3.test(s)){flag=1;}
if(flag>0){return true;}else{return false;}
}
//--------
function trim(str){
str=str.replace(/(^\s*)|(\s*$)/g, "");
  return str;
}

function f_trim(str){
//return f_rtrim(f_ltrim(str));
 str=str.replace(/(^\s*)|(\s*$)/g, "");
  return str;
}
//----------
function f_rtrim(str){
var whitespace = new String(" \t\n\r");
var s = new String(str);
if (whitespace.indexOf(s.charAt(s.length-1)) != -1)
{
var i = s.length - 1;
while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1){ i--;}
s = s.substring(0, i+1);
}
return s;
}
//---------
function f_ltrim(str){
var whitespace = new String(" \t\n\r");
var s = new String(str);
if (whitespace.indexOf(s.charAt(0)) != -1)
{var j=0, i = s.length;
while (j < i && whitespace.indexOf(s.charAt(j)) != -1){j++;}
s = s.substring(j, i);
}
    return s;
}
//---------

//----------
function f_page_goFirst(){
form1.page.value=1;
form1.submit();
}
//-------------
function f_page_goPre(){
var i = form1.page.value;
i--;
form1.page.value = i;
form1.submit();
}
//-------------
function f_page_goNext(){
var i = form1.page.value;
i++;
form1.page.value = i;
form1.submit();
}
//-------------
function f_page_goLast(){
form1.page.value='100000000';
form1.submit();
}
//-------------

//------------
function f_new(url){
form1.action=url;
form1.submit();
}
//-----------
function f_view(url){
var num = getSelectedNum("objectid");
if(num!=1){alert("请选择一条要查看的记录");return;}
form1.action=url;
form1.submit();
}
//-----------
function f_edit(url){
var num = getSelectedNum("objectid");
if(num!=1){alert("请选择一条要修改的记录");return;}
form1.action=url;
form1.submit();
}
//-----------
function f_del(url){
var num = getSelectedNum("objectid");
if(num<1){alert("请选择一条要删除的记录");return;}
var msg = "您确认要删除选定的记录吗?";
if(!confirm(msg)){return;}
form1.action=url;
form1.submit();
}
//-----------




/*-----------------------------*/
    function add_item(name_from,name_to) {
        var from = document.getElementById(name_from);
        var to = document.getElementById(name_to);
	   var cur_index = from.selectedIndex;
	   if(cur_index<0){alert("请选择一项");return;}
	   to.options.add(new Option(from.options[cur_index].text,from.options[cur_index].value));  
from.options.remove(cur_index);
if(from.length>cur_index){from.options[cur_index].selected = true;} 
	  }
  /*-----------------------------*/
   
 /*-----------------------------*/
function add_all_item(name_from,name_to) {
        var from = document.getElementById(name_from);
        var to = document.getElementById(name_to);
		var num = from.length;
		var i = 0;
		for(i=0;i<num;i++){to.options.add(new Option(from.options[i].text,from.options[i].value)); }
	   		for(i=0;i<num;i++){from.options.remove(0);}

	  }
 /*-----------------------------*/
function get_select_id(name,target_name){
var obj = document.getElementById(name);
var num = obj.options.length;
var i = 0;
var s = "";
for(i=0;i<num;i++){
s = s + obj.options[i].value + ",";
}
document.getElementById(target_name).value = s;
document.forms[0].submit();
}
/*-----------------------------*/

 /*-----------------------------*/
function go_to_page(ipage){
document.forms[0].page.value = ipage;
document.forms[0].submit();
}
 /*-----------------------------*/
function frameshow(){
//alert("dbl click");
var ele = top.document.getElementById("middleFrame");
var var1 = "1,*";
var var2 = "198,*";
ele.cols = (ele.cols==var1)?var2:var1;
}
 /*-----------------------------*/
function formsubmit(){
var f = document.forms[0];
   f.submit();
   }

 /*-----------------------------*/

function submitTo(url){
     var form = document.forms[0];
     form.action = url;
	 form.method = "post";
	 form.submit();
 }

 /*-----------------------------*/
function mouseover(obj){
obj.className = "trmouseover";
}

 /*-----------------------------*/

function mouseout(obj,s){
obj.className = s;
}

 /*-----------------------------*/


function switchBtn(boxName){
    var ele = document.getElementById("chooseAll");
var btnValue = ele.value;
	 if(btnValue =="全 选"){
	     setCheckboxes(boxName, true);
	     ele.value = "取 消";
	 }else{
	     setCheckboxes(boxName, false);
		 ele.value = "全 选";
	 }
 }
 
 /*-----------------------------*/


 function setCheckboxes(name,flag){
	 for(var i = 0; i < document.forms[0].elements.length; i++){
	      var ele = document.forms[0].elements[i];
		  if(ele.name == name){
		      ele.checked = flag;
		  }
	 }
 }





 /*-----------------------------*/
 
 function goAdd(url){
submitTo(url);
 }
 
 /*-----------------------------*/

 function goDel(url){

var num = getSelectedNum("objectid");
if(num==0){
alert("请选择您要删除的记录！");
		  return;
}
if(confirm("您确认要删除选中的记录吗？")){
		 var action = url;
		 //alert(action);
	     submitTo(action); 
	 }else{
	     setCheckboxes("objectid", false);
	     return ;
	 }

 }
 
 /*-----------------------------*/

 function goEdit(url){

	 
var num = getSelectedNum("objectid");

if(num!=1){
alert("请仅选择一条需要修改的记录！");
		  setCheckboxes("objectid", false);
		  return;
}
var action = url;
submitTo(action);
	}

 /*-----------------------------*/
 
 function goView(url){
     var num = getSelectedNum("objectid");
if(num!=1){
alert("请仅选择一条需要查看的记录！");
		  setCheckboxes("objectid", false);
		  return;
}
var action = url;
submitTo(action);
 }
 
 
  /*-----------------------------*/

function getSelectedNum(name){
	var num = 0;
for(var i = 0; i < document.forms[0].elements.length; i++){
	      var ele = document.forms[0].elements[i];
		  if(ele.name == name){
		      if(ele.checked == true){
			  num ++;
			  }/*end if*/
		  }/*end if*/
	 }
	 return num;
}

//-----------------ajf client-------------




function f_get_value_by_key(arr,name){

 var num = arr[0];
 var keys = arr[1];
 var values = arr[2];
 var i = 0;
 var key = null;
 var value = null;


 for(i=0;i<num;i++){
      key = keys[i];
      if(name==key){
           return values[i];
        }
 }
           return "";
}


//------------------------------


function get_key_and_value_array(input){

var keysAndValues = input.split("&");




var num = keysAndValues.length;


var i =0;
var key = null;
var value = null;
var values = null;
var keys = null;


var s = null;

var pos = 0;
var len = 0;

var j =0;


keys = new Array(num);
values = new Array(num);

for(i=0;i<num;i++){
s = keysAndValues[i];
pos = s.indexOf("=");

if(pos<0){continue;}
key = s.substring(0,pos);



len = s.length;

if(pos<len){
value =s.substring(pos+1,len);
}
if(value.length<1){continue;}

keys[j]=key;
values[j]=value;

j++;

}



var arr = new Array(3);

arr[0]=j;
arr[1]=keys;
arr[2]=values;

return arr;
}


//--------------------------


function get_key_value_array(input,sep){

var keysAndValues = input.split(sep);
var arr = new Array();



var num = keysAndValues.length;


var i =0;
var key = null;
var value = null;



var s = null;

var pos = 0;
var len = 0;

var j =0;


for(i=0;i<num;i++){
s = keysAndValues[i];
pos = s.indexOf("=");

if(pos<0){continue;}
key = s.substring(0,pos);
key=trim(key);
if(key.length<1){continue;}


len = s.length;

if(pos<len){
value =s.substring(pos+1,len);
}
if(value.length<1){continue;}

arr[key]=value;
}


return arr;
}


//--------------------------

function ajf_data_bind(form,content){



//form.reset();

var arr = get_key_value_array(content,"&\r\n");


var eles = form.elements;
var num = eles.length;

var i =0;

var name = null;
var value = null;
var value2 = null;


for(i=0;i<num;i++){


 name = eles[i].name;
// value = eles[i].value;
 //if(value.length>0){continue;}
 value2 = arr[name];
 if(value2==null){continue;}
 value2=trim(value2);
 if(value2.length<1){continue;}
 
 setValue(form,name,value2);
}



}

//-----------

function ajf_client_data_bind(form,content){


form.reset();

var arr = get_key_and_value_array(content);


var eles = form.elements;
num = eles.length;




var i =0;

var name = null;
var value = null;
var type = null;
var value2 = null;


for(i=0;i<num;i++){

 name = eles[i].name;
 type =  eles[i].type;
 value = eles[i].value;

  
 
 value2 = f_get_value_by_key(arr,name);

 


  



 if(type=="text" || type=="hidden" || type=="textarea"){

     
  
           if(value2.length>0 && value.length<1){
                eles[i].value = value2;
           }
  
 }

 
}



}







//-------------------------ajf form ------------

function UrlEncode(str){ 
 return str;
} 




function printFormInfo(form){
/*
if(form){
//alert("form is null in printFormInfo");
}else{
alert("form is null in printFormInfo");
}
*/
var name = null;
var type = null;
var value = null;
var i =0;
var num =0;

num = form.elements.length;
var s = "";
var obj = null;

for(i=0;i<num;i++){
obj = form.elements[i];
name = obj.name;
type = obj.type;
value= obj.value;

s = s+"name="+name+",type="+type+",value="+value+"\n";

}

alert(s);

}



function setValueOfCheckBox(obj,value){
var i =0;
var num =0;
var arr=value.split(";");
num=arr.length;

for(i=0;i<num;i++){
obj.checked=false;
if(obj.value==arr[i]){
	obj.checked=true;
	return;
	
	}
}


}

//---------------------

function setValueOfSelMul(obj,value){
var i =0;
var num =0;
var arr=value.split(";");
num=arr.length;
var option_num =0;
var j =0;

option_num=obj.options.length;


for(i=0;i<option_num;i++){
obj.options[i].selected=false;
}

for(i=0;i<option_num;i++){

for(j=0;j<num;j++){
if(obj.options[i].value==arr[j]){obj.options[i].selected=true;}
}

}


}




//-----------------------

function getValueOfSelMul(obj){
var i =0;
var num =0;

var s = "";

num=obj.options.length;

for(i=0;i<num;i++){


if(obj.options[i].selected){
s=s+obj.options[i].value+";";
}


}

return s;
}




//-----------------------



function setValue(form,name,value){

if(name==''){return;}

var name2 = null;
var type = null;

var i =0;
var num =0;

num = form.elements.length;
var obj = null;
var j =0;
var arr_num =0;
var k =0;
var option_num =0



for(i=0;i<num;i++){

obj = form.elements[i];
name2 = obj.name;

if(name2!=name){continue;}
type=obj.type;

//alert(type);



if(type=='text'||type=='hidden'||type=='textarea'||type=='select-one'){
obj.value=value;
continue;
}




if(type=='radio'){
if(obj.value==value){obj.checked=true;}
continue;
}


if(type=='checkbox'){

setValueOfCheckBox(obj,value);



continue;
}






if(type=='select-multiple'){

setValueOfSelMul(obj,value);
continue;
}



}//end i




}
//------------------






function getValue(form,name){

var name2 = null;
var type = null;

var i =0;
var num =0;

num = form.elements.length;
var obj = null;
var j =0;
var arr_num =0;
var k =0;
var option_num =0

var check_box_value = "";

var type_flag = -1;


for(i=0;i<num;i++){

obj = form.elements[i];
name2 = obj.name;

if(name2!=name){continue;}

type=obj.type;

if(type=='text'||type=='hidden'||type=='textarea'||type=='select-one'){
return obj.value;
}




if(type=='radio'){

   if(obj.checked){return obj.value;}

}





if(type=='checkbox'){

  if(type_flag<0){type_flag=0;}
  if(obj.checked){
	  check_box_value=check_box_value+obj.value+";";
	  continue;
	  
	  }
}




if(type=='select-multiple'){
  
return getValueOfSelMul(obj);

}


}//end i



if(type_flag==0){
return check_box_value;
}else{
return "";
}


}

//------------------

function getSelText(obj){
 var i = obj.selectedIndex;
 if(i<0){return "";}
 return obj.options[i].text;
}
//-----------









function getQueryStringOfSelect(obj){
var i =0;
var num =0;
var name = null;
var value = null;
var s = "";

num=obj.options.length;

name = obj.name;

for(i=0;i<num;i++){


if(obj.options[i].selected){
    value = obj.options[i].value;
    if(name.length>0 && value.length>0){
           //value = escape(value);
                value= UrlEncode(value);
           s=s+name+"="+value+"&";
    }
}


}
s="&"+s;
return s;
}





 function getQueryString(form){
   
  var name = null;
var type = null;
var value = null;
var i =0;
var num =0;

num = form.elements.length;
var s = "";
var obj = null;

for(i=0;i<num;i++){

obj = form.elements[i];
name = obj.name;
type = obj.type;

value= obj.value;



if(type=='text'||type=='hidden'||type=='textarea'){

if(name.length>0 && value.length>0){
           //value = escape(value);
                value= UrlEncode(value);
s=s+name+"="+value+"&";
}

}




if(type=='radio' || type=='checkbox'){

if(obj.checked){


if(name.length>0 && value.length>0){
           //value = escape(value);
                value= UrlEncode(value);
s=s+name+"="+value+"&";
}


}
}



if(type=='select-multiple' ||type=='select-one'){

s =s +getQueryStringOfSelect(obj);

}







}
s="&"+s;
return s;


 }




function get_form_value(form,sep){


var eles = form.elements;
var num = eles.length;

var i =0;

var name = null;
var type = null;
var arr = new Array();
var value = null;
var value2 = null;

var ele = null;
var s = "";
for(i=0;i<num;i++){

ele = eles[i];
name = ele.name;
type = ele.type;

if(type=='button' ||type=='submit'||type=='reset'){continue;}


value = arr[name];
if(value==null){
value=getValue(form,name);
arr[name]=value;
s=s+name+"="+value+sep;
}





}

return s;


}


