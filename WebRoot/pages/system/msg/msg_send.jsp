<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%!
  public int check_mobile(String s){
    if(f.empty(s)){return 0;}
    double d = f.getDouble(s,0);
    if(d<10){return 0;}
    int len = 0;
    len = s.length();
    if(len<11 &&len>12){return 0;}
    return 1;
    
    
  }
%>
<%
   String mobile = null;
   String content = null;
   Connection cn = null;
   int flag = 0;
   try{
   
     mobile = f.p(request,"mobile");
  content = f.p(request,"content");
    flag = check_mobile(mobile);
    
    if(flag<1){throw new Exception("mobile format error");}
    if(f.empty(content)){
    throw new Exception("content is empty");
    }
    cn =f.getConn();
    com.hoson.msg.MsgUtil.save_msg(cn,mobile,content);
    
   }catch(Exception e){
     w.error(e);
     return;
   }finally{f.close(cn);}
   

%>

msg send <%=f.time()%>

<table>
 <tr>
  <td>mobile</td>
  <td><%=mobile%></td>
 </tr>
  <tr>
  <td>content</td>
  <td><%=content%></td>
 </tr>
</table>

