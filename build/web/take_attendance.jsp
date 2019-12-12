
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/styles.css"/>
        <title>Take Attendance</title>
        <link rel="icon" type="image/gif" href="Favicon.ico" />
    </head>
    <body>
        <h2 style="margin-top:20px;">List of Students</h2>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/attendance" user="root" password="amalik"></sql:setDataSource>
        <sql:query dataSource="${db}" var="result">
            select roll_no,name from student,(select student_id from student_subject where subject_id=? ) s where roll_no=s.student_id;
            <sql:param value="${param.subject}"></sql:param>
        </sql:query>
           <form action="report.jsp" method="GET" class="login">
            <c:choose>
                
               
                    <c:when test="${result.rowCount== 0}">  
                      <div>
                          <p style="text-align:center;font-size:18px;">No Students</p>
                      </div> 
                     
                      </c:when>
                      
                      <c:otherwise>     
                <div style="padding:15px;margin-left:200px;margin-right:200px">
                
                
                    
                <table style="background-color: #ecf0f1;border:0px;padding:10px;border-radius:10px" align="center">
                    <tr style="border:0px ;border-radius:5px;margin-bottom:20px">
                        <th>Roll Number</th>
                        <th>Student Name</th>
                        <th>Present/Absent</th>  
                    </tr>
                    <c:forEach var="rs" items="${result.rows}">
                        <tr>
                            <td class="m2"><c:out value="${rs.roll_no}"></c:out></td>
                            <td class="m2"style="width:850px;"><c:out value="${rs.name}"></c:out></td>
                            <td class="m2"align="center"><input type="checkbox" name="attend" value="${rs.roll_no}"/></td>
                        </tr>
                    </c:forEach>
                </table>
                    <br><br>
                <input type="hidden" name="scode" value="${param.subject}"/>
                <input type="hidden" name="attend_type" value="${param.attendance_type}"/>
                <input type="hidden" name="num_class" value="${param.num_class}"/>
                <input type="submit" value="Mark Attendance" style="text-align:center;font-size:18px;width:450px;height: 38px;border-radius:10px;background-color:tomato;color:white;border:0px;font-size:18px" class="btn btn-block btn-primary"/>
                <input type="hidden" value="${param.college}" name="college"/>
                <input type="hidden" value="${param.user_id}" name="user_id"/> 
                <input type="hidden" value="${param.password}" name="password"/>
                </div>
                 
                </c:otherwise>
                
            </c:choose>
           </form>  
         
     <form action="faculty_home.jsp">
          
            <input type="hidden" value="${param.user_id}" name="user_id"/> 
            <input type="hidden" value="${param.password}" name="password"/>
                
            <input style="width: 225px;height :30px;" class="mybutton" type="Submit" value="Back" > 
          
        </form>
       
                    
                    
     
                    
                    
            </body>
</html>