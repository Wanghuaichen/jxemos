package com.hoson.msg;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import com.hoson.*;
public class MsgServlet extends HttpServlet{
	
	public void init()
    throws ServletException{
		
		//System.out.println("\n\n\n\n\n\n\nmsg servlet start\n\n\n\n\n");
	   Thread t = new MsgThread();
	   t.start();
	}
}


