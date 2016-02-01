<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.*,java.util.*,java.io.*,org.apache.commons.fileupload.*"%>
<%

try{

        DiskFileUpload fu = new DiskFileUpload();
 // 设置允许用户上传文件大小,单位:字节
 fu.setSizeMax(100000000);
 // maximum size that will be stored in memory?
 // 设置最多只允许在内存中存储的数据,单位:字节
 fu.setSizeThreshold(4096);
 // 设置一旦文件大小超过getSizeThreshold()的值时数据存放在硬盘的目录
 //fu.setRepositoryPath("/tmp");
 //开始读取上传信息

 List fileItems = fu.parseRequest(request);

 // 依次处理每个上传的文件
 Iterator iter = fileItems.iterator();
 
 String filepath = JspUtil.getAppPath(request)+"/pages/commons/upload/";
 
 FileUtil.createDirs(filepath);


  



 while (iter.hasNext()) {
  FileItem item = (FileItem) iter.next();
  //忽略其他不是文件域的所有表单信息
  if (!item.isFormField()) {
   String name = item.getName();
   long size = item.getSize();
   if((name==null||name.equals("")) && size==0)
   continue;
    // 注意item.getName()
    // 会返回上载文件在客户端的完整路径名称，这似乎是一个BUG。
    // 为解决这个问题，这里使用了fullFile.getName()。
    name=name.replace('\\','/');
    File fullFile = new File(name); 

    File savedFile = new File(filepath,fullFile.getName());
    item.write(savedFile);
   out.println(filepath+fullFile.getName()+"<br>");
  }
 }

}catch(Exception e){
out.println(e);
}
%>
