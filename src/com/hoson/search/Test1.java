package com.hoson.search;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Test1 {

	public static void main(String args[])
    {
//        String url = "jdbc:jtds:sqlserver://localhost:1433/emos";
//        String user ="sa";//�����滻�������ѵ����ݿ��û���
//        String password = "lshh";//�����滻�������ѵ����ݿ��û�����
//        String sqlStr = "select CustomerID, CompanyName, ContactName from Customers";
//
//        try{    //������쳣��������Ǳ����.������ͨ������!    
//            Class.forName("net.sourceforge.jtds.jdbc.Driver");
//            System.out.println( "��ʵ�����ɹ�!" );
//
//            Connection con = DriverManager.getConnection( url, user, password );
//            System.out.println( "�������Ӷ���ɹ�!" );
//
//            Statement st = con.createStatement();
//            System.out.println( "����Statement�ɹ�!" );
//
//            ResultSet rs = st.executeQuery( sqlStr );
//            System.out.println( "�������ݱ�ɹ�!" );
//            System.out.println( "----------------!" );
//
//            while(rs.next())
//            {
//                System.out.print(rs.getString("CustomerID") + "    ");
//                System.out.print(rs.getString("CompanyName") + "    ");
//                System.out.println(rs.getString("ContactName"));
//            }
//            rs.close();
//            st.close();
//            con.close();
//        }
//        catch(Exception err){
//            err.printStackTrace(System.out);
//        }
		
		int i = 0;
		int j = 5;
		while(i<5){
			System.out.println(i);
			i++;
		}
    }

}
