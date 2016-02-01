<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  Connection cn = null;
  String area_id,phone_no = null;
  Map m = null;
  

  
  try{
    area_id = w.p("area_id");
    phone_no = w.p("phone_no");
    if(f.empty(area_id)){throw new Exception("��������Ϊ��");}
    if(f.empty(phone_no)){throw new Exception("�ֻ��Ų���Ϊ��");}
    sql="select * from t_sys_msg_area_phone where area_id=? and phone_no=?";
    cn = f.getConn();
    Object[]p=new Object[]{area_id,phone_no};
    m = f.queryOne(cn,sql,p);
    if(m!=null){
      throw new Exception("��¼�Ѵ���,�����ظ����");
    }
    sql="insert into t_sys_msg_area_phone(area_id,phone_no) values(?,?)";
    f.update(cn,sql,p);
    response.sendRedirect("q.jsp");
  }catch(Exception e){
    w.error(e);
    return;
  }finally{f.close(cn);}

%>