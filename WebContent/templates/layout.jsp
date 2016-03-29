<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/struts-jquery-tags" prefix="jq"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Red Social">
<meta name="author" content="Jorge Jimenez">
<title>Socializing - La Nueva Red Social</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/logo.png">
<!-- Bootstrap Core CSS -->
<link
	href="${pageContext.request.contextPath}/flatlab/update/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/flatlab/update/bootstrap-reset.css"
	rel="stylesheet">
<!--External CSS-->
<link
	href="${pageContext.request.contextPath}/flatlab/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<!-- Custom Styles For This Template -->
<link href="${pageContext.request.contextPath}/flatlab/css/animate.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/flatlab/update/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/flatlab/update/style-responsive.css"
	rel="stylesheet" />
<jq:head locale="es" jqueryui="true" jquerytheme="flick" />
<script
	src="${pageContext.request.contextPath}/flatlab/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/jquery.dcjqaccordion.2.7.min.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/jquery.nicescroll.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/jquery.scrollTo.min.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/assets/humanize-duration/humanize-duration.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/assets/moment/min/moment.min.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/autocomplete.js"></script>
<script type="text/javascript">
	$(function() {
		$("html").niceScroll({
			styler : "fb",
			cursorcolor : "#FF6C60",
			cursorwidth : '6',
			cursorborderradius : '10px',
			background : '#404040',
			spacebarenabled : false,
			cursorborder : '',
			zindex : '1000'
		});
	});
</script>
</head>
<body>
	<section id="container"> <tiles:insertAttribute name="header" />
	<tiles:insertAttribute name="menu" /> <section id="main-content">
	<section class="wrapper"> <tiles:insertAttribute
		name="content" /> </section> </section> </section>
</body>
</html>