package com.hoson;

public class ErrorMsg{
	
	public static void station_id_empty()throws Exception{
		f.error("请选择站位");
	}
	
	public static void infectant_id_empty()throws Exception{
		f.error("请选择监测指标");
	}
	
	public static void no_login()throws Exception{
		f.error("未登录或超时");
	}
	
	public static void no_data()throws Exception{
		f.error("记录不存在");
	}
	
	public static void sp_ip_center()throws Exception{
		f.error("请配置流媒体中心服务器");
	}
	
}