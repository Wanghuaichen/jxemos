package com.hoson;

import org.hsqldb.lib.HashMap;

public class PageData {

	private static HashMap pd = new HashMap();

	public PageData() {
		pd.put("数据查询", "pages/data_p");
		pd.put("综合查询", "pages/fx/query/data.jsp");
		pd.put("报警数据", "pages/warn/index.jsp");
		pd.put("数据分析", "pages/fx/fx_home.jsp");

		pd.put("统计报表", "pages/report_p");
		pd.put("污染物排放总量报表", "pages/report_sj/index.jsp");
		pd.put("汇总报表", "pages/report_cm/index.jsp");
		pd.put("站位在线统计报表", "pages/report/zwzxtjrpt.jsp");
		pd.put("综合报表", "pages/report/zhrpt.jsp");
		pd.put("自定义报表", "pages/report_diy/index.jsp");

		pd.put("视频监控p", "pages/sp_p");
		pd.put("视频监控c", "pages/sp/list.jsp");
		pd.put("视频设置", "pages/system/sp/form.jsp");

		pd.put("意见反馈", "pages/advice_p");
		pd.put("意见反馈", "pages/advice/advice.jsp");
		pd.put("意见查询", "pages/advice/query_advice.jsp");

		pd.put("系统设置", "pages/system_p");
		pd.put("修改密码", "pages/home/pwd_edit.jsp");
		pd.put("部门管理", "pages/system/tab_dept/tab_dept_query.jsp");
		pd.put("用户管理", "pages/system/user/user_query.jsp");
		pd.put("站位管理", "pages/system/station/q_form.jsp");
		pd.put("行业管理", "pages/system/trade/trade_query.jsp");
		
		pd.put("地理信息", "pages/map_p");
		pd.put("区域地图", "pages/flashmap/map.jsp");
		pd.put("电子地图", "pages/g_map/g_map.jsp");
		
		pd.put("实时监控", "pages/real_data/index.jsp");
	}

	public String get(String key) {
		return pd.get(key).toString();
	}

}
