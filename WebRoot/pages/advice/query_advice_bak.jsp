<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>

<%
	try
	{
		zdxUpdate.query_advice(request);
	}
	catch(Exception e)
	{
		w.error(e);
		return;
	}
	List list = (List)request.getAttribute("adviceCol");
	RowSet rs = new RowSet(list);
	String stateOpts = (String)request.getAttribute("stateOpts");
	String date1 = (String)request.getAttribute("d1");
	String date2 = (String)request.getAttribute("d2");
%>
<html>
<head>
<title>����ʡ���������Զ������ϵͳ</title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<style>
.select {font-family: "����"; font-size: 12px; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }
</style>

<script type="text/javascript">
 function submit_check(){
    form1.submit();
 }
</script>

</head>
<body>
	<form name="form1" action="query_advice.jsp" method="post">
   <div class="fieldArea">
    <fieldset>
    <legend>��ѯ</legend>
    <div class="selarea">
     	<div class="item item1">
           <label>���״̬��</label>			
		   <select name="advice_state" onChange="form1.submit()" class="select">
		    <%=stateOpts %>
	       </select>
	    </div>
		  <label>ʱ�䣺</label>	
		  <input type="text" name="date1" value="<%=date1 %>" readonly="readonly" onClick="new Calendar().show(this);" class="input1">
		  <input type="text" name="date2" value="<%=date2 %>" readonly="readonly" onClick="new Calendar().show(this);" class="input1">
		  <input type="button" class="viewbtn button" onclick="submit_check()"/>
    </div>
    </fieldset>
    </div>
	<div class="tableSty1 view3">
	<table border=0 width="100%" cellspacing="0">
	<tr>
    	<th background="../../images/bg_blue01.gif" class="yellow12_b">���</th>
    	<th background="../../images/bg_blue01.gif" class="yellow12_b">�ϴ�ʱ��</th>
    	<th background="../../images/bg_blue01.gif" class="yellow12_b">�ϴ���Ա</th>
    	<th background="../../images/bg_blue01.gif" class="yellow12_b">��������</th>
    	<th background="../../images/bg_blue01.gif" class="yellow12_b">״̬</th>
    	<th background="../../images/bg_blue01.gif" class="yellow12_b">��ϸ</th>
    </tr>
    <%
    	while(rs.next())
    	{
    		String state = "δ����";
    		if(rs.get("advice_state").equals("1"))
    		{
    			state = "�Ѵ���";
    		}
    		if(rs.get("advice_state").equals("2"))
    		{
    			state = "������";
    		}
    		String time = rs.get("advice_time").toString();
    		time = time.substring(0,16);
    %>
    <tr align="center" bgcolor="#FFFFFF">
    	<td class="black12_lh24"><%=rs.get("advice_id") %></td>
    	<td class="black12_lh24"><%=time %></td>
    	<td class="black12_lh24"><%=rs.get("advice_user") %></td>
    	<td class="black12_lh24"><%=rs.get("advice_jg") %></td>
    	<td class="black12_lh24"><%=state %></td>
    <%
    	if(rs.get("advice_state").equals("0"))
    	{
    %>
    	<td class="black12_lh24"><a href="advice_detail_pt.jsp?advice_id=<%=rs.get("advice_id") %>"><font style="color:red">��ϸ</font></a></td>
    <%
    	}
    	if(rs.get("advice_state").equals("2")||rs.get("advice_state").equals("1"))
    	{
    %>
   		 <td class="black12_lh24"><a href="advice_detail_pt.jsp?advice_id=<%=rs.get("advice_id") %>"><font style="color:gray;">��ϸ</font></a></td>
   	<%
    	}
    %>
    </tr>
    <%
    	}
    %>
</table>
</div>
 </form>
</body>
</html>