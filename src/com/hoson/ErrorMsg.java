package com.hoson;

public class ErrorMsg{
	
	public static void station_id_empty()throws Exception{
		f.error("��ѡ��վλ");
	}
	
	public static void infectant_id_empty()throws Exception{
		f.error("��ѡ����ָ��");
	}
	
	public static void no_login()throws Exception{
		f.error("δ��¼��ʱ");
	}
	
	public static void no_data()throws Exception{
		f.error("��¼������");
	}
	
	public static void sp_ip_center()throws Exception{
		f.error("��������ý�����ķ�����");
	}
	
}