<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%


          try{
            SjReport.hzbb_water(request);
        
          }catch(Exception e){
            w.error(e);
            e.printStackTrace();
            return;
          }
          RowSet rs = w.rs("datalist");
          Map zongji = (Map)request.getAttribute("zongji");
          String date1 = request.getAttribute("date1")+"";
          String date2 = request.getAttribute("date2")+"";
          String format = "0.0000";
          int i =1;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>���߼��ͼ�ع���ϵͳ</title>
<link rel="stylesheet" href="../../web/index.css" />

</head>
<body>
<div id="div_excel_content">
<table class="nui-table-inner">
	<thead class="nui-table-head">
	<tr>	<th class="nui-table-cell" colspan="7">����Ϊ�������������<%=date1 %>��<%=date2 %>ʱ����ڵ��ŷ���ͳ��</th></tr>
		<tr class="nui-table-row">
			<th class="nui-table-cell">���</th>
		    <th class="nui-table-cell">����</th>
		    <th class="nui-table-cell">COD(Kg)</th>
		    <th class="nui-table-cell">����(Kg)</th>
		    <th class="nui-table-cell">�ܵ�(Kg)</th>
		    <th class="nui-table-cell">����(Kg)</th>
		    <th class="nui-table-cell">�ۻ�����(m<sup>3</sup>)</th>
		</tr>
	</thead>
	<tbody class="nui-table-body">
 <%
     while(rs.next()){

  %>
    <tr class="nui-table-row">
       <th class="nui-table-cell"> <%=i++ %> </th>
       <th class="nui-table-cell"> <%=rs.get("name") %> </th>    
       <th class="nui-table-cell"><%=f.format(f.getljll(rs.get("val02_q",1,format),"",1+"")+"","0.0000")%></th>
       <th class="nui-table-cell"><%=f.format(f.getljll(rs.get("val05_q",1,format),"",1+"")+"","0.0000")%></th>
       <th class="nui-table-cell"><%=f.format(f.getljll(rs.get("val17_q",1,format),"",1+"")+"","0.0000") %></th>
       <th class="nui-table-cell"><%=f.format(f.getljll(rs.get("val16_q",1,format),"",1+"")+"","0.0000")%></th>
       <th class="nui-table-cell"><%=f.format(f.getljll(rs.get("val04",1,format),"",1+"")+"","0.0000")%></th>
      
     </tr>
  <%
    }
  %>
  <tr class="nui-table-row">
 	 <th class="nui-table-cell"> <%=i %> </th>
       <th class="nui-table-cell"> �ܼ� </th>       
       <th class="nui-table-cell"><%=f.format(f.getljll(zongji.get("z_val02_q")+"","",1+"")+"","0.0000")%></th>
       <th class="nui-table-cell"><%=f.format(f.getljll(zongji.get("z_val05_q")+"","",1+"")+"","0.0000")%></th>
       <th class="nui-table-cell"><%=f.format(f.getljll(zongji.get("z_val17_q")+"","",1+"")+"","0.0000") %></th>
       <th class="nui-table-cell"><%=f.format(f.getljll(zongji.get("z_val16_q")+"","",1+"")+"","0.0000")%></th>
       <th class="nui-table-cell"><%=f.format(f.getljll(zongji.get("z_val04")+"","",1+"")+"","0.0000") %></th>
    </tr>
  </tbody>

</table>
</div>
</body>
</html>