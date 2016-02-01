package com.hoson.action;

import java.io.*;
import java.net.*;

import javax.servlet.http.HttpServletRequest;
import com.hoson.DBUtil;
import com.hoson.*;
import com.hoson.JspUtil;


public class MachineControl {

	private String station_id = "";		
	
	private String tbxType = "";
	
	private String tbxControlName = "";

	private String tbxMachine = "";
	
	private HttpServletRequest request = null;

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public String getTbxMachine() {
		return tbxMachine;
	}

	public void setTbxMachine(String tbxMachine) {
		this.tbxMachine = tbxMachine;
	}
	
	public String getStation_id() {
		return station_id;
	}

	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}

	public String getTbxControlName() {
		return tbxControlName;
	}

	public void setTbxControlName(String tbxControlName) {
		this.tbxControlName = tbxControlName;
	}

	public String getTbxType() {
		return tbxType;
	}

	public void setTbxType(String tbxType) {
		this.tbxType = tbxType;
	}
	
	public MachineControl(HttpServletRequest request) throws Exception
	{
		this.request = request;
		if (request.getParameter("station_id") != null)
			this.setStation_id(JspUtil.getParameter(request, "station_id"));
		if (request.getParameter("tbxType") != null)
			this.setTbxType(com.hoson.JspUtil.getParameter(request, "tbxType"));
		if (request.getParameter("tbxControlName") != null)
			this.setTbxControlName(com.hoson.JspUtil.getParameter(request, "tbxControlName"));
		if (request.getParameter("tbxMachine") != null)
			this.setTbxMachine(com.hoson.JspUtil.getParameter(request, "tbxMachine"));
	}
	
	public String getError(String strInput)
	{
		try
		{
			return SendMsg(strInput);
		}
		catch(Exception ex)
		{
			return ex.toString();
		}
	}
	
	public String SendMsg(String strInput) throws Exception
	{
		String strHostIP = PropUtil.getResProp("/app.properties").getProperty("Machine.IP");
		int iPort = Integer.parseInt(PropUtil.getResProp("/app.properties").getProperty("Machine.Port"));
		String strResult = "error";
		BufferedReader in = null;
		PrintWriter out = null;
		Socket socket = null;
		try {
			
			socket = new Socket(strHostIP,iPort);
			if(socket.isConnected() == false)
			{
				strResult = "not connected host...";
			}
			else
			{
				out = new PrintWriter(socket.getOutputStream(), true);
				in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
				out.write(strInput);
				//String strAccept = in.readLine();
				out.flush();
				strResult = "ok";
				
				//String strAccept = in.readLine();
				//if(strAccept.compareTo("over") == 0)
				//{
				//	strResult = "ok";
				//}

				out.close();
				in.close();
				socket.close();
			}
		}
		catch(SocketException se)
		{
			strResult = se.toString();
		}
		catch (IOException e) {
			strResult = e.toString();
		}
		finally
		{
			if(out != null)
				out.close();
			if(in != null)
				in.close();
			if(socket != null)
				socket.close();
		}
		return strResult;
	}
}
