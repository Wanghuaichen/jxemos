<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
	Properties dynaBean = null;
	String tableName = "t_cfg_trade";
	String cols = "trade_id,trace_name";
	String trade_id = null;
	String trace_name = null;
	String trade_desc = null;
	Map map = null;
	String msg = null;
	String sql = null;
	Connection cn = null;
    int id =0;
    

	try{
	cn=DBUtil.getConn();
	dynaBean = JspUtil.getReqProp(request);

    /*
    trade_id = dynaBean.getProperty("trade_id");
    id=StringUtil.getInt(trade_id,-1);
    if(id<0){
    	msg="行业编号必需为数字且大于0";
	//JspUtil.forward(request,response,"/pages/commons/error.jsp",msg);
	JspUtil.go2error(request,response,msg);
    }


   sql="select trade_id from t_cfg_trade where trade_id='"+trade_id+"'";
	map=DBUtil.queryOne(cn,sql,null);
	if(map!=null){
	msg="行业编号["+trade_id+"]已经存在";
	//JspUtil.forward(request,response,"/pages/commons/error.jsp",msg);
	JspUtil.go2error(request,response,msg);
	return;
	}
*/
	//trace_name = dynaBean.getProperty("trace_name");
	trace_name=JspUtil.getParameter(request,"trace_name");
// 	trade_desc=JspUtil.getParameter(request,"trade_desc");
	
	
	if(trade_desc == null){trade_desc="";}
	if(StringUtil.isempty(trace_name)){
	msg="行业名称不能为空";
	//JspUtil.forward(request,response,"/pages/commons/error.jsp",msg);
	JspUtil.go2error(request,response,msg);
	return;

	}
	
	sql="select trade_id from t_cfg_trade where trace_name='"+trace_name+"'";
	map=DBUtil.queryOne(cn,sql,null);
	if(map!=null){
	msg="行业["+trace_name+"]已经存在";
	//JspUtil.forward(request,response,"/pages/commons/error.jsp",msg);
	JspUtil.go2error(request,response,msg);
	return;
	}
	//不知可用否，待测试
	//trade_id=DBUtil.getNextId(cn, tableName, "trade_id")+"";
	//System.out.println(trade_id);
	
	dynaBean.setProperty("trace_name", trace_name);
// 	dynaBean.setProperty("trade_desc", trade_desc);
	
	DBUtil.insert(cn,tableName,cols,dynaBean);
	response.sendRedirect("trade_query.jsp");
	}catch(Exception e){
	//JspUtil.forward(request,response,"/pages/commons/error.jsp",e);
	JspUtil.go2error(request,response,e);
	return;
	}finally{
	DBUtil.close(cn);
	}

%>
