<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%
Connection cn = null;
String sql = null;
String bar = null;
String l_value = "";//����޸ĵ�ֵ
 String min = "";
    String max = "";
String hideCols="station_type,data_type,area_id,valley_id,station_name,date1,date2,show_minmax_flag,station_id,sh_flag";
String station_type = null;
String col = null;
String msg=null;
List list,infectantList = null;
String date1 = request.getParameter("date1");
String date2 = request.getParameter("date2");
Map m = null;
 RowSet rs1,rs2 = null;
 int i,num=0;
 String v=null;
int len = 10;
String data_type = request.getParameter("data_type");
 if(f.eq(data_type,"hour")){len=13;}else{len=10;}
station_type=request.getParameter("station_type");
if(StringUtil.isempty(station_type)){
//out.println("վλ�����Ϊ��");
	msg = "վλ�����Ϊ��";
	JspUtil.go2error(request,response,msg);
return;
}



try{

Check.data_query(request);
     infectantList = f.getInfectantList(station_type);
if(infectantList.size()<1){
//out.println("������Ϊ��,�����ü��ָ���Ӧ��������");
	msg = "������Ϊ��,�����ü��ָ���Ӧ��������";
	JspUtil.go2error(request,response,msg);
return;
}

cn = f.getConn();



sql=AppPage.get_fx_data_query_sql(infectantList,request);


   //out.println(sql);
   //m = f.query(cn,sql,null,request);
   /*
   if(f.eq(data_type,"hour")){
   m = f.checkQuery(cn,sql,null,request);
   }
   */
   m = f.checkQuery(cn,sql,null,request);

   list = (List)m.get("data");



   bar = (String)m.get("bar");
   rs1 = new RowSet(infectantList);
   rs2 = new RowSet(list);
   //len = 10;


}catch(Exception e){
//out.println(e);
        JspUtil.go2error(request,response,e);

return;
}finally{
f.close(cn);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
<link href="../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../styles/common/common.css" rel="stylesheet" type="text/css" />
<link href="../styles/common/select1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../scripts/jSelect/jselect.js"></script>
<script type="text/javascript" src="../scripts/common.js"></script>

<style >
.btn{
  width:30px;
}
 a {
   color:#000;
 }

</style>

</head>
<body style="background-color: #f7f7f7"  style="overflow-x:hidden">

<form name=form1 method="post">
<%=JspUtil.getHiddenHtml(hideCols,request)%>
<%--<div style="position: relative; top: expression(this.offsetParent.scrollTop);z-index:0;color:#000"><%=bar%></div>
--%><div id='div_excel_content' class="tableSty1 view3">
<% if(date1.equals(date2)){%>
<span  style="position: relative; top: expression(this.offsetParent.scrollTop);font: 18px;background-color: #f7f7f7;width:100%;margin-top: -20px">�±�Ϊ<%=date1 %>�ļ������</span>
<%}else{
%>
<span  style="position: relative; top: expression(this.offsetParent.scrollTop);font: 18px;background-color: #f7f7f7;width:100%;margin-top: -20px">�±�Ϊ<%=date1 %>��<%=date2 %>��ļ������</span>
<% 
} %>
<table width="99%" border="1" cellspacing="0" cellpadding="0">

<%--<tr style="position: relative; top: expression(this.offsetParent.scrollTop);">
--%>
<tr style="position: relative; top: expression(this.offsetParent.scrollTop);">
<%--<th>վλ���</th>--%>
<th>վλ����</th>
<th>���ʱ��</th>
   <%
     while(rs1.next()){
     if(!rs1.get("infectant_name").equals("����2"))
     	{
   %>
   <%--<th title="<%=rs1.get("infectant_unit")%>">
     --%>
     <th>
    <%=rs1.get("infectant_name")%> <%=rs1.get("infectant_unit")%>
     
   </th>
   <%
        }
     }
   %>
</tr>
     <%
       while(rs2.next()){
       rs1.reset();
       String className = "blue";
       if(rs2.get("v_flag")!=null){
       		if(rs2.get("v_flag").equals("1")){
       			className = "blank";
       		}
       }
		if(request.getParameter("sh_flag").equals("0")){
			className = "blank";
		}
     %>
     <tr class="<%=className %>" style="height: 30px;">
     <%--<td><%=rs2.get("station_id")%></td>--%>
     <td><%=rs2.get("station_name")%></td>
     <%--<td><%=f.sub(rs2.get("m_time"),0,len)%></td>--%>
     <td><%=rs2.get("m_time")%></td>
     <%while(rs1.next()){
     if(!rs1.get("infectant_name").equals("����2"))
     	{
       col = rs1.get("infectant_column");
       int flag = 0;
       if(col==null){col="";}
       col=col.toLowerCase();
       v = rs2.get(col);
       max ="";  min = "";
       if (v.indexOf(",") >= 0) {
       		String[] arr = v.split(",");

       		//�����ԭʼ��
       		//if(arr.length>=2){
       			//v = arr[0]+"["+arr[1]+"]";
       			//flag = 1;
       		//}else{
       			//v = arr[0];
       		//}
       		 if(arr.length>=1){
	           v=arr[0];
	           v = v.split(";")[0];
	         }
	         if(arr.length>=2){
	            min=arr[1];
	         }
	         if(arr.length>=3){
	            max=arr[2];
	         }
       }else{
       		v=f.v(v);
       }
       //v=f.format(v,"#.####");
       //�޸Ĺ����ú�ɫ��ʾ
       if(flag==0){
     %>
     <td title="���ֵ(<%=max %>)��Сֵ(<%=min %>)" style="cursor: pointer;"><%=v%></td>
     <%}else{ %>
     <td title="���ֵ(<%=max %>)��Сֵ(<%=min %>)" style="cursor: pointer;"><font style='color:red'><%=v%></font></td>
     <%}}
        }
     %>

     </tr>

     <%
      }

     %><%--
     <tr>
        <td colspan="100" align="right">
           <%=bar %>
        </td>
     </tr>

--%></table>
</div>
<div style="width:97%;float: right;color: #000">
     <%=bar %>
   </div>

</form>

</body>
</html>
<script>
function f_go_page(ipage){
 form1.page.value=ipage;
 form1.submit();
}
</script>
