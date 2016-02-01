package com.hoson;

import javax.servlet.http.*;

import java.text.DecimalFormat;
import java.util.*;
import java.util.Date;
import java.sql.*;

import com.ajf.dbpool.DBConn;
import com.hoson.util.*;
import com.hoson.app.App;
import com.hoson.hello.*;
import com.hoson.app.*;
import com.hoson.msg.MsgUtil;

import org.apache.log4j.Logger;

public class f {

	static int decode_flag = -1;
	static int debug_flag = -1;
	private static Logger log = Logger.getRootLogger();
	private static String input_error_msg_key = "input_error_msg_key";
	private static String wry_station_types = ",1,2,";

	/*
	 * ! ���name�������ļ���ֵ��û���򷵻�Ĭ��ֵdef
	 */
	public static String cfg(String name, String def) {
		return App.get(name, def);
	}

	/*
	 * ! ���request���nameֵ
	 */
	public static String p(HttpServletRequest req, String name)
			throws Exception {

		return JspUtil.getParameter(req, name);
	}

	/*
	 * ! ���request���nameֵ��û���򷵻�Ĭ��ֵdefv
	 */
	public static String p(HttpServletRequest req, String name, String defv)
			throws Exception {
		String s = JspUtil.getParameter(req, name);
		if (StringUtil.isempty(s)) {
			s = defv;
		}
		return s;
	}

	/*
	 * ! �ж��ַ����Ƿ�Ϊ��
	 */
	public static boolean empty(String s) {
		return StringUtil.isempty(s);
	}

	/*
	 * ! �ж������ַ����Ƿ����
	 */
	public static boolean eq(String s1, String s2) {

		return StringUtil.equals(s1, s2);
	}

	/*
	 * ! �ж������ַ����Ƿ���ȣ����Դ�Сд
	 */
	public static boolean eqi(String s1, String s2) {
		if (s1 == null && s2 == null) {
			return true;
		}
		if (s1 == null && s2 != null) {
			return false;
		}
		if (s2 == null && s1 != null) {
			return false;
		}
		return s1.equalsIgnoreCase(s2);
	}

	/*
	 * ! ��ȡ�ַ��������뿪ʼֵ�ͳ��ȣ��������ַ���
	 */
	public static String sub(String s, int start, int len) {

		if (s == null) {
			return s;
		}
		if (len < 1) {
			return "";
		}
		int max_index = s.length() - 1;
		if (start > max_index) {
			return "";
		}
		int end = start + len;
		if (end > max_index) {
			return s.substring(start);
		}

		return s.substring(start, end);
	}

	/*
	 * ! ��ȡ�ַ��������뿪ʼֵ�����غ�ߵ����ַ���
	 */
	public static String sub(String s, int start) {
		return sub(s, start, 1000000);
	}

	/*
	 * ! �õ���Ƶ�ı��
	 */
	public static String getSpCtlFlag(HttpServletRequest req, Connection cn)
			throws Exception {
		HttpSession s = req.getSession();
		String user_id = (String) s.getAttribute("user_id");
		if (empty(user_id)) {
			return "0";
		}
		String flag = null;

		String sql = null;
		Map m = null;

		sql = "select sp_ctl_flag from t_sys_user where user_id='" + user_id
				+ "'";
		try {
			m = DBUtil.queryOne(cn, sql, null);
		} catch (Exception e) {
			throw e;
		} finally {
			f.close(cn);
		}
		if (m == null) {
			return "0";
		}
		flag = (String) m.get("sp_ctl_flag");
		if (empty(flag)) {
			return "0";
		}
		return flag;
	}

	/*
	 * ! ����list,value_key,text_key,value�õ������б������
	 */
	public static String getOption(List list, String value_key,
			String text_key, String value)

	{
		if (list == null) {
			return "";
		}
		if (value == null) {
			value = "";
		}
		StringBuffer sb = new StringBuffer(100);

		String v = null;
		String label = null;
		int i = 0;
		int num = 0;
		Map map = null;

		num = list.size();

		for (i = 0; i < num; i++) {
			map = (Map) list.get(i);
			v = (String) map.get(value_key);

			label = (String) map.get(text_key);
			if (v == null) {
				v = "";
			}
			if (label == null) {
				label = "";
			}
			// v = v.trim();
			// label = label.trim();

			sb.append("<option value=\"");
			sb.append(v);
			sb.append("\"");
			if (value.equals(v)) {
				sb.append(" selected");
			}
			sb.append(">").append(label).append("\n");
		}
		return sb.toString();

	}

	/*
	 * ! ����cn,��ѯsql��ѡ�е�ֵv�õ������б������
	 */
	public static String getOption(Connection cn, String sql, String v)
			throws Exception {

		return JspUtil.getOption(cn, sql, v);
	}

	/*
	 * ! ���ݲ�ѯsql��ѡ�е�ֵv�õ������б������
	 */
	public static String getOption(String sql, String v) throws Exception {
		Connection cn = null;
		try {
			cn = f.getConn();
			return JspUtil.getOption(cn, sql, v);
		} catch (Exception e) {
			throw e;
		} finally {
			f.close(cn);
		}
	}

	/*
	 * ! ����vs(value���ַ�������","�ָ�),ts(key���ַ�������","�ָ�)��ѡ�е�ֵv�õ������б������
	 */
	public static String getOption(String vs, String ts, String v)
			throws Exception {
		return JspUtil.getOption(vs, ts, v);
	}

	/*
	 * ! ������ݿ�����
	 */
	public static Connection getConn() throws Exception {
		return DBUtil.getConn();
	}

	/*
	 * ! �������ֻ�����ݿ�����
	 */
	public static Connection getConn(String name) throws Exception {
		return DBUtil.getConn(name);
	}

	/*
	 * ! �ر����ݿ�����
	 */
	public static void close(Connection cn) {
		if (cn == null) {
			return;
		}
		DBUtil.close(cn);
		cn = null;
	}

	/*
	 * ! ����sql��ѯ���ݿ⣬���map����
	 */
	public static Map getMap(Connection cn, String sql) throws Exception {

		return DBUtil.getMap(cn, sql);
	}

	/*
	 * ! ����sql�Ͳ���ps��ѯ���ݿ⣬���list����
	 */
	public static List query(Connection cn, String sql, Object[] ps)
			throws Exception {

		return DBUtil.query(cn, sql, ps);
	}

	/*
	 * ! ����sql,����ps�����������ѯ���ݿ⣬���list����
	 */
	public static List query(Connection cn, String sql, Object[] ps, int maxrow)
			throws Exception {

		return DBUtil.query(cn, sql, ps, maxrow);
	}

	/*
	 * ! ����sql,����ps��req��ѯ���ݿ⣬���map����
	 */
	public static Map query(Connection cn, String sql, Object[] ps,
			HttpServletRequest req) throws Exception {

		return Query.query(cn, sql, ps, req);
	}

	/*
	 * ! ����sql,����ps��req��ѯ���ݿ⣬���map����
	 */
	public static Map checkQuery(Connection cn, String sql, Object[] ps,
			HttpServletRequest req) throws Exception {

		return Query.checkQuery(cn, sql, ps, req);
	}

	/*
	 * ! ����sql�Ͳ���ps��ѯ���ݿ⣬���map����
	 */
	public static Map queryOne(Connection cn, String sql, Object[] ps)
			throws Exception {

		return DBUtil.queryOne(cn, sql, ps);
	}

	/*
	 * ! ����sql�Ͳ���ps�������ݿ⣬�ɹ�����0��ʧ�ܷ���-1
	 */
	public static int update(Connection cn, String sql, Object[] ps)
			throws Exception {

		return DBUtil.update(cn, sql, ps);
	}

	/*
	 * ! ���ݱ�table,��cols,�Ƿ�����auto_pk��model�������ݿ⣬�ɹ�����0��ʧ�ܷ���-1
	 */
	public static int insert(Connection cn, String table, String cols,
			int auto_pk, Map model) throws Exception {

		return PBean.insert(cn, table, cols, auto_pk, model);
	}

	/*
	 * ! ���ݱ�table,��cols,pknum��model�������ݿ⣬�ɹ�����0��ʧ�ܷ���-1
	 */
	public static int save(Connection cn, String table, String cols, int pknum,
			Map model) throws Exception {

		return PBean.save(cn, table, cols, pknum, model);
	}

	/*
	 * ! ����sql��psֵ��ѯ���ݿ⣬���list����
	 */
	public static List query(String sql, Object[] ps) throws Exception {
		Connection cn = null;
		try {
			cn = getConn();

			return DBUtil.query(cn, sql, ps);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}
	}

	/*
	 * ! ����sql,psֵ(����)���������maxrow��ѯ���ݿ⣬���list����
	 */
	public static List query(String sql, Object[] ps, int maxrow)
			throws Exception {
		Connection cn = null;
		try {
			cn = getConn();

			return DBUtil.query(cn, sql, ps, maxrow);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}
	}

	/*
	 * ! ����sql,psֵ(����)��requestֵreq��ѯ���ݿ⣬���map����
	 */
	public static Map query(String sql, Object[] ps, HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		try {
			cn = getConn();

			return Query.query(cn, sql, ps, req);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}
	}

	/*
	 * ! ����sql��psֵ(����)��ѯ���ݿ⣬���һ��map����
	 */
	public static Map queryOne(String sql, Object[] ps) throws Exception {
		Connection cn = null;
		try {
			cn = getConn();

			return DBUtil.queryOne(cn, sql, ps);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}
	}

	/*
	 * ! ����sql��psֵ(����)�������ݿ⣬����0Ϊ�ɹ���-1Ϊʧ��
	 */
	public static int update(String sql, Object[] ps) throws Exception {
		Connection cn = null;
		try {
			cn = getConn();

			return DBUtil.update(cn, sql, ps);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}
	}

	/*
	 * ! ���ݱ�table,��cols,�Ƿ���������auto_pk�����ݼ���model�������ݿ⣬����0�ǳɹ���-1ʧ��
	 */
	public static int insert(String table, String cols, int auto_pk, Map model)
			throws Exception {

		Connection cn = null;
		try {
			cn = getConn();

			return PBean.insert(cn, table, cols, auto_pk, model);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}
	}

	/*
	 * ! ���ݱ�table,��cols,�����ĸ���pknum�����ݼ���model�������ݿ⣬����0�ǳɹ���-1ʧ��
	 */
	public static int save(String table, String cols, int pknum, Map model)
			throws Exception {
		Connection cn = null;
		try {
			cn = getConn();
			return PBean.save(cn, table, cols, pknum, model);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}
	}

	/*
	 * ! ��õ�ǰʱ��
	 */
	public static Timestamp time() {
		return StringUtil.getNowTime();
	}

	/*
	 * ! ���ַ���sת��Ϊʱ��
	 */
	public static Timestamp time(String s) throws Exception {
		return StringUtil.getTimestamp(s);
	}

	/*
	 * ! ���ַ���sת��Ϊʱ�䣬����ת���򷵻�Ĭ��ֵdef
	 */
	public static Timestamp time(String s, Timestamp def) {
		try {
			return StringUtil.getTimestamp(s);
		} catch (Exception e) {
			return def;
		}
	}

	/*
	 * ! ��õ�ǰʱ���long��
	 */
	public static long ms() {
		return StringUtil.getTime();
	}

	/*
	 * ! ��ò�ѯʵʱ���ݵ�sql
	 */
	public static String getRealSql() throws Exception {
		String s = "";
		String t = getRealStartTime();

		s = s + "select a.station_id,a.m_time,a.infectant_id,a.m_value ";
		s = s + " from  t_monitor_real_minute a, ";
		s = s + "(";
		s = s
				+ "select station_id,max(m_time) as m_time_max from  t_monitor_real_minute where m_time>='"
				+ t + "' group by station_id";
		s = s + ") b";
		s = s + " where a.m_time>='" + t + "' ";
		s = s + " and a.m_time=b.m_time_max ";
		s = s + " and a.station_id=b.station_id";

		return s;

	}

	/*
	 * ! ���ʵʱ���ݵĿ�ʼʱ��
	 */
	public static String getRealStartTime() throws Exception {
		String s = "";
		int num = 0;
		int len = 0;
		s = f.cfg("real_start_time", "");
		if (!f.empty(s)) {
			return s;
		}
		s = f.cfg("real_hour", "1");
		num = StringUtil.getInt(s, 1);
		Timestamp now = f.time();
		Timestamp t = null;
		java.util.Date d = null;

		d = StringUtil.dateAdd(now, "hour", -num);
		// System.out.println(now);
		t = new Timestamp(d.getTime());
		// s=f.sub(t+"",0,19);
		s = t + "";
		len = s.indexOf(".");
		s = f.sub(t + "", 0, len);
		// 2008-01-08 08:08:08.008
		return s;

	}

	/*
	 * ! ���ݸ�ʽ��飬����С����4λ
	 */
	public static List dataCheck(List list) throws Exception {
		return SupportUtil.dataCheck(list);
	}

	/*
	 * ! ���ڸ�ʽ��飬����ǰ8λ
	 */
	public static List hourDataCheck(List list) throws Exception {
		return SupportUtil.hourDataCheck(list);
	}

	/*
	 * ! ���ڸ�ʽ��飬����ǰ8λ
	 */
	public static List avgDataCheck(List list) throws Exception {
		return SupportUtil.hourDataCheck(list);
	}

	/*
	 * ! ���ڸ�ʽ��飬����ǰ8λ
	 */
	public static String avgDataRowCheck(Map map) throws Exception {
		return SupportUtil.avgDataRowCheck(map);
	}

	/*
	 * ! ��ѯվλ����Ϊstation_type������
	 */
	public static List getInfectantList(Connection cn, String station_type)
			throws Exception {
		// Connection cn = null;
		String sql = null;
		sql = "select * from t_cfg_infectant_base ";
		sql = sql + " where station_type='" + station_type + "' and ";
		sql = sql
				+ "(infectant_type='1' or infectant_type='2') order by infectant_order ";
		try {
			return query(cn, sql, null);
		} catch (Exception e) {
			throw e;
		}
	}

	/*
	 * ! ��ѯվλ����Ϊstation_type������
	 */
	public static List getInfectantList(String station_type) throws Exception {
		Connection cn = null;
		String sql = null;
		sql = "select * from t_cfg_infectant_base ";
		sql = sql + " where station_type='" + station_type + "' and ";
		sql = sql
				+ "(infectant_type='1' or infectant_type='2') order by infectant_order ";
		try {
			cn = getConn();
			return query(cn, sql, null);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	/*
	 * ! ��ʽ���ַ���f
	 */
	public static String format(Object obj, String f) {
		if (obj == null) {
			return "";
		}
		if ("".equals(obj) || obj.equals("null")) {
			return "";
		}
		// if("0.0".equals(obj)){return "";}
		String s = obj + "";
		if (empty(s)) {
			return "";
		}
		// if(s.equals("0.0")){return "";}
		double d = 0;
		try {
			d = Double.parseDouble(s);
			DecimalFormat df = new DecimalFormat(f);
			return df.format(d);
		} catch (Exception e) {
			return s;
		}
	}

	/*
	 * ! ��ʽ���ַ���f
	 */
	public static String format2(Object obj, String f) {
		if (obj == null) {
			return "";
		}
		String s = obj + "";
		if (empty(s)) {
			return "";
		}

		if (obj.equals("0.0")) {
			return "";
		}

		double d = 0;
		try {
			d = Double.parseDouble(s);
			DecimalFormat df = new DecimalFormat(f);
			return df.format(d);
		} catch (Exception e) {
			return s;
		}
	}

	/*
	 * ! ��ʽ���ַ���f
	 */
	public static String format3(Object obj, String f) {
		if (obj == null) {
			return "";
		}
		if ("".equals(obj) || obj.equals("null")) {
			return "";
		}
		if ("0.0".equals(obj)) {
			return "";
		}
		String s = obj + "";
		if (empty(s)) {
			return "";
		}
		if (s.equals("0.0")) {
			return "";
		}
		double d = 0;
		try {
			d = Double.parseDouble(s);
			DecimalFormat df = new DecimalFormat(f);
			return df.format(d);
		} catch (Exception e) {
			return s;
		}
	}

	/*
	 * ! ��sת��Ϊint�ͣ�����ת���򷵻�Ĭ��ֵdef
	 */
	public static int getInt(String s, int def) {
		return StringUtil.getInt(s, def);
	}

	/*
	 * ! ��sת��ΪInteger�ͣ�����ת���򷵻�Ĭ��ֵdef
	 */
	public static Integer getIntObj(String s, Integer def) {
		Integer obj = null;

		int v = 0;

		try {
			v = Integer.parseInt(s);

			obj = new Integer(v);

		} catch (Exception e) {
			obj = def;
		}

		return obj;
	}

	/*
	 * ! ��sת��Ϊdouble�ͣ�����ת���򷵻�Ĭ��ֵdef
	 */
	public static double getDouble(String s, double def) {
		return StringUtil.getDouble(s, def);
	}

	/*
	 * ! ��s��ȡ","ǰ���ַ�����û���򷵻�s,�����쳣���ؿ��ַ���
	 */
	public static String v(String s) {
		return App.getValueStr(s);
	}

	/*
	 * ! ��s��ȡ","ǰ���ַ�����û���򷵻�s,�����쳣���ؿ��ַ�����������ܵ����ݽ��н��ܴ���
	 */
	public static String rv(String s) {
		return App.getRealValueStr(s);
	}

	/*
	 * ! �������ļ����ȡdecode��״̬
	 */
	public static int get_decode_flag() {
		if (decode_flag >= 0) {
			return decode_flag;
		}
		String s = cfg("decode", "1");
		int flag = getInt(s, 1);
		decode_flag = flag;
		return decode_flag;
	}

	/*
	 * ! ���ַ���s���н���
	 */
	public static String dd(String s) {
		if (get_decode_flag() < 1) {
			return s;
		}
		return CheckEmos.decode(s);
	}

	/*
	 * ! ���ַ���s���н���
	 */
	public static String dd_avg_data(String s) {
		if (empty(s)) {
			return "";
		}
		if (get_decode_flag() < 1) {
			return s;
		}
		if (s.indexOf(",") >= 0) {
			return "";
		}
		// return CheckEmos.decode(s);
		return s;
	}

	/*
	 * ! ���ַ���s���н���
	 */
	public static String dd_real_data(String s) {
		if (empty(s)) {
			return "";
		}
		if (get_decode_flag() < 1) {
			return s;
		}
		Double obj = null;

		obj = getDoubleObj(s, null);
		if (obj != null) {
			return "";
		}
		// return CheckEmos.decode(s);
		return s;
	}

	/*
	 * ! ���ַ���sת����Double�ͣ�����ת���򷵻�Ĭ��ֵdef
	 */
	public static Double getDoubleObj(String s, Double def) {
		double v = 0;
		try {
			v = Double.parseDouble(s);
			return new Double(v);
		} catch (Exception e) {
			return def;
		}
	}

	/*
	 * ! ��list����ת��Ϊmap����
	 */
	public static Map getListMap(List list, String key) throws Exception {
		Map m = new HashMap();
		int i, num = 0;
		Map tmp = null;
		String kv = null;
		List list2 = null;

		num = list.size();

		for (i = 0; i < num; i++) {
			tmp = (Map) list.get(i);
			kv = (String) tmp.get(key);

			list2 = (List) m.get(kv);
			if (list2 == null) {
				list2 = new ArrayList();
				m.put(kv, list2);
			}
			list2.add(tmp);
		}
		return m;
	}

	/*
	 * ! ���ַ���s����md5����
	 */
	public static String md5(String s) throws Exception {
		s = StringUtil.md5(s);
		s = s.toLowerCase();
		return s;
	}

	/*
	 * ! ��map����ת����list����
	 */
	public static List getMapKey(Map map) {
		List list = new ArrayList();
		if (map == null) {
			return list;
		}
		Set set = map.keySet();
		Object[] arr = set.toArray();
		int i = 0;
		int num = 0;
		num = arr.length;
		for (i = 0; i < num; i++) {
			list.add(arr[i]);
		}
		return list;
	}

	/*
	 * ! ��list����ת��Ϊmap����
	 */
	public static Map getMap(List list, String key) throws Exception {
		Map map = new HashMap();
		Map m = null;
		Object kv = null;
		if (list == null) {
			return map;
		}
		int i = 0;
		int num = 0;

		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			kv = m.get(key);
			if (kv != null) {

				map.put(kv, m);
			}
		}
		return map;
	}

	/*
	 * ! ����key�Ļ���
	 */
	public static void clear(String key) {

		Cache.clear(key);
	}

	/*
	 * ! ������d����type(second,minute,hour,day,month,year)��������offset����
	 */
	public static Timestamp dateAdd(Timestamp d, String type, int offset)
			throws Exception {
		java.util.Date d2 = StringUtil.dateAdd(d, type, offset);
		Timestamp t = new Timestamp(d2.getTime());
		return t;
	}

	/*
	 * ! ��������ļ�debug��ֵ
	 */
	public static int get_debug_flag() {
		if (debug_flag > -1) {
			return debug_flag;
		}
		String v = null;
		v = cfg("debug", "0");
		debug_flag = f.getInt(v, 0);
		return debug_flag;
	}

	/*
	 * ! ��ý��������
	 */
	public static String today() {
		return StringUtil.getNowDate() + "";
	}

	/*
	 * ! ��request���ֵת����map����
	 */
	public static Map model(HttpServletRequest req) throws Exception {
		return JspUtil.getRequestModel(req);
	}

	/*
	 * ! ���debug����0����msg��ӡ������̨
	 */
	public static void debug(Object msg) {
		if (get_debug_flag() > 0) {
			System.out.println(msg);
		}
	}

	/*
	 * ! ����վλ���station_id,������Ӽ���
	 */
	public static List getInfectantListByStationId(Connection cn,
			String station_id) throws Exception {
		// Connection cn = null;
		String sql = null;
		sql = " select * from t_cfg_infectant_base b,t_cfg_monitor_param p where b.INFECTANT_ID=p.INFECTANT_ID and station_id='"
				+ station_id + "' ";
		sql = sql + " order by infectant_order ";
		try {
			// cn = getConn();
			return query(cn, sql, null);
		} catch (Exception e) {
			throw e;
		}
		// finally{DBUtil.close(cn);}
	}

	/*
	 * ! ����վλ���station_id,station_type������Ӽ���     //MF ����
	 */
	public static List getInfectantListByStationIdAndType(Connection cn,
			String station_id, String station_type) throws Exception {
		// Connection cn = null;
		String sql = null;
		sql = " select * from t_cfg_infectant_base b,t_cfg_monitor_param p where b.INFECTANT_ID=p.INFECTANT_ID and station_id='"
				+ station_id + "' and station_type='" + station_type + " ' ";
		sql = sql + " order by infectant_order ";
		try {
			// cn = getConn();
			return query(cn, sql, null);
		} catch (Exception e) {
			throw e;
		}
		// finally{DBUtil.close(cn);}
	}

	/*
	 * ! ����վλ���station_id,������Ӽ���
	 */
	public static List getInfectantListByStationId(String station_id)
			throws Exception {
		Connection cn = null;
		try {
			cn = getConn();
			return getInfectantListByStationId(cn, station_id);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}
	}

	/*
	 * ! ����վλ���station_id,station_type������Ӽ��� MF ����
	 */
	public static List getInfectantListByStationIdAndType(String station_id,
			String station_type) throws Exception {
		Connection cn = null;
		try {
			cn = getConn();
			return getInfectantListByStationIdAndType(cn, station_id,
					station_type);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}
	}

	/*
	 * ! ���ַ���sת����ͼ��ı���
	 */
	public static String getChartTitle(String s) throws Exception {
		if (f.empty(s)) {
			return "";
		}

		s = s.replaceAll("<sub>", "");
		s = s.replaceAll("</sub>", "");
		s = s.replaceAll("<sup>", "");
		s = s.replaceAll("</sup>", "");
		return s;
	}

	/*
	 * ! ���ַ���sת����double������r,�������format��ʽ��
	 */
	public static String s(String s, double r, String format) throws Exception {
		if (f.empty(s)) {
			return "";
		}
		Double vobj = f.getDoubleObj(s, null);
		if (vobj == null) {
			return "";
		}
		double v = vobj.doubleValue();
		v = v / r;
		s = format(v + "", format);
		return s;
	}

	/*
	 * ! ������ӳ���Ϣ
	 */
	public static String getPoolInfo() throws Exception {
		// return SimpleConnectionPool.getPoolInfo();
		return com.ajf.dbpool.DBConn.info();
	}

	/*
	 * ! ���24Сʱ�������б�ֵ��ѡ��hh
	 */
	public static String getHourOption(int hh) throws Exception {
		String s = "";
		int i, num = 0;
		num = 24;
		String flag = null;

		for (i = 0; i < num; i++) {
			if (hh == i) {
				flag = " selected";
			} else {
				flag = "";
			}
			s = s + "<option value=" + i + flag + ">" + i + "\n";

		}

		return s;
	}

	/*
	 * ! ������date����format��ʽ��
	 */
	public static String dateFormat(java.util.Date date, String format) {
		if (date == null) {
			return "";
		}
		if (format == null) {
			return "";
		}
		String s = "";

		int yy = 0;
		int mm = 0;
		int dd = 0;
		int hh = 0;
		int mi = 0;
		int ss = 0;
		String smm = null;
		String sdd = null;
		String shh = null;
		String smi = null;
		String sss = null;

		yy = date.getYear() + 1900;
		mm = date.getMonth() + 1;
		dd = date.getDate();

		// java.sql.Date can not call getHours(),getMinutes(),getSeconds()

		try {
			hh = date.getHours();
			mi = date.getMinutes();

			ss = date.getSeconds();
		} catch (Exception e) {
			hh = 0;
			mi = 0;
			ss = 0;
		}

		if (mm < 10) {
			smm = "0" + mm;
		} else {
			smm = mm + "";
		}
		if (dd < 10) {
			sdd = "0" + dd;
		} else {
			sdd = dd + "";
		}

		if (hh < 10) {
			shh = "0" + hh;
		} else {
			shh = hh + "";
		}
		if (mi < 10) {
			smi = "0" + mi;
		} else {
			smi = mi + "";
		}

		if (ss < 10) {
			sss = "0" + ss;
		} else {
			sss = ss + "";
		}

		s = format;
		s = s.replaceAll("yy", yy + "");

		s = s.replaceAll("mm", smm);

		s = s.replaceAll("dd", sdd);
		s = s.replaceAll("hh", shh);
		s = s.replaceAll("mi", smi);
		s = s.replaceAll("ss", sss);

		return s;
	}

	/*
	 * ! ������input����format��ʽ��
	 */
	public static String dateFormat(Object input, String format, int flag) {

		if (input == null) {
			return "";
		}
		if (input.getClass().getName().equals("java.lang.String")) {
			try {
				java.util.Date d = time(input + "");
				return dateFormat(d, format);
			} catch (Exception e) {
				return "";
			}

		} else {
			try {
				return dateFormat((java.util.Date) input, format);
			} catch (Exception e) {
				return "";
			}

		}

	}

	/*
	 * ! ������input����format��ʽ��
	 */
	public static String df(Object input, String format) {
		return dateFormat(input, format, 0);
	}

	/*
	 * ! ������msg����debug��Ϣ��ӡ����־�ļ���
	 */
	public static void log_debug(Object msg) {
		log.debug(msg);
	}

	/*
	 * ! ������msg����info��Ϣ��ӡ����־�ļ���
	 */
	public static void log_info(Object msg) {
		log.info(msg);
	}

	/*
	 * ! ������msg����warn��Ϣ��ӡ����־�ļ���
	 */
	public static void log_warn(Object msg) {
		log.warn(msg);
	}

	/*
	 * ! ������msg����error��Ϣ��ӡ����־�ļ���
	 */
	public static void log_error(Object msg) {
		log.error(msg);
	}

	/*
	 * ! ��������list��������","�ָ���ַ���
	 */
	public static String list2str(List list) {
		if (list == null) {
			return "list is null";
		}
		int i, num = 0;
		String s = "";
		num = list.size();
		for (i = 0; i < num; i++) {
			s = s + "," + list.get(i);
		}
		s = "size=" + num + s;
		return s;
	}

	/*
	 * ! ����request��Ĵ�����ʾ��Ϣ
	 */
	public static String getErrorMsg(HttpServletRequest req) {
		return JspUtil.getErrorMsg(req);
	}

	/*
	 * ! ��request�Ĵ�����ʾ��Ϣ����msgֵ������ת��urlҳ��
	 */
	public static void go2input(HttpServletRequest req,
			HttpServletResponse res, String url, Object msg) throws Exception {
		// return JspUtil.getErrorMsg(req);
		if (msg == null) {
			throw new Exception("input error msg is null");
		}
		req.setAttribute(input_error_msg_key, msg);
		req.getRequestDispatcher(url).forward(req, res);

	}

	/*
	 * ! ����request������������ʾ��Ϣ
	 */
	public static String getInputErrorMsg(HttpServletRequest req) {
		Object msg = req.getAttribute(input_error_msg_key);
		if (msg == null) {
			return "";
		}
		return msg + "";
	}

	/*
	 * ! �׳��쳣����ϢΪmsg
	 */
	public static void error(String msg) throws Exception {
		throw new Exception(msg);
	}

	/*
	 * ! ��request��ֵ����Ϊkey��ֵΪvalue
	 */
	public static void add(HttpServletRequest req, String key, Object value) {

		if (StringUtil.isempty(key)) {
			return;
		}
		if (value == null) {
			return;
		}
		// model.put(key, value);
		req.setAttribute(key, value);
	}

	/*
	 * ! ��request��ֵ����Ϊmap��key��ֵΪmap��value
	 */
	public static void add(HttpServletRequest req, Map map) throws Exception {
		if (map == null) {
			return;
		}
		List list = null;
		int i = 0;
		int num = 0;
		Object key = null;

		list = StringUtil.getMapKey(map);
		num = list.size();
		for (i = 0; i < num; i++) {

			key = list.get(i);
			if (key != null) {
				add(req, key + "", map.get(key));
			}
		}

	}

	/*
	 * ! ��õ�½�û�����sessionֵ
	 */
	public static String getLoginUserName(HttpSession session) {

		return (String) session.getAttribute("user_name");

	}

	/*
	 * ! ��õ�½�û���ŵ�sessionֵ
	 */
	public static String getLoginUserId(HttpSession session) {

		return (String) session.getAttribute("user_id");

	}

	/*
	 * !
	 * �ж�session�Ƿ�ʱ����ʱ�׳�������Ϣ"δ��¼��ʱ"���������admin�˺ţ��׳�������Ϣ"ֻ�г���ϵͳ����Ա������ӱ༭ɾ�����㹫ʽ"
	 */
	public static void jsgs_check(HttpSession session) throws Exception {

		String name = getLoginUserName(session);
		if (empty(name)) {
			error("δ��¼��ʱ");
		}
		if (!eq(name, "admin")) {
			error("ֻ�г���ϵͳ����Ա������ӱ༭ɾ�����㹫ʽ");
		}

	}

	/*
	 * ! ����ص�Դ���Ե������б�ֵ
	 */
	public static String getCtlTypeOption(String type) throws Exception {
		return SwjUpdate.getCtlTypeOption(type);
	}

	/*
	 * ! ��ö����ĵ������
	 */
	public static String getTopAreaId() {
		return App.get("area_id", "33");
	}

	/*
	 * ! ���Ĭ�ϵĵ������
	 */
	public static String getDefaultAreaId() {
		return App.get("default_area_id", "3301");
	}

	/*
	 * ! ���Ĭ�ϵ�վλ����
	 */
	public static String getDefaultStationType() {
		return App.get("default_station_type", "5");
	}

	/*
	 * ! ���ݵ�����ţ���øñ�ŵĵ��������б�
	 */
	public static String getAreaOption(String area_id) throws Exception {
		String s = null;
		String area_pid = getTopAreaId();
		String sql = "select area_id,area_name from t_cfg_area where area_id like '"
				+ area_pid + "%' or area_id='" + area_pid + "'";
		sql = sql + " order by area_id";
		s = getOption(sql, area_id);
		return s;
	}

	/*
	 * ! ���ݵ�����ţ���øñ�ŵĵ��������б�,��Ҫ���ڻ��ܱ���
	 */
	public static String getHZBBAreaOption(String area_id) throws Exception {
		String s = null;
		String sql = "select area_id,area_name from t_cfg_area where area_id ='"
				+ area_id + "' or area_pid='" + area_id + "'";
		sql = sql + " order by area_id";
		s = getOption(sql, area_id);
		return s;
	}

	/*
	 * ! ���ݽ������ͣ���øý���������б�
	 */
	public static String getBuildTypeOption(String build_type) throws Exception {
		String s = null;
		String sql = "select parameter_value,parameter_name from t_cfg_parameter  where parameter_type_id='build_flag'";
		s = getOption(sql, build_type);
		return s;
	}

	/*
	 * ! ���ݼ���map��requestֵ����ø�վλ�������б�
	 */
	public static List getStationList(Map params, HttpServletRequest req)
			throws Exception {
		return JspPageUtil.getStationList(params, req);
	}

	/*
	 * ! ���ݼ���map��requestֵ����ø�վλ�������б�
	 */
	public static List getStationList2(Map params, HttpServletRequest req)
			throws Exception {
		return JspPageUtil.getStationList2(params, req);
	}

	/*
	 * ! ���ݼ���map��requestֵ����ò�ѯ��sql
	 */
	public static String getStationQuerySql(Map params, HttpServletRequest req)
			throws Exception {
		return JspPageUtil.getStationQuerySql(params, req);
	}

	/*
	 * ! ����վλ����station_type����ø�վλ�������б�
	 */
	public static String getStationTypeOption(String station_type)
			throws Exception {
		Connection cn = null;
		try {
			cn = f.getConn();
			return JspPageUtil.getStationTypeOption(cn, station_type);
		} catch (Exception e) {
			throw e;
		} finally {
			f.close(cn);
		}
	}

	/*
	 * ! ������ҵ���trade_id����ø���ҵ�������б�
	 */
	public static String getTradeOption(String trade_id) throws Exception {
		return SwjUpdate.getTradeOption(trade_id);
	}

	/*
	 * ! ����������valley_id����ø�����������б�
	 */
	public static String getValleyOption(String valley_id) throws Exception {
		Connection cn = null;
		try {
			cn = f.getConn();
			return JspPageUtil.getValleyOption(cn, valley_id);
		} catch (Exception e) {
			throw e;
		} finally {
			f.close(cn);
		}
	}

	public static String getHZBBValleyOption(String valley_id) throws Exception {

		String sql = "select SUBSTRING(valley_id,0,5) as valley_id,valley_name from t_cfg_valley where  PARENT_ID='1100000000'  order by valley_id";
		// sql=sql+"where valley_level='2' or valley_level='3' order by valley_level";
		String valleyOption = getOption(sql, valley_id);

		return valleyOption;

	}

	/*
	 * ! ���24Сʱ�������б�ֵ��ѡ��hh
	 */
	public static String getHourOption(String hh) throws Exception {
		int h = 0;
		h = getInt(hh, 0);
		return getHourOption(h);
	}

	/*
	 * ! �ж�վλ�����ǲ�����ȾԴ����
	 */
	public static boolean iswry(String station_type) {
		if (f.empty(station_type)) {
			return false;
		}
		String s = "," + station_type + ",";
		if (wry_station_types.indexOf(s) >= 0) {
			return true;
		}
		return false;
	}

	/*
	 * ! �ַ������⴦��ķ���
	 */
	public static String str(String s, Object[] vs) throws Exception {
		if (vs == null) {
			return s;
		}
		int i, num = 0;
		String s2 = null;
		num = vs.length;
		for (i = 0; i < num; i++) {
			s2 = "\\{" + i + "\\}";
			s = s.replaceFirst(s2, vs[i] + "");
		}
		return s;
	}

	/*
	 * ! ��cols����Ϊ����������
	 */
	public static String hide(String cols, HttpServletRequest req)
			throws Exception {
		return JspUtil.getHiddenHtml(cols, req);
	}

	/*
	 * ! ����վλ��ź�mapֵ����Ż�����id_or_col,s�����ʽ
	 */
	public static String get_css(Map m, String station_id, String id_or_col,
			String s) {
		if (f.empty(s)) {
			return "";
		}
		double v = f.getDouble(s, 0);
		if (v == 0) {
			return "";
		}
		Map m2 = null;
		String key = null;
		key = station_id + "_" + id_or_col;
		m2 = (Map) m.get(key);
		if (m2 == null) {
			return "";
		}
		Double vobj = null;
		vobj = (Double) m2.get("lo");
		if (vobj != null) {
			if (v < vobj.doubleValue()) {
				return "vover";
			}
		}

		vobj = (Double) m2.get("hi");
		if (vobj != null) {
			if (v > vobj.doubleValue()) {
				return "vover";
			}
		}

		return "";
	}

	/*
	 * ! �ж����Ƿ�Ϊ0��С�ڵ���0����true������Ϊfalse
	 */
	public static boolean is_q_zero(RowSet rs) {
		int i;
		String id = null;
		String s = null;
		Double obj = null;
		for (i = 0; i < q_id_num; i++) {
			id = q_id_arr[i];
			s = rs.get(id);
			if (empty(s)) {
				continue;
			}
			s = f.v(s);
			obj = f.getDoubleObj(s, null);
			if (obj == null) {
				continue;
			}
			if (obj.doubleValue() <= 0) {
				continue;
			}
			if (obj.doubleValue() > 0) {
				return false;
			}
		}
		return true;

	}

	/**
	 * ���ĳ��ĳ���ȵ����һ�������
	 * 
	 * @param year
	 * @param quarter
	 * @return Date
	 */
	public static Date getLastDayOfQuarter(int year, int quarter) {
		int month = 0;
		if (quarter > 4) {
			return null;
		} else {
			month = quarter * 3;
		}
		return getLastDayOfMonth(year, month);

	}

	/**
	 * ���ĳ��ĳ���ȵĵ�һ�������
	 * 
	 * @param year
	 * @param quarter
	 * @return Date
	 */
	public static Date getFirstDayOfQuarter(int year, int quarter) {
		int month = 0;
		if (quarter > 4) {
			return null;
		} else {
			month = (quarter - 1) * 3 + 1;
		}
		return getFirstDayOfMonth(year, month);
	}

	/**
	 * ���ĳ��ĳ�µ�һ�������
	 * 
	 * @param year
	 * @param month
	 * @return Date
	 */
	public static Date getFirstDayOfMonth(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, month - 1);
		calendar.set(Calendar.DATE, 1);
		return getSqlDate(calendar.getTime());
	}

	/**
	 * ���ĳ��ĳ�����һ�������
	 * 
	 * @param year
	 * @param month
	 * @return Date
	 */
	public static Date getLastDayOfMonth(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, month);
		calendar.set(Calendar.DATE, 1);
		return getPreviousDate(getSqlDate(calendar.getTime()));
	}

	public static String getLastDayOfMonthString(int year, int month) {

		Calendar now = Calendar.getInstance();
		now.set(Calendar.YEAR, year);
		now.set(Calendar.MONTH, month - 1);
		now.add(Calendar.MONTH, +1);
		now.set(now.get(Calendar.YEAR), now.get(Calendar.MONTH), 01);
		now.add(Calendar.DAY_OF_MONTH, -1);
		int yue = now.get(Calendar.MONTH);
		String yue_s = "";
		if (yue < 10) {
			yue_s = "0" + String.valueOf(yue);
		}

		String next_month = String.valueOf(now.get(Calendar.YEAR) + "-"
				+ (month) + "-" + now.get(Calendar.DAY_OF_MONTH));

		return next_month;
	}

	/**
	 * ��java.util.Date��java.sql.Date������ת��
	 * 
	 * @param date
	 * @return Date
	 */
	public static Date getSqlDate(java.util.Date date) {
		return new Date(date.getTime());
	}

	/**
	 * ���ĳһ���ڵ�ǰһ��
	 * 
	 * @param date
	 * @return Date
	 */
	public static Date getPreviousDate(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int day = calendar.get(Calendar.DATE);
		calendar.set(Calendar.DATE, day - 1);
		return getSqlDate(calendar.getTime());
	}

	// ��ȡ����
	public static String getThisSeasonTime(int month) {
		String quarter = "";
		if (month >= 1 && month <= 3) {
			quarter = "1";
		}
		if (month >= 4 && month <= 6) {
			quarter = "2";
		}
		if (month >= 7 && month <= 9) {
			quarter = "3";
		}
		if (month >= 10 && month <= 12) {
			quarter = "4";
		}
		return quarter;
	}

	// ��ȡ���µ�����
	public static String getMonthToMonth(int month) {
		String monthToMonth = "";
		String[] months = { "(January-March)", "(April-June)",
				"(July-September)", "(October-December)" };
		int index = month / 4;
		monthToMonth = months[index];
		return monthToMonth;
	}

	// ȡ�õ�ǰʱ��
	public static Date getDateTime(String dateTime) {
		Date strDate = java.sql.Date.valueOf(dateTime);
		return strDate;
	}

	public static int getMonth(String dateTime) {
		Calendar c = Calendar.getInstance();
		c.setTime(getDateTime(dateTime));
		int month = c.get(c.MONTH) + 1;
		return month;
	}

	public static String getStringMonth(String dateTime) {
		Calendar c = Calendar.getInstance();
		c.setTime(getDateTime(dateTime));
		int month = c.get(c.MONTH) + 1;
		String ret = String.valueOf(month);
		if (ret.length() == 1)
			ret = "0" + ret;

		return ret;
	}

	public static int getYear(String dateTime) {
		Calendar c = Calendar.getInstance();
		c.setTime(getDateTime(dateTime));
		int year = c.get(c.YEAR);
		return year;
	}

	public static Double getljll(String value, String data_table,
			String station_type) {
		Double n_value = f.getDoubleObj(value, null);

		if (n_value == null)
			return n_value;

		if (station_type.equals("1")) {
			n_value = (n_value * 3.6);

		}

		if (data_table.equals("t_monitor_real_day")) {
			n_value = (n_value * 24);
		}

		if (data_table.equals("t_monitor_real_month")) {
			n_value = (n_value * 24);
		}

		return n_value;
	}

	/*
	 * //�õ��ۻ����� public static Double getljll(String value , String
	 * data_table,String date, String station_type){ Double n_value =
	 * f.getDoubleObj(value, null);
	 * 
	 * if(!"".equals(data_table) && n_value !=null &&
	 * data_table.equals("T_MONITOR_REAL_TEN_MINUTE")){ n_value = n_value / 6;
	 * }else if(!"".equals(data_table) && n_value !=null &&
	 * station_type.equals("2") && data_table.equals("t_monitor_real_month")){
	 * String[] date_count = date.split("-"); String count =""; if(date_count
	 * !=null && date_count.length>=2){ count =
	 * f.getLastDayOfMonthString(Integer
	 * .valueOf(date_count[0]),Integer.valueOf(date_count[1]));
	 * if(!"".equals(count)){ n_value = (n_value *
	 * Integer.valueOf(count.split("-")[2])); } }
	 * 
	 * }
	 * 
	 * return n_value; }
	 * 
	 * 
	 * 
	 * 
	 * //�õ���ˮ������������ public static String getwyliuliang(String value ,String
	 * data_table,String date, String station_type){
	 * 
	 * if("".equals(value) || value == null || "".equals(station_type) ||
	 * station_type == null){ return value; }
	 * 
	 * if( !"".equals(data_table) ){ Double n_value = f.getDoubleObj(value,
	 * null); if(station_type.equals("2") && !"".equals(n_value) && n_value
	 * !=null && data_table.equals("t_monitor_real_day")){ value
	 * =(n_value/24)+""; }else if(station_type.equals("2") &&
	 * !"".equals(n_value) && n_value !=null &&
	 * data_table.equals("t_monitor_real_month")){ String[] date_count =
	 * date.split("-"); String count =""; if(date_count !=null &&
	 * date_count.length>=2){ count =
	 * f.getLastDayOfMonthString(Integer.valueOf(date_count
	 * [0]),Integer.valueOf(date_count[1])); if(!"".equals(count)){ value =
	 * n_value / Integer.valueOf(count.split("-")[2])+""; } } }else
	 * if(station_type.equals("1") && !"".equals(n_value) && n_value !=null &&
	 * data_table.equals("t_monitor_real_day")){ value =(n_value / 24)+""; }else
	 * if(station_type.equals("1") && !"".equals(n_value) && n_value !=null &&
	 * data_table.equals("t_monitor_real_month")){ String[] date_count =
	 * date.split("-"); String count =""; if(date_count !=null &&
	 * date_count.length>=2){ count =
	 * f.getLastDayOfMonthString(Integer.valueOf(date_count
	 * [0]),Integer.valueOf(date_count[1])); if(!"".equals(count)){ value =
	 * n_value / Integer.valueOf(count.split("-")[2])/24+""; } } } }
	 * 
	 * return f.format2(value, "0.0000"); }
	 */

	// �õ���ˮ������������
	public static String getwyliuliangp(String value, String data_table,
			String station_type) {

		if ("".equals(value) || value == null || "".equals(station_type)
				|| station_type == null) {
			return value;
		}

		if (!"".equals(data_table)) {
			Double n_value = f.getDoubleObj(value, null);
			if (station_type.equals("2") && !"".equals(n_value)
					&& n_value != null
					&& data_table.equals("t_monitor_real_day")) {
				value = (n_value / 24) + "";
			} else if (station_type.equals("2") && !"".equals(n_value)
					&& n_value != null
					&& data_table.equals("t_monitor_real_month")) {
				value = (n_value / 30) + "";
			} else if (station_type.equals("1") && !"".equals(n_value)
					&& n_value != null
					&& data_table.equals("t_monitor_real_day")) {
				value = (n_value / 24) + "";
			} else if (station_type.equals("1") && !"".equals(n_value)
					&& n_value != null
					&& data_table.equals("t_monitor_real_month")) {
				value = (n_value / 30 / 24) + "";
			}
		}

		return f.format2(value, "0.0000");
	}

	/*
	 * ! ����sql��ѯ���ݿ⣬����map����
	 */
	public static Map getMap(String sql) throws Exception {
		Connection cn = null;
		try {
			cn = getConn();
			return getMap(cn, sql);
		} catch (Exception e) {
			throw e;
		} finally {
			close(cn);
		}

	}

	/*
	 * ! ��ñ�����ʾ��Ϣ
	 */
	public static String getWarnMsg() {
		return WarnUtil.getMsg();
	}

	/*
	 * ! �����ʾ��Ϣ
	 */
	public static String getMsgMsg() {
		return MsgUtil.getMsg();
	}

	/*
	 * ! ��õ�ǰ��Ŀ��Ŀ¼
	 */
	public static String ctx(HttpServletRequest req) throws Exception {
		return JspUtil.getCtx(req);
	}

	/*
	 * ! ��õ�ǰ��Ŀ��Ŀ¼������ת��url
	 */
	public static void rd(HttpServletRequest req, HttpServletResponse res,
			String url) throws Exception {

		JspUtil.rd(req, res, url);
	}

	public static String getNowTime() {
		java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		java.util.Date nowTime = new java.util.Date();
		String time = format.format(nowTime);
		return time;
	}

	/*
	 * ! ��õ�ǰ��Ŀ��Ŀ¼������ת��url
	 */
	public static void fd(HttpServletRequest req, HttpServletResponse res,
			String url) throws Exception {
		JspUtil.fd(req, res, url);
	}

	/*
	 * ! ��ñ�����Ϣ�����ݼ���
	 */
	public static Map getMsgWarnDataMap() throws Exception {
		return CacheUtil.getMsgWarnDataMap();
	}

	/*
	 * ! ���ͳһ��֤���ķ���IP
	 */
	public static String getUums_ip() throws Exception {
		return App.get("uums_ip");
	}

	/*
	 * ! ���ͳһ��֤���ķ���˿�
	 */
	public static String getUums_port() throws Exception {
		return App.get("uums_port");
	}

	private static String q_id_str = "8,34,492";
	private static String[] q_id_arr = q_id_str.split(",");
	private static int q_id_num = q_id_arr.length;

}