<%@page import="fr.cg44.plugin.intranetvisualidentity.util.AnnuaireUtil"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%

Group goupUo = AnnuaireUtil.renvoieGroupeFromUo(loggedMember);
String visitorGroup = goupUo != null ? goupUo.getName() : "inconnu" ;

String contentWS = workspace.getTitle();
String pageId;
String pageType;
String pageTitle;

Publication pub = (Publication) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
if(pub != null) {
    pageId = pub.getId();
    pageType = pub.getClass().getSimpleName();
    pageTitle = pub.getTitle();
}else {
    pageId = currentCategory.getId();
    pageType = "Category";
    pageTitle = currentCategory.getName();
}
%>


<script>
  dataLayer = [{
    'visitorGroup': '<%= visitorGroup %>', // si inconnu, mettre Inconnu
    'contentWS':'<%= contentWS %>', // nom de l espace de travail du contenu courant, si le contenu est une catégorie, mettre Category
    'pageId':'<%= pageId %>', // id du contenu ou de la category
    'pageType': '<%= pageType %>', // mettre Category si le contenu courrant est une catégorie
    'pageTitle':'<%= HttpUtil.encodeForJavaScript(pageTitle) %>' // titre du contenu ou de la category
  }];
</script>


<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-5SGH5H');</script>
<!-- End Google Tag Manager -->
