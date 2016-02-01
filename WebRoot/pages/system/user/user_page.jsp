<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<HTML>
<%
	try {
		SysAclUtil.user_res_view(request);
	} catch (Exception e) {
		w.error(e);
		return;
	}

	RowSet rs = w.rs("list");
	String user_id = w.get("user_id");

	String page_url = w.get("page_url");
%>
<input type="hidden" value="<%=page_url%>" id="page_url">
<HEAD>

<link rel="stylesheet" href="../../../web/index.css" />
<style type="text/css">
.tj1 {
	height: 30px;
	line-height: 30px;
	font-weight: bold;
	margin-left: 80px;
}
</style>

<link rel="stylesheet" href="user_page/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript" src="user_page/jquery-1.4.2.js"></script>
<script type="text/javascript" src="user_page/jquery.ztree-2.6.js"></script>
<script type="text/javascript" src="user_page/pageData.js"></script>
<script type="text/javascript" src="user_page/pageTools.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var zTree1;
	var setting;

	setting = {
		checkable : true,
		checkType : {
			"Y" : "ps",
			"N" : "ps"
		}
	};

	$(document).ready(function() {
		refreshTree();
	});

	function refreshTree() {
		zTree1 = $("#pageTree").zTree(setting, clone(zNodes));

		var page_urls = document.getElementById("page_url").value.split(",");
		var node;
		for (x in page_urls) {
			node = zTree1.getNodeByParam("value", page_urls[x]);
			node.checked = true;
		}
		zTree1.refresh();
	}

	function getUserPage() {
		var nodes = zTree1.getCheckedNodes();
		var page_urls = new Array();
		for (x in nodes) {
			page_urls[x] = nodes[x].value;
		}
		document.getElementById("url").value = page_urls.join(",");
	}
</SCRIPT>

</HEAD>

<BODY>
	<div style="margin:20px 10px 10px 110px;">
		<div>
			<p style="font-size: 13px;">
				<a href="javascript: zTree1.expandAll(true);">展开</a> | <a
					href="javascript: zTree1.expandAll(false);">折叠</a> | <a
					href="javascript: zTree1.checkAllNodes(true);">全选</a> | <a
					href="javascript: zTree1.checkAllNodes(false);">不选</a>
			</p>
		</div>
		<div>
			<ul id="pageTree" class="tree"></ul>
		</div>
	</div>
	<form action="user_page/user_page_update.jsp" method="post">
		<input type=hidden name='user_id' value='<%=user_id%>'> <input
			type="hidden" value="" id="url" name="page_url"><input
			type="submit" value="保存" class="tiaojianbutton tj1"
			onclick="getUserPage();" /><input type="button" value="返回"
			class="tiaojianbutton tj1" onclick="history.back()" />
	</form>
</BODY>
</HTML>
