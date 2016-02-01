<%@ page contentType="text/html; charset=gb2312" language="java" import="java.io.*" errorPage="" %>
<%@page import="com.hoson.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
<link href="../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../styles/common/common.css" rel="stylesheet" type="text/css" />
<link href="../styles/common/select1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../scripts/jSelect/jselect.js"></script>
<script type="text/javascript" src="../scripts/common.js"></script>
</head>

<body>
<% 
   //声明要下载的文件loadFile
	String path = Config.get_sys_prop().getProperty("down_path");
   File loadFile=new File(path+"/fx/query/dataInfectant.rar");
   //使用对话框保存文件
   response.setHeader("Content-disposition","attachment;filename="+"dataInfectant.rar");
   //通知客户要下载文件类型
   response.setContentType("application/rar");
   //定义下载文件的长度
   long fileLength=loadFile.length();
   //把长整形的文件长度转换为字符串
   String length=String.valueOf(fileLength);
   response.setHeader("content_Length",length);
    //声明一个输入文件流clientFile,接收并读取己下载的文件
   FileInputStream clientFile=new FileInputStream(loadFile);
   //声明一个输出流serverFile获取要下载的文件
   OutputStream serverFile=response.getOutputStream();

   //把要下载的文件的内容读入输入流clientFile
   int n=0;
   byte b[]=new byte[100];
   while((n=clientFile.read(b))!=-1)
   {
       serverFile.write(b,0,n);
   }
   serverFile.close();
   clientFile.close();
%>
</body>
</html>
