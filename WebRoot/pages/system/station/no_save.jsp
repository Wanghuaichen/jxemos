<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    
      String station_id,station_no,station_desc=null;
      String msg = null;
      int num=0;
      String sql = "update t_cfg_station_info set station_no=? where station_id=?";
      
      try{
        station_id=w.p("station_id");
        station_no=w.p("station_no");
        station_desc=w.p("station_desc");
        //f.sop( station_no);
        //s = b.get("station_no");
		if(!f.empty(station_no)){
		num = f.getInt(station_no,0);
		if(num<1){f.error("��ű���Ϊ����0������");}
		}
		
		f.update(sql,new Object[]{station_no,station_id});
		
        msg = "�ѱ���,վλ����="+station_desc;
      }catch(Exception e){
      //w.error(e);
      msg = "�������,վλ����="+station_desc+","+e;
         msg = msg.replaceAll("java.lang.Exception:"," ");   
  // msg = msg.replaceAll("java.lang.IllegalArgumentException","���������ʽ����ȷ");
   msg = msg.replaceAll("java.sql.SQLException:","");
     // return;
      }
      
      
      
%>
<body onload="alert(form1.msg.value)">
<form name=form1>
 <textarea name=msg cols=80 rows=5><%=msg%></textarea>
</form>
</body>


