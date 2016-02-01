var zNodes = [ 
{
	name : '地理信息',
	value : 'pages/map_p',
	open : false,
	nodes : [ {
		name : '电子地图',
		value : 'pages/g_map/g_map.jsp'
	}, {
		name : '区域地图',
		value : 'pages/flashmap/map.jsp'	
	}]
},{
	name :'实时监控',
	value : 'pages/real_data/index.jsp',
	open : true
},
 {
	name : '数据查询',
	value : 'pages/data_p',
	open : false,
	nodes : [ {
		name : '综合查询',
		value : 'pages/fx/query/data.jsp'
	}, {
		name : '报警数据',
		value : 'pages/warn/index.jsp'
	}, {
		name : '数据分析',
		value : 'pages/fx/fx_home.jsp'
	} ]
}, {
	name : '统计报表',
	value : 'pages/report_p',
	open : false,
	nodes : [ {
		name : '污染物排放总量报表',
		value : 'pages/report_sj/index.jsp'
	}, {
		name : '汇总报表',
		value : 'pages/report_cm/index.jsp'
	}, {
		name : '站位在线统计报表',
		value : 'pages/report/zwzxtjrpt.jsp'
	}, {
		name : '综合报表',
		value : 'pages/report/zhrpt.jsp'
	}, {
		name : '自定义报表',
		value : 'pages/report_diy/index.jsp'
	} ]
}, {
	name : '视频监控',
	value : 'pages/sp_p',
	open : false,
	nodes : [ {
		name : '视频监控',
		value : 'pages/sp/list.jsp'
	}, {
		name : '视频设置',
		value : 'pages/system/sp/form.jsp'
	} ]
}, {
	name : '意见反馈',
	value : 'pages/advice_p',
	open : false,
	nodes : [ {
		name : '意见反馈',
		value : 'pages/advice/advice.jsp'
	}, {
		name : '意见查询',
		value : 'pages/advice/query_advice.jsp'
	} ]
}, {
	name : '系统设置',
	value : 'pages/system_p',
	open : false,
	nodes : [ {
		name : '修改密码',
		value : 'pages/home/pwd_edit.jsp'
	}, {
		name : '部门管理',
		value : 'pages/system/tab_dept/tab_dept_query.jsp'
	}, {
		name : '用户管理',
		value : 'pages/system/user/user_query.jsp'
	}, {
		name : '站位管理',
		value : 'pages/system/station/q_form.jsp'
	}, {
		name : '行业管理',
		value : 'pages/system/trade/trade_query.jsp'
	} ]
} ];
