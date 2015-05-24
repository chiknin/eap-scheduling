<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/views/common/jsp-header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title><decorator:title>调度管理中心</decorator:title></title>
<%@include file="segment/page-resources.jsp"%>
<decorator:head />
</head>
<body class="main <decorator:getProperty property="body.class" writeEntireProperty="false" />">
<decorator:body />
<%@include file="/WEB-INF/views/common/jsp-footer.jsp"%>
</body>
</html>