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
   //����Ҫ���ص��ļ�loadFile
	String path = Config.get_sys_prop().getProperty("down_path");
   File loadFile=new File(path+"/fx/query/dataInfectant.rar");
   //ʹ�öԻ��򱣴��ļ�
   response.setHeader("Content-disposition","attachment;filename="+"dataInfectant.rar");
   //֪ͨ�ͻ�Ҫ�����ļ�����
   response.setContentType("application/rar");
   //���������ļ��ĳ���
   long fileLength=loadFile.length();
   //�ѳ����ε��ļ�����ת��Ϊ�ַ���
   String length=String.valueOf(fileLength);
   response.setHeader("content_Length",length);
    //����һ�������ļ���clientFile,���ղ���ȡ�����ص��ļ�
   FileInputStream clientFile=new FileInputStream(loadFile);
   //����һ�������serverFile��ȡҪ���ص��ļ�
   OutputStream serverFile=response.getOutputStream();

   //��Ҫ���ص��ļ������ݶ���������clientFile
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
