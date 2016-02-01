<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%
	try
	{
		ReportUpdate.report_index(request);
	}
	catch(Exception e)
	{
		w.error(e);
		return;
	}
	RowSet rs = w.rs("paramList");
	String type = w.get("type");
%>
<html>
<head>
<style>
	body,table,tr{
		background:#ffffff;
	}
	tr{
		padding:0px;
		margin:0px;
	}
	select{
		width:146px;
	}
</style>
</head>
<body onload="fill_opt()">
<form name="form2" method="post" action="stationlist.jsp" target="station_frm">
<input type="hidden" name="num" value="<%=rs.size() %>" />
<input type="hidden" name="stOption" value="<%=w.get("stations") %>" />
<table width="100%" border="0" height="100%">
	<tr style="height:100%">
		<td width=25% height="100%">
			<table border="0" cellspacing="0" height="100%">
				<tr><td colspan="4"><select name="area_id" onchange="f_s()" style="width:100%"><%=w.get("areaOption") %></select></td></tr>
				<tr><td colspan="4"><select name="station_type" onchange="f_t()" style="width:100%"><%=w.get("stationTypeOption") %></select></td></tr>
				<tr><td colspan="4"><select name="ctl_type" onchange="f_s()" style="width:100%"><option value="null">重点源属性</option><%=w.get("ctlTypeOption") %></select></td></tr>
				<tr><td colspan="4"><select name="valley_id" onchange="f_s()" style="width:100%"><option value="null">请选择流域</option><%=w.get("valleyOption") %></select></td></tr>
				<tr><td colspan="4"><select name="trade_id" onchange="f_s()" style="width:100%"><option value="null">请选择行业</option><%=w.get("tradeOption") %></select></td></tr>
				<tr><td colspan="4">站位名称:<input type="text" onblur="f_s()" name="station_name" value="<%=w.get("station_name") %>" style="width:100%" /></td></tr>
				<tr style="height:50%"><td colspan="4"><iframe height="100%" id="station_frm" width="100%" src="stationlist.jsp?station_type=<%=w.get("station_type") %>&area_id=<%=w.get("area_id") %>&valley_id=<%=w.get("valley_id") %>&trade_id=<%=w.get("trade_id") %>" name="station_frm" frameborder="0"></iframe></td></tr>
				<tr><td><input type="button" value="添加" onclick="add_select()" class="btn" /></td><td><input type="button" value="删除" onclick="move_select()" class="btn" /></td><td><input type="button" value="添加全部" onclick="add_all()" class="btn" /></td><td><input type="button" value="删除全部" onclick="move_all()" class="btn" /></td></tr>
				<tr><td colspan="4"><select style="width:100%" multiple size="7" id="station_ids" name="station_ids"></select></td></tr>
			</table>
		</td>
		<td>
			<table height="100%">
				<input type="hidden" name="stations" />
				<tr height="25px" valign="top">
					<td colspan="2">报表类型:
					<select name="type" id="type" onchange="t_change(this.value)">
						<%=w.get("typeOption") %>
					</select>
					</td>
				</tr>
				<tr height="25px">
					<td colspan="2">
					<div id="hour">时间段:
						<input type="text" name="date1" value="<%=w.get("date1") %>" style="width:80px" onclick="new Calendar().show(this);" />
						<select name="hour1" id="hour1" style="width:40px"><%=w.get("hourOption1") %></select>
						<input type="text" name="date2" value="<%=w.get("date2") %>" style="width:80px" onclick="new Calendar().show(this);" />
						<select name="hour2" id="hour2" style="width:40px"><%=w.get("hourOption2") %></select>
					</div>
					<div id="dis_hour" style="display:none">时间段:
						<input type="text" name="date3" value="<%=w.get("date1") %>" style="width:80px" onclick="new Calendar().show(this);" />
						<input type="text" name="date4" value="<%=w.get("date2") %>" style="width:80px" onclick="new Calendar().show(this);" />
					</div>
					</td>
				</tr>
				<%
					int i=0;
					while(rs.next())
					{
					i++;
				%>
					<tr height="25px" id="zq<%=i %>" style="display:<%=ReportUtil.getZQ_BScss(type,"zq")%>">
					<td width="25%" style="padding-left:50px;">
						<input type="checkbox" checked name="col" id="col<%=i %>" value="<%=rs.get("infectant_column").toLowerCase() %>" /><%=rs.get("infectant_name") %>
					</td>
					<td style="display:<%=ReportUpdate.getValueDisplay(type) %>">
						值区间:&nbsp;&nbsp;
						<input type="text" id="xv<%=i %>" name="v_<%=rs.get("infectant_column").toLowerCase() %>_lo"/>
						&nbsp;&nbsp;<input id="dv<%=i %>" type="text" name="v_<%=rs.get("infectant_column").toLowerCase() %>_hi"/>
					</td>
					</tr>
					<tr height="25px" id="bs<%=i %>" style="display:<%=ReportUtil.getZQ_BScss(type,"bs")%>">
					<td width="21%" style="padding-left:50px">
						<input type="checkbox" checked name="bs_col" id="bs_col<%=i %>" value="<%=rs.get("infectant_column").toLowerCase() %>" /><%=rs.get("infectant_name") %>
					</td>
					<%
						if(rs.get("infectant_name").equals("PH"))
						{
					%>
					<td>
						&nbsp;值区间:&nbsp;&nbsp;&nbsp;
						<input type="text" id="xv<%=i %>" name="bs_<%=rs.get("infectant_column").toLowerCase() %>_lo"/>
						&nbsp;&nbsp;<input id="dv<%=i %>" type="text" name="bs_<%=rs.get("infectant_column").toLowerCase() %>_hi"/>
					</td>
					<%
						}
						else
						{
					%>
					<td>
						超标倍数:&nbsp;&nbsp;
						<input type="text" id="xv<%=i %>" name="bs_<%=rs.get("infectant_column").toLowerCase() %>"/>
					</td>
					<%}%>
					</tr>
				<%
					}
				%>
				<tr height="40px">
					<td colspan="2"><input type="button" value="制作报表" onclick="m_bb()" class="btn" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</td>
	</tr>
</table>	
</form>	
</body>
<script>
	function f_r()
	{
		form2.action = "index.jsp";
		form2.target="";
		form2.submit();
	}
	function f_t()
	{
		form2.stOption.value="";
		form2.action = "index.jsp";
		form2.target="";
		form2.submit()
	}
	function m_bb()
	{
		var stations = document.getElementById("station_ids").options;
		var type=form2.type.value;
		var num = form2.num.value;
		var ids = "";
		for(var i=0;i<stations.length;i++)
		{
			if(ids=="")
			{
				ids=stations[i].value;
			}
			else
			{
				ids = ids + ","+stations[i].value;
			}
		}
		if(ids=="")
		{
			alert("请选择监测点！");
		}
		else
		{
			form2.stations.value=ids;
		}
		var c = false;
		for(var i=1;i<=num;i++)
		{
 			var t = form2.type.value;
			var mark = "";
			if(t=="tj_up")
			{
				mark = "bs_col";
			}
			else
			{
				mark = "col";
			}
			var col = document.getElementById(mark+i);
			if(col.checked)
			{
				c = true;
				break;
			}
		}
		var b = isDigit();
		if(c==false)
		{
			alert("请选择监测指标！");
		}
		if(b&&c){
		var sel = document.getElementById("station_ids");
		var options = sel.options;
		var value = "";
		for(var k=0;k<options.length;k++)
		{
			var option = options[k];
			var v = option.value;
			var t = option.text;
			if(value=="")
			{
				value = v+","+t;
			}
			else
			{
				value = value+";"+v+","+t;
			}
		}
		form2.stOption.value=value;
		if(ids!=""&&type=="real_hour")
		{
			form2.action="real_hour.jsp"
			form2.target="";
			form2.submit();
		}
		else if(ids!=""&&(type=="real_day"||type=="real_month"))
		{
			form2.action="real_md.jsp"
			form2.target="";
			form2.submit();
		}
		else if(ids!=""&&type=="tj_yc")
		{
			form2.action="real_yc.jsp"
			form2.target="";
			form2.submit();
		}
		else if(ids!=""&&type=="tj_up")
		{
			form2.action="real_up.jsp"
			form2.target="";
			form2.submit();
		}
		else if(ids!=""&&type=="tj_zl")
		{
			form2.action="zl_table.jsp"
			form2.target="";
			form2.submit();
		}
		else if(ids!=""&&type=="tj_zh")
		{
			form2.action="data.jsp"
			form2.target="";
			form2.submit();
		}}
		else if(!b)
		{
			alert("输入的格式不正确!");
		}
	}
	function isDigit() 
	{ 
		var num = form2.num.value;
		var b = true;
		for(var i=1;i<=num;i++)
		{
			var dv = document.getElementById("dv"+i).value;
			var xv = document.getElementById("xv"+i).value;
			if(!data_sh(dv)||!data_sh(xv))
			{
				b = false;
			}
		}
		return b;
	} 
	function data_sh(sh_data)
	{
	sh_data = sh_data.replace(".","0");
	var b = true;
	var k = 0;
	if(!sh_data) return true;
	for(var i=0;i<sh_data.length;i++)
	{
		var c = sh_data.charAt(i);
		if(isNaN(c))
		{
			b = false;
			break;
		}
		if(c=='0')
		{
			k = k+1;
		}
	}
	if(sh_data.indexOf(".",sh_data.indexOf(".")+1)>=0)
	{
		b = false;
	}
	if(k==sh_data.length)
	{
		b = false;
	}
	return b;
}

var tp = form2.type.value;
if(tp!="real_hour")
{
	hour.style.display="none";
	dis_hour.style.display="block";
}
function f_s()
{
	form2.action = "stationlist.jsp";
	form2.target = "station_frm";
	form2.submit();
}
function t_change(type)
{
	var sel = document.getElementById("station_ids");
	var options = sel.options;
	var value = "";
	for(var k=0;k<options.length;k++)
	{
		var option = options[k];
		var v = option.value;
		var t = option.text;
		if(value=="")
		{
			value = v+","+t;
		}
		else
		{
			value = value+";"+v+","+t;
		}
	}
	if(type=="tj_zl")
	{
		form2.stOption.value="";
       }
	else
	{
		form2.stOption.value=value;
	}
	f_r();
}

function add_select()
{
	var frm = document.getElementById("station_frm");
	var stations = frm.contentWindow.document.form1.stations;
	var sel = document.getElementById("station_ids");
	for(var i=0;i<stations.length;i++)
	{
		if(stations[i].checked)
		{
			var b = true;
			var va = stations[i].value;
			var te = stations[i].nextSibling.nodeValue;
			var newoption = document.createElement("option");
			newoption.value=va;
			var text = document.createTextNode(te);
			newoption.appendChild(text);
			for(var k=0;k<sel.options.length;k++)
			{
				var old = sel[k].value;
				if(old==va)
				{
					b = false;
					break;
				}
			}
			if(b==true)
			{
				sel.appendChild(newoption);
			}
		}
	}
}

function move_select()
{
	var sel = document.getElementById("station_ids");
	var num = sel.options.length;
	for(var i=0;i<sel.options.length;i++) 
	{
		var op = sel.options[i];
		if(op.selected)
		{
			sel.options.removeChild(op);
			i--;
		}
	}
}
function add_all()
{
	var frm = document.getElementById("station_frm");
	var stations = frm.contentWindow.document.form1.stations;
	var sel = document.getElementById("station_ids");
	var num = sel.options.length;
	for(var i=1;i<stations.length;i++)
	{
		var b = true;
		var va = stations[i].value;
		var te = stations[i].nextSibling.nodeValue;
		var newoption = document.createElement("option");
		newoption.value=va;
		newoption.text=te;
		for(var k=0;k<num;k++)
		{
			var old = sel[k].value;
			if(old==va)
			{
				b = false;
				break;
			}
		}
		if(b==true)
		{
			sel.add(newoption);
		}
	}
}
function move_all()
{
	var sel = document.getElementById("station_ids");
	while(sel.options.length>0)
	{
		sel.options.removeChild(sel.options[0]);
	}
}

function fill_opt()
{
	var text = form2.stOption.value;
	var sel = document.getElementById("station_ids");
	if(text)
	{
		var ops = text.split(";");
		for(var i=0;i<ops.length;i++)
		{
			var op = ops[i];
			var va = op.split(",")[0];
			var te = op.split(",")[1];
			var option = document.createElement("option");
			option.value = va;
			option.text = te;
			sel.add(option);
		}
	}
}
</script>
</html>