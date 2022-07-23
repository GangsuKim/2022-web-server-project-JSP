<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">	
		<title>카페 승인 | BEAN 공간</title>
	</head>
	
	<body>
		<%@ include file="dbconn.jsp"%>
		<%
			request.setCharacterEncoding("euc-kr");
			String esp = request.getParameter("cafeEsp");
			String open = request.getParameter("cafeOpen");
			String id = request.getParameter("cafeID");
			String breakDay = request.getParameter("breakDay");
			
			ResultSet rs = null;
			PreparedStatement pstmt = null;

			try {
				String sql = "UPDATE cafes SET verified=1, open='" + open + "', espPrice='" + esp + "', break='" + breakDay + "' WHERE id=" + id + ";";
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
			} catch (SQLException ex) { // EXCEPTION
				out.println("Cafes 테이블 선택이 실패했습니다.");
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
				
				out.println("<script>alert('승인 완료 되었습니다.'); location.href='./admin.jsp';</script>");
			}
		%>
	</body>
</html>