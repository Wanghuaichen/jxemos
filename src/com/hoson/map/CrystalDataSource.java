package com.hoson.map;

import java.sql.*;
import com.crystaldecisions.reports.sdk.*;
import com.crystaldecisions.sdk.occa.report.lib.ReportSDKException;
import com.crystaldecisions.sdk.occa.report.reportsource.IReportSource;
import com.hoson.PropUtil;

public class CrystalDataSource {

	private String REPORT_NAME = "";

	public CrystalDataSource(String report_name) {
		this.REPORT_NAME = report_name;
	}

	/**
	 * @return report_name
	 */
	public String getREPORT_NAME() {
		return REPORT_NAME;
	}

	/**
	 * @param report_name
	 *            要设置的 rEPORT_NAME
	 */
	public void setREPORT_NAME(String report_name) {
		REPORT_NAME = report_name;
	}

	/**
	 * 连接数据库，通过sql查询语句进行查询，返回结果集
	 */
	private ResultSet getResultSetFromQuery(String query, int scrollType) {
		try {
			Class.forName(PropUtil.getResProp("/app.properties").getProperty(
					"driver"));
			final String DBUSERNAME = PropUtil.getResProp("/app.properties")
					.getProperty("user");
			final String DBPASSWORD = PropUtil.getResProp("/app.properties")
					.getProperty("pwd");
			final String CONNECTION_URL = PropUtil
					.getResProp("/app.properties").getProperty("url");

			java.sql.Connection connection = DriverManager.getConnection(
					CONNECTION_URL, DBUSERNAME, DBPASSWORD);
			Statement statement = connection.createStatement(scrollType,
					ResultSet.CONCUR_READ_ONLY);

			return statement.executeQuery(query);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	/**
	 * 通过sql语句过滤报表数据，在.net就不用这么惨了
	 * 
	 * @return
	 * @throws ReportSDKException
	 */
	public IReportSource getReportSource(String query)
			throws ReportSDKException {
		// 打开水晶报表
		ReportClientDocument reportClientDoc = new ReportClientDocument();
		reportClientDoc.open(REPORT_NAME, 0);
		// sql查询语句,返回的字段数必须跟报表里面的一样，不能多也不能少，并且字段的类型要跟报表的一样，其他不管是什么数据都可以
		// from 表这里要填完整，如数据库名.dbo.数据库表，最好做个别名

		ResultSet resultSet = this.getResultSetFromQuery(query,
				ResultSet.TYPE_SCROLL_INSENSITIVE);

		String tableAlias = reportClientDoc.getDatabaseController()
				.getDatabase().getTables().getTable(0).getAlias();
		// 把结果集放进报表里，将会自动产生一个datasource
		reportClientDoc.getDatabaseController().setDataSource(resultSet,
				tableAlias, null);
		return reportClientDoc.getReportSource();

	}

}
