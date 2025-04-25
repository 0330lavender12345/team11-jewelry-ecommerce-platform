<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%
    // 取得註冊表單資訊
    String new_name = request.getParameter("username");
    String new_email = request.getParameter("email");
	String new_phone = request.getParameter("phone");
    String new_pwd = request.getParameter("pwd");
    String new_confirmpwd = request.getParameter("confirmpwd");

    Connection con = null;
    PreparedStatement pstmtEmail = null;
    PreparedStatement pstmtPwd = null;
    PreparedStatement pstmtInsert = null;
    ResultSet rsEmail = null;
    ResultSet rsPwd = null;

    try {
        // 載入資料庫驅動程式
        Class.forName("com.mysql.jdbc.Driver");
        // 建立連線
        String url = "jdbc:mysql://localhost/?serverTimezone=UTC";
        con = DriverManager.getConnection(url, "root", "1234");

        // 判斷是否連線成功
        if (con.isClosed()) {
            out.println("連線建立失敗");
        } else {
            // 連資料庫
            String sql = "USE `team11_silverwrb`";  // 替換成最終資料庫的名稱
            con.createStatement().execute(sql);

            // 判斷資料是否為空值
            // 用戶名、密碼、確認密碼、mail 為必填欄位
            if (new_name != null && !new_name.equals("") && 
                new_email != null && !new_email.equals("") && 
                new_pwd != null && !new_pwd.equals("") && 
                new_confirmpwd != null && !new_confirmpwd.equals("")) {

                // 如果不是空值，開始判斷 email 是否已存在
                String checkEmailSQL = "SELECT * FROM `members` WHERE MembersEmail=?";
                pstmtEmail = con.prepareStatement(checkEmailSQL);
                pstmtEmail.setString(1, new_email);

                // 檢查 Email 是否重複
                rsEmail = pstmtEmail.executeQuery();
                if (rsEmail.next()) {
					response.sendRedirect("signup.jsp?error=acduplicate&username=" + URLEncoder.encode(new_name, "UTF-8") + "&email=" + URLEncoder.encode(new_email, "UTF-8") + "&phone=" + URLEncoder.encode(new_phone, "UTF-8"));               
					} else {
                    // Email 不重複，開始判斷密碼是否重複
                    String checkPwdSQL = "SELECT * FROM `members` WHERE MembersPWD=?";
                    pstmtPwd = con.prepareStatement(checkPwdSQL);
                    pstmtPwd.setString(1, new_pwd);

                    // 檢查密碼是否重複
                    rsPwd = pstmtPwd.executeQuery();
                    if (rsPwd.next()) {
                        response.sendRedirect("signup.jsp?error=pwduplicate&username=" + URLEncoder.encode(new_name, "UTF-8") + "&email=" + URLEncoder.encode(new_email, "UTF-8") + "&phone=" + URLEncoder.encode(new_phone, "UTF-8"));
                    } else {
                        // 密碼不重複，開始判斷密碼和確認密碼是否匹配
                        if (!new_pwd.equals(new_confirmpwd)) {
                            response.sendRedirect("signup.jsp?error=pwdmismatch&username=" + URLEncoder.encode(new_name, "UTF-8") + "&email=" + URLEncoder.encode(new_email, "UTF-8") + "&phone=" + URLEncoder.encode(new_phone, "UTF-8"));
                        } else {
                            // 新增資料至 SQL
                            String insertSQL = "INSERT INTO `members`(`MembersName`,`MembersEmail`,`MembersPhone`,`MembersPWD`,`Memberstype`) VALUES(?,?,?,?,?)";
                            pstmtInsert = con.prepareStatement(insertSQL);
                            pstmtInsert.setString(1, new_name);
                            pstmtInsert.setString(2, new_email);
							pstmtInsert.setString(3, new_phone);
                            pstmtInsert.setString(4, new_pwd);
                            pstmtInsert.setString(5, "member" );
                            pstmtInsert.executeUpdate();  // 執行 INnew_pwdSERT 語句

                            // 返回登入頁面
                            response.sendRedirect("login.jsp");
                        }
                    }
                }
            } else {
                response.sendRedirect("signup.jsp?error=null&username=" + URLEncoder.encode(new_name, "UTF-8") + "&email=" + URLEncoder.encode(new_email, "UTF-8") + "&phone=" + URLEncoder.encode(new_phone, "UTF-8"));
            }
        }
    } catch (ClassNotFoundException err) {
        out.println("class錯誤: " + err.toString());
    } catch (SQLException sExec) {
        out.println("SQL錯誤: " + sExec.toString());
    } finally {
        // 關閉資源
        try {
            if (rsEmail != null) rsEmail.close();
            if (pstmtEmail != null) pstmtEmail.close();
            if (rsPwd != null) rsPwd.close();
            if (pstmtPwd != null) pstmtPwd.close();
            if (pstmtInsert != null) pstmtInsert.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

