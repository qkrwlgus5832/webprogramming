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
	// ������ �� ���� ���
	public static final int memo_EXISTENT = 1;
	public static final int memo_JOIN_FAIL = 0;
	public static final int memo_JOIN_SUCCESS = 1;
	public static final int memo_LOGIN_PW_NO_GOOD = 0;
	public static final int memo_LOGIN_SUCCESS = 1;
	public static final int memo_LOGIN_IS_NOT = -1;
	
	public static int COUNT = 0;   // �˻��� ����� ���� �߰� 
	
	/*�̱��� �����̶� - Ŭ�����κ��� ��ü ���� ���� �ٷ� ��ü�� ������ ����� �� �ִ�.
	 * �����ڰ� ���� ���� ȣ��Ǵ��� ������ �����Ǵ� ��ü�� �ϳ��̰� 
	 * ���� ���� ���Ŀ� ȣ��� �����ڴ� ������ �����ڰ� ������ ��ü�� �����Ѵ�  
          ��ü ���� ���α׷����� �����ϴ� ���ҽ��� ���� �׼����� ���� �� �� ��� */
	
	private static memoDao instance = new memoDao();
	// MemberDao() �� �̿��Ͽ� instance �� ����
	// instance �� �ڱⰡ �ڱ⸦ �����ϰ� �����ϴ� ���� 
	// static�� �ν��Ͻ��� ��������� ���� ȣ��Ǵ� �ڵ� 
	
	
	private memoDao() {
		// ������ �����ڴ� public �� - �ܺο��� ������ �����ؾ� �ϹǷ�  
		// MemberDao �� �����ڰ� private �̹Ƿ� �ٸ������� ������ �Ұ�
		// �׷��Ƿ� �ܺο��� �ν��Ͻ� ���� ���ϰ� private �� ���� 
		// private �̹Ƿ� �ٸ������� ��� �Ұ� 
		// �� instance ��ü�� �ϳ��� �����ǰ�, ��� ������ ��� ������
		// �ڱ� Ŭ�������� �ڽ��� �����ϰ� �����ϴ� ��ü
	}  
	
	public static memoDao getInstance(){
		return instance;
	} // private MemberDao()�� ������ �ȵǹǷ� public �ϰ� static �� 
	  //  �ν��Ͻ��� ����� �ٸ� ������ �ٷ� ������ �����ϵ����� - 
	  // ������ ���� instance �� ��ȯ
	
	// ============= insertMember ==================
	public int insertMember(memoDto dto) {
		int ri = 0;   // ���� ���� 
		Connection connection = null;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO memoTime(NUM, name, title, pass) VALUES(AUTO_SEQ_NUMBER.NEXTVAL,?,?,?)";

		try {
			connection = getConnection();  // ȣ�� - �ǵڿ� ����
			pstmt = connection.prepareStatement(query);
			// ������ ����
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getPass());
			pstmt.executeUpdate();  // ����
			ri = memoDao.memo_JOIN_SUCCESS; // 1 �̸� -�����̸�
		/*select �� �ƴϹǷ� resultSet ��ü�� ���� ��ȯ���� int ���̴�.*/
			
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
	}  /* ri  select �� �ƴϹǷ� resultSet ��ü�� ���� ��ȯ���� int ���̴�.*/	
	
	//============ confirmId ====================
	public int confirmId(String id) {
		int ri = 0;	
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select id from members where id = ?";
		                 /*DB�� id            ������ �Է��� id */
		 try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, id); // id�� ����ڰ� ������ �Է��� id
			set = pstmt.executeQuery();  // select �� �� ���
			if(set.next()){
				ri = memoDao.memo_EXISTENT;// �̹� �����ϴ� �Ƶ�� 1
			} else {
				ri = memoDao.memo_NONEXISTENT; // �������� �ʴ� �Ƶ�� 0
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
		return ri;    /* 0 or  1 ��ȯ */
	}
	
	//=============== userCheck =====================
	/*����ڰ� �Է��� id�� pass�� ������ �� �Է��� ���� ������ �� */
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
			pstmt.setString(1, id);  // ����ڰ� �Է��� �Ƶ�
			set = pstmt.executeQuery();
			
			if(set.next()) {
				dbPw = set.getString("pw");
				if(dbPw.equals(pw)) {     // ����ڰ� �Է��� �н�����
					ri = memoDao.memo_LOGIN_SUCCESS;// 1 �̸� �α��� Ok
				} else {
					ri = memoDao.memo_LOGIN_PW_NO_GOOD;	// 0  ��� X
				}
			} else {
				ri = memoDao.memo_LOGIN_IS_NOT;	// -1  ȸ���� �ƴϸ�	
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
			
			if(set.next()) {       // ó������ ������ ���� 
				dto = new memoDto();
				dto.setNum(set.getInt("num"));  // ���� 
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
		return dto;		// ��ȯ
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
		
       
    // ==================  ��  ȸ ,  �� ��  ===========================
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
       // �����Ϸ��� ����� dto ��ü�� ���޹޾� 
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
			// ������Ʈ �� ����� ������ ��ȯ 1 �̸� ����
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
		return ri;   // ���� 1�̸� ����, 0 �̸� ���� 
	}
	
	
	
	
	// ==============  deleteMember =======================
		 // �����Ϸ��� ����� dto ��ü�� ���޹޾� 
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
				// ������Ʈ �� ����� ������ ��ȯ 1 �̸� ����
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
			return ri;   // ���� 1�̸� ����, 0 �̸� ���� 
		}
		
	
	
	//==========================================
	private Connection getConnection() {
		
	Context context = null;
	DataSource dataSource = null;
	Connection connection = null;
	try {
		context = new InitialContext();
		// ����Ŭ DB�� ����ϱ� ���� ��ü context ����
		
		dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle11g");
		// context ��ü�� lookup �޼ҵ忡 �Ű������� �̿��Ͽ� ���ҽ��� ȹ���Ѵ�.
		// ����Ŭ DB �̸��� �⺻������ java:comp/env �� ��ϵǾ� �ִ�.
		// �ش� �������� jdbc/Oracle11g �� ������ �̸��� ���´�.
	
		connection = dataSource.getConnection();
		// ds ��ü�κ��� Connection  ��ü ���´�.
		// ���ݺ��ʹ� �� ��ü�� �� �����̳��� DBCP �� ���� �����ȴ�.
		 
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return connection;
	}
}



 