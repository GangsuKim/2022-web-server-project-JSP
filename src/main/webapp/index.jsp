<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BEAN 공간 | 당신의 빈 공간, BEAN 공간으로</title>

<!-- Local Style Sheet -->
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/fonts.css">
<link rel="stylesheet" href="./css/addCafe.css">
<link rel="stylesheet" href="./css/user.css">
<link rel="stylesheet" href="./css/footer.css">

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- Bootstrap ICON -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
	
	<%
		// Check login data
		String logined = (String) session.getAttribute("logined");
		String admin = (String) session.getAttribute("admin");
		if (logined == null) {
			logined = "false";
		} else if (logined.equals("true")) {
			logined = "true";
		}
	%>
</head>

<body>
	<main>
		<div class="leftDiv">
			<div id="map" style="width: 100%; height: 100%; z-index: 0;"></div>
			<div class="toolTip" id="mapToolTip" hidden></div>
		</div>

		<div class="rightBarDiv">
			<%@ include file="dbconn.jsp"%>
			<%
			request.setCharacterEncoding("euc-kr");
			String area = request.getParameter("area");
			String setHidden = "";

			// out.print(area);

			if (area == null) {
				area = "0";
				setHidden = "hidden";
			}

			ResultSet rs = null;
			Statement stmt = null;
			String name = "";

			try {
				String sql = "Select * from areaname WHERE id=" + area;
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					name = rs.getString("name");
				}
			} catch (SQLException ex) { // EXCEPTION
				out.println("AreaName 테이블 선택이 실패했습니다.");
				out.println("SQLException : " + ex.getMessage());
			}
			%>
			<div class="mainTextDiv">BEAN 공간</div>

			<div class="mainRightList" <%=setHidden%>>
				<div class="districtName">
					<%=name%>
				</div>

				<%
				rs = null;
				stmt = null;
				int cnt = 0;

				try {
					String sql = "Select * from cafes WHERE area=" + area;
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql);
					String cafe_id = request.getParameter("cafeId");

					while (rs.next()) {
						String cafeName = rs.getString("name");
						String cafeAddr = rs.getString("addr");
						float cafeStar = rs.getFloat("stars");
						String cafeTag = rs.getString("tags");
						int cafeId = rs.getInt("id");
						int verifed = rs.getInt("verified");
						String classAdder = "";

						// 관리자의 인증이 없는 경우에 Skip
						if (verifed == 0) {
							continue;
						} else {
							cnt++;
						}
						
						// Selected Cafe
						if(cafe_id != null) {
							if(Integer.parseInt(cafe_id) == cafeId) {
								classAdder = "selected";
							}
						}

						String cafeTags[] = cafeTag.split(",");
				%>
				<div class="item <%= classAdder %>" onclick="clickOnList(<%=area%>,<%=cafeId%>)">
					<table>
						<tr>
							<th rowspan="4"><img src="./images/<%=cafeId%>.jpg"
								alt="<%=cafeName%>"></th>
						</tr>
						<tr>
							<td id="cafeTitle"><%=cafeName%> &nbsp;<span id="stars"><%=cafeStar%></span>⭐
							</td>
						</tr>
						<tr>
							<td id="cafeAddr"><%=cafeAddr%></td>
						</tr>
						<tr>
							<td id="cafeTags">
								<%
								for (int i = 0; i < cafeTags.length; i++) {
									out.print("<div class=\"tags\">" + cafeTags[i] + "</div> &nbsp;");
								}
								%>
							</td>
						</tr>
					</table>
				</div>
				<hr>
				<%
				}
				} catch (SQLException ex) {
					out.println("cafes 테이블 선택이 실패했습니다.");
					out.println("SQLException : " + ex.getMessage());
				}
				if (cnt == 0) {
				%>
				<div class="item" style="text-align: center;">등록된 카페가 없습니다</div>
				<%
				}
				%>

				<div class="addCafe" id="addCafe" hidden>
					<div class="item"
						style="background-color: #6748361f; font-size: 20px;">
						<table>
							<tr>
								<th rowspan="4"><img id="addImageShow" alt="Insert Image"
									hidden>
									<div id="clickToAddImage" title="사진 추가">+</div> <input
									type="file" id="addCafeImage" accept="image/*"
									onchange="addCafeImage(this)" hidden></th>
							</tr>
							<tr>
								<td id="AddCafeTitle">카페명</td>
							</tr>
							<tr>
								<td id="AddCafeAddr" style="font-size: 16px;">카페주소</td>
							</tr>
							<tr>
								<td id="AddCafeTags" style="font-size: 16px;">
									<div class="tags">태그</div>
								</td>
							</tr>
						</table>
					</div>

					<form action="addCafe.jsp" method="POST">
						<div style="height: 10px;"></div>
						<a class="cafeNameTitle">카페명</a> <br>
						<input type="text" class="cafeInput" id="cafeNameInput" name="c_name">
						<a class="cafeNameTitle">주소</a> <br> 
						<input type="text" class="cafeInput" id="cafeAddrInput" name="c_addr">
						<a class="cafeNameTitle">태그 <span style="color: rgba(0, 0, 0, 0.5);">( , 로 구분)</span></a> <br>
						<input type="text" class="cafeInput" id="cafeTagInput" name="c_tags">
						<a class="cafeNameTitle">한줄평</a> <br> 
						<input type="text" class="cafeInput" id="cafeOneLineInput" name="c_line">
						<input tpye="text" name="c_area" value="<%=area%>" hidden>
						<input type="submit" value="전송" id="addCafeToDB" hidden>
					</form>

					<div class="addCafeDone" id="addCafeDone">카페 등록 신청</div>
				</div>

				<div class="addMore">
					<div class="addButton alignCenter" id="addCafeBtn">카페 추가하기</div>
				</div>
			</div>
		</div>
		
		<%
			if(logined.equals("false")) {
				%>
					<div class="userBtn" id="userBtn" onclick="location.href='./login.html';">
			            <i class="bi bi-person-fill"></i>
			        </div>
				<%
			} else {
				if(admin.equals("true")) {
					%>
				        <div class="MyBtn" id="MyBtn" onclick="location.href='./admin.jsp'">
				            관리자
				        </div>
				        
						<div class="logoutBtn" id="logoutBtn" style="left: 110px;" onclick="location.href='./logout.jsp'">
				            LOGOUT
				        </div>
					<%	
				} else {
					%>
				        <div class="MyBtn" id="MyBtn">
				            My
				        </div>
				        
				        <div class="logoutBtn" id="logoutBtn" onclick="location.href='./logout.jsp'">
				            LOGOUT
				        </div>
					<%	
				}
			}
		%>
	</main>

	<%
	String cafeId = request.getParameter("cafeId");
	String articelStyle = "";
	
	if (cafeId == null) {
		articelStyle = "style=\"display: none;\"";
	}
	%>

	<article <%=articelStyle%>>
		<div class="innerDiv">
			<%
			rs = null;
			stmt = null;
			String cafeName = "", cafeAddr = "", cafeTag = "", cafeOpen = "", cafeOneLine = "", breakStr = "";
			float cafeStar = 0;
			int price = 0;

			try {
				String sql = "Select * from cafes WHERE id=" + cafeId;
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					cafeName = rs.getString("name");
					cafeAddr = rs.getString("addr");
					cafeStar = rs.getFloat("stars");
					cafeTag = rs.getString("tags");
					cafeOpen = rs.getString("open");
					cafeOneLine = rs.getString("oneline");
					breakStr = rs.getString("break");
					price = rs.getInt("espPrice");
				}
				
				// 잘못된 접근 (검색된 카페가 없음)
				if (cafeId != null && price == 0) {
					out.print("<script>location.href='./?area=" + area + "'</script>");
				}
			} catch (SQLException ex) { // EXCEPTION
				out.println("cafes 테이블 선택이 실패했습니다.");
				out.println("SQLException : " + ex.getMessage());
			}
			
			%>
			<a id="articletitle"><%=cafeName%> <span id="stars"><%=cafeStar%></span>⭐</a>
			<br>

			<%
			String cafeTags[] = cafeTag.split(",");
			for (int i = 0; i < cafeTags.length; i++) {
				out.print("<div class=\"tags\" style=\"font-size: 2vw;\">" + cafeTags[i] + "</div> &nbsp;");
			}
			%>
			<hr style="margin: 20px 0px;">
			<%
				if(cafeOneLine.length() != 0) {
					%>
						<div class="comment">
							"<%=cafeOneLine%>" <br> <a class="commentDes"> 에디터 한줄평 </a>
						</div>
					<%
				}
			%>

			<div class="seperater">
				<div class="inner">
					<img src="./images/<%= cafeId %>.jpg" alt="<%= cafeName %> 전경" width="100%">
				</div>
				<div class="inner">
					<a id="times"><span class="timesTitle"><i
							class="bi bi-clock-history"></i> <span>영업시간</span></span> <%=cafeOpen%></a>
					<a id="break"><span class="timesTitle"><i
							class="bi bi-calendar-check"></i> <span>휴일</span></span> <%= breakStr %></a> <a
						id="break"><span class="timesTitle"><i
							class="bi bi-cup-straw"></i> <span style="font-size: 1.6vw;">아메리카노</span></span>
						<%=price%>원</a>
				</div>
			</div>

			<!-- SHOW reviews -->
			<a id="reviewTitle">사용자 후기 <span id="stars"><%=cafeStar%></span>⭐ <a class="reviewCnt">0</a>
			</a>
			<hr style="margin: 5px 20px 20px 20px;">

			<div class="reviews">
				<!-- SET -->
				<%
					rs = null;
					stmt = null;
					String r_values = "", r_writer = "", r_date = "";
					float r_star = 0;
					int c_id = 0, r_id = 0, r_cnt = 0;
	
					try {
						String sql = "Select * from reviews WHERE c_id=" + cafeId;
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql);
	
						while (rs.next()) {
							c_id = rs.getInt("c_id");
							r_id = rs.getInt("r_id");
							r_star = rs.getInt("stars");
							r_values = rs.getString("r_values");
							r_writer = rs.getString("writer");
							r_date = rs.getString("date");
							r_cnt++;
							%>
							
							<div class="userReview">
								<a class="userName"><%= r_writer %></a> <span class="starShow">
									<%
										for (int i = 0; i < r_star; i++) {
											out.print("<i class='bi bi-star-fill fill'></i>&nbsp");
										}
										for (int i = 0; i < 5 - r_star; i++) {
											out.print("<i class='bi bi-star-fill'></i>&nbsp");
										}
									%>
								</span> <a class="userDate"><%= r_date %></a> <br> <a
									class="userReviewValue"><%= r_values %></a>
							</div>
							
							<%
						}
					} catch (SQLException ex) { // EXCEPTION
						out.println("AreaName 테이블 선택이 실패했습니다.");
						out.println("SQLException : " + ex.getMessage());
					}  finally {
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
					
					if(r_cnt == 0) {
						out.print("<div class=\"noReview\">작성된 리뷰가 없습니다.</div>");
					}
					
					out.print("<script>document.querySelector('.reviewCnt').innerHTML = '" + r_cnt + "'</script>");
				%>
				<div class="writeReview" id="writeReview">
					<i class="bi bi-pencil-square"></i> 리뷰 쓰기
				</div>
			</div>
		</div>
		
		<div class="write_review_window" id="write_review_window" hidden>
            <form action="review.jsp" method=POST>
            	<% 
            		if(logined.equals("true")) {
            			out.print("<input type=\"text\" name=\"r_name\" id=\"r_name\" value=\"" + session.getAttribute("userName") + "\" readonly>");
            		} else {
            			out.print("<input type=\"text\" name=\"r_name\" id=\"r_name\" placeholder=\"닉네임\">");
            		}
            	%>
                
                <div class="starbox">
                    <i class="bi bi-star-fill" id="0"></i>
                    <i class="bi bi-star-fill" id="1"></i>
                    <i class="bi bi-star-fill" id="2"></i>
                    <i class="bi bi-star-fill" id="3"></i>
                    <i class="bi bi-star-fill" id="4"></i>
                </div>
                <textarea name="r_review" id="r_review" cols="30" rows="10" placeholder="방문 후기를 적어주세요!"></textarea>
                <input type="submit" value="작성하기">
                <input type="number" name="r_star" id="r_star" value="-1" hidden>
                <input type="number" name="r_area" id="r_area" value="<%= area %>" hidden>
                <input type="number" name="r_cafeid" id="r_cafeid" value="<%= cafeId %>" hidden>
            </form>
        </div>
	</article>
	
	<footer <%=articelStyle%>>
        <a id="footerMain">BEAN 공간</a> <br>
        <a id="footerDes">2022년도 1학기 웹서버구축 기말프로젝트 <br>20205116 김강수 </a>
    </footer>
	
	<!-- KAKAO MAP API -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=03b766d9319c5acf32c24de7281e3949"></script>
	<script src="./js/map.js"></script>
	<script src="./js/addCafe.js"></script>
	<script src="./js/review.js"></script>
</body>

</html>