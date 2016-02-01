package com.hoson;

import org.hsqldb.lib.HashMap;

public class PageData {

	private static HashMap pd = new HashMap();

	public PageData() {
		pd.put("���ݲ�ѯ", "pages/data_p");
		pd.put("�ۺϲ�ѯ", "pages/fx/query/data.jsp");
		pd.put("��������", "pages/warn/index.jsp");
		pd.put("���ݷ���", "pages/fx/fx_home.jsp");

		pd.put("ͳ�Ʊ���", "pages/report_p");
		pd.put("��Ⱦ���ŷ���������", "pages/report_sj/index.jsp");
		pd.put("���ܱ���", "pages/report_cm/index.jsp");
		pd.put("վλ����ͳ�Ʊ���", "pages/report/zwzxtjrpt.jsp");
		pd.put("�ۺϱ���", "pages/report/zhrpt.jsp");
		pd.put("�Զ��屨��", "pages/report_diy/index.jsp");

		pd.put("��Ƶ���p", "pages/sp_p");
		pd.put("��Ƶ���c", "pages/sp/list.jsp");
		pd.put("��Ƶ����", "pages/system/sp/form.jsp");

		pd.put("�������", "pages/advice_p");
		pd.put("�������", "pages/advice/advice.jsp");
		pd.put("�����ѯ", "pages/advice/query_advice.jsp");

		pd.put("ϵͳ����", "pages/system_p");
		pd.put("�޸�����", "pages/home/pwd_edit.jsp");
		pd.put("���Ź���", "pages/system/tab_dept/tab_dept_query.jsp");
		pd.put("�û�����", "pages/system/user/user_query.jsp");
		pd.put("վλ����", "pages/system/station/q_form.jsp");
		pd.put("��ҵ����", "pages/system/trade/trade_query.jsp");
		
		pd.put("������Ϣ", "pages/map_p");
		pd.put("�����ͼ", "pages/flashmap/map.jsp");
		pd.put("���ӵ�ͼ", "pages/g_map/g_map.jsp");
		
		pd.put("ʵʱ���", "pages/real_data/index.jsp");
	}

	public String get(String key) {
		return pd.get(key).toString();
	}

}
