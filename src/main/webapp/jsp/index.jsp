<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.PostDTO" %>
<%@ page import="dao.PostDAO" %>

<%
    PostDAO postDAO = PostDAO.getInstance();
    List<PostDTO> posts = postDAO.getAllPosts();

    StringBuilder json = new StringBuilder();
    json.append("[");

    for (int i = 0; i < posts.size(); i++) {
        PostDTO post = posts.get(i);
        json.append("{");
        json.append("\"no\": \"").append(post.getNo()).append("\",");
        json.append("\"title\": \"").append(post.getTitle()).append("\",");
        json.append("\"userId\": \"").append(post.getUserId()).append("\",");
        json.append("\"logtime\": \"").append(post.getLogtime()).append("\"");
        json.append("}");

        if (i < posts.size() - 1) {
            json.append(",");
        }
    }

    json.append("]");

    out.print(json.toString());
%>
