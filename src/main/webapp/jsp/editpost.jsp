<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.PostDAO, dto.PostDTO" %>

<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // 세션에서 사용자 ID를 가져옵니다.
    String sessionUserId = (String) session.getAttribute("userId");
    String postIdParam = request.getParameter("no");
    String title = request.getParameter("title");
    String post_content = request.getParameter("post_content");
	
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": false, \"message\": \"로그인이 필요합니다.\"}");
        return;
    }
    
    // JSON 응답을 구성할 StringBuilder
    StringBuilder jsonResponse = new StringBuilder();
    
    // 게시글 ID가 유효하지 않은 경우
    if (postIdParam == null || postIdParam.isEmpty()) {
        jsonResponse.append("{\"success\": false, \"message\": \"게시글 ID가 제공되지 않았습니다.\"}");
    } else {
        int postId;
        try {
            postId = Integer.parseInt(postIdParam);
        } catch (NumberFormatException e) {
            jsonResponse.append("{\"success\": false, \"message\": \"게시글 ID가 유효하지 않습니다.\"}");
            out.print(jsonResponse.toString());
            return;
        }

        // 로그인된 사용자 ID가 유효한 경우
        if (sessionUserId != null) {
            PostDAO postDAO = PostDAO.getInstance();
            PostDTO postDTO = postDAO.getPostById(postId);

            // 게시글이 존재하고, 로그인된 사용자와 게시글 작성자가 일치하는 경우
            if (postDTO != null && sessionUserId.equals(postDTO.getUserId())) {
                // 제목과 내용이 유효한 경우
                if (title != null && !title.isEmpty() && post_content != null && !post_content.isEmpty()) {
                    postDTO.setTitle(title);
                    postDTO.setPost_content(post_content);
                    post_content = post_content.replaceAll("\\r\\n", "<br/>");

                    int updateCount = postDAO.updatePost(postDTO);
                    if (updateCount > 0) {
                        jsonResponse.append("{\"success\": true, \"message\": \"게시글이 수정되었습니다.\"}");
                    } else {
                        jsonResponse.append("{\"success\": false, \"message\": \"수정에 실패했습니다.\"}");
                    }
                } else {
                    jsonResponse.append("{\"success\": false, \"message\": \"제목이나 내용이 유효하지 않습니다.\"}");
                }
            } else {
                jsonResponse.append("{\"success\": false, \"message\": \"권한이 없습니다.\"}");
            }
        } else {
            jsonResponse.append("{\"success\": false, \"message\": \"로그인이 필요합니다.\"}");
        }
    }

    // JSON 응답을 클라이언트에 전송합니다.
    out.print(jsonResponse.toString());
    out.flush();
%>
