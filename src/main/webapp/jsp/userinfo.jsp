<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, javax.servlet.http.*, javax.servlet.*, java.io.*, dto.MemberDTO, dao.MemberDAO" %>

<%
    HttpSession session1 = request.getSession(false);
    String userId = (String) session1.getAttribute("userId");

    // JSON 응답 객체 생성
    StringBuilder jsonResponse = new StringBuilder();
    jsonResponse.append("{");

    if (userId != null) {
        MemberDAO memberDAO = MemberDAO.getInstance();
        MemberDTO memberDTO = memberDAO.getUserById(userId);
        
        if (memberDTO != null) {
            jsonResponse.append("\"userId\": \"").append(memberDTO.getUserId()).append("\",");
            jsonResponse.append("\"userName\": \"").append(memberDTO.getUserName()).append("\",");
            jsonResponse.append("\"userDate\": \"").append(memberDTO.getUserDate()).append("\",");
            jsonResponse.append("\"gender\": \"").append(memberDTO.getGender()).append("\"");
        } else {
            jsonResponse.append("\"error\": \"회원 정보를 찾을 수 없습니다.\"");
        }
    } else {
        jsonResponse.append("\"error\": \"로그인이 필요합니다.\"");
    }

    jsonResponse.append("}");
    
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print(jsonResponse.toString());
    out.flush();
%>
