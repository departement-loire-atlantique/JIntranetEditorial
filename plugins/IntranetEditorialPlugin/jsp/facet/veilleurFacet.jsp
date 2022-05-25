<%@ include file='/jcore/doInitPage.jsp' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%
%><%!

 public boolean inArray(String[] array, String value) {
    if (Util.notEmpty(array)) {
      for (String string : array) {
        if (string.equals(value)) {
          return true;
        }
      }
    }
    return false;
  }
%>

<%

Group documentation = channel.getGroup("$id.jcmsplugin.intraneteditorial.jmag.veilleur.documentation.group");
Group innovation = channel.getGroup("$id.jcmsplugin.intraneteditorial.jmag.veilleur.innovation.group");
Group contentieux = channel.getGroup("$id.jcmsplugin.intraneteditorial.jmag.veilleur.contentieux.group");

String[] groupAuthorFilter = request.getParameterValues("veilleurGroupIds");

%>

<div class="separator"></div>

<div class="form-group widget field-enumerate">
       
                
	<div class="control-label col-md-3 clearfix" min-width="90%" style="padding-bottom: 5px;">                
	      <span class="jalios-label-addon"></span>
	      <label>Recherche par veilleur</label>             
	</div>
   
	<%-- *** GROUPE AUTEUR ************************************** --%>
	<ul class="unstyled categories">
		<li class=""><input id="<%= documentation.getId() %>" name="veilleurGroupIds" value="<%= documentation.getId() %>"
			type="checkbox" <% if(inArray(groupAuthorFilter, documentation.getId())){%> checked <%}; %>><label for="documentation.getId()"><%= documentation.getName() %></label>
		</li>
		<li class=""><input id="<%= innovation.getId() %>" name="veilleurGroupIds" value="<%= innovation.getId() %>"
			type="checkbox" <% if(inArray(groupAuthorFilter, innovation.getId())){%> checked <%}; %>><label for="p1_149585"><%= innovation.getName() %></label>
		</li>
		<li class=""><input id="<%= contentieux.getId() %>" name="veilleurGroupIds" value="<%= contentieux.getId() %>"
			type="checkbox" <% if(inArray(groupAuthorFilter, contentieux.getId())){%> checked <%}; %>><label for="<%= contentieux.getId() %>"><%= contentieux.getName() %></label>
		</li>
	</ul>
	
	
	<%-- *** MEMBRE AUTEUR ************************************** --%>
    <% Member dsgMember = (Member) channel.getMember(request.getParameter("mids")); %>
    <jalios:field  name="mids" value='<%= dsgMember %>' resource="field-vertical">
      <jalios:control settings='<%= new MemberSettings().filter(MemberSettings.MemberFilter.ACCOUNT).placeholder("autre veilleur") %>' />
    </jalios:field>

	

</div>