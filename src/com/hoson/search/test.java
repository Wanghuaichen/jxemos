package com.hoson.search;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.hoson.f;


public class test {

	public static void main(String[] args) {
//		String s = "6sabcsssfsfs33";
//		//System.out.println(s.substring(4,10));
////		byte b[] = s.getBytes();
////		byte a[] = new byte[b.length];
////		int n = 0;
////		for(int i=0;i<b.length;i++){
////			if(b[i]!='a'&&b[i]!='b'&&b[i]!='3'){
////				a[n] = b[i];
////				n++;
////			}
////		}
////		System.out.println(new String(a));
//		String a = "";
//		for(int i=0;i<s.length();i++){
//			if(s.charAt(i)!='a'&&s.charAt(i)!='b'&&s.charAt(i)!='3'){
//				a = a + s.charAt(i);
//			}
//		}
//		System.out.println(a);
//		
//		
//		String path="f:/1.txt";//定义文件路径
//		String content="";//content保存文件内容，
//		int zimu = 0;
//		int shuzi = 0;
//		int kongge = 0;
//		int hang = 0;
//		BufferedReader reader=null;//定义BufferedReader
//		try{
//		reader=new BufferedReader(new FileReader(path));
//		//按行读取文件并加入到content中。
//		//当readLine方法返回null时表示文件读取完毕。
//		String line;
//		
//		while((line=reader.readLine())!=null){
//			content+=line;
//			hang ++;
//			if(isNumeric(line)){
//				shuzi ++;
//			}
//			for(int i = 0;i<line.length();i++){
//				if(isNumeric(String.valueOf(line.charAt(i)))){
//					shuzi ++;
//				}
//				if(isLetter(String.valueOf(line.charAt(i)))){
//					zimu ++;
//				}
//				if(isKongge(String.valueOf(line.charAt(i)))){
//					kongge ++;
//				}
//			}
//		}
//		}catch(IOException e){
//			e.printStackTrace();
//		}finally{
//		//最后要在finally中将reader对象关闭
//		if(reader!=null){
//		try{
//		reader.close();
//		}catch(IOException e){
//		e.printStackTrace();
//		}
//		}
//		}
//		System.out.println("文件内容："+content);
//		System.out.println("数字个数："+shuzi);
//		System.out.println("字母个数："+zimu);
//		System.out.println("空格个数："+kongge);
//		System.out.println("行数个数："+hang);

//		String   d="2004-01-01";   
//		String   d1="2004-01-03";  
//		  DateFormat   format=new   SimpleDateFormat("yyyy-MM-dd");   
//		  Date dd =null;
//		  Date dd1 =null;
//		try {
//			dd = format.parse(d);
//			dd1 = format.parse(d1);
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}   
//		  Calendar   calendar=Calendar.getInstance();   
//		  calendar.setTime(dd);   
//		  calendar.add(Calendar.DAY_OF_MONTH,1);   
//		  System.out.println(format.format(calendar.getTime()));
//		  Timestamp ts = new Timestamp(dd.getTime());
//		  Timestamp ts1 = new Timestamp(dd1.getTime());
//		  if(ts1.getTime()>ts.getTime()){
//			  System.out.println("dd");
//		  }
//		  try {
//			Timestamp ts2 = f.dateAdd(ts,"day",1);
//			String d5 = ts.toString();
//			String d6 = ts2.toString();
//			System.out.println(d5);
//			System.out.println(d6);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		
		String s = "流量2";
		if(s.indexOf("流量")==0){
			System.out.println(s.indexOf("流量"));
		}
	}
	 public static boolean isNumeric(String str)
     {
           Pattern pattern = Pattern.compile("[0-9]*");
           Matcher isNum = pattern.matcher(str);
           if( !isNum.matches() )
           {
                 return false;
           }
           return true;
     }
	 public static boolean isLetter(String str)
     {
           Pattern pattern = Pattern.compile("[a-zA-Z]*");
           Matcher isNum = pattern.matcher(str);
           if( !isNum.matches() )
           {
                 return false;
           }
           return true;
     }
	 public static boolean isKongge(String str)
     {
//           Pattern pattern = Pattern.compile("([\u4e00-\u9fa5]\\s+[\u4e00-\u9fa5])");
//           Matcher isNum = pattern.matcher(str);
           if( !str.equals(" ") )
           {
                 return false;
           }
           return true;
     }
}
