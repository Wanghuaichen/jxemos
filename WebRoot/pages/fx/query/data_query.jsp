<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
Connection cn = null;
String sql = null;
String bar = null;
String l_value = "";//最后修改的值
String min = "";
String max = "";
String hideCols = "station_type,data_type,area_id,valley_id,station_name,date1,date2,show_minmax_flag,station_id,sh_flag";
String station_type = null;
String col = null;
String msg = null;
@SuppressWarnings("rawtypes")
List  infectantList = null;
String date1 = request.getParameter("date1");
String date2 = request.getParameter("date2");
@SuppressWarnings("rawtypes")
Map m = null;
RowSet rs1, rs2 = null;
int i, num = 0;
String v = null;
int len = 10;
String data_type = request.getParameter("data_type");
if (f.eq(data_type, "hour")) {
    len = 13;
    } else {
    len = 10;
}
station_type = request.getParameter("station_type");
if (StringUtil.isempty(station_type)) {
    //out.println("站位类别不能为空");
    msg = "站位类别不能为空";
    JspUtil.go2error(request, response, msg);
    return;
}

try {
    
    Check.data_query(request);
    infectantList = f.getInfectantList(station_type);
    if (infectantList.size() < 1) {
        //out.println("数据列为空,请配置监测指标对应的数据列");
        msg = "数据列为空,请配置监测指标对应的数据列";
        JspUtil.go2error(request, response, msg);
        return;
    }
    
    cn = f.getConn();
    
    sql = AppPage.get_fx_data_query_sql(infectantList, request);
    
    //out.println(sql);
    //m = f.query(cn,sql,null,request);
    /*
    if(f.eq(data_type,"hour")){
        m = f.checkQuery(cn,sql,null,request);
    }
    */
    m = f.checkQuery(cn, sql, null, request);
    @SuppressWarnings("rawtypes")
    List list = (List) m.get("data");
    
    bar = (String) m.get("bar");
    rs1 = new RowSet(infectantList);
    rs2 = new RowSet(list);
    //len = 10;
    
    } catch (Exception e) {
    //out.println(e);
    JspUtil.go2error(request, response, e);
    
    return;
    } finally {
    f.close(cn);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>在线检测和监控管理系统</title>
<link rel="stylesheet" href="../../../web/index.css" />
</head>
<body>
<form name=form1 method="post">
<%=JspUtil.getHiddenHtml(hideCols, request)%>
<div id='div_excel_content'>
<table class="nui-table-inner">
<thead class="nui-table-head">
<tr class="nui-table-row">
<%
if (date1.equals(date2)) {
    %>
    <th class="nui-table-cell" id="colspan"
    colspan="<%=rs1.size()+2%>">下表为<%=date1%>的监测数据</th>
    <%
    } else {
    %>
    <th class="nui-table-cell" id="colspan"
    colspan="<%=rs1.size()+2%>">下表为<%=date1%>到<%=date2%>间的监测数据</th>
    <%
}
%>
</tr>
<tr class="nui-table-row">
<th class="nui-table-cell">站位名称</th>
<th class="nui-table-cell">监测时间</th>
<%
int colspan = 0;
while (rs1.next()) {
    if (!rs1.get("infectant_name").equals("流量2")) {
        %>
        <th class="nui-table-cell"><%=rs1.get("infectant_name")%> <%=rs1.get("infectant_unit")%>
        </th>
        <%
        }else{
        colspan++;
        %>
        <script type="text/javascript">
        document.getElementById("colspan").colSpan--;
        </script>
        <%
    }
}
%>
</tr>
</thead>
<tbody class="nui-table-body">
<%
while (rs2.next()) {
    rs1.reset();
    String className = "blue";
    if (rs2.get("v_flag") != null) {
        if (rs2.get("v_flag").equals("1")) {
            className = "blank";
        }
    }
    if (request.getParameter("sh_flag").equals("0")) {
        className = "blank";
    }
    %>
    <%--<tr class="<%=className %>" style="height: 30px;">--%>
    <tr class="nui-table-row">
    <td class="nui-table-cell"><%=rs2.get("station_name")%></td>
    <td class="nui-table-cell"><%=rs2.get("m_time")%></td>
    <%
    while (rs1.next()) {
        if (!rs1.get("infectant_name").equals("流量2")) {
            col = rs1.get("infectant_column");
            int flag = 0;
            if (col == null) {
                col = "";
            }
            col = col.toLowerCase();
            v = rs2.get(col);
            max = "";
            min = "";
            if (v.indexOf(",") >= 0) {
                String[] arr = v.split(",");
                if (arr.length >= 1) {
                    v = arr[0];
                    v = v.split(";")[0];
                }
                if (arr.length >= 2) {
                    min = arr[1];
                }
                if (arr.length >= 3) {
                    max = arr[2];
                }
                } else {
                v = f.v(v);
            }
            if (flag == 0) {
                %>
                <td class="nui-table-cell" title="最大值(<%=max%>)最小值(<%=min%>)"
                style="cursor: pointer;"><%=v%></td>
                <%
                } else {
                %>
                <td class="nui-table-cell" title="最大值(<%=max%>)最小值(<%=min%>)"
                style="cursor: pointer;"><font style='color:red'><%=v%></font>
                </td>
                <%
            }
        }
    }
    %>
    
    </tr>
    
    <%
}
%>
<tr class="nui-table-row">
<th class="nui-table-cell" colspan="<%=rs1.size()+2-colspan%>"><%=bar%></th>
</tr>
</tbody>
</table>
</div>
</form>
<script>
function f_go_page(ipage) {
    form1.page.value = ipage;
    form1.submit();
}
</script>
</body>
</html>