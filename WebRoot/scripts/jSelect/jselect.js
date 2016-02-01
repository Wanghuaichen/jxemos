function $Select() {
	return document.getElementById(arguments[0]);
}
//取得外部class的属性值
function getCurrentStyle(o) {
	return o.currentStyle||document.defaultView.getComputedStyle(o,null);
}
var SetAllSelects = {
Offset:function(e) {
   var t = e.offsetTop;
   var l = e.offsetLeft;
   var w = e.offsetWidth;
   var h = e.offsetHeight;
   while(e = e.offsetParent) { t += e.offsetTop; l += e.offsetLeft; }
   return {top:t, left:l, width:w, height:h};
},
setCreated:function(obj,status) { //设置属性
   obj.setAttribute("childCreated",status);
},
getCreated:function(obj) { //获取属性
   var status = obj.getAttribute("childCreated");
   if(status == null) { status = ""; }
   return status;
},
setSelectStyle:function(obj,idnum,showHeight) {
   if(obj.id == null || obj.id == "") { obj.id = "selectID_"+idnum; }
   var offset = this.Offset(obj);
   obj.style.visibility = "hidden";
   var mainDiv = document.createElement("div");
   var iDiv = document.createElement("div");
   var js_select_;
   var _this = this;
   iDiv.className = "iDiv";
   iDiv.id = js_select_+obj.id;
   iDiv.style.width = offset.width +10+ "px";
   iDiv.style.top = offset.top + "px";
   iDiv.style.left = offset.left + "px";
   this.setCreated(iDiv,"");
   mainDiv.appendChild(iDiv);
   var tValue = obj.options[obj.selectedIndex].innerHTML;
   iDiv.innerHTML = tValue;
   iDiv.onmouseover = function() { iDiv.className = "iDiv iDiv_over"; }
   iDiv.onmouseout = function() { iDiv.className = "iDiv iDiv_out"; }
   iDiv.onclick = function() {
    var created = _this.getCreated(this);
    if (created != "") {
     if (created == "open") {
      this.nextSibling.style.display = "none";
      _this.setCreated(this,"close");
     }
     else {
      _this.setCreated(this,"open");
      var arrLiObj = this.nextSibling.getElementsByTagName("li");
      var selOjbIndex = 0;
      for(var i=0;i<arrLiObj.length;i++) {
       var status = arrLiObj[i].getAttribute("liSelected");
       if(status == null) { status = ""; }
       if(status == "selected") { selOjbIndex = i; break; }
      }
      arrLiObj[selOjbIndex].style.background = "#fff";
      arrLiObj[selOjbIndex].style.color = "#000";
      this.nextSibling.style.display = "block";
     }
    }
    else {
     _this.setCreated(this,"open");
     var cDiv = document.createElement("div");
     cDiv.className = "cDiv";
     cDiv.style.width = offset.width +10+ "px";
     cDiv.style.height = obj.options.length * 20 + "px";
     if(parseInt(cDiv.style.height)>showHeight) {
      cDiv.style.height = showHeight + "px";
     }
     cDiv.style.top = (offset.top+parseInt(getCurrentStyle(this).height)+1) + "px";
     cDiv.style.left = offset.left + "px";
     cDiv.onselectstart = function() {return false;};
     var uUl = document.createElement("ul");
     cDiv.appendChild(uUl);
     mainDiv.appendChild(cDiv);
     for (var i=0;i<obj.options.length;i++) {
      var lLi = document.createElement("li");
      lLi.id = obj.options[i].value;
      lLi.innerHTML = obj.options[i].innerHTML;
      lLi.sValue = obj.options[i].value;
      uUl.appendChild(lLi);
     }
     var liObj = uUl.getElementsByTagName("li");
     if(liObj.length>0) {
      for (var j=0;j<obj.options.length;j++) {
       liObj[j].onmouseover = function() {
        var arrLiObj = this.parentNode.getElementsByTagName("li");
        for(var i=0;i<arrLiObj.length;i++) {
         var status = "";
         var _background = "#85A5DE";
         var _color = "#fff";
         if(arrLiObj[i] != this) {
          _background = "#fff";
          _color = "#000";
          status = "selected";
         }
         arrLiObj[i].style.background = _background;
         arrLiObj[i].style.color = _color;
         arrLiObj[i].setAttribute("liSelected",status);
        }
       }
       liObj[j].onclick = function() {
        obj.options.length = 0;
        obj.options[0] = new Option(this.innerHTML,this.sValue);
        this.parentNode.parentNode.style.display = "none";
        _this.setCreated(this.parentNode.parentNode.previousSibling,"close");
        iDiv.innerHTML = this.innerHTML;
       };
       liObj[0].style.background = "#85A5DE";
       liObj[0].style.color = "#fff";
       liObj[0].setAttribute("liSelected","selected");
      }
     }
    }
   }
   document.body.appendChild(mainDiv);
},
setSelectStyle2:function(obj,idnum,showHeight) {
   if(obj.id == null || obj.id == "") { obj.id = "selectID_"+idnum; }
   var offset = this.Offset(obj);
   obj.style.visibility = "hidden";
   var mainDiv = document.createElement("div");
   var iDiv = document.createElement("div");
   var js_select_;
   var _this = this;
   iDiv.className = "iDiv2";
   iDiv.id = js_select_+obj.id;
   iDiv.style.width = 189 + "px";
   iDiv.style.top = offset.top + "px";
   iDiv.style.left = 10 + "px";
   this.setCreated(iDiv,"");
   mainDiv.appendChild(iDiv);
   var tValue = obj.options[obj.selectedIndex].innerHTML;
   iDiv.innerHTML = tValue;
   iDiv.onmouseover = function() { iDiv.className = "iDiv2 iDiv_over2"; }
   iDiv.onmouseout = function() { iDiv.className = "iDiv2 iDiv_out2"; }
   iDiv.onclick = function() {
    var created = _this.getCreated(this);
    if (created != "") {
     if (created == "open") {
      this.nextSibling.style.display = "none";
      _this.setCreated(this,"close");
     }
     else {
      _this.setCreated(this,"open");
      var arrLiObj = this.nextSibling.getElementsByTagName("li");
      var selOjbIndex = 0;
      for(var i=0;i<arrLiObj.length;i++) {
       var status = arrLiObj[i].getAttribute("liSelected");
       if(status == null) { status = ""; }
       if(status == "selected") { selOjbIndex = i; break; }
      }
      arrLiObj[selOjbIndex].style.background = "#fff";
      arrLiObj[selOjbIndex].style.color = "#000";
      this.nextSibling.style.display = "block";
     }
    }
    else {
     _this.setCreated(this,"open");
     var cDiv = document.createElement("div");
     cDiv.className = "cDiv2";
     cDiv.style.width = 165 + "px";
     cDiv.style.height = obj.options.length * 20 + "px";
     if(parseInt(cDiv.style.height)>showHeight) {
      cDiv.style.height = showHeight + "px";
     }
     cDiv.style.top = (offset.top+parseInt(getCurrentStyle(this).height)) + "px";
     cDiv.style.left = 10 + "px";
     cDiv.onselectstart = function() {return false;};
     var uUl = document.createElement("ul");
     cDiv.appendChild(uUl);
     mainDiv.appendChild(cDiv);
     for (var i=0;i<obj.options.length;i++) {
      var lLi = document.createElement("li");
      lLi.id = obj.options[i].value;
      lLi.innerHTML = obj.options[i].innerHTML;
      lLi.sValue = obj.options[i].value;
      uUl.appendChild(lLi);
     }
     var liObj = uUl.getElementsByTagName("li");
     if(liObj.length>0) {
      for (var j=0;j<obj.options.length;j++) {
       liObj[j].onmouseover = function() {
        var arrLiObj = this.parentNode.getElementsByTagName("li");
        for(var i=0;i<arrLiObj.length;i++) {
         var status = "";
         var _background = "#FEF6C4";
         var _color = "#ff9966";
         if(arrLiObj[i] != this) {
          _background = "#fff";
          _color = "#000";
          status = "selected";
         }
         arrLiObj[i].style.background = _background;
         arrLiObj[i].style.color = _color;
         arrLiObj[i].setAttribute("liSelected",status);
        }
       }
       liObj[j].onclick = function() {
        obj.options.length = 0;
        obj.options[0] = new Option(this.innerHTML,this.sValue);
        this.parentNode.parentNode.style.display = "none";
        _this.setCreated(this.parentNode.parentNode.previousSibling,"close");
        iDiv.innerHTML = this.innerHTML;
       };
       liObj[0].style.background = "#FEF6C4";
       liObj[0].style.color = "#ff9966";
       liObj[0].setAttribute("liSelected","selected");
      }
     }
    }
   }
   document.body.appendChild(mainDiv);
},
setAllSelectStyle:function() {
   var s = document.getElementsByTagName("select");
   var s2 = document.getElementsByTagName("select");
   for (var i=0; i<s.length; i++) {
    if(s[i].className == "select") {
     this.setSelectStyle(s[i],i,200);
    }
   }
   for (var j=0; j<s2.length; j++) {
    if(s2[j].className == "select2") {
     this.setSelectStyle2(s2[j],j,200);
    }
   }
}
}
document.onclick = function(e) {
e = e || window.event;
var target = e.target || event.srcElement;
var s = document.getElementsByTagName("select");
var s2 = document.getElementsByTagName("select");
var js_select_;
for (var i=0; i<s.length; i++) {
   if(s[i].className == "select") {
    var objdivtmp = $Select(js_select_+s[i].id);
    var created = SetAllSelects.getCreated(objdivtmp);
    if (created == "open") {
     if(target != objdivtmp) {
      objdivtmp.nextSibling.style.display = "none";
      SetAllSelects.setCreated(objdivtmp,"close");
     }
    }
   }
}
for (var j=0; j<s2.length; j++) {
   if(s2[j].className == "select2") {
    var objdivtmp = $Select(js_select_+s2[j].id);
    var created = SetAllSelects.getCreated(objdivtmp);
    if (created == "open") {
     if(target != objdivtmp) {
      objdivtmp.nextSibling.style.display = "none";
      SetAllSelects.setCreated(objdivtmp,"close");
     }
    }
   }
}
}
window.onload = function() {
SetAllSelects.setAllSelectStyle();
}

/*
var kk = document.getElementsByTagName('select')[2];
return kk.options[kk.selectedIndex].value;

var kk = document.getElementsByTagName('select')[2];
return kk.options[kk.selectedIndex].innerHTML;
*/