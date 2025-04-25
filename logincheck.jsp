<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%
try{
	// 載入資料庫驅動程式 
	Class.forName("com.mysql.jdbc.Driver");
	try{
		//建立連線 
		String url="jdbc:mysql://localhost/?serverTimezone=UTC";
		Connection con=DriverManager.getConnection(url,"root","1234");
		//判斷是否連線成功
		if(con.isClosed()){
			out.println("連線建立失敗");
		}
		else{
		//連資料庫
		String sql="USE `team11_silverwrb`";
		con.createStatement().execute(sql);
		}
		
		// 取得登入表單資訊
        String login_email = request.getParameter("email");
        String login_pwd = request.getParameter("pwd");
      
		//判斷資料
		//用戶名、密碼是否未輸入
		if (login_email!=null && !login_email.equals("") && login_pwd!=null && !login_pwd.equals("")){
			//如果不是空值，開始判斷帳號是否已存在
			//執行SQL指令
			// 
			String Checksql = "SELECT * FROM `members` WHERE MembersEmail=? AND MembersPWD=?";
			PreparedStatement pstmt = null;
			pstmt=con.prepareStatement(Checksql);
			pstmt.setString(1,login_email);
			pstmt.setString(2,login_pwd);
			//管理者登入後台
			//自己設一個
			if(login_email.equals("backstage@gmail.com") && login_pwd.equals("02987")){
				response.sendRedirect("back_index.jsp");
			}
			else{
				//檢查Email、密碼是否正確
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()){
					//登入成功
					//關閉連線SQL
					con.close();
					//帳密正確將email存入session中
					session.setAttribute("email",login_email);
					//返回首頁
							response.sendRedirect("index.jsp");/////還沒設好應該要返回index.html
				}
					
				else{
					response.sendRedirect("login.jsp?error=failed");//返回login.jsp 並傳送一個error=failed參數
				}
			}
		}
		else{
			response.sendRedirect("login.jsp?error=null");//返回login.jsp 並傳送一個error=null參數
		}
		
		
	}
	catch(SQLException sExec) {
           out.println("SQL錯誤"+sExec.toString());
		   
	}	
}
catch(ClassNotFoundException err) {
   out.println("class錯誤"+err.toString());
}


	
%>
