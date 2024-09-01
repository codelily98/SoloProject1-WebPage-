package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.MemberDTO;

public class MemberDAO {
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String username = "c##java";
	private String password = "1234";
	
	private static MemberDAO instance = new MemberDAO();	//SingTon Static으로 1번 설정
	
	private Connection connection;	//인터페이스
	private PreparedStatement pstmt;	//인터페이스
	private ResultSet resultSet;	//인터페이스 
	
	public MemberDAO() {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	// 예외처리
	}
	
	public static MemberDAO getInstance() {
		return instance;
	}
	
	public void getConnection() {
		try {
			connection = DriverManager.getConnection(url, username, password);			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
	
	//회원가입
	public int userJoin(MemberDTO memberDTO) {
		int su = 0;
		
		getConnection();
		
		String sql = "insert into user_status values(?, ?, ?, ?, ?)";
		
		try {
			pstmt = connection.prepareStatement(sql);
			
			pstmt.setString(1, memberDTO.getUserId());
			pstmt.setString(2, memberDTO.getUserPw());
			pstmt.setString(3, memberDTO.getUserName());
			pstmt.setString(4, memberDTO.getUserDate());
			pstmt.setString(5, memberDTO.getGender());
			
			su = pstmt.executeUpdate(); //데이터 입력
			
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
	
	//아이디 중복 확인
	public boolean isExistId(String userId) {
		boolean result = false;
		
		getConnection();
		String sql = "select * from user_status where userId = ?";
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			resultSet = pstmt.executeQuery();
			
			if(resultSet.next()) {
				result = true;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
				try {
					if(resultSet != null) resultSet.close();
					if(pstmt != null) pstmt.close();
					if(connection != null) connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return result;
	}
	
	// userId로 사용자 정보를 가져오는 메서드
	public MemberDTO getUserById(String userId) {
		MemberDTO memberDTO = null;
		getConnection();
		String sql = "SELECT * FROM user_status WHERE userId = ?";
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, userId);
			resultSet = pstmt.executeQuery();
			
			if (resultSet.next()) {
				memberDTO = new MemberDTO();
				memberDTO.setUserId(resultSet.getString("userId"));
				memberDTO.setUserPw(resultSet.getString("userPw"));
				memberDTO.setUserName(resultSet.getString("userName"));
				memberDTO.setUserDate(resultSet.getString("userDate"));
				memberDTO.setGender(resultSet.getString("gender"));
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
		return memberDTO;
	}
	
	//아이디 찾기
	public String getSerchId(String userName, String userDate) {
		String userId = null;
		System.out.print(userName);
		System.out.print(userDate);
		getConnection();
		String sql = "SELECT USERID FROM user_status WHERE USERNAME = ? and USERDATE = ?";
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, userDate);
			resultSet = pstmt.executeQuery();
			
			if (resultSet.next()) {
			    userId = resultSet.getString("userId");
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
		return userId;
	}
	
	//비밀번호 찾기
		public String getSerchPw(String userId, String userName, String userDate) {
			String userPw = null;
			getConnection();
			String sql = "SELECT USERPW FROM user_status WHERE USERID = ? and USERNAME = ? and USERDATE = ?";
			
			try {
				pstmt = connection.prepareStatement(sql);
				pstmt.setString(1, userId);
				pstmt.setString(2, userName);
				pstmt.setString(3, userDate);
				resultSet = pstmt.executeQuery();
				
				if (resultSet.next()) {
					userPw = resultSet.getString("userPw");
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
			return userPw;
		}
	
	//아이디, 비번 확인
	public String checkUser(String userId, String userPw) {
		String userName = null;
		getConnection();
		String sql = "select * from user_status where userId = ? and userPw = ?";
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPw);
			
			resultSet = pstmt.executeQuery();
			
			if(resultSet.next()) {
				userName = resultSet.getString("userName");
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
				try {
					if(resultSet != null) resultSet.close();
					if(pstmt != null) pstmt.close();
					if(connection != null) connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return userName;
	}
	
	//회원정보 아이디, 비번 확인
	public boolean checkUserinfo (String userId, String userPw) {
		boolean success = false;
		
		getConnection();
		String sql = "select * from user_status where userId = ? and userPw = ?";
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPw);
			
			resultSet = pstmt.executeQuery();
			
			if(resultSet.next()) {
				success = true;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
				try {
					if(resultSet != null) resultSet.close();
					if(pstmt != null) pstmt.close();
					if(connection != null) connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return success;
	}
	
	// 비밀번호를 수정하는 메서드
	public boolean updatePassword(String userId, String UpdateuserPw) {
		boolean result = false;
        
        getConnection();
        
        String sql = "UPDATE user_status SET userPw = ? WHERE userId = ?";
        
        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, UpdateuserPw);
            pstmt.setString(2, userId);
            
            int rowsAffected  = pstmt.executeUpdate();
            
            result = rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    // 회원 정보를 삭제하는 메서드
	public boolean deleteUser(String userId) {
		boolean result = false;
        
		System.out.println(userId);																	
		
        getConnection();
        
        String sql = "DELETE FROM user_status WHERE userId = ?";
        
        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, userId);
            
            int rowsAffected = pstmt.executeUpdate();
            result = rowsAffected > 0;
            
            System.out.println(result);
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}