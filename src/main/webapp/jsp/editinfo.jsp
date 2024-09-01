<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
    String userId = request.getParameter("userId");
    String UpdateuserPw = request.getParameter("UpdateuserPw");
    
 	// 디버깅용 출력
 	System.out.println("Received userId: " + userId);
 	System.out.println("Received userPw: " + UpdateuserPw);
    
    MemberDAO dao = MemberDAO.getInstance();
    boolean success = dao.updatePassword(userId, UpdateuserPw);
    
    response.setContentType("application/json");
    PrintWriter outter = response.getWriter();
    
    if (success) {
    	outter.print("{ \"success\": true }");
    } else {
    	outter.print("{ \"success\": false }");
    }

 	// 응답 스트림 종료
 	outter.flush();
 	outter.close();
%>
