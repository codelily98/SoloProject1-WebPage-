<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
    String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	
	// 디버깅용 출력
	System.out.println("Delete userId: " + userId);
	System.out.println("Delete userPw: " + userPw);
    
    MemberDAO memberdao = MemberDAO.getInstance();
    boolean success = false; 
    
    success = memberdao.checkUserinfo(userId, userPw); // 비밀번호 검증
    
    if (!success) {
        System.out.println("삭제 실패");
    } else {
    	success = memberdao.deleteUser(userId); // 비밀번호 검증 후 삭제
    }
    
    response.setContentType("application/json");
    PrintWriter outter = response.getWriter();
    
    if (success) {
    	outter.print("{ \"success\": true }");
    } else {
    	outter.print("{ \"success\": false }");
    }
    
    outter.flush();
%>
