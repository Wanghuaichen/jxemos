<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      
BaseAction action = null;
String dataTypeOption = null;
String vs = "t_monitor_real_hour,T_MONITOR_REAL_TEN_MINUTE,t_monitor_real_day,t_monitor_real_month";
String ts = "Сʱ����,ʮ��������,������,������";
String data_type = request.getParameter("data_type");
String sh_flag = null;
String shOption = null;

try{
    action = new WarnAction();
    action.run(request,response,"his");
   
   
   dataTypeOption = JspUtil.getOption(vs,ts,data_type);
   
   sh_flag = request.getParameter("sh_flag");
   shOption = SwjUpdate.getShState(sh_flag);
   
}catch(Exception e){
      w.error(e);
      return;
}
   
%>

<style>
*{
 font-size:12px;
}

</style>

<style>
.search {font-family: "����"; font-size: 12px; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }
.input {
   border: #ccc 1px solid;
   font-family: "΢���ź�";
   font-size: 13px;
   width: 100px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

.btn1{width:40px; height:23px;  background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none; text-align:center; }

</style>

<script>
function f_v(){
 //alert(1);
  form1.submit();
}

function select_station(){
   var date1 = document.getElementById("date1").value;
   var date2 = document.getElementById("date2").value;
   
   if(date1 !="" && date2 !=""){//�������ڶ���Ϊ��
      
        if((date2>date1) && (DateDiff(date1,date2)<31)){
            
        }else{
           alert("��ʼʱ�䲻�ܴ��ڽ���ʱ���ʱ��β��ܴ���һ����!");
        }
   }
   
}


function DateDiff(sDate1,sDate2){ 
  
  var aDate,oDate1,oDate2,iDays ;
  aDate = sDate1.split('-');  
  
  oDate1 = new Date(aDate[1]+'-'+aDate[2]+'-'+aDate[0]) ;
  
  aDate = sDate2.split('-') ;  
  oDate2 = new Date(aDate[1]+'-'+ aDate[2] +'-'+ aDate[0]);  
  iDays = parseInt(Math.abs(oDate1 - oDate2)/1000/60/60/24);   
   return iDays ;
}


function f_save(){
    var obj = window.frames["qq"].window.document.getElementById('div_excel_content');
    //alert(obj);
    form2.txt_excel_content.value=obj.innerHTML;
    var date1 = form1.date1.value;
    var date2 = form1.date2.value;
    if(date1 == date2){
        form2.title.value = date1+"�ı�������";
    }else {
        form2.title.value = "��"+date1+"��"+date2+"��ı�������";
    }
    
    form2.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form2.submit();
}


</script>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<body onload=f_v() style="background-color: #f7f7f7">

<form name=form2 method=post>
<input type=hidden name='txt_excel_content' />
<input type=hidden name='title' value="��������" />
</form>

<table border=0  cellspacing=0 style='width:100%;height:100%;font-size: 13px;color: #01538a;font-weight: bold'>
<tr>
<td >
<form name=form1 method=post action=q.jsp target=qq>
վλ:<select name=station_id  onchange=form1.submit() class="search" style="width: 240px;">
<%=w.get("option")%>
</select>
<span style="display:none">
��ֵ����:
<select name="data_type"  onchange=form1.submit() class="search" style="width:100px" >
<%=dataTypeOption%>
</select>
</span>
����״̬:
<select name="sh_flag"  onchange=form1.submit() class="search" style="width:100px">
<%=shOption %>
</select>

<%--
��:
<input type=text name=date1 id='date1' value="<%=w.get("date1")%>" class=date readonly="readonly" onpropertychange="select_station()"  onclick="new Calendar().show(this);" >
��:
<input type=text name=date2 id='date2' value="<%=w.get("date2")%>" class=date readonly="readonly"  onpropertychange="select_station()" onclick="new Calendar().show(this);">

--%>
��:
<input type=text name=date1 id='date1' value="<%=w.get("date1")%>" class="input" readonly="readonly" onclick="new Calendar().show(this);" >
��:
<input type=text name=date2 id='date2' value="<%=w.get("date2")%>" class="input" readonly="readonly" onclick="new Calendar().show(this);">


<input type=button value='�鿴' onclick=f_v() class=btn1 style="width:80px">
<input type=button value="����Ϊexcel" title="����Ϊexcel" style=" background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none;  width:80px;height:25px " onclick=f_save() />


</form>
</td>
</tr>

<tr>
<td  style='height:100%'>
<iframe name=qq id='qq' width=100% height=100% scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</td>
</tr>
</table>





