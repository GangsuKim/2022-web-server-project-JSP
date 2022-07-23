<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>로그인 | BEAN 공간</title>
	</head>
	
	<body>
		<%@ include file="dbconn.jsp"%>
		<%
			request.setCharacterEncoding("euc-kr");
			String userId = request.getParameter("userId");
			String userPw = request.getParameter("userPw");
			
			ResultSet rs = null;
			Statement stmt = null;

			try {
				String sql = "select * from userdb WHERE id='" + userId + "'";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);

				if (rs.next()) {
					String dbPW = rs.getString("passwd");
					
					if (userPw.equals(dbPW)) {
						// 로그인 성공
						session.setAttribute("logined", "true");
						session.setAttribute("userName", rs.getString("name"));
						
						if(rs.getInt("admin") == 1) {
							session.setAttribute("admin", "true");
						} else {
							session.setAttribute("admin", "false");
						}
						
						%>
							<script> 
								location.href = './';
							</script>
						<%
					} else {
						// 로그인 실패
						out.println("로그인 실패");
						%>
							<script> 
								location.href = './login.html?login=failed';
							</script>
						<%
					}
				} else {
					out.println("로그인 실패");
					%>
						<script> 
							location.href = './login.html?login=failed';
						</script>
					<%
				}
			} catch (SQLException ex) { // EXCEPTION
				out.println("userDB 테이블 선택이 실패했습니다.");
				out.println("SQLException : " + ex.getMessage());
			} finally {
				if (rs != null) {
					rs.close();
				}

				if (stmt != null) {
					stmt.close();
				}

				if (conn != null) {
					conn.close();
				}
			}
		%>
	</body>
</html>