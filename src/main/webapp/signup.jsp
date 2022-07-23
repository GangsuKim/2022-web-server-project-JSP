<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������ | BEAN ����</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
	request.setCharacterEncoding("utf-8");

	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	String name = request.getParameter("name");
	String email = request.getParameter("email");

	// For Insert data by SQL
	PreparedStatement pstmt = null;

	try {
		String sql = "INSERT INTO userdb (id, passwd, email, name, reviews, admin) VALUES(?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, userId);
		pstmt.setString(2, userPw);
		pstmt.setString(3, email);
		pstmt.setString(4, name);
		pstmt.setInt(5, 0);
		pstmt.setInt(6, 0);
		pstmt.executeUpdate();

		out.println("<script>alert('ȸ�������� �Ϸ�Ǿ����ϴ�.'); location.href='./login.html';</script>");
	} catch (SQLException ex) {
		out.print("<script>alert('�̹� �����ϴ� ���̵� �Դϴ�.'); history.back()</script>");
	} finally {
		if (pstmt != null) {
			pstmt.close();
		} else {
			conn.close();
		}
	}
	%>
</body>
</html>