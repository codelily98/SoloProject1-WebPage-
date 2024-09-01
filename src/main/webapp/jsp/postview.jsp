<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, dao.PostDAO, dto.PostDTO" %>

<%
    int postId = Integer.parseInt(request.getParameter("no"));
    
    // JSON 응답 객체 생성
    StringBuilder jsonResponse = new StringBuilder();
    
    PostDAO postDAO = PostDAO.getInstance();
    PostDTO postDTO = postDAO.getPostById(postId);
    
    jsonResponse.append("{");
    
    if (postDTO != null) {
        jsonResponse.append("\"no\": \"").append(postDTO.getNo()).append("\",");
        jsonResponse.append("\"title\": \"").append(postDTO.getTitle()).append("\",");
        jsonResponse.append("\"userId\": \"").append(postDTO.getUserId()).append("\",");
        jsonResponse.append("\"logtime\": \"").append(postDTO.getLogtime()).append("\",");
        jsonResponse.append("\"post_content\": \"").append(postDTO.getPost_content()).append("\"");
    } else {
        jsonResponse.append("\"error\": \"게시글을 찾을 수 없습니다.\"");
    }

    jsonResponse.append("}");
	
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print(jsonResponse.toString());
    out.flush();
%>
