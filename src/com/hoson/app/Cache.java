package com.hoson.app;

import java.sql.Timestamp;
import java.util.*;
import com.hoson.*;


public class Cache {

	private static final Map data = new HashMap();

	static long wait_time = 500;

	static long max_cache_time = 10000000;
	static int max_wait_count = 6;

	// static String class_name = null;

	// public Object getObject(Map input),sub class
	// the key is the class name

	String getKey() {

		return this.getClass().getName();

	}

	public static Map getCacheData() {
		return data;
	}

	static long getTime() {
		return System.currentTimeMillis();
	}

	static long getLong(String s, long def_val) {

		try {
			return Long.parseLong(s);

		} catch (Exception e) {
			return def_val;
		}
	}

	int getUpdateFlag(long cache_time) {
		String key = getKey();
		long now = getTime();
		long update = getLong((String) data.get(key + "_update"), 0);

		if (cache_time <= 0 || cache_time > max_cache_time) {
			cache_time = max_cache_time;
		}
		cache_time = cache_time * 1000;

		long diff = now - update;
		if (diff < 0) {
			diff = diff * (-1);
		}
		if (cache_time <= 0) {
			return 0;
		}
		if (diff > cache_time) {
			return 1;
		} else {
			return 0;
		}

	}

	public Object get(long cache_time, Map input) throws Exception {
		return get(cache_time, input, 1);
	}

	public Object get(long cache_time, Map input, int update_when_error)
			throws Exception {

		Object obj = null;

		obj = getObjectInternal(cache_time, input, update_when_error);
		if (obj != null) {
			return obj;
		}

		return getAndUpdate(cache_time, input, update_when_error);

	}

	Object getAndUpdate(long cache_time, Map input) throws Exception {

		return getAndUpdate(cache_time, input, 1);

	}

	/**
	 * can not use synchronized here
	 */

	public Object getAndUpdate(long cache_time, Map input, int update_when_error)
			throws Exception {

		String key = getKey();

		Object obj = null;
		long t1,t2=0;
		int wait_num=0;
		

		try {
			
			if(isReadingAndNull()){
				throw new Exception("正在读取数据,请稍侯");
			}

			while (isReadingAndNull()) {
				wait_num++;
				if(wait_num>max_wait_count){
					throw new Exception("正在读取数据,请稍侯");
				}
				Thread.sleep(wait_time);
				
			
			
				obj = getObjectInternal(cache_time, input, update_when_error);
				if (obj != null) {
					return obj;
				}

			}

			data.put(key + "_read", "1");
			
			 t1 = StringUtil.getTime();
				obj = getObject(input);
				t2 = StringUtil.getTime();
				data.put(key+"_time",(t2-t1)+"");

			if (obj == null) {
				throw new Exception("getObject() can not return null");
			}

			if (obj != null) {
				data.put(key + "_content", obj);
				data.put(key + "_update", getTime() + "");

			}
			return obj;

		} catch (Exception e) {
			data.put(key + "_error", getTime() + "");
			if (update_when_error > 0) {
				data.put(key + "_update", getTime() + "");
			}
			throw e;
		} finally {
			data.put(key + "_read", "0");
		}

	}

	public Object getObject(Map input) throws Exception {

		// write code here in sub class

		return null;
	}

	static List getCacheKeys() {
		List list = new ArrayList();
		List tmp = null;
		int i = 0;
		int num = 0;
		String key = null;
		tmp = StringUtil.getMapKey(data);
		num = tmp.size();
		for (i = 0; i < num; i++) {
			key = (String) tmp.get(i);
			if (key == null) {
				key = "";
			}
			if (key.endsWith("_update")) {
				key = key.substring(0, key.length() - 7);
				list.add(key);
			}
		}

		return list;

	}

	static Timestamp getTimestamp(String s) {

		if (StringUtil.isempty(s)) {
			return null;
		}
		long t = getLong(s, 0);
		Timestamp ts = null;
		try {
			ts = new Timestamp(t);
		} catch (Exception e) {
		}
		return ts;
	}

	public static String getCacheInfo() {
		List list = null;
		String s = "";
		String key = null;
		int i = 0;
		int num = 0;
		Timestamp ts_update = null;
		Timestamp ts_error = null;

		list = getCacheKeys();
		num = list.size();

		for (i = 0; i < num; i++) {
			key = (String) list.get(i);
			ts_update = getTimestamp((String) data.get(key + "_update"));
			ts_error = getTimestamp((String) data.get(key + "_error"));
			s = s + "key=" + key + ",read=" + data.get(key + "_read")+",time="+data.get(key + "_time")
					+ ",update=" + ts_update + ",error=" + ts_error + "\n\n";
		}

		return s;

	}

	public boolean isReadingAndNull() {

		String key = getKey();
		Object v = data.get(key + "_content");
		String read = null;
		read = (String) data.get(key + "_read");
		if (v == null && StringUtil.equals(read, "1")) {
			// Thread.sleep(wait_time);
			return true;
		}
		return false;
	}

	public Object getObjectInternal(long cache_time, Map input,
			int update_when_error) throws Exception {

		String key = getKey();
		Object v = data.get(key + "_content");
		String read = null;
		int flag = getUpdateFlag(cache_time);

		if (v != null && flag == 0) {
			return v;
		}
		read = (String) data.get(key + "_read");
		if (StringUtil.equals(read, "1") && v != null) {
			return v;
		}
		return null;

	}

	public static void clear(String key) {

		String update = null;
		key = key + "_update";
		update = (String) data.get(key);
		if (StringUtil.isempty(update)) {
			return;
		}
		data.put(key, "");

	}

	public static void clear() {

		String key = null;
		List list = getCacheKeys();
		int i = 0;
		int num = 0;
		num = list.size();
		for (i = 0; i < num; i++) {

			key = (String) list.get(i);
			clear(key);
		}
	}

}