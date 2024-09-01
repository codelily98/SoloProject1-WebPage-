<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	//폼에서 전송된 데이터 읽기
	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	
	// 디버깅용 출력
	System.out.println("Received userId: " + userId);
	System.out.println("Received userPw: " + userPw);
	
	// 데이터베이스 연결 및 사용자 정보 확인
	MemberDAO dao = MemberDAO.getInstance();
	boolean success = dao.checkUserinfo(userId, userPw);
	
	// 응답 형식 설정
	response.setContentType("application/json");
	PrintWriter outter = response.getWriter();
	
	// JSON 응답 생성
	if (success) {
		outter.print("{ \"loginSuccess\": \"true\" }");
	} else {
		outter.print("{ \"loginSuccess\": \"false\" }");
	}
	
	// 응답 스트림 종료
	outter.flush();
	outter.close();
%>
