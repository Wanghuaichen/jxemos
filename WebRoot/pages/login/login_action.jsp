<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="com.hoson.*" %>
<%@page import="com.hoson.search.md5" %>
<%
    String user_name = null;
    String user_id = null;
    String user_pwd = null;
    String sql = null;
    Map<?, ?> map = null;
    Properties prop = null;
    String msg = null;
    String res_ids = null;
    Connection cn = null;
    try {
        prop = JspUtil.getReqProp(request);
        user_id = prop.getProperty("user_id", "");
        user_name = prop.getProperty("user_name", "");
        user_pwd = prop.getProperty("user_pwd", "");
        //user_pwd=new md5().EncoderByMd5(user_pwd);
        //System.out.println(user_pwd);
        sql = "select * from t_sys_user where user_name=? and user_pwd=?";

        cn = DBUtil.getConn();

        //System.out.println(cn.toString());

        Object[] p = new Object[]{user_name, user_pwd};
        map = DBUtil.queryOne(cn, sql, p);
        if (map == null) {
            //msg="用户名密码不正确";
            //JspUtil.go2error(request,response,msg);
%>
<script type='text/javascript'>
    alert("用户名或密码不正确");
    history.back();
    //window.top.location.href = "login.jsp";
</script>
<%
            return;
        }
        user_id = (String) map.get("user_id");

        //sql="delete from t_sys_user_res where user_id not in ";
        // sql=sql+"(select user_id from t_sys_user)";
        //  DBUtil.update(cn,sql,null);

        //  sql="select res_ids from t_sys_user_res where user_id='"+user_id+"'";
        //  map=DBUtil.queryOne(cn,sql,null);
        //  if(map==null){
        //  res_ids="";
        // }else{
        //  res_ids=(String)map.get("res_ids");
        // }
        //  session.setAttribute("res_ids",res_ids);

        session.setAttribute("user_id", user_id);
        session.setAttribute("user_name", user_name);
        response.sendRedirect("../home/index.jsp");

    } catch (Exception e) {
        JspUtil.go2error(request, response, e);
        e.printStackTrace();
        return;
    } finally {
        DBUtil.close(cn);
    }
%>
