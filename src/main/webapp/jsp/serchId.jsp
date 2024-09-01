<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="dao.MemberDAO" %>
<%@ page import="org.json.JSONObject" %>
<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    String userName = request.getParameter("userName");
    String userDate = request.getParameter("userDate");
    
    MemberDAO memberDAO = MemberDAO.getInstance();
    String userId = memberDAO.getSerchId(userName, userDate);
    
    JSONObject jsonResponse = new JSONObject();
    if (userId != null) {
        jsonResponse.put("status", "success");
        jsonResponse.put("userId", userId);
    } else {
        jsonResponse.put("status", "error");
        jsonResponse.put("message", "일치하는 회원정보가 없습니다.");
    }
    
    out.print(jsonResponse.toString());
%>
