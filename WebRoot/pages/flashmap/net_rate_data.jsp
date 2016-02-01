<%@ page contentType="text/xml;charset=UTF-8" language="java" %>

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
	int net = standard + bj + yj;
	int all = net + drop;
	float net_rate = net * 100 / all;
%>

<anychart>
  <settings>
    <animation enabled="true" />
  </settings>
  <gauges>
    <gauge>
      <chart_settings>
        <title>
          <text><![CDATA[实时的联网率]]></text>
        </title>
        <chart_background enabled="false"/> 
      </chart_settings>
      <circular>
        <axis radius="37" start_angle="85" sweep_angle="190" size="3">
          <labels align="Outside" padding="6">
            <format><![CDATA[{%Value}{numDecimals:0}%]]></format>
          </labels>
          <scale_bar>
            <fill color="#292929" />
          </scale_bar>
          <major_tickmark align="Center" length="10" padding="0" />
          <minor_tickmark enabled="false" />
          <color_ranges>
            <color_range start="0" end="100" align="Inside" start_size="15" end_size="15" padding="6">
              <fill type="Gradient">
                <gradient>
                  <key color="Red" />
                  <key color="Yellow" />
                  <key color="Green" />
                </gradient>
              </fill>
              <border enabled="true" color="Black" opacity="0.4" />
            </color_range>
          </color_ranges>
        </axis>
        <frame>
          <inner_stroke enabled="false" />
          <outer_stroke enabled="false" />
          <background>
            <fill type="Gradient">
              <gradient angle="45">
                <key color="#FDFDFD" />
                <key color="#F7F3F4" />
              </gradient>
            </fill>
            <border enabled="true" color="#A9A9A9" />
          </background>
          <effects enabled="false" />
        </frame>
        <pointers>
          <pointer value="<%=net_rate%>">
            <label enabled="true" under_pointers="true">
              <position placement_mode="ByAnchor" x="0" y="18" anchor="CenterBottom" />
              <format><![CDATA[{%Value}{numDecimals:1}%]]></format>
              <background enabled="false" />
            </label>
            <actions>
            	<action type='navigateToURL' url='../real_data/index.jsp' target='frm_home_main' />
           	</actions>
           	<tooltip enabled="true">
       			<font bold="True">
       			</font>
           		<format>
{%Value}{numDecimals:1}%
点击跳转到实时监控页面
           		</format>
           	</tooltip>
            <needle_pointer_style thickness="7" point_thickness="5" point_radius="3">
              <fill color="Rgb(230,230,230)" />
              <border color="Black" opacity="0.7" />
              <effects enabled="true">
                <bevel enabled="true" distance="2" shadow_opacity="0.6" highlight_opacity="0.6" />
                <drop_shadow enabled="true" distance="1" blur_x="1" blur_y="1" opacity="0.4" />
              </effects>
              <cap>
                <background>
                  <fill type="Gradient">
                    <gradient type="Linear" angle="45">
                      <key color="#D3D3D3" />
                      <key color="#6F6F6F" />
                    </gradient>
                  </fill>
                  <border color="Black" opacity="0.9" />
                </background>
                <effects enabled="true">
                  <bevel enabled="true" distance="2" shadow_opacity="0.6" highlight_opacity="0.6" />
                  <drop_shadow enabled="true" distance="1.5" blur_x="2" blur_y="2" opacity="0.4" />
                </effects>
              </cap>
            </needle_pointer_style>
            <animation enabled="true" start_time="0" duration="0.7" interpolation_type="Bounce" />
          </pointer>
        </pointers>
      </circular>
    </gauge>
  </gauges>
</anychart>
