<!-- Step 0: import library -->
<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>列出所有留言</title>
</head>
<body>
<a href="board.jsp">留言版</a><p>
<%
try {
//Step 1: 載入資料庫驅動程式 
    Class.forName("com.mysql.jdbc.Driver");
    try {
//Step 2: 建立連線 	
        String url="jdbc:mysql://localhost/?serverTimezone=UTC";
        String sql="";
        Connection con=DriverManager.getConnection(url,"root","1234");
        if(con.isClosed())
           out.println("連線建立失敗");
        else {
//Step 3: 選擇資料庫   
           sql="USE `team11_silverwrb`";
           con.createStatement().execute(sql);
//Step 4: 執行 SQL 指令, 若要操作記錄集, 需使用executeQuery, 才能傳回ResultSet	
           sql="SELECT * FROM `guestbook`"; //算出共幾筆留言
           ResultSet rs=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY).executeQuery(sql);
           rs.last();
           int total_content=rs.getRow();
           out.println("共"+total_content+"筆留言<p>");
           
           //每頁顯示5筆, 算出共幾頁
           int page_num=(int)Math.ceil((double)total_content/5.0);
           
           // 跳轉相對應頁面
		   for(int i=1;i<=page_num;i++)
           out.println("<form action='boardtest.jsp' method='get'>");
		    
           out.println("跳轉至第<input type='number' name='page' min='1' max='" + page_num + "' style='width: 50px;'/>頁");
		   
           out.println("<input type='submit' value='跳轉'/>");
           out.println("</form>");
           out.println("<p>");

           //讀取page變數
           String page_string = request.getParameter("page");
           if (page_string == null) 
               page_string = "0";          
           int current_page=Integer.valueOf(page_string);
           if(current_page==0) 
	          current_page=1;
 
//Step 5: 顯示結果 
           int start_record=(current_page-1)*5;
           //遞減排序, 讓最新的資料排在最前面
           sql="SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT ";
           sql+=start_record+",5";

// current_page... SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT
//      current_page=1: SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT 0, 5
//      current_page=2: SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT 5, 5
//      current_page=3: SELECT * FROM `guestbook` ORDER BY `GBNO` DESC LIMIT 10, 5
           rs=con.createStatement().executeQuery(sql);
//  逐筆顯示, 直到沒有資料(最多還是5筆)
           while(rs.next())
                {
                 out.println("留言主題:"+rs.getString(4)+"<br>");
                 out.println("訪客姓名:"+rs.getString(2)+"<br>");
                 out.println("E-mail:"+rs.getString(3)+"<br>");
                 out.println("留言內容:"+rs.getString(5)+"<br>");
                 out.println("留言時間:"+rs.getString(6)+"<br><hr>");
          }
//Step 6: 關閉連線
          con.close();
      }
    }
    catch (SQLException sExec) {
           out.println("SQL錯誤"+sExec.toString());
		   
    }
}
catch (ClassNotFoundException err) {
      out.println("class錯誤"+err.toString());
}
%>
</body>
</html>
