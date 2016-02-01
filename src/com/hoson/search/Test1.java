package com.hoson.search;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Test1 {

	public static void main(String args[])
    {
//        String url = "jdbc:jtds:sqlserver://localhost:1433/emos";
//        String user ="sa";//这里替换成你自已的数据库用户名
//        String password = "lshh";//这里替换成你自已的数据库用户密码
//        String sqlStr = "select CustomerID, CompanyName, ContactName from Customers";
//
//        try{    //这里的异常处理语句是必需的.否则不能通过编译!    
//            Class.forName("net.sourceforge.jtds.jdbc.Driver");
//            System.out.println( "类实例化成功!" );
//
//            Connection con = DriverManager.getConnection( url, user, password );
//            System.out.println( "创建连接对像成功!" );
//
//            Statement st = con.createStatement();
//            System.out.println( "创建Statement成功!" );
//
//            ResultSet rs = st.executeQuery( sqlStr );
//            System.out.println( "操作数据表成功!" );
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
