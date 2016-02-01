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
	 *            Ҫ���õ� rEPORT_NAME
	 */
	public void setREPORT_NAME(String report_name) {
		REPORT_NAME = report_name;
	}

	/**
	 * �������ݿ⣬ͨ��sql��ѯ�����в�ѯ�����ؽ����
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
	 * ͨ��sql�����˱������ݣ���.net�Ͳ�����ô����
	 * 
	 * @return
	 * @throws ReportSDKException
	 */
	public IReportSource getReportSource(String query)
			throws ReportSDKException {
		// ��ˮ������
		ReportClientDocument reportClientDoc = new ReportClientDocument();
		reportClientDoc.open(REPORT_NAME, 0);
		// sql��ѯ���,���ص��ֶ�����������������һ�������ܶ�Ҳ�����٣������ֶε�����Ҫ�������һ��������������ʲô���ݶ�����
		// from ������Ҫ�������������ݿ���.dbo.���ݿ�������������

		ResultSet resultSet = this.getResultSetFromQuery(query,
				ResultSet.TYPE_SCROLL_INSENSITIVE);

		String tableAlias = reportClientDoc.getDatabaseController()
				.getDatabase().getTables().getTable(0).getAlias();
		// �ѽ�����Ž�����������Զ�����һ��datasource
		reportClientDoc.getDatabaseController().setDataSource(resultSet,
				tableAlias, null);
		return reportClientDoc.getReportSource();

	}

}
