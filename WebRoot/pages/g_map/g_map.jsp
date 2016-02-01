<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.hoson.map.*,net.sf.json.*,java.util.*"%>
<%
	GoogleMap googleMap = new GoogleMap();
	List<TCfgStationInfo> stationsList = googleMap.getStations();
	
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>google map v3</title>
<style>
.map-content{font-size: 12px;
text-align: left;}
.map-content a{padding-top: 10px;
float: left; font-size:12px;}
</style>
<!-- <script type="text/javascript" -->
<!-- 	src="https://maps.google.com/maps/api/js?sensor=false&language=zh"></script> --><base>
<script type="text/javascript" src="mapapi.js"></script>
<script type="text/javascript">
<!--
	var map;
	/*
		latitude 纬度 
		longitude 精度 
		title 悬浮在标记图标上显示的内容
		openInfo 提示窗口内容(InfoWindow)
	 */
	function initialize() {
		//地图定位 
		//var myLatlng = new google.maps.LatLng('27.92', '115.69');
		var myLatlng = new google.maps.LatLng('28.10', '115.75');//丰城
		var myOptions = {
			//zoom : 8, //地图的缩放程度
			zoom : 10,//丰城
			center : myLatlng, //地图中心位置
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};

		//把地图绑定在ID为map_canvas的DIV上
		map = new google.maps.Map(document.getElementById("map_canvas"),
				myOptions);
		//所有站点信心		
		var stationList = eval(<%=JSONArray.fromObject(stationsList)%>);

		for ( var i = 0; i < stationList.length; i++) {
			var stationId = stationList[i].stationId;
			var longitude = stationList[i].longitude;
			var latitude = stationList[i].latitude;
			var stationDesc = stationList[i].stationDesc;
			var parameterName=stationList[i].parameterName;
			var g_point = new google.maps.LatLng(latitude, longitude);
			
			showMarker(g_point,stationDesc,parameterName);
	}
		function showMarker(g_point,stationDesc,parameterName){
					//显示地址的标记图标
			var marker = new google.maps.Marker({
				position : g_point,
				map : map,
				title : stationDesc,
			 	icon: 'http://google-maps-icons.googlecode.com/files/factory.png'   //自定义标记图标
			});
			
			var showInfo="<div class='map-content'>"+stationDesc;
				showInfo+="<br>污染源类型:"+parameterName;
				showInfo+="<br><a href='<%=path%>/pages/station_new/index_one.jsp?station_id="+stationId+"'  target='_blank'>点击查看详细信息</a></div>";
				
			var infowindow = new google.maps.InfoWindow({ //InfoWindow 内容提示
				content : showInfo,
				position : g_point
			});
			
// 			给marker添加点击事件
			google.maps.event.addListener(marker, 'click', function() {
				infowindow.open(map); //如果提示窗口关闭了，点击标记图标可再次显示提示主窗口
			});
		} 
// 				infowindow.open(map); //显示提示主窗口
	}
</script>
</head>
<body onload="initialize()">
	<div align="center">
		<div id="map_canvas" style="width: 100%; height: 600px;"></div>
	</div>
</body>
</html>