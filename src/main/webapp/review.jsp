<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="EUC-KR">
		<title>리뷰 등록 | BEAN 공간</title>	
	</head>
	
	<body>
		<%@ include file="dbconn.jsp"%>
		<%@ page import="java.util.Date" %>
		<%@ page import="java.text.SimpleDateFormat" %>
		<%
			request.setCharacterEncoding("utf-8");
			String name = request.getParameter("r_name");
			String review = request.getParameter("r_review");
			String star = request.getParameter("r_star");
			String area = request.getParameter("r_area");
			String cafeid = request.getParameter("r_cafeid");
			
			if(Integer.parseInt(area) < 10) {
				area = "0" + area;
			}
			
			if(Integer.parseInt(cafeid) < 1000) {
				cafeid = "0" + cafeid;
			}
			
			ResultSet rs = null;
			Statement stmt = null;
			int cnt = 0; // Review 개수
			int starAdd = 0;

			// 특정 Cafe의 Review 개수 확인 및 모든 평점 합산
			try {
				String sql = "Select stars from reviews WHERE c_id=" + cafeid;
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					starAdd += rs.getInt("stars");
					cnt++;
				}
			} catch (SQLException ex) { // EXCEPTION
				out.println("Area 테이블 선택이 실패했습니다.");
				out.println("SQLException : " + ex.getMessage());
			}
			
			cnt++; // 새로운 리뷰 추가
			String cntStr = Integer.toString(cnt);
			double doneStar = (starAdd + Integer.parseInt(star)) / (double) cnt; // 전체 평점 재 계산 
			
			for (int i = cntStr.length(); i < 4; i++) {
				cntStr = "0" + cntStr;
			}
			
			// For Insert data by SQL
			PreparedStatement pstmt = null;
			Date nowTime = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			try {
				String sql = "UPDATE cafes SET stars = " + (Math.round(doneStar * 10) / 10.0) + ", r_cnt=" + cnt + " WHERE id = " + cafeid;
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
			} catch (SQLException ex) {
				out.println("Cafes 테이블 삽입이 실패했습니다.");
				out.println("SQLException : " + ex.getMessage());
			}
			
			try {
				String sql = "INSERT INTO reviews (area, c_id, r_id, stars, r_values, writer, date) VALUES(?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, area);
				pstmt.setString(2, cafeid);
				pstmt.setString(3, cafeid + cntStr);
				pstmt.setInt(4, Integer.parseInt(star));
				pstmt.setString(5, review);
				pstmt.setString(6, name);
				pstmt.setString(7, sf.format(nowTime));
				pstmt.executeUpdate();
				
				out.println("<script>alert('리뷰 등록이 완료되었습니다.'); location.href='./?area=" + Integer.parseInt(area) + "&cafeId=" + Integer.parseInt(cafeid) + "';</script>");
			} catch (SQLException ex) {
				out.println("Reviews 테이블 삽입이 실패했습니다.");
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