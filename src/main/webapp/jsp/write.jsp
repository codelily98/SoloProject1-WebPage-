<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.PostDTO" %>
<%@ page import="dao.PostDAO" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
    String userId = request.getParameter("userId");
    String title = request.getParameter("title");
    String post_content = request.getParameter("post_content");
    post_content = post_content.replaceAll("\\r\\n", "<br/>");
    
    PostDAO postDAO = PostDAO.getInstance();

    int su = 0;
    
    PostDTO postDTO = new PostDTO();
    postDTO.setUserId(userId);
    postDTO.setTitle(title);
    postDTO.setPost_content(post_content);
    
    su = postDAO.writePost(postDTO);
%>

<?xml version="1.0" encoding="UTF-8"?>
<su><%=su%></su>