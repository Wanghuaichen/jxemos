package com.hoson.map;

/**
 * վ����Ϣ
 * 
 * @author MF
 * 
 */
public class TCfgStationInfo {
	/*
	 * վ��Id
	 */
	private String stationId;
	/*
	 * ����
	 */
	private String longitude;

	/*
	 * γ��
	 */
	private String latitude;

	/*
	 * վ����ʾ��
	 */
	private String stationDesc;
	
	/*
	 * ��Ⱦ����
	 */
	private String parameterName;

	public String getStationId() {
		return stationId;
	}

	public void setStationId(String stationId) {
		this.stationId = stationId;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getStationDesc() {
		return stationDesc;
	}

	public void setStationDesc(String stationDesc) {
		this.stationDesc = stationDesc;
	}

	public String getParameterName() {
		return parameterName;
	}

	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}
	
}
