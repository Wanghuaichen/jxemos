<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
	out.clear();
	out = pageContext.pushBody();

	String title = "";
	String s = null;
	String gbk = "<meta http-equiv='Content-Type' contect='text/html;charset=gbk'>";
	//s = request.getParameter("txt_excel_content");
	try {
		s = com.hoson.JspUtil
				.getParameter(request, "txt_excel_content");
		title = com.hoson.JspUtil.getParameter(request, "title");
		title = java.net.URLEncoder.encode(title + ".xls", "UTF-8");
		if ("".equals(title) || title == null) {
			title = "data";
		}
		//if(s==null){s="null";}
		//s= new String(s.getBytes("ISO-8859-1"),"GBK");
		//System.out.println(s);title
	} catch (Exception e) {
		s = e + "";
	}
	if (s == null) {
		s = "null";
	}
	//System.out.println(s);
	s = s.replaceAll("border=0", "border=1");
	s = s.replaceAll("BORDER=0", "border=1");

	//System.out.println(s);
	s = gbk + s;
	//response.addHeader("Content-Disposition","attachment;filename=data.xls"); 
	response.addHeader("Content-Disposition", "attachment;filename="
			+ title);
	//response.setContentType("ms-excel/msword");
	response.setContentType("application/vnd.ms-excel;charset=gb2312");
	response.getOutputStream().write(s.getBytes());
%>

<%
	response.getOutputStream().close();
%>
