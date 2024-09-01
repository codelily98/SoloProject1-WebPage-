package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.PostDTO;

public class PostDAO {
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String username = "c##java";
	private String password = "1234";
	
	private static PostDAO instance = new PostDAO();	//SingTon Static으로 1번 설정
	
	private Connection connection;	//인터페이스
	private PreparedStatement pstmt;	//인터페이스
	private ResultSet resultSet;	//인터페이스 
	
	public PostDAO() {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	// 예외처리
	}
	
	public static PostDAO getInstance() {
		return instance;
	}
	
	public void getConnection() {
		try {
			connection = DriverManager.getConnection(url, username, password);			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
	
	public int writePost(PostDTO postDTO) {
		int su = 0;
		
		getConnection();
		
		String sql = "Insert into POST (NO, USERID, TITLE, POST_CONTENT, LOGTIME) Values(POST_NO.NEXTVAL, ?, ?, ?, sysdate)";
		
		try {
			pstmt = connection.prepareStatement(sql);
			
			pstmt.setString(1, postDTO.getUserId());
			pstmt.setString(2, postDTO.getTitle());
			pstmt.setString(3, postDTO.getPost_content());
			
			su = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(connection != null) connection.close();				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return su;
	}
	
	public List<PostDTO> getAllPosts() {
	    List<PostDTO> posts = new ArrayList<>();
	    getConnection();
	    
	    String sql = "SELECT NO, USERID, TITLE, LOGTIME FROM POST ORDER BY NO DESC";
	    
	    try {
	        pstmt = connection.prepareStatement(sql);
	        resultSet = pstmt.executeQuery();
	        
	        while (resultSet.next()) {
	            PostDTO postDTO = new PostDTO();
	            postDTO.setNo(resultSet.getInt("NO"));
	            postDTO.setUserId(resultSet.getString("USERID"));
	            postDTO.setTitle(resultSet.getString("TITLE"));
	            postDTO.setLogtime(resultSet.getTimestamp("LOGTIME").toString());
	            posts.add(postDTO);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) resultSet.close();
	            if (pstmt != null) pstmt.close();
	            if (connection != null) connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return posts;
	}
	
	public PostDTO getPostById(int postId) {
	    PostDTO postDTO = null;
	    getConnection();
	    
	    String sql = "SELECT NO, USERID, TITLE, POST_CONTENT, LOGTIME FROM POST WHERE NO = ?";
	    
	    try {
	        pstmt = connection.prepareStatement(sql);
	        pstmt.setInt(1, postId);
	        resultSet = pstmt.executeQuery();
	        
	        if (resultSet.next()) {
	            postDTO = new PostDTO();
	            postDTO.setNo(resultSet.getInt("NO"));
	            postDTO.setUserId(resultSet.getString("USERID"));
	            postDTO.setTitle(resultSet.getString("TITLE"));
	            postDTO.setPost_content(resultSet.getString("POST_CONTENT"));
	            postDTO.setLogtime(resultSet.getTimestamp("LOGTIME").toString());
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) resultSet.close();
	            if (pstmt != null) pstmt.close();
	            if (connection != null) connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return postDTO;
	}
	
	public int deletePost(int postId) {
		int deleteCount = 0;
		
		getConnection();
        
		String sql = "DELETE FROM POST WHERE NO = ?";
        
        try {            
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, postId);
            deleteCount = pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	try {
	            if (resultSet != null) resultSet.close();
	            if (pstmt != null) pstmt.close();
	            if (connection != null) connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
        }
        return deleteCount;
    }
	
	public int updatePost(PostDTO postDTO) {
		int updateCount = 0;
		
	    getConnection();

	    String sql = "UPDATE POST SET TITLE = ?, POST_CONTENT = ? WHERE NO = ? AND USERID = ?";

	    try {
	        pstmt = connection.prepareStatement(sql);
	        pstmt.setString(1, postDTO.getTitle());
	        pstmt.setString(2, postDTO.getPost_content());
	        pstmt.setInt(3, postDTO.getNo());
	        pstmt.setString(4, postDTO.getUserId());

	        updateCount = pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null) resultSet.close();
	            if (pstmt != null) pstmt.close();
	            if (connection != null) connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return updateCount;
	}
}