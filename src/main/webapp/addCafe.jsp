<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카페 추가 | BEAN 공간</title>
</head>

<body>
	<%@ include file="dbconn.jsp"%>
	<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("c_name");
	String addr = request.getParameter("c_addr");
	String tags = request.getParameter("c_tags");
	String oneLine = request.getParameter("c_line");
	String area = request.getParameter("c_area");

	ResultSet rs = null;
	Statement stmt = null;
	int cnt = 0; // Cafe 개수

	// 특정 Area의 Cafe 개수 확인
	try {
		String sql = "Select * from cafes WHERE area=" + area;
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			cnt++;
		}
	} catch (SQLException ex) { // EXCEPTION
		out.println("Area 테이블 선택이 실패했습니다.");
		out.println("SQLException : " + ex.getMessage());
	}

	// For Insert data by SQL
	PreparedStatement pstmt = null;

	try {
		String sql = "INSERT INTO cafes (area, id, name, addr, stars, tags, oneline, espPrice, verified, r_cnt, break) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, area);
		pstmt.setString(2, (((cnt < 10) ? area + "0" : area) + Integer.toString(cnt + 1)));
		pstmt.setString(3, name);
		pstmt.setString(4, addr);
		pstmt.setFloat(5, 0);
		pstmt.setString(6, tags);
		pstmt.setString(7, oneLine);
		pstmt.setInt(8, 0);
		pstmt.setInt(9, 0);
		pstmt.setInt(10, 0);
		pstmt.setString(11, "");
		pstmt.executeUpdate();
		
		out.println("<script>alert('카페 신청이 완료되었습니다.'); location.href='./';</script>");
	} catch (SQLException ex) {
		out.println("Area 테이블 삽입이 실패했습니다.");
		out.println("SQLException : " + ex.getMessage());
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