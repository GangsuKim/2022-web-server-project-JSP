<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>ī�� ���� | BEAN����</title>
	</head>	
	<body>
		<%@ include file="dbconn.jsp"%>
		<%
			String id = request.getParameter("id");
			
			ResultSet rs = null;
			PreparedStatement pstmt = null;

			try {
				String sql = "DELETE FROM cafes WHERE id=" + id + ";";
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
			} catch (SQLException ex) { // EXCEPTION
				out.println("AreaName ���̺� ������ �����߽��ϴ�.");
				out.println("SQLException : " + ex.getMessage());
			}  finally {
				if (rs != null) {
					rs.close();
				}

				if (pstmt != null) {
					pstmt.close();
				}

				if (conn != null) {
					conn.close();
				}
				
				out.println("<script>alert('���� �Ϸ� �Ǿ����ϴ�.'); location.href='./admin.jsp';</script>");
			}
		%>
	</body>
</html>