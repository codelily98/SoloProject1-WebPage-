<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.MemberDTO" %>
<%@ page import="dao.MemberDAO" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
    String userId = request.getParameter("userId");
    String userPw = request.getParameter("userPw");
    String userName = request.getParameter("userName");
    String userDate = request.getParameter("userDate");
    String gender = request.getParameter("gender");

    MemberDAO memberDAO = MemberDAO.getInstance();

    int su = 0;
    
    MemberDTO memberDTO = new MemberDTO();
    memberDTO.setUserId(userId);
    memberDTO.setUserPw(userPw);
    memberDTO.setUserName(userName);
    memberDTO.setUserDate(userDate);
    memberDTO.setGender(gender);
    
    su = memberDAO.userJoin(memberDTO);
%>

<?xml version="1.0" encoding="UTF-8"?>
<su><%=su%></su>