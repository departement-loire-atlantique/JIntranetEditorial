<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: ContenuLibre display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%>
<%
String redirectHomeUrl = workspace.getHomeUrl(userLocale);

sendRedirect(redirectHomeUrl, request, response);
%>
