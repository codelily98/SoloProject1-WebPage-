<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.MemberDTO" %>
<%@ page import="dao.MemberDAO" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
    String userId = request.getParameter("userId");
    String userPw = request.getParameter("userPw");

    MemberDAO memberDAO = MemberDAO.getInstance();
    
    String userName = null;
    boolean loginSuccess = false;
    
    userName = memberDAO.checkUser(userId, userPw);
    
    if (userName != null) {
        loginSuccess = true;
        session.setAttribute("userId", userId); // 로그인 성공 시 세션에 userId 저장
    }
%>

<?xml version="1.0" encoding="UTF-8"?>
<response>
    <loginSuccess><%=loginSuccess%></loginSuccess>
    <userName><%=userName != null ? userName : ""%></userName>
</response>
