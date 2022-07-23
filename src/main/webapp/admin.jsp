<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>������ ������ | BEAN ����</title>

    <link rel="stylesheet" href="./css/admin.css">
    <link rel="stylesheet" href="./css/fonts.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
    
	<%
		String logined = (String) session.getAttribute("logined");
		String admin = (String) session.getAttribute("admin");
		if (logined == null) {
			out.println("<script>location.href='./';</script>");
		} else if (!admin.equals("true")) {
			out.println("<script>location.href='./';</script>");
		}
	%>
</head>

<body>
	<%@ include file="dbconn.jsp"%>
    <main>
        <a class="topTitle">������ ������</a> <br>
        <div class="notverifiedCafeTitle">���� ��� ī��</div>
        <div class="setBox">
        
        <%
	        ResultSet rs = null;
			Statement stmt = null;
			int cnt = 0;
	
			try {
				String sql = "Select * from cafes WHERE verified=0";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
	
				while (rs.next()) {
					int id = rs.getInt("id"); // Cafe ID
					String name = rs.getString("name"); // Cafe Name
					String addr = rs.getString("addr"); // Cafe address
					String tags = rs.getString("tags"); // Cafe tags
					String oneline = rs.getString("oneline");
					cnt++;
					
					%>
						<div class="readyCafeBox">
			                <table>
			                    <tbody>
			                        <tr>
			                            <td>
			                                <img src="./images/projBold.jpg" alt="CafeImage">
			                            </td>
			                            <td class="cafeDetails">
			                                <a id="cafeTitle"><%=name %></a> | <a id="cafeTags"><%= tags %></a>
			                                <br>
			                                <a id="cafeAddr"><%= addr %></a>
			                                <br>
			                                <a id="cafeOneLine"><%= oneline %></a>
			                                <a id="cafeID" hidden><%= id %></a>
			                                <br>
			                                <div class="readyCafeBtn del" onclick="delReq(this)">�����ϱ�</div>
			                                <div class="readyCafeBtn" onclick="verify(this)">�����ϱ�</div>
			                            </td>
			                        </tr>
			                    </tbody>
			                </table>
			            </div>
					<%
					
				}
				
				if(cnt == 0) {
					out.println("<div>���� ������� ī�䰡 �����ϴ�.</div>");
				}
			} catch (SQLException ex) { // EXCEPTION
				out.println("AreaName ���̺� ������ �����߽��ϴ�.");
				out.println("SQLException : " + ex.getMessage());
			}
        %>            
        </div>
    </main>

    <div class="verifyBox" id="verifyBox" hidden>
        <form action="acceptCafe.jsp" method="POST">
            <input type="text" name="cafeName" id="cafeName" value="" readonly>
            <input type="text" name="cafeTags" id="cafeTags" value="" readonly>
            <input type="text" name="cafeAddr" id="cafeAddr" value="" readonly>
            <input type="text" name="cafeLine" id="cafeLine" value="" readonly>
            <input type="text" class="inputReq" name="cafeEsp" id="cafeEsp" placeholder="�Ƹ޸�ī�� ����">
            <input type="text" class="inputReq" name="cafeOpen" id="cafeOpen" placeholder="�����ð�">
            <input type="text" class="inputReq" name="breakDay" id="breakDay" placeholder="����">
            <input type="text" name="cafeID" id="cafeID" value="" hidden>
            <input type="submit" value="�����ϱ�">
        </form>
    </div>

	<div class="backToHome" onclick="location.href='./'">
        <i class="bi bi-house-fill"></i>
    </div>

    <script src="./js/admin.js"></script>
    
    <script>
    	function delReq(target) {
    		const id = target.parentNode.querySelector('#cafeID').innerHTML;
  			location.href = './delCafe.jsp?id=' + id;
    	}
    </script>
</body>

</html>