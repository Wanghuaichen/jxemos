package com.hoson;

import java.io.*;
import java.util.*;
import java.net.*;

/**http client 20060908
 *
*/


public class HttpClient{

public static String trim(String s){
 if(s==null){return null;}
  return s.trim();
}

//--------------
public static String getStringFromInputStream(InputStream is)throws Exception{

if(is==null){return null;}
char ch = ' ';
 int ich = 0;
StringBuffer sb = new StringBuffer();

 ich = is.read();
 while(ich>=0){
  ch = (char)ich;
  sb.append(ch);
  ich = is.read();

}
return sb.toString();


}
//--------------
public static String getUrlContent(String url)throws Exception{
URL u = null;
InputStream is = null;
String s = null;
u = new URL(url);
is = u.openStream();
s = getStringFromInputStream(is);
s=trim(s);
s = StringUtil.iso2gbk(s);
return s;
}
//------------
public static String getHttpURLConnectionInfo(String url)throws Exception{
String s = "";
HttpURLConnection cn = null;
URL u = null;


 u = new URL(url);
cn =(HttpURLConnection) u.openConnection();


s = s+"getRequestMethod()="+cn.getRequestMethod()+"\n";
s = s+"getResponseCode()="+cn.getResponseCode()+"\n";
s = s+"getResponseMessage()="+cn.getResponseMessage()+"\n";

return s;
}
//-------------------
public static String getUrlContent(String url,String method,Properties params)throws Exception{

String s = null;
HttpURLConnection cn = null;
URL u = null;
InputStream is = null;

u = new URL(url);
cn =(HttpURLConnection) u.openConnection();

if(StringUtil.equals("post",method)){
cn.setRequestMethod("POST");
}
if(StringUtil.equals("get",method)){
cn.setRequestMethod("GET");
}

//setRequestProperties(cn,requestProp);
//cn.setRequestProperty("msg","cat");
setRequestParameters(cn,params);

is = cn.getInputStream();
s = getStringFromInputStream(is);
s=trim(s);
s = StringUtil.iso2gbk(s);

return s;
}

//----------
public static void setRequestProperties(HttpURLConnection cn,Properties requestProp)throws Exception{
if(cn==null){return;}
if(requestProp==null){return;}
//System.out.println("set prop");

Enumeration e = requestProp.propertyNames();
String key = null;
String value = null;

while(e.hasMoreElements()){
   key = (String)e.nextElement();
   value = requestProp.getProperty(key);
   cn.setRequestProperty(key,value);
   }


}
//--------------
public static void setRequestParameters(HttpURLConnection cn,Properties params)throws Exception{
if(cn==null){return;}
if(params==null){return;}

StringBuffer sb = new StringBuffer();
Enumeration e =params.propertyNames();
String key = null;
String value = null;

while(e.hasMoreElements()){
   key = (String)e.nextElement();
   value = params.getProperty(key);
   value = URLEncoder.encode(value);
   sb.append(key).append("=").append(value).append("&");
   }

PrintWriter out = null;
try{
cn.setDoOutput(true);
out = new PrintWriter(cn.getOutputStream());
out.print(sb.toString());
//System.out.println(sb.toString());
//out.close();
}catch(Exception ex){
throw new Exception("error when set request parameter,"+ex);
}finally{
FileUtil.close(out);
}

}
//-----------------------
}