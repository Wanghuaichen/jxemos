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
<link rel="stylesheet" href="../../web/index.css"/>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<body onload=f_v()  style="overflow: hidden;">

<form name=form2 method=post>
<input type=hidden name='txt_excel_content' />
<input type=hidden name='title' value="��������" />
</form>
<form name=form1 method=post action=q.jsp target=qq>
	<div class="frame-main-content" style="left:0; top:0;position: static;">
	    <div class="tiaojian">
	    	<p class="tiaojiao-p">
	    	վλ:<select name=station_id  onchange=form1.submit() class="selectoption">
			<%=w.get("option")%>
			</select>
	    	</p>
	    	<span style="display:none"><p class="tiaojiao-p">
	    	��ֵ����:
			<select name="data_type"  onchange=form1.submit() class="selectoption" >
			<%=dataTypeOption%>
			</select>
	    	</p></span>
	    	<p class="tiaojiao-p">
	    	����״̬:
			<select name="sh_flag"  onchange=form1.submit() class="selectoption">
			<%=shOption %>
			</select>
	    	</p>
	    	 <p class="tiaojiao-p">
	    	 <span id="time_select">
	    	 	��:
				<input type=text name=date1 id='date1' value="<%=w.get("date1")%>" class="c1" readonly="readonly" onclick="new Calendar().show(this);" >
				��:
				<input type=text name=date2 id='date2' value="<%=w.get("date2")%>" class="c1" readonly="readonly" onclick="new Calendar().show(this);">
	    	 </span>
	    	 </p>
	    		    	 
	    	 <input type=button value='�鿴' onclick=f_v() class="tiaojianbutton">
			<input type=button value="����Ϊexcel" title="����Ϊexcel" class="tiaojianbutton" onclick=f_save() />
	    	 
	    </div>
	    
	</div>
	 
</form><iframe name="qq" id="qq" width="100%"   scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true" ></iframe>
</body>