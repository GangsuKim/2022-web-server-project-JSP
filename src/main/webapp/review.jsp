<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="EUC-KR">
		<title>���� ��� | BEAN ����</title>	
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
			int cnt = 0; // Review ����
			int starAdd = 0;

			// Ư�� Cafe�� Review ���� Ȯ�� �� ��� ���� �ջ�
			try {
				String sql = "Select stars from reviews WHERE c_id=" + cafeid;
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					starAdd += rs.getInt("stars");
					cnt++;
				}
			} catch (SQLException ex) { // EXCEPTION
				out.println("Area ���̺� ������ �����߽��ϴ�.");
				out.println("SQLException : " + ex.getMessage());
			}
			
			cnt++; // ���ο� ���� �߰�
			String cntStr = Integer.toString(cnt);
			double doneStar = (starAdd + Integer.parseInt(star)) / (double) cnt; // ��ü ���� �� ��� 
			
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
				out.println("Cafes ���̺� ������ �����߽��ϴ�.");
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
				
				out.println("<script>alert('���� ����� �Ϸ�Ǿ����ϴ�.'); location.href='./?area=" + Integer.parseInt(area) + "&cafeId=" + Integer.parseInt(cafeid) + "';</script>");
			} catch (SQLException ex) {
				out.println("Reviews ���̺� ������ �����߽��ϴ�.");
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