<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>카페 삭제 | BEAN공간</title>
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
				out.println("AreaName 테이블 선택이 실패했습니다.");
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
				
				out.println("<script>alert('삭제 완료 되었습니다.'); location.href='./admin.jsp';</script>");
			}
		%>
	</body>
</html>