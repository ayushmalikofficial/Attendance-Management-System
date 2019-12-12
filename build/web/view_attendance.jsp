
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/styles.css"/>
        <link rel="icon" type="image/gif" href="Favicon.ico"/>
        <title>View Attendance</title>
    </head>
    <body>
     <h2 style="margin-top:20px;">Details</h2>
                    
         <div style="padding:15px;margin-left:200px;margin-right:200px;">
                        <table style="width:100%;border-spacing:10px">
             
                           
            
                                <tr>
                                    <td class="m1">Faculty:</td>
                                    <td class="m2"><c:out value="${param.tname}"></c:out></td>
                                    <td class="m1">Date:</td>
                                    <td class="m2"><c:out value="${param.date}"></c:out></td>
                                    
                        
                                </tr>
    
                                <tr>
                        
                                    <td class="m1">Subject:</td>
                                    <td class="m2"><c:out value="${param.subject}"></c:out></td> 
                                    <td class="m1">Attendance Type:</td>
                                    <td class="m2"><c:out value='<%= request.getParameter("attendance_type").toUpperCase() %>'></c:out></td>
                                    
                                </tr>
                
                                
                            </table>
                            </div>
      <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/attendance"
                           user="root" password="amalik"></sql:setDataSource>
      <c:choose>
            
          
          
          
          
          
          
          
          
        <c:when test="${param.attendance_type=='theory'}">
        <sql:query dataSource="${db}" var="rs">
            select theory_conduct from attendance_2 where  Date=? and Subject_id=?;
            <sql:param value="${param.date}"></sql:param>
            <sql:param value="${param.subject}"></sql:param>
        </sql:query>
            <c:choose>
                <c:when test="${rs.rowCount== 0}">
                    <div>
                          <p style="text-align:center;font-size:18px;">No Class Conducted</p>
                      </div> 
                </c:when>
                <c:otherwise>
      <c:forEach var="row" items="${rs.rows}">
          <c:set var="total" value="${row.theory_conduct}"></c:set>
      </c:forEach>
        <sql:query dataSource="${db}" var="rs1">
            select Roll_no,Name,theory_attend from attendance_1,student where Roll_no=Student_id and Date=? and Subject_id=?;
            <sql:param value="${param.date}"></sql:param>
            <sql:param value="${param.subject}"></sql:param>
        </sql:query>
            <h2 style="margin-top:20px;">List of Students</h2>
           
               
            <div style="padding:15px;margin-left:200px;margin-right:200px">
                    
                <table style="background-color: #ecf0f1;border:0px;padding:10px;border-radius:10px" align="center">
                    <tr style="border:0px ;border-radius:5px;margin-bottom:20px">
                        <th>Roll Number</th>
                        <th>Student Name</th>
                        <th>Attendance(<c:out value="${total}"></c:out>)</th>  
                    </tr>
                       <c:forEach var="row1" items="${rs1.rows}">
                        <tr>
                            <td class="m2"><c:out value="${row1.Roll_no}"></c:out></td>
                            <td class="m2"style="width:850px;"><c:out value="${row1.Name}"></c:out></td>
                            <td class="m2"align="center"><c:out value="${row1.theory_attend}"></c:out></td>
                        </tr>
                    </c:forEach>
                </table>
                    <br><br>
               
                </div>
           
            </c:otherwise>
         </c:choose>  
        </c:when>
           
            
            
            
            
            
            
            
            
            
            
            
            <c:when test="${param.attendance_type=='practical'}">
                     <sql:query dataSource="${db}" var="rs">
            select prac_conduct from attendance_2 where  Date=? and Subject_id=?;
            <sql:param value="${param.date}"></sql:param>
            <sql:param value="${param.subject}"></sql:param>
        </sql:query>
            
            <c:choose>
                <c:when test="${rs.rowCount== 0}">
                    <div>
                          <p style="text-align:center;font-size:18px;">No Class Conducted</p>
                      </div> 
                </c:when>
                <c:otherwise>
      <c:forEach var="row" items="${rs.rows}">
          <c:set var="total" value="${row.prac_conduct}"></c:set>
      </c:forEach>
        <sql:query dataSource="${db}" var="rs1">
            select Roll_no,Name,prac_attend from attendance_1,student where Roll_no=Student_id and Date=? and Subject_id=?;
            <sql:param value="${param.date}"></sql:param>
            <sql:param value="${param.subject}"></sql:param>
        </sql:query>
            <h2 style="margin-top:20px;">List of Students</h2>
           
               
            <div style="padding:15px;margin-left:200px;margin-right:200px">
                    
                <table style="background-color: #ecf0f1;border:0px;padding:10px;border-radius:10px" align="center">
                    <tr style="border:0px ;border-radius:5px;margin-bottom:20px">
                        <th>Roll Number</th>
                        <th>Student Name</th>
                        <th>Attendance(<c:out value="${total}"></c:out>)</th>  
                    </tr>
                       <c:forEach var="row1" items="${rs1.rows}">
                        <tr>
                            <td class="m2"><c:out value="${row1.Roll_no}"></c:out></td>
                            <td class="m2"style="width:850px;"><c:out value="${row1.Name}"></c:out></td>
                            <td class="m2"align="center"><c:out value="${row1.prac_attend}"></c:out></td>
                        </tr>
                    </c:forEach>
                </table>
                    <br><br>
               
                </div>
           
              </c:otherwise>
         </c:choose>    
            </c:when>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            <c:when test="${param.attendance_type=='tut'}">
                <sql:query dataSource="${db}" var="rs">
            select tut_conduct from attendance_2 where  Date=? and Subject_id=?;
            <sql:param value="${param.date}"></sql:param>
            <sql:param value="${param.subject}"></sql:param>
        </sql:query>
            <c:choose>
                <c:when test="${rs.rowCount== 0}">
                    <div>
                          <p style="text-align:center;font-size:18px;">No Class Conducted</p>
                      </div> 
                </c:when>
                <c:otherwise>
      <c:forEach var="row" items="${rs.rows}">
          <c:set var="total" value="${row.tut_conduct}"></c:set>
      </c:forEach>
        <sql:query dataSource="${db}" var="rs1">
            select Roll_no,Name,tut_attend from attendance_1,student where Roll_no=Student_id and Date=? and Subject_id=?;
            <sql:param value="${param.date}"></sql:param>
            <sql:param value="${param.subject}"></sql:param>
        </sql:query>
            <h2 style="margin-top:20px;">List of Students</h2>
           
               
            <div style="padding:15px;margin-left:200px;margin-right:200px">
                    
                <table style="background-color: #ecf0f1;border:0px;padding:10px;border-radius:10px" align="center">
                    <tr style="border:0px ;border-radius:5px;margin-bottom:20px">
                        <th>Roll Number</th>
                        <th>Student Name</th>
                        <th>Attendance(<c:out value="${total}"></c:out>)</th>  
                    </tr>
                       <c:forEach var="row1" items="${rs1.rows}">
                        <tr>
                            <td class="m2"><c:out value="${row1.Roll_no}"></c:out></td>
                            <td class="m2"style="width:850px;"><c:out value="${row1.Name}"></c:out></td>
                            <td class="m2"align="center"><c:out value="${row1.tut_attend}"></c:out></td>
                        </tr>
                    </c:forEach>
                </table>
                    <br><br>
               
                </div>
           
              </c:otherwise>
         </c:choose>   
            </c:when>
            
            
            
            
            
            
            
       
      </c:choose>  
            
            
            
            <form action="faculty_home.jsp">
                <br>  
                <input style="width: 225px;height :30px;" class="mybutton" type="submit" value="Back"/>
                  <input type="hidden" name="user_id" value="${param.user_id}"/>
                <input type="hidden" name="password" value="${param.password}"/>
              </form>
    </body>
</html>
