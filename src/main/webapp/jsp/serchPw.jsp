<%@page contentType="application/json; charset=UTF-8" %>
<%@page import="dao.MemberDAO" %>
<%@page import="dto.MemberDTO" %>
<%@page import="org.json.JSONObject" %>
<%
    // Set response content type and encoding
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // Retrieve request parameters
    String userId = request.getParameter("userId");
    String userName = request.getParameter("userName");
    String userDate = request.getParameter("userDate");
    
    // Get MemberDAO instance and search for userPw
    MemberDAO memberDAO = MemberDAO.getInstance();
    String userPw = memberDAO.getSerchPw(userId, userName, userDate);
    
    // Create JSON response
    JSONObject jsonResponse = new JSONObject();
    if (userPw != null) {
        jsonResponse.put("status", "success");
        jsonResponse.put("userPw", userPw);
    } else {
        jsonResponse.put("status", "error");
        jsonResponse.put("message", "일치하는 회원정보가 없습니다.");
    }
    
    // Print JSON response
    out.print(jsonResponse.toString());
%>
