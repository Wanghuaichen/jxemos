<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    try{
    
      SHUpdate.data_sh(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    Map data = (Map)request.getAttribute("data");
    XBean b = new XBean(data);
%>
<title>数据审核</title>
<body scroll=no>
<form name=form1 method=post target="sj_sh" action="data_update.jsp">
<input type="hidden" name="station_id" value="<%=b.get("station_id") %>" />
<input type="hidden" name="m_time" value="<%=b.get("m_time") %>" />
<input type="hidden" name="infectant_name" value="<%=b.get("infectant_col") %>" />
<input type="hidden" name="jc_data" value="<%=f.v(b.get(b.get("infectant_col"))) %>" />
<table border=0 cellspacing=1>

<tr class=tr0>
<td class='tdtitle'>审核站位</td>
<td class=left>

<%=b.get("station_desc") %>
</td>
</tr>

<tr class=tr0>
<td class='tdtitle'>监测时间</td>
<td class=left>

<%=b.get("m_time") %>
</td>
</tr>


<tr class=tr0>
<td class='tdtitle'>审核因子</td>
<td class=left>

<%=b.get("infectant_desc") %>
</td>
</tr>




<tr class=tr1>
<td class='tdtitle'>监测值</td>
<td class=left>

<%=f.v(b.get(b.get("infectant_col"))) %>
</td>
</tr>



<tr class=tr0>
<td class='tdtitle'>参考值</td>
<td class=left>

7
</td>
</tr>


<tr>
<td class='tdtitle'>审核值</td>
<td class=left>

<input type="text" name="<%=b.get("infectant_col") %>">
</td>
</tr>


<tr>
<td class=left colspan="2">


<input type="button" value="返回" onclick="window.close()" class="btn">
<input type="submit" value="保存" class="btn">
</form>
</body>
<script>
name="sj_sh";
</script>
