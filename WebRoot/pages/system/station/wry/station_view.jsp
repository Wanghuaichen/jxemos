<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	Map m = null;
	XBean b = null;
	try {
		SwjUpdate.view(request);
		m = (Map) request.getAttribute("data");
		b = new XBean(m);
	} catch (Exception e) {
		w.error(e);
		return;
	}
	Connection cn = null;

	Map map, row = null;
	List list = null;
	RowSet rs = null;
	String bar = null;
	String station_id, sql, station_type, infectant_id = null;
	List infectantList = null;
	List stationInfectantList = null;
	int i, j, num = 0;
	map = new HashMap();
	String flag = "0";
	String rpt_flag = "0";
	String form = null;
	String show_btn_flag = request.getParameter("show_btn_flag");
	int irow = 0;
	try {
		show_btn_flag = "1";
		station_id = request.getParameter("station_id");
		if (StringUtil.isempty(station_id)) {
			throw new Exception("请选择站位");
		}
		cn = DBUtil.getConn();
		sql = "select station_type from t_cfg_station_info where station_id='"
				+ station_id + "'";
		map = DBUtil.queryOne(cn, sql, null);
		if (map == null) {
			throw new Exception("站位不存在");
		}
		station_type = (String) map.get("station_type");

		if (StringUtil.isempty(station_type)) {
			throw new Exception("请配置监测类型");
		}

		sql = "select infectant_id,infectant_name,infectant_column from t_cfg_infectant_base ";
		sql = sql + " where station_type='" + station_type + "' ";
		sql = sql + " order by infectant_order";

		infectantList = DBUtil.query(cn, sql, null);

		sql = "select * from t_cfg_monitor_param where station_id='"
				+ station_id + "'";

		stationInfectantList = DBUtil.query(cn, sql, null);

		num = stationInfectantList.size();
		for (i = 0; i < num; i++) {

			row = (Map) stationInfectantList.get(i);
			map.put(row.get("infectant_id"), row);
		}

		rs = new RowSet(infectantList);
	} catch (Exception e) {
		JspUtil.go2error(request, response, e);
		return;
	} finally {
		DBUtil.close(cn);
	}
%>
<link rel="stylesheet" href="<%=path%>/web/index.css" />
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<style>
td {
	text-align: left;
}

.v {
	width: 50px;
}
</style>
<body scroll="no">
	<form name="form1" method=post action='update.jsp' >
		<table>
			<tr>
				<td>
					<fieldset>
						<legend>站点信息</legend>
						<table cellspacing=1 style='width:100%;height:100%'>
							<tr>
								<td class='tdtitle'>编号</td>
								<td><input readonly type=text name='station_id'
									value='<%=b.get("station_id")%>'>
								</td>
								<td class='tdtitle'>名称</td>
								<td><input type=text name='station_desc'
									style='width:220px' value='<%=b.get("station_desc")%>'>
								</td>
								<td class='tdtitle'>序号</td>
								<td><input type=text name='station_no'
									value='<%=b.get("station_no")%>'>
								</td>


								<td class='tdtitle'>地址</td>
								<td><input type=text name='station_addr'
									style='width:220px' value='<%=b.get("station_addr")%>'>
								</td>
							</tr>


							<tr>
								<td class='tdtitle'>行业</td>
								<td><select name='trade_id'><%=w.get("tradeOption")%></select>
								</td>
								<td class='tdtitle'>地区</td>
								<td><select name=area_id>
										<option value=''>
											<%=w.get("areaOption")%>
								</select></td>
								<td class='tdtitle'>流域</td>
								<td><select name=valley_id>
										<option value=''>
											<%=w.get("valleyOption")%>
								</select></td>
								<td class='tdtitle'>排放去向</td>

								<td><input type=text name='pfqx' style='width:220px'
									value='<%=b.get("pfqx")%>'>
								</td>

							</tr>


							<tr>
								<td class='tdtitle'>运维单位</td>
								<td><input type=text name='ywdw' value='<%=b.get("ywdw")%>'>
								</td>
								<td class='tdtitle'>联系人</td>
								<td><input type=text name='ywdw_man'
									value='<%=b.get("ywdw_man")%>'>
								</td>
								<td class='tdtitle'>联系方式</td>
								<td><input type=text name='ywdw_man_phone'
									value='<%=b.get("ywdw_man_phone")%>'>
								</td>
								<td class='tdtitle'>建设单位</td>

								<td><input type=text name='jsdw' style='width:220px'
									value='<%=b.get("jsdw")%>'>
								</td>

							</tr>

							<tr>
								<td class='tdtitle'>设施管理人员</td>
								<td><input type=text name='ssgl_man'
									value='<%=b.get("ssgl_man")%>'>
								</td>
								<td class='tdtitle'>联系方式</td>
								<td><input type=text name='ssgl_man_phone'
									value='<%=b.get("ssgl_man_phone")%>'>
								</td>

								<td class='tdtitle'>生产情况</td>

								<td><input type=text name='scqk' value='<%=b.get("scqk")%>'>

								</td>

								<td class='tdtitle'>是否显示</td>
								<td><select name='show_flag'><%=w.get("showOption")%></select>
								</td>

							</tr>

							<tr>

								<td class='tdtitle'>重点源属性</td>
								<td><select name='ctl_type'><%=w.get("ctlTypeOption")%></select>
								</td>

								<td class='tdtitle'>备注</td>
								<td><input type=text name='station_bz'
									value='<%=b.get("station_bz")%>'>
								</td>



								<td class='tdtitle'>企业状态</td>
								<td><select name='qy_state'><%=w.get("qyStateOption")%></select>
								</td>

								<td class='tdtitle'></td>

								<td></td>

							</tr>
							<!--    <tr> -->
							<!--     <td colspan=10 style='height:80%'> -->
							<!--     <iframe name='frm_wry' width=100% height=100% frameborder=0></iframe> -->
							<!--     </td> -->
							<!--    </tr> -->
			<tr>
				<td colspan=10 style="text-align: center;">
					<!-- <input type=button value=查看监测指标  class=btn onclick=f_f()> -->
					<input type=button value=保存 class="tiaojianbutton" 	onclick=f_update()> 
<!-- 					<input type=button value=关闭 onclick='window.close()' class="tiaojianbutton">  -->
					<input type=button value=返回 onclick=f_back()  class="tiaojianbutton">
				</td>
			</tr>								
						</table>
					</fieldset></td>
			</tr>
			<tr>
				<td>
					<fieldset>
						<legend>因子信息</legend>
<table border=0 cellspacing=1 class="nui-table-inner">
	<thead class="nui-table-head">
		<tr>
			<td class="nui-table-cell">序号</td>
			<td class="nui-table-cell">是否监测</td>
			<td class="nui-table-cell">名称</td>
			<td class="nui-table-cell">标准值</td>
			<td class="nui-table-cell">预警下限</td>
			<td class="nui-table-cell">预警上限</td>
			<td class="nui-table-cell">报警下限</td>
			<td class="nui-table-cell">报警上限</td>
			<td class="nui-table-cell">量程下限</td>
			<td class="nui-table-cell">量程上限</td>
			<td class="nui-table-cell">报表是否打印</td>
			<td class="nui-table-cell">显示顺序</td>
			<td class="nui-table-cell">保存</td>
<!-- 		<%if(StringUtil.equals(show_btn_flag,"1")){%> -->
<!-- 		<td></td> -->
<!-- 		<%}%> -->
		</tr>
	</thead>
<%
	while(rs.next())
	{
		infectant_id=rs.get("infectant_id");
		form="form_"+rs.getIndex();
		row = (Map)map.get(infectant_id);
		if(row==null){flag=" ";}else{flag=" checked";}
	
		b= new XBean(row);
		if(StringUtil.equals(b.get("report_flag"),"1")){
		rpt_flag=" checked";
		}else{
		rpt_flag=" ";
		}
%>

  <tr>
  	<form name="<%=form%>"  method="post">
  		<input type=hidden name=station_id value="<%=station_id%>">
  		<input type=hidden name=infectant_id value=<%=infectant_id%>>
  		<input type=hidden name=infectant_column value=<%=rs.get("infectant_column")%>>
  		<input type=hidden name=group_id value="01">
		<td align="center"><%=rs.getIndex()+1%></td>
  		<td><input type=checkbox name=flag value="1" <%=flag%>></td>
  		<td><%=rs.get("infectant_name")%></td>
  		<td><input class=v type=text name=standard_value value='<%=b.get("standard_value")%>'></td>
  		<td><input  class=v type=text name=lo value='<%=b.get("lo")%>'></td>
  		<td><input class=v  type=text name=hi value='<%=b.get("hi")%>'></td>
  		<td><input  class=v type=text name=lolo value='<%=b.get("lolo")%>'></td>
    	<td><input  class=v type=text name=hihi value='<%=b.get("hihi")%>'></td>
   		<td><input  class=v type=text name=lolololo value='<%=b.get("lolololo")%>'></td>
  		<td><input class=v  type=text name=hihihihi value='<%=b.get("hihihihi")%>'></td>
  		<td><input type=checkbox name=report_flag value="1" <%=rpt_flag%>></td>
   		<td><input class=v  type=text name=show_order value='<%=b.get("show_order")%>'></td>
  		<%if(StringUtil.equals(show_btn_flag,"1"))
  		{%>
  		<td><input type=button value=保存 onclick="f_save(this.form)" class=btn>	</td>
 	 <%}%>
  	</form>
  </tr>
<%}%>
</table>

					</fieldset></td>
			</tr>
		</table>
	</form>
</body>

<script>
	function f_f() {
		form1.action = '../infectant/q.jsp';
		form1.submit();
	}

	function f_update() {
		form1.action = 'station_update.jsp';
		form1.submit();
	}
	
	function f_save(f){
	f.action="../infectant/u.jsp";
	f.submit();
}
</script>







