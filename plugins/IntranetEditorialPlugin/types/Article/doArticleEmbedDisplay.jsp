<%@ include file='/jcore/doInitPage.jspf' %><%
Article pub = (Article)request.getAttribute(PortalManager.PORTAL_PUBLICATION);

%><%@ include file='/front/doFullDisplay.jspf' %>

<div class="fulldisplay <%= Article.class.getSimpleName() %>">

	<article class="row-fluid">	
		<section class="col-md-12">
			<h1><%= pub.getTitle() %></h1>	
			<jalios:thumbnail path="<%= pub.getPicture() %>" width="240" height="240"/>
			<jalios:wysiwyg><%= pub.getContent() %></jalios:wysiwyg>
		</section>
	</article>
</div>