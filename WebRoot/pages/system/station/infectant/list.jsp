<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      
      Connection cn = null;
   
      Map map,row = null;
      List list = null;
      RowSet rs = null;
      String bar = null;
      String station_id,sql,station_type,infectant_id = null;
      List infectantList = null;
      List stationInfectantList = null;
      int i,j,num=0;
      XBean b = null;
      map = new HashMap();
      String flag = "0";
      String rpt_flag = "0";
      String form = null;
      String show_btn_flag = request.getParameter("show_btn_flag");
      int irow=0;
      try{
      show_btn_flag="1";
      station_id = request.getParameter("station_id");
       if(StringUtil.isempty(station_id)){
     throw new Exception("��ѡ��վλ");
     }
      cn = DBUtil.getConn();
     sql = "select station_type from t_cfg_station_info where station_id='"+station_id+"'";
     map = DBUtil.queryOne(cn,sql,null);
     if(map==null){
     throw new Exception("վλ������");
     }
      station_type = (String)map.get("station_type");
      
         if(StringUtil.isempty(station_type)){
     throw new Exception("�����ü������");
     }
      
      sql = "select infectant_id,infectant_name,infectant_column from t_cfg_infectant_base ";
      sql=sql+" where station_type='"+station_type+"' ";
      sql=sql+" order by infectant_order";
      
      infectantList = DBUtil.query(cn,sql,null);
      
      sql="select * from t_cfg_monitor_param where station_id='"+station_id+"'";
      
      stationInfectantList = DBUtil.query(cn,sql,null);
      
      num = stationInfectantList.size();
      for(i=0;i<num;i++){
      
       row = (Map)stationInfectantList.get(i);
       map.put(row.get("infectant_id"),row);
       
       
      
      }
      
      rs = new RowSet(infectantList);
      
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
      
      
      
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<style>
td{
text-align:left;
}
.v{
width:50px;
}
</style>
<table border=0 cellspacing=1>

<tr class=title>
<td>���</td>

<td>����</td>
<td>��׼ֵ</td>


<td>Ԥ������</td>
<td>Ԥ������</td>

<td>��������</td>
<td>��������</td>



<td>��������</td>
<td>��������</td>

<!--
<td>�����Ƿ��ӡ</td>

<td>��ʾ˳��</td>
-->


</tr>


<%
	while(rs.next()){
	infectant_id=rs.get("infectant_id");
	form="form_"+rs.getIndex();
	row = (Map)map.get(infectant_id);
	//if(row==null){flag=" ";}else{flag=" checked";}
	if(row==null){continue;}
	irow++;
	b= new XBean(row);
	if(StringUtil.equals(b.get("report_flag"),"1")){
	rpt_flag="��ӡ";
	}else{
	rpt_flag="����ӡ";
	}
	
%>

  <tr>
  
  <form name=<%=form%> method=post>
  
  <input type=hidden name=station_id value="<%=station_id%>">
  <input type=hidden name=infectant_id value=<%=infectant_id%>>
  <input type=hidden name=infectant_column value=<%=rs.get("infectant_column")%>>
  
  <input type=hidden name=group_id value="01">
  
  <td><%=irow%></td>
 
  <td><%=rs.get("infectant_name")%></td>
  
  <td><%=b.get("standard_value")%></td>

    
  <td><%=b.get("lo")%></td>
  <td><%=b.get("hi")%></td>
  

   <td><%=b.get("lolo")%></td>
    <td><%=b.get("hihi")%></td>
  
   <td><%=b.get("lolololo")%></td>
  
  <td><%=b.get("hihihihi")%></td>
  <!--
  
  <td><%=rpt_flag%></td>
  
   <td><%=b.get("show_order")%></td>
  
  -->
  
  </form>
  
  </tr>




<%}%>

</table>



<script>
function f_save(f){
//alert(f);
f.action="u.jsp";
f.target="u";
f.submit();



}
</script>











