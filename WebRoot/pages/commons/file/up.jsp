<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.*,java.util.*,java.io.*,org.apache.commons.fileupload.*"%>
<%

try{

        DiskFileUpload fu = new DiskFileUpload();
 // ���������û��ϴ��ļ���С,��λ:�ֽ�
 fu.setSizeMax(100000000);
 // maximum size that will be stored in memory?
 // �������ֻ�������ڴ��д洢������,��λ:�ֽ�
 fu.setSizeThreshold(4096);
 // ����һ���ļ���С����getSizeThreshold()��ֵʱ���ݴ����Ӳ�̵�Ŀ¼
 //fu.setRepositoryPath("/tmp");
 //��ʼ��ȡ�ϴ���Ϣ

 List fileItems = fu.parseRequest(request);

 // ���δ���ÿ���ϴ����ļ�
 Iterator iter = fileItems.iterator();
 
 String filepath = JspUtil.getAppPath(request)+"/pages/commons/upload/";
 
 FileUtil.createDirs(filepath);


  



 while (iter.hasNext()) {
  FileItem item = (FileItem) iter.next();
  //�������������ļ�������б���Ϣ
  if (!item.isFormField()) {
   String name = item.getName();
   long size = item.getSize();
   if((name==null||name.equals("")) && size==0)
   continue;
    // ע��item.getName()
    // �᷵�������ļ��ڿͻ��˵�����·�����ƣ����ƺ���һ��BUG��
    // Ϊ���������⣬����ʹ����fullFile.getName()��
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
