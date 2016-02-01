<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   String today = f.today()+"";
   String typeOption = null;
    try{
 
   typeOption = TianJinDataFile.getTypeOption();
   
   }catch(Exception e){
      w.error(e);
      return;
   }
%>
<body onload='form1.submit()'>
<form name=form1 method=post action='list.jsp' target='filef'>
<table border=0 cellspacing=0 style='width:100%;height:100%'>
 <tr>
   <td style='height:10px'>
        <select name='data_type' onchange='form1.submit()'>
        <option value=''>全部
        <%=typeOption%>
         </select>
         
         <input type=text name=date1 value='<%=today%>' onclick="new Calendar().show(this);" class=date>
         <input type=text name=date2 value='<%=today%>' onclick="new Calendar().show(this);" class=date>
         <input type=submit value='查看' class='btn'>
   </td>
 </tr>
  <tr>
   <td >
     <iframe frameborder=0 width=100% height=100% name='filef'></iframe>
   </td>
 </tr>
</table>
</form>
</body>






