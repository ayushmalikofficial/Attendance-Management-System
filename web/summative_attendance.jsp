<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Summative Attendance</title>
        <link rel="stylesheet" type="text/css" href="css/styles.css">
        <link rel="icon" type="image/gif" href="Favicon.ico" />
    </head>
    <body>
       <form method="POST"  action="student_home.jsp">
        <h2>Summative Attendance</h2>
     
        <div style="padding:15px;margin-left:200px;margin-right:200px;">
        <table style="width:100%;border-spacing:10px">
            <tr>
                <td class="m1">Name:</td>    
                <td class="m2"><c:out value="${param.stname}"></c:out></td>
                <td class="m1">Roll Number:</td>
                <td class="m2"><c:out value="${param.stroll_no}"></c:out></td>
            </tr> 
            <tr>
                <td class="m1">Class:</td>
                <td class="m2"><c:out value="${param.stclass_name}"></c:out></td>
                <td class="m1">Semester:</td>
                <td class="m2"><c:out value="${param.stsemester}"></c:out></td>
            </tr>
            <tr>
                <td class="m1">Year of Admission:</td>
                <td class="m2"><c:out value="${param.styear_of_admission}"></c:out></td>
              
        
            </tr>
         </table> 
                <c:set var="flag" value="1"></c:set>
                
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" 
                           url="jdbc:mysql://localhost:3306/attendance" 
                           user="root" password="amalik"></sql:setDataSource> 
         
        <sql:query dataSource="${db}" var="result_1">
          select subject_id from student_subject where student_id=?;
          <sql:param value="${param.stroll_no}"></sql:param>
        </sql:query>
          
        <table style="background-color: #ecf0f1;border:0px;padding:10px;border-radius:10px;" >
           
          
        <c:forEach var="i" items="${result_1.rows}">
        
            <c:set var="subjectid" value="${i.subject_id}"></c:set>
              
             <sql:query dataSource="${db}" var="result_2">
                select sum(a1.tut_attend) as tua,sum(a1.prac_attend) as pa,sum(a1.theory_attend) as tha,sum(a2.tut_conduct) as tuc,sum(a2.theory_conduct) as thc,sum(a2.prac_conduct) as pc from ((attendance_1 a1 JOIN attendance_2 a2 on a1.subject_id=a2.subject_id and a1.date=a2.date)) where student_id=? and a1.subject_id=? ; 
                <sql:param value="${param.stroll_no}"></sql:param>
                <sql:param value="${subjectid}"></sql:param>
               
            </sql:query>
          
            
            <sql:query dataSource="${db}" var="result_3">
                  select name from subject where subject_id=?;
            <sql:param value="${subjectid}"></sql:param>
            </sql:query>
             
            
            <c:forEach var="j" items="${result_3.rows}">
                  <c:set var="subjectname" value="${j.name}"></c:set>
             </c:forEach>
        
              
              <c:forEach var="row" items="${result_2.rows}">
               <c:set var="tut_attend" value="${row.tua}"></c:set>
               <c:set var="prac_attend" value="${row.pa}"></c:set>  
               <c:set var="theory_attend" value="${row.tha}"></c:set>  
               <c:set var="tut_conduct" value="${row.tuc}"></c:set>  
               <c:set var="theory_conduct" value="${row.thc}"></c:set>  
               <c:set var="prac_conduct" value="${row.pc}"></c:set> 
             </c:forEach>
             
            <c:if test="${flag==1}">
                
            
            
                    <tr style="border:0px; border-radius:5px;margin-bottom:20px;">
                    <th align="left" style="width:500px;">Subject</th>
                    <th align="center" style="width:250px;">Theory Attendance</th>
                    <th align="center" style="width:250px;">Practical Attendance</th>
                    <th align="center" style="width:250px;">Tutorial Attendance</th>
                    <th align="center" style="width:250px;">Total</th>
                    
                    <c:set var="flag" value="0"></c:set>
               
                    </tr>
            </c:if>      
                <tr>
                        <td style="background-color: pink;text-align: center;"class="m2"><c:out value="${subjectname}"></c:out></td>
                        <td style="text-align: center;"class="m2"><c:out value="${theory_attend}"></c:out>/<c:out value="${theory_conduct}"></c:out></td>
                        <td style="text-align: center;"class="m2"><c:out value="${prac_attend}"></c:out>/<c:out value="${prac_conduct}"></c:out></td>
                        <td style="text-align: center;"class="m2"><c:out value="${tut_attend}"></c:out>/<c:out value="${tut_conduct}"></c:out></td>
                       
                        <c:choose>        
                            <c:when test="${tut_conduct+theory_conduct+prac_conduct==0}">
                            <td style="background-color: burlywood;text-align: center;"class="m2">Not Applicable</td>
                            </c:when>
                            <c:otherwise>
                            <td style="background-color: burlywood;text-align: center;"class="m2"><c:out value="${(((theory_attend+prac_attend+tut_attend)*100)div(theory_conduct+prac_conduct+tut_conduct)) }"></c:out>%</td>
                            </c:otherwise> 
                        </c:choose>
            </tr>
                 
          
             
        
             
        </c:forEach>
          </table>
               
        
          <input type="hidden" value="${param.college}" name="college"/>
        </div>
               <br>
       
       </form>    
        <form action="student_home.jsp" method="POST">
                <input style="width: 225px;height :30px;" class="mybutton" type="Submit" value="Back" >
                <input type="hidden" value="${param.user_id}" name="user_id"/> 
                <input type="hidden" value="${param.password}" name="password"/>
                </form>
        </body>
</html>
