<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%
         String area_id = App.get("default_area_id","3609");
         String areaOption = null;
         String stationTypeOption = null;
         Connection cn = null;
         String sql = null;
         String station_type = null;

         List list = null;
         int i,num=0;
         String s = "";

         Map map = null;
         String id,name = null;
          String ctl_type,trade_id,valley_id = null;

         String ctlTypeOption,tradeOption,valleyOption = null;


         try {

         station_type = request.getParameter("station_type");
         area_id = request.getParameter("area_id");

         ctl_type = request.getParameter("ctl_type");
         trade_id = request.getParameter("trade_id");
         valley_id = request.getParameter("valley_id");

         ctlTypeOption = SwjUpdate.getCtlTypeOption(ctl_type);
         tradeOption = SwjUpdate.getTradeOption(trade_id);
         valleyOption = SwjUpdate.getValleyOption(valley_id);




         if(StringUtil.isempty(station_type)){station_type=App.get("default_station_type","1");}
                  if(StringUtil.isempty(area_id)){area_id=App.get("default_area_id","33");}

           cn = DBUtil.getConn();
              areaOption = JspPageUtil.getAreaOption(cn,area_id);
               stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);


           //sql = "select station_id,station_desc from t_cfg_station_info where ";
          // sql=sql+" station_type='"+station_type+"' ";
           //sql=sql+" and area_id like '"+area_id+"%' ";


           sql = "select station_id,station_desc from t_cfg_station_info where 2>1 and show_flag !='1'";//黄宝
           sql=sql+" and station_type='"+station_type+"' ";
           sql=sql+" and area_id like '"+area_id+"%' ";
           if(!f.empty(ctl_type)){
            if(ctl_type.equals("0")){
						sql=sql+" and ctl_type ='"+ctl_type+"' ";
					}else{
						//sql=sql+" and ctl_type >='"+ctl_type+"' ";
						sql=sql+" and ctl_type ='"+ctl_type+"' ";//黄宝修改
					}
           }

           if(!f.empty(trade_id)){
            sql=sql+" and trade_id='"+trade_id+"' ";
           }

           if(!f.empty(valley_id)){
            sql=sql+" and valley_id like '"+valley_id+"%' ";
           }



            sql = sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");

           sql=sql+" order by area_id,station_desc";

           list = DBUtil.query(cn,sql,null);
           num = list.size();

           for(i=0;i<num;i++){
           map=(Map)list.get(i);
           id = (String)map.get("station_id");
           name = (String)map.get("station_desc");
           s=s+"<span title='"+name+"'><input name=station_ids type=checkbox value='"+id+"'>"+( name.length()>12?name.substring(0, 12)+"…":name )+"</span></br>";

           }



         } catch (Exception e) {
				//out.println(e);
			JspUtil.go2error(request,response,e);
				return;
			}finally{DBUtil.close(cn);}

%>

<style>
.search {font-family: "宋体"; font-size: 12px;
    BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand;
    width:95%;
 }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 13px;
   width: 150px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

body{
background-color:#f7f7f7;
overflow: auto;
scrollbar-base-color: #ecf2f9;
	scrollbar-arrow-color: #336699;
	scrollbar-track-color: #ecf2f9;
	scrollbar-3dlight-color: #ecf2f9;
	scrollbar-darkshadow-color: #ecf2f9;
	scrollbar-highlight-color: #336699;
	scrollbar-shadow-color: #336699;

}

</style>

<body  style='padding:2px;margin:0px;background-color: #f7f7f7' >
<form name=tree_form method=post>
<input type=hidden name=txt_station_ids>
<input type="hidden" name="txt_station_type" value="<%=station_type%>">

<table style='width:100%' cellspacing=0 border=0>

<tr>
<td style='height:10px'>

<select name=area_id onchange=f_submit() class="search">
<%=areaOption%>
</select>
<select name=station_type  onchange=f_submit()  class="search">
<%=stationTypeOption%>
</select>

<select name=ctl_type onchange=f_submit()  class="search">
<option value=''>重点源属性</option>
<%=ctlTypeOption%>
</select>


<select name=valley_id onchange=f_submit() class="search">
<option value=''>请选择流域</option>
<%=valleyOption%>
</select>

<select name=trade_id onchange=f_submit() class="search" >
<option value=''>请选择行业
<%=tradeOption%>
</select>

</td>
</tr>

<tr>
<td style='font-size: 13px'>
<div>
<%=s%>
</div>
</td>
</tr>
</table>



</form>
</body>


<script>
f_load_right();

function f_load_right(){
tree_form.target="fx_right";
tree_form.action="../fx/sjfx.jsp";
tree_form.submit();
}



function f_submit(){
tree_form.target="";
tree_form.action="left2.jsp";
tree_form.submit();
}


function f_getValue(){

var cur_index = tree_form.station_type.selectedIndex;
var station_type = tree_form.station_type.options[cur_index].value;

var i =0;
var num = 0;
var v = null;
num = tree_form.station_ids.length;
var flag = f_getCheckedNum();
//alert(flag);
var station_ids = "";
var ichecked = 0;
if(num == undefined){
	if(tree_form.station_ids.checked){
	ichecked=ichecked+1;
	v = tree_form.station_ids.value;
	if(ichecked<flag){station_ids=station_ids+v+",";}else{station_ids=station_ids+v;}
}
}else{
for(i=0;i<num;i++){

if(tree_form.station_ids[i].checked){
ichecked=ichecked+1;
v = tree_form.station_ids[i].value;
if(ichecked<flag){station_ids=station_ids+v+",";}else{station_ids=station_ids+v;}
}
}
}//end for
//alert(station_ids);

//tree_form.txt_station_type.value=station_type;
tree_form.txt_station_ids.value=station_ids;
//alert(tree_form.txt_station_type.value);
//alert(tree_form.txt_station_ids.value);
}
//----------
function f_getCheckedNum(){
var num2 =0;
var num =0;
var i =0;
num = tree_form.station_ids.length;
for(i=0;i<num;i++){
if(tree_form.station_ids[i].checked){num2=num2+1;}
}
return num2;
}
//--------------------
</script>


