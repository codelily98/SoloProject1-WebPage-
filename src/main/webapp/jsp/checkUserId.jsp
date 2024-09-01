<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
    String userId = request.getParameter("userId");
    
    MemberDAO memberDAO = MemberDAO.getInstance();
    boolean exists = memberDAO.isExistId(userId);
%>

<?xml version="1.0" encoding="UTF-8"?>
<response>
    <exists><%= exists %></exists>
</response>