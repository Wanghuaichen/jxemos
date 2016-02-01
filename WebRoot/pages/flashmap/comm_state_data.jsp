<%@ page contentType="text/xml;charset=UTF-8" language="java"%>

<%@ page import="java.util.*"%>
<%@ page
	import="com.hoson.util.SwjUpdate,com.hoson.RowSet,com.hoson.zdxupdate.zdxUpdate,com.hoson.JspWrapperNew,com.hoson.f"%>

<%
	int drop = 0;
	int standard = 0;
	int bj = 0;
	int yj = 0;
	String station_id = null;
	RowSet rs = null;
	List<?> list = null;
	List<String> infectant_css = new ArrayList<String>();
	String css = null;
	String id = null;
	String v = null;
	JspWrapperNew w = new JspWrapperNew();
	w.set(request, response);
	RowSet rsf = w.rs("flist");
	int num=rsf.size();

	try {
		SwjUpdate.real_data(request);//初始化数据
		list = (List<?>) request.getAttribute("list");
		list = SwjUpdate.getFocusList(request, list);// 根据request值和list值获得收藏夹信息列表,
		rs = new RowSet(list);
	} catch (Exception e) {
		w.error(e);
		return;
	}

	while (rs.next()) {
		station_id = rs.get("station_id");
		String st_css = zdxUpdate.getStandardByStation(
				rs.get("m_time"), "", station_id, request);
		if (st_css.equals("drop")) {
			drop++;
		} else {
			standard++;
		}
		while (rsf.next()) {
			id = rsf.get("infectant_id");
			String col = rsf.get("infectant_column").toString()
					.toLowerCase();
			v = rs.get(id);
			v = f.v(v);
			css = zdxUpdate.get_css(rs.get("m_time"), v,
					rs.get("station_bz"), col, request);
			infectant_css.add(css);
		}
		if (infectant_css.contains("bj")) {
			bj++;
		}
		if (infectant_css.contains("yj")) {
			yj++;
		}
	}

	/*
	System.out.println("standard\t" + standard);
	System.out.println("drop\t" + drop);
	System.out.println("bj\t" + bj);
	System.out.println("yj\t" + yj);
	*/
%>

<%
	String[][] comm_states = new String[4][2];
	//Sales data by month
	//[0] = month name
	//[1] = sales
	comm_states[0][0] = "正常";
	comm_states[0][1] = String.valueOf(standard);

	comm_states[1][0] = "预警";
	comm_states[1][1] = String.valueOf(yj);

	comm_states[2][0] = "报警";
	comm_states[2][1] = String.valueOf(bj);

	comm_states[3][0] = "脱机";
	comm_states[3][1] = String.valueOf(drop);

	String comm_states_DataStr = "<series>";
	for (String[] comm_state : comm_states) {
		comm_states_DataStr += "<point name=\"" + comm_state[0]
				+ "\" y=\"" + comm_state[1] + "\" />";
		comm_states_DataStr += "<actions><action type='navigateToURL' url='../real_data/index.jsp' target='frm_home_main' /></actions>";
	}
	comm_states_DataStr += "</series>";
%>

<anychart>
  <settings>
    <animation enabled="True"/>
  </settings>
  <charts>
    <chart plot_type="Pie">
      <data_plot_settings enable_3d_mode="true">
        <pie_series>
          <tooltip_settings enabled="true">
            <format>
{%Name}: {%Value}{numDecimals: 0}
Percent: {%YPercentOfSeries}{numDecimals:1}%
点击跳转到实时监控页面
            </format>
          </tooltip_settings>
          <label_settings enabled="true">
            <background enabled="false"/>
            <position anchor="Center" valign="Center" halign="Center" padding="20"/>
            <font color="White">
              <effects>
                <drop_shadow enabled="true" distance="2" opacity="0.5" blur_x="2" blur_y="2"/>
              </effects>
            </font>
            <format>{%YPercentOfSeries}{numDecimals:1}%</format>
          </label_settings>
        </pie_series>
      </data_plot_settings>
      
      <data>
      	<%=comm_states_DataStr%>
      </data>
      
      <chart_settings>
        <title enabled="true" padding="15">
          <text>实时污水通讯服务状态</text>
        </title>
        <legend enabled="true" position="Bottom" align="Spread" ignore_auto_item="true" padding="15">
          <format>{%Icon} {%Name} ({%YValue}{numDecimals: 0})</format>
          <template></template>
          <title enabled="true">
            <text>各状态</text>
          </title>
          <columns_separator enabled="false"/>
          <background>
            <inside_margin left="10" right="10"/>
          </background>
          <items>
            <item source="Points"/>
          </items>
        </legend>
        <chart_background enabled="false"/>
      </chart_settings>
    </chart>
  </charts>
</anychart>
