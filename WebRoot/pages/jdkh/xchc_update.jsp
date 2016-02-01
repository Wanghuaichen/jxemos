<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    Map data;

    String id = "";

   String user_area_id = (String)request.getSession().getAttribute("area_id");
   String flag = request.getParameter("flag");
    try{
      id = request.getParameter("id");
      SwjUpdate.queryXchcInfoByID(request);
    }catch(Exception e){
       w.error(e);
       return;
    }
    
    data = (Map)w.a("data");


	//String drop_css = "";
	String checked = "";


  	Map map = null;

%>

<form action="xchc_updateaction.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">国家重点监控企业污染源自动监测设备现场核查表(修改信息页面)</caption>
    <tr>
        <td style="text-align: center">核查单位</td>
        <td> <input type="text" name="hcdw" value="<%=data.get("hcdw") %>"> </td>
        <td colspan="2" style="text-align: center">核查日期</td>
        <td colspan="2"> 
        
           <input type="text" name="hcrq" id="hcrq"  value="<%=data.get("hcrq") %>" readonly="readonly"  onclick="new Calendar().show(this);"> 
           <input type="hidden" name="id" value="<%=id %>">
           <input type="hidden" name="qyid" value="<%=data.get("qyid") %>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    <tr>
        <td style="text-align: center">企业名称</td>
        <td> <input type="text" name="qymc" value="<%=data.get("qymc") %>"> </td>
        <td colspan="2" style="text-align: center">组织机构代码</td>
        <td colspan="2"> <input type="text" name="zzjgdm" value="<%=data.get("zzjgdm") %>"> </td>
    </tr>
    <tr>
        <td style="text-align: center">企业地址</td>
        <td colspan="3"> <input type="text" name="address" value="<%=data.get("address") %>"> </td>
        <td style="text-align: center">邮编</td>
        <td > <input type="text" name="youbian" value="<%=data.get("youbian") %>"> </td>
    </tr>
     <tr>
        <td style="text-align: center">法人代表</td>
        <td > <input type="text" name="frdb" value="<%=data.get("frdb") %>"> </td>
        <td style="text-align: center">环保负责人</td>
        <td > <input type="text" name="hbfzr" value="<%=data.get("hbfzr") %>"> </td>
        <td style="text-align: center">电话</td>
        <td > <input type="text" name="phone" value="<%=data.get("phone") %>"> </td>
    </tr>
    <tr>
        <td rowspan="5">污染源自动监测设备基本情况</td>
        <td > 排污口名称</td>
        <td colspan="4"><input type="text" name="wr_pwkmc" value="<%=data.get("wr_pwkmc") %>"></td>
    </tr>
    <tr>
        <td > 排污口编码</td>
        <td colspan="4"><input type="text" name="wr_pwkbm" value="<%=data.get("wr_pwkbm") %>"></td>
    </tr>
    <tr>
        <td > 设备型号</td>
        <td colspan="4"><input type="text" name="wr_sbxh" value="<%=data.get("wr_sbxh") %>"></td>
    </tr>
    <tr>
        <td >生产厂家</td>
        <td colspan="4"><input type="text" name="wr_sccj" value="<%=data.get("wr_sccj") %>"></td>
    </tr>
    <tr>
        <td >验收情况</td>
        <td colspan="4"><input type="text" name="wr_ysqk" value="<%=data.get("wr_ysqk") %>"></td>
    </tr>
    
    
    
    <tr>
        <td rowspan="5">制度执行情况</td>
        <td > 设备操作、使用维护保养记录</td>
        <td colspan="2">
            <select name="zd_sbyw" >
               <%=f.getOption("1,0","有,无",(String)data.get("zd_sbyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_sbws">
               <%=f.getOption("1,0","完善,不完善",(String)data.get("zd_sbws")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td > 运行、巡检记录</td>
        <td colspan="2">
            <select name="zd_xjyw">
               <%=f.getOption("1,0","有,无",(String)data.get("zd_xjyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_xjws">
               <%=f.getOption("1,0","完善,不完善",(String)data.get("zd_xjws")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td > 定期校准校验记录</td>
        <td colspan="2">
            <select name="zd_xyyw">
               <%=f.getOption("1,0","有,无",(String)data.get("zd_xyyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_xyws">
               <%=f.getOption("1,0","完善,不完善",(String)data.get("zd_xyws")) %>
            </select>
        </td>
    </tr>
    <tr>
       <td >标准物质易耗品定期更换记录</td>
        <td colspan="2">
            <select name="zd_ghyw">
               <%=f.getOption("1,0","有,无",(String)data.get("zd_ghyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_ghws">
               <%=f.getOption("1,0","完善,不完善",(String)data.get("zd_ghws")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td > 设备故障状况及处理记录</td>
        <td colspan="2">
            <select name="zd_clyw">
               <%=f.getOption("1,0","有,无",(String)data.get("zd_clyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_clws">
               <%=f.getOption("1,0","完善,不完善",(String)data.get("zd_clws")) %>
            </select>
        </td>
    </tr>
    
    
    
   <tr>
        <td rowspan="19">设备运行情况</td>
        <td rowspan="4"> 仪器参数设置情况</td>
        <td colspan="2">
            二级门禁管理系统
        </td>
        <td colspan="2">
            <select name="sb_mjyw">
              <%=f.getOption("1,0","有,无",(String)data.get("sb_mjyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
           氧量
        </td>
        <td colspan="2">
            <select name="sb_ylyw">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_ylyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            校准系数
        </td>
        <td colspan="2">
            <select name="sb_xsyw">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_xsyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            速度场系数
        </td>
        <td colspan="2">
            <select name="sb_scyw">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_scyw")) %>
            </select>
        </td>
    </tr>
    
    
    <tr>
        <td> 仪器参数</td>
        <td colspan="2">
            设备设置值
        </td>
        <td colspan="2">
            现场核查值
        </td>
    </tr>
    <tr>
        <td> 排污口尺寸(米)</td>
        <td colspan="2">
             <input type="text" name="sb_cjsb" value="<%=data.get("sb_cjsb") %>"> 
        </td>
        <td colspan="2">
           <input type="text" name="sb_cjxc" value="<%=data.get("sb_cjxc") %>"> 
        </td>
    </tr>
    <tr>
        <td> 过剩空气系数</td>
        <td colspan="2">
              <input type="text" name="sb_kqsb" value="<%=data.get("sb_kqsb") %>"> 
        </td>
        <td colspan="2">
               <input type="text" name="sb_kqxc" value="<%=data.get("sb_kqxc") %>"> 
        </td>
    </tr>
    <tr>
        <td> 校准系数</td>
        <td colspan="2">
               <input type="text" name="sb_xzsb" value="<%=data.get("sb_xzsb") %>"> 
        </td>
        <td colspan="2">
              <input type="text" name="sb_xzxc" value="<%=data.get("sb_xzxc") %>"> 
        </td>
    </tr>
    <tr>
        <td> 速度场系数</td>
        <td colspan="2">
              <input type="text" name="sb_sdsb" value="<%=data.get("sb_sdsb") %>"> 
        </td>
        <td colspan="2">
              <input type="text" name="sb_sdxc" value="<%=data.get("sb_sdxc") %>"> 
        </td>
    </tr>
    <tr>
        <td rowspan="2"> 异常、缺失数据标记和处理</td>
        <td colspan="2">
             有无标记
        </td>
        <td colspan="2">
            <select name="sb_ycbjyw">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_ycbjyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
             有无处理
        </td>
        <td colspan="2">
            <select name="sb_ycclyw">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_ycclyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td> 数据运转率(%)</td>
        <td colspan="4">
             <input type="text" name="sb_sbyzl" value="<%=data.get("sb_sbyzl") %>"> 
        </td>
    </tr>
    <tr>
        <td> 数据传输率(%)</td>
        <td colspan="4">
             <input type="text" name="sb_sjcsl" value="<%=data.get("sb_sjcsl") %>"> 
        </td>
    </tr>
    
    <tr>
        <td rowspan="6"> 数据报表</td>
        <td colspan="2">
             污染物排放浓度
        </td>
        <td colspan="2">
            <select name="sb_bbnd">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_bbnd")) %>
            </select>
        </td>
    </tr>
    
    <tr>

        <td colspan="2">
             流量
        </td>
        <td colspan="2">
            <select name="sb_bbll">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_bbll")) %>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
            污染物排放总量
        </td>
        <td colspan="2">
            <select name="sb_bbzl">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_bbzl")) %>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             日报
        </td>
        <td colspan="2">
            <select name="sb_bbrb">
              <%=f.getOption("1,0","有,无",(String)data.get("sb_bbrb")) %>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             月报
        </td>
        <td colspan="2">
            <select name="sb_bbyb">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_bbyb")) %>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             季报
        </td>
        <td colspan="2">
            <select name="sb_bbjb">
               <%=f.getOption("1,0","有,无",(String)data.get("sb_bbjb")) %>
            </select>
        </td>
    </tr>
    
    <tr>

        <td >
             核查人员(签字)
        </td>
        <td colspan="2">
            <input type="text" name="hcry" value="<%=data.get("hcry") %>">
        </td>
        <td>
            签字日期
        </td>
        <td colspan="2">
            <input type="text" name="hcry_rq" value="<%=data.get("hcry_rq") %>" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>

        <td >
             企业人员(签字)
        </td>
        <td colspan="2">
            <input type="text" name="qyry" value="<%=data.get("qyry") %>">
        </td>
        <td>
            签字日期
        </td>
        <td colspan="2">
            <input type="text" name="qyry_rq" value="<%=data.get("qyry_rq") %>" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>

        <td >
             备注
        </td>
        <td colspan="3">
            <input type="text" name="beizhu" style="width:350px"  value="<%=data.get("beizhu") %>">
        </td>
        <td>
            结论
        </td>
        <td>
            <select name="hcjl">
               <%=f.getOption("1,0","合格,不合格",(String)data.get("hcjl")) %>
            </select>
        </td>
    </tr>
    
    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
	    <tr >
	       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="修改" class="btn">
	           <input type="button" value="关闭" class="btn" onclick="window.close();">&nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="导出信息" class="btn" onclick="export_info('<%=id %>','export_XchcInfo')">
	        </td>
	    </tr>
	<%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
	    <tr >
	       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="修改" class="btn">
	           <input type="button" value="关闭" class="btn" onclick="window.close();">  &nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="导出信息" class="btn" onclick="export_info('<%=id %>','export_XchcInfo')">
	        </td>
	    </tr>
    <%} %>
    
     <tr>
      <td style='height:100%' colspan="6">
         <iframe name='frm_zw_list' id='frm_zw_list' width=100% height=100% frameborder=0 allowtransparency="true"></iframe>
     <br></td>
  </tr>
    
</table>

</form>
<br>
<br>

<script type="text/javascript">

function check_form(form){
   var input_cart=document.getElementsByTagName("INPUT");
   var input_all=0;
      for(var i=0;i<input_cart.length;i++)   {   
          if(input_cart[i].type=="text" && input_cart[i].value!="") {
    
              input_all=input_all+1;   
          }   
      }
   if (input_all<29)
   {
     alert("请把信息填写完整，谢谢!");
     return false;
   }
   
   form.submit();

}

function export_info(id,method){
   window.open("export_page.jsp?id="+id+"&method="+method,"frm_zw_list");
   
}

</script>


