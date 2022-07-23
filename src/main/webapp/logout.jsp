<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>로그아웃 | BEAN 공간</title>
	</head>
	
	<body>
		<%
			session.removeAttribute("logined");
			session.removeAttribute("userName");
			out.println("<script>location.href='./';</script>");
		%>
	</body>
</html>