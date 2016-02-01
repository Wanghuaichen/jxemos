<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
         String user_id = null;
         
         user_id = (String)session.getAttribute("user_id");
         if(StringUtil.isempty(user_id)){
         response.sendRedirect("./nologin.jsp");
         return;
         
         }
         
         String pwd_old,pwd1,pwd2 = null;
         Connection cn = null;
         String sql = null;
         Map m = null;
         String pwd_lock = null;
         String md5 = null;

         try{
         pwd_old = JspUtil.getParameter(request,"pwd_old","");
         pwd1 = JspUtil.getParameter(request,"pwd1","");
         pwd2 = JspUtil.getParameter(request,"pwd2","");
         if(StringUtil.isempty(pwd_old)){
         throw new Exception("原密码不能为空");
         }
         if(StringUtil.isempty(pwd1)){
         throw new Exception("密码不能为空");
         }
         
         if(!StringUtil.equals(pwd1,pwd2)){
            throw new Exception("密码不一致");
         }
         
         cn = DBUtil.getConn();


         //if(2>1){out.println(user_id+","+pwd_lock+","+sql);}
         sql = "select user_id from t_sys_ww_user where user_id=? and user_pwd=?";
         
         
         md5 = f.cfg("md5","0");
         if(f.eq(md5,"1")){
           pwd_old = f.md5(pwd_old);
           pwd1 = f.md5(pwd1);
         }
         m = DBUtil.queryOne(cn,sql,new Object[]{user_id,pwd_old});
         if(m==null){
         throw new Exception("原密码不正确");
         }
         
         sql = "update t_sys_ww_user set user_pwd=? where user_id=? ";
         DBUtil.update(cn,sql,new Object[]{pwd1,user_id});
         
         
         }catch(Exception e){
           JspUtil.go2error(request,response,e);
           return;
         }finally{DBUtil.close(cn);}
         
         
         
         

%>

<br><br><br><br><br><br>
密码已修改