<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%--
    String optionStation = null;
	String sql = null;
	try{

	sql = "select station_id,station_desc from t_cfg_station_info";
	optionStation = JspUtil.getOption(sql,"",request);

	}catch(Exception e){
	JspUtil.go2error(request,response,e);
	return;
	}

--%>



<body scroll=no>

<form name=form1 method=post action="user_insert.jsp">
<input type=hidden name=station_ids >
<table border=0 cellspacing=1>

<tr class=tr0>
<td class='tdtitle'>�û���</td>
<td class=left>

<input type="text" name="user_name">
<%=App.require()%>
</td>
</tr>


<tr class=tr1>
<td class='tdtitle'>�û�����</td>
<td class=left>

<input type="password" name="user_pwd">
<%=App.require()%>
</td>
</tr>


<tr class=tr0>
<td class='tdtitle'>�ظ�����</td>
<td class=left>

<input type="password" name="user_pwd2">
<%=App.require()%>
</td>
</tr>

<tr class=tr1>
<td class='tdtitle'>�û�������</td>
<td class=left>

<input type="text" name="user_allname">
</td>
</tr>
<%-- 
<tr class=tr0>
<td class='tdtitle' width="230px">ӵ��վλ<span style="color:red">(��סctrl���ɽ��ж�ѡ��</td>
<td class=left>

<select name=sel_station_ids multiple=true size="20"><%=optionStation%></select>
</td>
</tr>
--%>
<tr class=tr0>
<td class='tdtitle'></td>
<td class=left>

<input type="button" value="����" class="btn" onclick="submit1()">
<input type="button" value="����" onclick="history.back()" class="btn">
</td>
</tr>
</table>
</form>
<script>
	function submit1(){
		//var itemSelect=document.all["sel_station_ids"]; 
	    //var res="";  
	   // for(var i=0;i <itemSelect.options.length;i++) { 
	   // if (itemSelect.options[i].selected == true) { 
	   // res=res+itemSelect.options[i].value+","; 
	   // } 
	   // }  
	   // alert(res); 
	   // form1.station_ids.value = res;
	    form1.submit();
	}
</script>

