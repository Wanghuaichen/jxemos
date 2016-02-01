<%@ page contentType="text/html;charset=gbk" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    List list = null;
    RowSet rs = null;
    List infectant_list = new ArrayList();
    List infectant_css = new ArrayList();
    Map infectant_map = new HashMap();
    try{

      SwjUpdate.real_data(request);//初始化数据
     list = (List)request.getAttribute("list");
     list = SwjUpdate.getFocusList(request,list);// 根据request值和list值获得收藏夹信息列表,
     rs = new RowSet(list);
    }catch(Exception e){
     w.error(e);
     return;
    }
	String area_id = request.getParameter("area_id");
    boolean iswry = f.iswry(w.get("station_type"));//判断是否是污染源数据
    String state = request.getParameter("state");//状态类型
    RowSet rsf = w.rs("flist");
    int size = rsf.size();

    String id = null;
    String v = null;
    String station_id = null;
    Map m = (Map)request.getAttribute("m");
    String css = null;
    boolean is_q_zero =false;
    int drop = 0;
    int bj = 0;
    int yj = 0;
    int all = 0;
    int standard = 0;
    int bj_flag = 0;
    int yj_flag = 0;
    int j = 1;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery-latest.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery.tablesorter.js"></script>

<script type="text/javascript">
	
	$(function() {
		$("table").tablesorter();
	});
	
</script>	

<style>
 .yj{color:#FF8000;}
 .bj{color:red;};
 .drop{color:#666;}
 .zc{color:blue}
</style>

</head>
<body>
<div id="div_excel_content" class="tableSty1" style="overflow: hidden;margin-top: -6px">
<table width="99%" border="1" cellspacing="0" cellpadding="0">

<thead>
  <tr   style="position: relative; top: expression(this.offsetParent.scrollTop);cursor: pointer;" title="点击可排序">
    <th>序号</th>
    <th>站位名称</th>
    <th>监测时间</th>
    <%while(rsf.next()){
    	if(!rsf.get("infectant_name").equals("流量2")){
    %>
      <th title="<%=rsf.get("infectant_unit")%>">
      <%=rsf.get("infectant_name")%>
      
      </th>
    <%}}%>
    <th>备注</th>

  </tr>
 </thead>
<tbody>
   <%while(rs.next()){
    station_id = rs.get("station_id");
    //String st_css = zdxUpdate.getStandardByStation(rs.get("m_time"),rs.get("station_bz"),station_id,request);//修改
    String st_css = zdxUpdate.getStandardByStation(rs.get("m_time"),"",station_id,request);
    if(st_css.equals("drop")){
    	drop++;
    }else{
    	standard++;
    }
     is_q_zero = f.is_q_zero(rs);//判断行是否为0，小于等于0返回true，否则为false
     //f.sop("is_q_zero="+is_q_zero);

     rsf.reset();
     infectant_list.clear();
     infectant_css.clear();
      while(rsf.next()){
	      id = rsf.get("infectant_id");
	      String col = rsf.get("infectant_column").toString().toLowerCase();
	      v = rs.get(id);//对应com.hoson.util.RealDataUtil.java类中的171行row.put(infectant_id, m_value);

	      v = f.v(v);
	      //if(is_q_zero){v="";}

	      css = zdxUpdate.get_css(rs.get("m_time"),v,rs.get("station_bz"),col,request);
	      //System.out.println("==="+css);
	      //if(css.equals("bj")){//异常
	      	//bj_flag = 1;
	      //}else if(css.equals("yj")){//偏高
	      	//yj_flag = 1;
	      //}

	      infectant_list.add(v);
	      infectant_css.add(css);
	  }

	  if("".equals(state)){
  %>
    <tr style="height:30px;font-family: Tahoma;">
	    <td width=3%>
	    <input name=station_ids id=station_ids type="hidden" value='<%=station_id%>'/>
	    <%=j++%></td>
	    <td width=22%><a href="javascript:f_real_view('<%=station_id%>','<%=area_id%>')"><font class='<%=st_css %>'><%=rs.get("station_desc")%></font></a></td>
	    <td width=7%><%=f.sub(rs.get("m_time"),10,9)%></td>
	        <%for(int i=0;i<infectant_list.size();i++){ %>
		        <td width=<%=55/size%>% class='<%=infectant_css.get(i) %>'><%=f.format(infectant_list.get(i),"0.#####")%></td>
		    <%
	
		    } %>
	
	     <td width=12%><a href="javascript:f_view_comment('<%=station_id%>')"><font class='<%=st_css %>'><%=rs.get("station_bz")%></font></a></td>

     </tr>
     
    
     
  <%--<%}else if(state.equals("zc") && !st_css.equals("drop") && !infectant_css.contains("yc") && !infectant_css.contains("up")){ %>
     --%>
    <%}else if(state.equals("zc") && !st_css.equals("drop")){ %>
    <tr style="height:30px;font-family: Tahoma;">
    <td width=3%>
    <input name=station_ids id=station_ids type="hidden" value='<%=station_id%>'/>
    <%=j++%></td>
    <td width=22%><a href="javascript:f_real_view('<%=station_id%>','<%=area_id%>')"><font class='<%=st_css %>'><%=rs.get("station_desc")%></font></a></td>
    <td width=7%><%=f.sub(rs.get("m_time"),10,9)%></td>
        <%for(int i=0;i<infectant_list.size();i++){ %>
	        <td width=<%=55/size%>% class='<%=infectant_css.get(i)%>'><%=f.format(infectant_list.get(i),"0.#####")%></td>
	    <%

	    }
	     %>

     <td width=12%><a href="javascript:f_view_comment('<%=station_id%>')"><font class='<%=st_css %>'><%=rs.get("station_bz")%></font></a></td>

     </tr>
  <%}else if(state.equals("yj") && infectant_css.contains("yj")){

  %>
     <tr style="height:30px;font-family: Tahoma;">
    <td width=3%>
    <input name=station_ids id=station_ids type="hidden" value='<%=station_id%>'/>
    <%=j++%></td>
    <td width=22%><a href="javascript:f_real_view('<%=station_id%>','<%=area_id%>')"><font class='<%=st_css %>'><%=rs.get("station_desc")%></font></a></td>
    <td width=7%><%=f.sub(rs.get("m_time"),10,9)%></td>
        <%for(int i=0;i<infectant_list.size();i++){ %>
	        <td width=<%=55/size%>% class='<%=infectant_css.get(i)%>'><%=f.format(infectant_list.get(i),"0.#####")%></td>
	    <%

	    } %>

     <td width=12%><a href="javascript:f_view_comment('<%=station_id%>')"><font class='<%=st_css %>'><%=rs.get("station_bz")%></font></a></td>

     </tr>
  <%}else if(state.equals("bj") && infectant_css.contains("bj")){ %>
     <tr style="height:30px;font-family: Tahoma;">
    <td width=3%>
    <input name=station_ids id=station_ids type="hidden" value='<%=station_id%>'/>
    <%=j++%></td>
    <td width=22%><a href="javascript:f_real_view('<%=station_id%>','<%=area_id%>')"><font class='<%=st_css %>'><%=rs.get("station_desc")%></font></a></td>
    <td width=7%><%=f.sub(rs.get("m_time"),10,9)%></td>
        <%for(int i=0;i<infectant_list.size();i++){ %>
	        <td width=<%=55/size%>% class='<%=infectant_css.get(i)%>'><%=f.format(infectant_list.get(i),"0.#####")%></td>
	    <%

	    } %>

     <td width=12%><a href="javascript:f_view_comment('<%=station_id%>')"><font class='<%=st_css %>'><%=rs.get("station_bz")%></font></a></td>

     </tr>
  <%}else if(state.equals("tj") && st_css.equals("drop")){ %>
     <tr style="height:30px;font-family: Tahoma;">
    <td width=3%>
    <input name=station_ids id=station_ids type="hidden" value='<%=station_id%>'/>
    <%=j++%></td>
    <td width=22%><a href="javascript:f_real_view('<%=station_id%>','<%=area_id%>')"><font class='<%=st_css %>'><%=rs.get("station_desc")%></font></a></td>
    <td width=7%><%=f.sub(rs.get("m_time"),10,9)%></td>
        <%for(int i=0;i<infectant_list.size();i++){ %>
	        <td width=<%=55/size%>% class='<%=infectant_css.get(i)%>'><%=f.format(infectant_list.get(i),"0.#####")%></td>
	    <%

	    } %>

     <td width=12%><a href="javascript:f_view_comment('<%=station_id%>')"><font class='<%=st_css %>'><%=rs.get("station_bz")%></font></a></td>

     </tr>
  </tbody>
  <%} %>
     <%
     //if(bj_flag==1){
     	//bj++;
     //}else if(yj_flag==1){
     	//yj++;
     //}
     //bj_flag = 0;
     //yj_flag = 0;
     if(infectant_css.contains("bj")){
        bj++;
     }
     if(infectant_css.contains("yj")){
        yj++;
     }

  }

  %>
  <input type=hidden name='zc' id='zc' value='<%=standard%>' />
  <input type=hidden name='yj' id='yj' value='<%=yj%>' />
  <input type=hidden name='bj' id='bj' value='<%=bj%>' />
  <input type=hidden name='tj' id='tj' value='<%=drop%>' />
</table>
</div>
</body>
</html>


<script>
 function f_real_view(station_id,area_id){
var url = "real_view_jx.jsp";
//url = "real_view.jsp";
url = "../station_new/index_one.jsp";
url = url+"?station_id="+station_id+"&area_id="+area_id;
var width = 1024;
var height = 668;
window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);

}
function f_view_comment(station_id){
	var url = "../station_new/comments.jsp";
	url = url+"?station_id="+station_id;
	var width = 1024;
	var height = 668;
	window.open(url,"","scrollbars=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);

}
    parent.get(zc.value,yj.value,bj.value,tj.value);

//var table1 = window.parent.document.getElementById("topDiv");
//var table2 = window.document.getElementById("topDiv");
//table1.innerHTML=table2.innerHTML;
</script>



