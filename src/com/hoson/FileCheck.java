package com.hoson;

import com.hoson.app.*;
import java.io.*;

public class FileCheck {

	static String file_check_path = App.get("file_check_path", "");

	static String file_check_string = App.get("file_check_string", "");

	public static void main(String[] args) throws Exception {

		if (StringUtil.isempty(file_check_path)) {

			System.out.println("file_check_path is empty");
			return;
		}
		if (StringUtil.isempty(file_check_string)) {
			System.out.println("file_check_string is empty");
			return;
		}
		System.out.println(file_check_path);
		System.out.println(file_check_string);
		StringBuffer sb = new StringBuffer();
		File f = new File(file_check_path);
		if (f == null) {
			throw new Exception("file is null");
		}
		updateFile(f, sb);
		System.out.println(sb);

	}

	public static void updateFile(File f, StringBuffer sb) throws Exception {
		if (f == null) {
			throw new Exception("file is null");
		}
		String s = "";
		if (!f.isDirectory()) {
			return;
		}
		boolean b = false;
		int i, num = 0;
		String file_name = null;
		String file_name2 = null;
		int pos = 0;
		File[] fs = f.listFiles();
		num = fs.length;
		for (i = 0; i < num; i++) {
			f = fs[i];
			if (f.isDirectory()) {
				updateFile(f, sb);
			} else {
				file_name = f.getPath();
				file_name2 = file_name.toLowerCase();
				b = file_name2.endsWith(".jsp") || file_name2.endsWith(".htm")
						|| file_name2.endsWith(".html");
				if (!b) {
					continue;
				}
				if (b)
				{
					s = FileUtil.read(file_name);
					pos = s.indexOf(file_check_string);
					if (pos >= 0) {
						sb.append(file_name + "\r\n");
					} else {
						continue;
					}
				}
			}
		}
	}
}