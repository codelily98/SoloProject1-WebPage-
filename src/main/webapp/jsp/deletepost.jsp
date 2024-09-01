<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.PostDAO, dto.PostDTO" %>

<%
    // 세션에서 현재 로그인한 사용자 ID 가져오기
    String sessionUserId = (String) session.getAttribute("userId");
	String userId = (String) session.getAttribute("userId");
	
	if (userId == null) {
	    response.setContentType("application/json");
	    response.getWriter().write("{\"success\": false, \"message\": \"로그인이 필요합니다.\"}");
	    return;
	}
    // 삭제하려는 게시글의 ID 가져오기
    String postIdParam = request.getParameter("no");
    int postId = Integer.parseInt(postIdParam);

    // 결과를 JSON 형식으로 반환하기 위한 변수
    String result = "";

    // 세션에 사용자 ID가 있는지 확인
    if (sessionUserId != null) {
        PostDAO postDAO = PostDAO.getInstance();
        PostDTO postDTO = postDAO.getPostById(postId);

        // 게시글 작성자와 현재 로그인한 사용자가 일치하는지 확인
        if (postDTO != null && sessionUserId.equals(postDTO.getUserId())) {
            // 일치하면 게시글 삭제
            int deleteCount = postDAO.deletePost(postId);
            if (deleteCount > 0) {
                result = "{\"success\": true, \"message\": \"게시글이 삭제되었습니다.\"}";
            } else {
                result = "{\"success\": false, \"message\": \"삭제에 실패했습니다.\"}";
            }
        } else {
            // 일치하지 않으면 오류 메시지 반환
            result = "{\"success\": false, \"message\": \"권한이 없습니다.\"}";
        }
    } else {
        // 로그인되지 않은 상태일 때
        result = "{\"success\": false, \"message\": \"로그인이 필요합니다.\"}";
    }

    // JSON 형식으로 결과 반환
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print(result);
%>
