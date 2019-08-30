package memoPackage;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import memoPackage.memoDto;
public class memoDao {
	public static final int memo_NONEXISTENT  = 0;  
	// 수정할 수 없는 상수
	public static final int memo_EXISTENT = 1;
	public static final int memo_JOIN_FAIL = 0;
	public static final int memo_JOIN_SUCCESS = 1;
	public static final int memo_LOGIN_PW_NO_GOOD = 0;
	public static final int memo_LOGIN_SUCCESS = 1;
	public static final int memo_LOGIN_IS_NOT = -1;
	
	public static int COUNT = 0;   // 검색에 사용할 변수 추가 
	
	/*싱글턴 패턴이란 - 클래스로부터 객체 생성 없이 바로 객체를 가져다 사용할 수 있다.
	 * 생성자가 여러 차례 호출되더라도 실제로 생성되는 객체는 하나이고 
	 * 최초 생성 이후에 호출된 생성자는 최초의 생성자가 생성한 객체를 리턴한다  
          전체 응용 프로그램에서 공유하는 리소스에 대한 액세스를 관리 할 때 사용 */
	
	private static memoDao instance = new memoDao();
	// MemberDao() 를 이용하여 instance 를 생성
	// instance 는 자기가 자기를 생성하고 참조하는 변수 
	// static은 인스턴스가 만들어지기 전에 호출되는 코드 
	
	
	private memoDao() {
		// 보통의 생성자는 public 임 - 외부에서 접근이 가능해야 하므로  
		// MemberDao 는 생성자가 private 이므로 다른곳에서 접근이 불가
		// 그러므로 외부에서 인스턴스 생성 못하게 private 로 선언 
		// private 이므로 다른곳에서 상속 불가 
		// 이 instance 객체는 하나만 생성되고, 모든 곳에서 사용 가능함
		// 자기 클래스에서 자신을 생성하고 참조하는 객체
	}  
	
	public static memoDao getInstance(){
		return instance;
	} // private MemberDao()는 접근이 안되므로 public 하고 static 한 
	  //  인스턴스를 만들어 다른 곳에서 바로 접근이 가능하도록함 - 
	  // 위에서 만든 instance 를 반환
	
	// ============= insertMember ==================
	public int insertMember(memoDto dto) {
		int ri = 0;   // 지역 변수 
		Connection connection = null;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO memoTime(NUM, name, title, pass) VALUES(AUTO_SEQ_NUMBER.NEXTVAL,?,?,?)";

		try {
			connection = getConnection();  // 호출 - 맨뒤에 있음
			pstmt = connection.prepareStatement(query);
			// 데이터 저장
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getPass());
			pstmt.executeUpdate();  // 실행
			ri = memoDao.memo_JOIN_SUCCESS; // 1 이면 -성공이면
		/*select 가 아니므로 resultSet 객체가 없고 반환형이 int 형이다.*/
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(connection != null) connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}		
		return ri;   
	}  /* ri  select 가 아니므로 resultSet 객체가 없고 반환형이 int 형이다.*/	
	
	//============ confirmId ====================
	public int confirmId(String id) {
		int ri = 0;	
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select id from members where id = ?";
		                 /*DB의 id            폼에서 입력한 id */
		 try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, id); // id는 사용자가 폼에서 입력한 id
			set = pstmt.executeQuery();  // select 일 때 사용
			if(set.next()){
				ri = memoDao.memo_EXISTENT;// 이미 존재하는 아디면 1
			} else {
				ri = memoDao.memo_NONEXISTENT; // 존재하지 않는 아디면 0
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}	
		return ri;    /* 0 or  1 반환 */
	}
	
	//=============== userCheck =====================
	/*사용자가 입력한 id와 pass를 가지고 비교 입력한 값과 같은지 비교 */
	public int userCheck( String id, String pw) {
		int ri = 0;
		String dbPw;		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select pw from members where id = ?";		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, id);  // 사용자가 입력한 아디
			set = pstmt.executeQuery();
			
			if(set.next()) {
				dbPw = set.getString("pw");
				if(dbPw.equals(pw)) {     // 사용자가 입력한 패스워드
					ri = memoDao.memo_LOGIN_SUCCESS;// 1 이면 로그인 Ok
				} else {
					ri = memoDao.memo_LOGIN_PW_NO_GOOD;	// 0  비번 X
				}
			} else {
				ri = memoDao.memo_LOGIN_IS_NOT;	// -1  회원이 아니면	
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}
	
	//=============== getMember   ===================
	public memoDto getMember(int num) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select * from memoTime where num = ?";
		memoDto dto = null;
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, num);
			set = pstmt.executeQuery();
			
			if(set.next()) {       // 처음부터 마지막 까지 
				dto = new memoDto();
				dto.setNum(set.getInt("num"));  // 저장 
				dto.setName(set.getString("name"));
				dto.setTitle(set.getString("title"));
				dto.setIndate(set.getTimestamp("indate"));
				dto.setPass(set.getString("pass"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}		
		return dto;		// 반환
	}
		
      
	//===============  getList  =================================
       public ArrayList<memoDto> getList() {
    	  /* public ArrayList<MemberDto> getList() {*/
		ArrayList<memoDto> dtos = new ArrayList<memoDto>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try {
			connection = getConnection();
			
			String query = "select * from memoTime order by indate desc";
			preparedStatement = connection.prepareStatement(query);
			resultSet = preparedStatement.executeQuery();
			
			while (resultSet.next()) {
				int bnum = resultSet.getInt("num");
				String bname = resultSet.getString("name");
				String btitle = resultSet.getString("title");
				
				Timestamp bindate = resultSet.getTimestamp("indate");
				String bpass = resultSet.getString("pass");
							
				memoDto dto = new memoDto(bnum, bname, btitle, bindate, bpass);
				dtos.add(dto);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if(resultSet != null) resultSet.close();
				if(preparedStatement != null) preparedStatement.close();
				if(connection != null) connection.close();
				// TODO: handle exception
			} catch (Exception e) { 
			e.printStackTrace();
			}
		}
		return dtos;
	}
		
       
    // ==================  조  회 ,  검 색  ===========================
       public ArrayList<memoDto> getSearchList(String search_op,String search_text) {
     	  /* public ArrayList<MemberDto> getList() {*/
 		ArrayList<memoDto> dtos = new ArrayList<memoDto>();
 		Connection connection = null;
 		PreparedStatement preparedStatement = null;
 		ResultSet resultSet = null;
 		COUNT=0;
 		
 		try {
 			connection = getConnection();
 			String query=null;
 			int search_text2=0;
 			if(search_op.equals("num")){
 				query = "select * from memoTime where num = ?";
 				 search_text2 = Integer.parseInt(search_text);
 			}else if(search_op.equals("name")){
 				query = "select * from memoTime where name like ?";
 			}
 			else if(search_op.equals("title")){
 				query = "select * from memoTime where title like ?";
 			}
 			
 			preparedStatement = connection.prepareStatement(query);
 			if (search_op.equals("name") || search_op.equals("title") ) {
 			preparedStatement.setString(1, "%"+search_text+"%");
 			}
 			else {
 	 			preparedStatement.setInt(1, search_text2);

 			}
 			resultSet = preparedStatement.executeQuery();
 			
 			while (resultSet.next()) {
 				COUNT++;
 				int bnum = resultSet.getInt("num");
 				String bname = resultSet.getString("name");
 				String btitle = resultSet.getString("title");
 				Timestamp bindate = resultSet.getTimestamp("indate");
 				String pass = resultSet.getString("pass");
 							
 				memoDto dto = new memoDto(bnum, bname, btitle, bindate, pass);
 				dtos.add(dto);
 			}
 			
 		} catch (Exception e) {
 			// TODO: handle exception
 			e.printStackTrace();
 		} finally {
 			try {
 				if(resultSet != null) resultSet.close();
 				if(preparedStatement != null) preparedStatement.close();
 				if(connection != null) connection.close();
 			} catch (Exception e2) {
 				// TODO: handle exception
 				e2.printStackTrace();
 			}
 		}
 		return dtos;
 	}
       
       
       
       
       
	//==============  updateMember   ==========================
       // 수정하려는 사람의 dto 객체를 전달받아 
	public int updateMember(memoDto dto) {
		int ri = 0;		
		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "update memoTime set name=?, title=?, pass=? where num=?";		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getPass());
			pstmt.setInt(4, dto.getNum());
			ri = pstmt.executeUpdate();  
			// 업데이트 한 결과를 정수로 반환 1 이면 정상
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}		
		return ri;   // 리턴 1이면 정상, 0 이면 에러 
	}
	
	
	
	
	// ==============  deleteMember =======================
		 // 삭제하려는 사람의 dto 객체를 전달받아 
		public int deleteMember(int num){
			int ri = 0;		
			Connection connection = null;
			PreparedStatement pstmt = null;
			String query = "delete memoTime where num=?";		
			try {
				connection = getConnection();
				pstmt = connection.prepareStatement(query);
				pstmt.setInt(1, num);
				ri = pstmt.executeUpdate();  
				// 업데이트 한 결과를 정수로 반환 1 이면 정상
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					connection.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}		
			return ri;   // 리턴 1이면 정상, 0 이면 에러 
		}
		
	
	
	//==========================================
	private Connection getConnection() {
		
	Context context = null;
	DataSource dataSource = null;
	Connection connection = null;
	try {
		context = new InitialContext();
		// 오라클 DB를 사용하기 위한 객체 context 생성
		
		dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle11g");
		// context 객체로 lookup 메소드에 매개변수를 이용하여 리소스를 획득한다.
		// 오라클 DB 이름은 기본적으로 java:comp/env 에 등록되어 있다.
		// 해당 영역에서 jdbc/Oracle11g 로 설정된 이름을 얻어온다.
	
		connection = dataSource.getConnection();
		// ds 객체로부터 Connection  객체 얻어온다.
		// 지금부터는 이 객체는 웹 컨테이너의 DBCP 에 의해 관리된다.
		 
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return connection;
	}
}



 