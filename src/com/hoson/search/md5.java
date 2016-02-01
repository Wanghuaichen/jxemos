package com.hoson.search;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import sun.misc.BASE64Encoder;

public class md5 {

	/**
	 * @param args
	 */
	public String EncoderByMd5(String str) throws NoSuchAlgorithmException,UnsupportedEncodingException {
		// 确定计算方法
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		BASE64Encoder base64en = new BASE64Encoder();
		// 加密后的字符串
		String newstr = base64en.encode(md5.digest(str.getBytes("utf-8")));
		return newstr;
	}

	public boolean checkpassword(String newpasswd, String oldpasswd) throws

	NoSuchAlgorithmException, UnsupportedEncodingException {
		if (EncoderByMd5(newpasswd).equals(oldpasswd))
			return true;
		else
			return false;
	}

	public static void main(String[] args) {
		md5 md = new md5();
		try {
			System.out.println(md.EncoderByMd5("aa11"));
			if (md.checkpassword("aa", md.EncoderByMd5("aa1"))) {
				System.out.println("密码相同");
			} else {
				System.out.println("密码不同");
			}
			System.out.println(md.EncoderByMd5("test"));
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
