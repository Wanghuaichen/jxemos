<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      String url1,url2 = null;
      Connection cn = null;
      String ip = null;
      Map m = null;
      String station_id = null;
      String sql = null;
      String port = "8888";
      String user = "admin";
      String pwd = "admin1234";
      String  msg = "请从左边选择一个站位";
      String info = null;
      int pos = 0;
      String sid = null;
      String user_name = null;
      String comm_user,comm_passwd = null;
      String url = null;
    
      user = "user";
      pwd = "user";
      
      try{
      user_name = (String)session.getAttribute("user_name");
      if(user_name == null){user_name="null";}
      //pos = user_name.indexOf("admin");
      if(!user_name.equals("admin")){
        throw new Exception("只有系统管理员才有远程控制权限");
      }
      session.setAttribute("url_index","7");
  
station_id=(String)session.getAttribute("station_id");
 if(StringUtil.isempty(station_id)){

	station_id = request.getParameter("station_id");
	}
if(StringUtil.isempty(station_id)){

	throw new Exception(msg);
	}
	  
	  sql = "select comm_str,comm_user,comm_passwd from t_cfg_station_info where station_id='"+station_id+"'";
	cn =DBUtil.getConn();
	m = DBUtil.queryOne(cn,sql,null);
	if(m==null){m=new HashMap();}
	ip = (String)m.get("comm_str");
	if(StringUtil.isempty(ip)){

	throw new Exception("请配置远程控制信息");
	}
	comm_user = (String)m.get("comm_user");
	comm_passwd = (String)m.get("comm_passwd");
	if(!StringUtil.isempty(comm_user)){user=comm_user;}
	if(!StringUtil.isempty(comm_passwd)){pwd=comm_passwd;}
	
	url1 = "http://"+ip+":"+port+"/emos/odbc_form_web_login?account="+user+"&password="+pwd;
        
	try{
	info = HttpClient.getUrlContent(url1);
	}catch(Exception e){
	 throw new Exception("远程控制登录时出错，请检查配置信息");
	}
	pos = info.indexOf("|");
	if(pos<0){
	 throw new Exception("用户名密码错误");
	}
	sid = info.substring(pos+1);
        String power = "guest";
        if(f.eq(user,"admin")){power="admin";}
	url2 = "http://"+ip+":"+port+"/Frame/default.htm?power="+power+"&account="+user+"&valCode="+sid;
       
        if(2<1){
               response.sendRedirect(url2);
                return;
        }
      }catch(Exception e){
       JspUtil.go2error(request,response,e);
       return;
      }finally{DBUtil.close(cn);}
%>
<body>
<%=ip%>
<%=info%>
<%=sid%>
<form name=form1 action='<%=url2%>' target=q>
    
</form>

</body>
<script>
 //form1.submit();

function openWindow(url,width,height)
{

    window.open (url,"_blank", "height=" + height + "px , width=" + width + "px ,top=" 
	+ ((screen.availHeight - height -100)/2).toString() + "px ,left=" + ((screen.availWidth - width)/2).toString() 
	+ "px , toolbar =no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no");


//showModalDialog(url); 

}
//openWindow('<%=url2%>',800,600);
//window.opener.close();
function openWindowSelf(url)
{
	var  features =  "scrollbars=yes,"
					+ "height="+(screen.availHeight - 70).toString()+","
					+ "width="+(screen.availWidth - 27).toString()+","
					+ "top=10,left=10"
					+ ",resizable=yes,status=no,titlebar=no,toolbar=no";
	//var features = "titlebar=no,menubar=no,scrollbars=yes,fullscreen =yes,resizable=yes,status=no";
    var pw = null;
	pw = window.open(url,"_blank",features);
   	if (null == pw || true == pw.closed)
    {
       	return false;
    }
	else
	{
		CloseSelf();
		return false;
	}
}

function CloseSelf()
{					
	window.opener = 'xxx';
	window.self.close();
}


openWindowSelf('<%=url2%>');

</script>

