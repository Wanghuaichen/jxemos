<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.search.*" %>
<%
 	Map model = null;
 	String table = request.getParameter("data_table").toString();
 	String operator3 = request.getParameter("operator3");
 	String v_flag = request.getParameter("v_flag");
  	String cols = "station_id,m_time,V_DESC,v_flag,operator"+request.getParameter("cols");
  	String his_value = "";//ԭʼֵ
  	String[] hv_arr = null;//ԭʼֵ����
  	String now_value = "";//�����޸ĵ�ֵ
  	
  	if(!"".equals(operator3) && operator3 != null && v_flag !=null ){
  	   cols = "station_id,m_time,V_DESC,v_flag,operator,operator2"+request.getParameter("cols");
  	}
 	
 try{
 
    //��ѯԭ���ļ�¼
    String sql = "select * from  T_MONITOR_REAL_HOUR_V where station_id=? and m_time=?";
    String station_id = request.getParameter("station_id");
	String m_time = request.getParameter("m_time");
    Object[]p = new Object[]{station_id,m_time};
    List  exinfo = f.query(sql,p);//�������ݿ��Ѿ����ڵļ�¼
    
    String[] col= request.getParameter("cols").split(",");
    
    model = f.model(request);
    
    if(exinfo !=null && exinfo.size()>0){
        for(int j=0;j<col.length;j++){
        
          his_value = (String)((Map)exinfo.get(0)).get(col[j]);
          now_value = request.getParameter(col[j]);
          if(his_value !=null){
             hv_arr = his_value.split(",");
          }
          if(his_value !=null && !"".equals(his_value)){
        
             if(!"".equals(now_value) && now_value !=null && !now_value.equals(hv_arr[0])){
                model.put(col[j],request.getParameter(col[j])+","+((Map)exinfo.get(0)).get(col[j]));
             }else if(!"".equals(now_value) && now_value !=null && now_value.equals(hv_arr[0])){
                model.put(col[j],((Map)exinfo.get(0)).get(col[j]));
             }else if("".equals(now_value) || now_value ==null){
                model.put(col[j],","+((Map)exinfo.get(0)).get(col[j]));
             }
          }else{
             
             if(!"".equals(now_value) && now_value !=null){
                model.put(col[j],request.getParameter(col[j])+","+((Map)exinfo.get(0)).get(col[j]));
             }else{
                model.put(col[j],((Map)exinfo.get(0)).get(col[j]));
             }
          }
          
	      
	   }
    }
     
     if(v_flag !=null || v_flag.equals("5")){
         model.put("v_flag","7");
     }
	 
	 f.save(table,cols,2,model);
	 
	 //���¼����վ�ֵ���¾�ֵ
	 String station_type = request.getParameter("station_type");
	 
	 sql = "select * from t_cfg_infectant_base where station_type='"+station_type+"' and (infectant_type='1' or infectant_type='2')";
	 List infectant = f.query(sql,null);
	 
	 WarnAction action = null;
     
	 try{
	    action = new WarnAction();
	    action.js(station_id,m_time,m_time,infectant);
	}catch(Exception e){
	      w.error(e);
	      e.printStackTrace();
	}
	 //���¼����վ�ֵ���¾�ֵ����
	 
	  
	  String V_DESC = request.getParameter("V_DESC");
	  if(!"".equals(V_DESC) && V_DESC != null){
		   V_DESC = new String(V_DESC.getBytes("ISO-8859-1"), "gbk"); 
	    }
	 Log.insertLog("���Ϊ��"+station_id+"��վλ��"+m_time+"ʱ������ݱ���ˣ����˵��Ϊ��"+V_DESC, request);
	 
 }catch(Exception e){
       e.printStackTrace();
      JspUtil.go2error(request,response,e);
      return;
 }
 

%>
<script>
alert("�޸ĳɹ���");
</script>