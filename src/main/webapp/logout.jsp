<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>�α׾ƿ� | BEAN ����</title>
	</head>
	
	<body>
		<%
			session.removeAttribute("logined");
			session.removeAttribute("userName");
			out.println("<script>location.href='./';</script>");
		%>
	</body>
</html>