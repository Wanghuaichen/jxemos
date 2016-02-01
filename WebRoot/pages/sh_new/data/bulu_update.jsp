<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%@page import="com.hoson.search.*"%>
<%@page import="com.hoson.util.PBean"%>
<%--<%
 	Map model = null;
 	String table = "T_MONITOR_REAL_HOUR_V";
  	String cols = "station_id,m_time,V_DESC,v_flag,operator"+request.getParameter("cols");
 	
 try{
 
 model = f.model(request);
 f.insert(table,cols,0,model);
   String station_id = request.getParameter("station_id");
  String m_time = request.getParameter("m_time");
  String V_DESC = request.getParameter("V_DESC");
  if(!"".equals(V_DESC) && V_DESC != null){
	   V_DESC = new String(V_DESC.getBytes("ISO-8859-1"), "gbk"); 
    }
 Log.insertLog("编号为："+station_id+"的站位，"+m_time+"时间的数据被补录，补录说明为："+V_DESC, request);
 
 }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }
 

%>
<script>
alert("修改成功！");
</script>--%>

<%
	Map model = null;
	String t = "";
	String table = "T_MONITOR_REAL_HOUR_V";
	//String cols = "station_id,m_time,V_DESC,v_flag,operator"+request.getParameter("cols");

	Timestamp t1, t2 = null;
	String date = request.getParameter("date1");

	String hour1 = request.getParameter("hour1");

	String hour2 = request.getParameter("hour2");

	t1 = f.time(date + " " + hour1 + ":0:0");
	t2 = f.time(date + " " + hour2 + ":59:59");

	String cols = request.getParameter("cols");

	try {

		String sql = "select distinct station_id,m_time,v_desc,v_flag,operator"
				+ cols + " from  T_MONITOR_REAL_HOUR_V";
		sql = sql + " where station_id=? and m_time>=? and m_time<=?";
		sql = sql + " order by m_time desc ";

		String station_id = request.getParameter("station_id");

		Object[] p = new Object[]{station_id, t1, t2};

		List extjl = f.query(sql, p);//查找数据库已经存在的记录

		List extsj = new ArrayList();//数据库中已经存在的时间

		List needbl = new ArrayList();//需要补录的时间点

		List needcr = new ArrayList();//需要插入的记录

		for (int i = Integer.valueOf(hour1); i <= Integer
				.valueOf(hour2); i++) {
			needbl.add(f.time(date + " " + i + ":0:0").toString());
		}

		int size = extjl.size();

		for (int i = 0; i < size; i++) {
			t = ((Map) extjl.get(i)).get("m_time").toString();
			extsj.add(t);
		}

		for (int i = 0; i < needbl.size(); i++) {
			if (!(extsj.contains(needbl.get(i)))) {
				needcr.add(needbl.get(i));
			}
		}
		cols = "station_id,m_time,V_DESC,v_flag,operator"
				+ request.getParameter("cols");
		String[] col = request.getParameter("cols").split(",");

		model = f.model(request);

		//插入不存在的记录
		size = needcr.size();
		for (int i = 0; i < size; i++) {
			model.put("m_time", needcr.get(i).toString());
			f.insert(table, cols, 0, model);
		}

		//更新已存在的记录
		size = extsj.size();
		for (int i = 0; i < size; i++) {
			model.put("m_time", extsj.get(i).toString());
			//System.out.println(extsj.get(i).toString());
			for (int j = 0; j < col.length; j++) {
				model.put(col[j], request.getParameter(col[j]) + ","
						+ ((Map) extjl.get(i)).get(col[j]));
			}
			f.save(table, cols, 2, model);
		}

		//f.insert(table,cols,0,model);

		String V_DESC = request.getParameter("V_DESC");
		if (!"".equals(V_DESC) && V_DESC != null) {
			V_DESC = new String(V_DESC.getBytes("ISO-8859-1"), "gbk");
		}
		Log.insertLog("编号为：" + station_id + "的站位，在" + date + "号"
				+ hour1 + "时到" + hour2 + "时间的数据为补录数据，补录说明为：" + V_DESC,
				request);

	} catch (Exception e) {
		e.printStackTrace();
		JspUtil.go2error(request, response, e);
		return;
	}
%>
<script>
	alert("修改成功！");
</script>