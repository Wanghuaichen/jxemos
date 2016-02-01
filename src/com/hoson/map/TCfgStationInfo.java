package com.hoson.map;

/**
 * 站点信息
 * 
 * @author MF
 * 
 */
public class TCfgStationInfo {
	/*
	 * 站点Id
	 */
	private String stationId;
	/*
	 * 经度
	 */
	private String longitude;

	/*
	 * 纬度
	 */
	private String latitude;

	/*
	 * 站点显示名
	 */
	private String stationDesc;
	
	/*
	 * 污染类型
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
