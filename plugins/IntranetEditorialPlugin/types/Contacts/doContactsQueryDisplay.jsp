<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Contacts obj = (Contacts)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>

<div class="fullDisplay Contacts <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>">

    <%@ include file="doContactsList.jspf" %>

</div>