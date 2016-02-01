<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet station,flist;



    try{

      SwjUpdate.report_cm_index(request);

    }catch(Exception e){
     w.error(e);
     return;
    }
    
    String sh_flag = request.getParameter("sh_flag");
    String shOption = SwjUpdate.getShState(sh_flag);
    String hzOption = SwjUpdate.gethzbbtype("");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<link rel="stylesheet" href="../../web/index.css"/>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<title>在线检测和监控管理系统</title>

</head>


<script type="text/javascript">

function f_save(){
//alert(window.frames["frm_station"].window.frames["q"]);
    var obj = window.frames["frm_station"].window.document.getElementById('div_excel_content');
    // alert(obj);
    //alert(obj.innerHTML);
    //var form2 = window.document.getElementById('excel_form');
    //alert(form2);
    form1.txt_excel_content.value=obj.innerHTML;
    
    var date1 = form1.date1.value;
    var date2 = form1.date2.value;
    if(date1 == date2){
        form1.title.value = date1+"日的汇总报表";
    }else {
        form1.title.value = "从"+date1+"到"+date2+"间的汇总报表";
    }
    

    form1.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form1.submit();
}

</script>

<body style="overflow: hidden;" onload=form1.submit()>

<form name="form1" method=post action="rpt.jsp" target="frm_station">
<input type=hidden name='title' value='汇总报表' />
<input type=hidden name='txt_excel_content' />
<input type=hidden name='w_cols' value='val01,val02,val03,val04,val05,val06,val07,val08,val16,val17' />
<input type=hidden name='w_gross_cols' value='val01,val02,val05,val16,val17'  />
<input type=hidden name='w_q_col' value='val04'  />


<input type=hidden name='w_ph' value='val03'  />
<input type=hidden name='w_cod' value='val02'  />
<input type=hidden name='w_toc' value='val01'  />
<input type=hidden name='w_q' value='val04'  />
<input type=hidden name='w_q_lj' value='val08'  />
<input type=hidden name='w_nh3n' value='val05'  />
<input type=hidden name='w_tn' value='val17'  />
<input type=hidden name='w_tp' value='val16'  />
<input type=hidden name='station_id' value=''  />


<input type=hidden name='g_cols' value='val05,val06,val07,val04,val09,val11,val22'  />
<input type=hidden name='g_gross_cols' value='val05,val06,val07'  />
<input type=hidden name='g_q_col' value='val11'  />

<input type=hidden name='g_so2' value='val05'  />
<input type=hidden name='g_pm' value='val06'  />
<input type=hidden name='g_nox' value='val07'  />
<input type=hidden name='g_op' value='val04'  />
<input type=hidden name='g_t' value='val09'  />
<input type=hidden name='g_q' value='val11'  />
<input type=hidden name='g_s' value='val11'  />
<input type=hidden name='g_q_lj' value='valxx'  />


<div class="frame-main-content" style="left:0; top:0;position: static;" >
		<div class="nt">
	      <ul class="">
	        <li>
	          <label>
	         	   报表类型:
				<select name="hzbb_type"  onchange=f_r()  class="selectoption" >
				<%=hzOption %>
		       </select>
	          </label>
	        </li>
	        <li>
	          <label>
	         	  站位类型:
					<select name=station_type  onchange=f_r() class="selectoption" >
						<%=w.get("stationTypeOption")%>
					</select>
	          </label>
	        </li>
	        <li>
	          <label>
			            地区:
				<select name=area_id id="area" onchange=f_r() class="selectoption" >
					<%=w.get("areaOption")%>
				</select>
	          </label>
	        </li>
	        <li>
	          <label>
			              行业:
				<select name=trade_id onchange=f_r() class="selectoption"  >
					<option value='root'>请选择行业</option>
					<%=w.get("tradeOption")%>
				</select>
	          </label>
	        </li>
	      </ul>    
	    </div>
	    
	    <div class="tiaojian">
	    	 <p class="tiaojiao-p">
	    	 	从:
		      <input type='text' class="c1" name='date1' id='date1' value='<%=w.get("date1")%>' readonly="readonly" onclick="new Calendar().show(this);" /> 
		           到:
		      <input type='text' class="c1" name='date2' id='date2' value='<%=w.get("date2")%>' readonly="readonly" onclick="new Calendar().show(this);" /> 
		    	 </p>
	    	 <p class="tiaojiao-p">
	    	 	  数据状态:
				<select name="sh_flag"  onchange=f_submit()  class="selectoption" >
				<%=shOption %>
		       </select>
  	    	 </p>
	    
	    	 <input type="button" value='查看' title="查看" class="tiaojianbutton" onclick='f_submit()' id='btn_view' />
			 <input type="button" value='保存为excel' title="保存为excel" class="tiaojianbutton"  onclick=f_save() />
	    	 
	    </div>    
	</div>

</form>

<iframe name="frm_station" id="frm_station"  width=100%  frameborder="0"  style="border:0px;height: 85%" allowtransparency="true">
</iframe>

<script>
function f_submit(){
  form1.action='rpt.jsp';
  form1.target='frm_station';
  form1.submit();

}
 function f_r(){
   form1.action='rpt.jsp';
   form1.target='frm_station';
   form1.submit();
   
 }
 
 function select_area(id){
       var id = id;
       
       if(id !="" && id.length<=4){
		   var url="<%=request.getContextPath() %>/servlet/ServletSys?area_id="+id;
	       $.post(url,null,select_area_databack);
	       return false;
	   }
	   f_r();
 }
 
 function select_area_databack(databack){
    var area = document.getElementById("area");
   // alert(databack);
    area.innerHTML = "";
    $("#area").append(databack);
    f_r();
 }

 if(screen.height>=1024){
	  document.getElementById("frm_station").height=800;
	}else if(screen.height>=900  && screen.height<1024 ){
	  document.getElementById("frm_station").height=680;
	}else if(screen.height>=800  && screen.height<900 ){
	  document.getElementById("frm_station").height=580;
	}else if(screen.height>=768  && screen.height<800 ){
	  document.getElementById("frm_station").height=540;
	}else if(screen.height>=720  && screen.height<768 ){
	  document.getElementById("frm_station").height=500;
	}


</script>
</body>



