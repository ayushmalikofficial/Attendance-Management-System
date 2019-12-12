<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Monthly Attendance</title>
        <link rel="stylesheet" type="text/css" href="css/styles.css">
        <link rel="icon" type="image/gif" href="Favicon.ico" />
    </head>

    <style>
                 td.m3{
                    text-align:center;
                    padding:5px;
                    font-size:17px;
                    border:0px;
                    background-color: white;
                    border-radius: 5px;
                        }  
     
    </style>
  
    <body>
       <form method="POST"  action="student_home.jsp">
        <h2>Monthly Attendance</h2>
       
        
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" 
                           url="jdbc:mysql://localhost:3306/attendance" 
                           user="root" password="amalik"></sql:setDataSource> 
    
        
        <sql:query dataSource="${db}" var="results">
          select sum(a1.tut_attend) as tua,sum(a1.prac_attend) as pa,sum(a1.theory_attend) as tha,sum(a2.tut_conduct) as tuc,sum(a2.theory_conduct) as thc,sum(a2.prac_conduct) as pc from ((attendance_1 a1 JOIN attendance_2 a2 on a1.subject_id=a2.subject_id and a1.date=a2.date)) where student_id=? and a1.subject_id=? and month(a2.date)=? and year(a2.date)=?; 
           <sql:param value="${param.stroll_no}"></sql:param>
           <sql:param value="${param.subject}"></sql:param>
           <sql:param value="${param.month}"></sql:param>
           <sql:param value="${param.year}"></sql:param>
          
        </sql:query>
           
        <sql:query dataSource="${db}" var="sub_result">
              select name from subject where subject_id=?;
              <sql:param value="${param.subject}"></sql:param>
        </sql:query>
              
              
              
              <c:forEach var="j" items="${sub_result.rows}">
                  <c:set var="z" value="${j.name}"></c:set>
              </c:forEach>
        
              
              <c:forEach var="row" items="${results.rows}">
               <c:set var="tut_attend" value="${row.tua}"></c:set>
               <c:set var="prac_attend" value="${row.pa}"></c:set>  
               <c:set var="theory_attend" value="${row.tha}"></c:set>  
               <c:set var="tut_conduct" value="${row.tuc}"></c:set>  
               <c:set var="theory_conduct" value="${row.thc}"></c:set>  
               <c:set var="prac_conduct" value="${row.pc}"></c:set> 
             </c:forEach>
         
              
              <c:set var="theory_attend_sum" value="0"></c:set>
              <c:set var="theory_conduct_sum" value="0"></c:set>
              <c:set var="prac_attend_sum" value="0"></c:set>
              <c:set var="prac_conduct_sum" value="0"></c:set>
              <c:set var="tut_attend_sum" value="0"></c:set>
              <c:set var="tut_conduct_sum" value="0"></c:set>
              
        <div style="padding:15px;margin-left:10px;margin-right:10px;">
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
            <tr>
                <td class="m1">Subject Name</td>
                <td class="m2"><c:out value="${z}"></c:out></td>
                <td class="m1">Subject ID:</td>
                <td class="m2"><c:out value="${param.subject}"></c:out></td>
            </tr>
            <tr>
                <td class="m1">Month:</td>
                <td class="m2"><c:out value="${param.month}"></c:out></td>
                <td class="m1">Year:</td>
                <td class="m2"><c:out value="${param.year}"></c:out></td>
            </tr>            
        
          </table> 
        
         <table style="border-radius:10px;background-color:white;padding:10px;;margin-top: 50px;">
                <tr style="background-color">
                    <th style="text-align:left;">Type of Class</th>
                    <th  colspan="31">Date</th>
                    <th >Total</th>
                </tr>
                <tr>
                    
                <th></th>
                <% for(int i=1;i<32;i++){ %>
                    <th><%out.print(i);%></th>
                <% } %>
                    <th>
                        
                    </th>
                    
                </tr>
                
                <tr>
                    <td style="background-color: pink;"class="m3">Theory</td>
                    <% for(int i=1;i<32;i++){ %>
                    <sql:query dataSource="${db}" var="th_result">
                     select theory_attend ,theory_conduct from ((attendance_1 a1 JOIN attendance_2 a2 on a1.subject_id=a2.subject_id and a1.date=a2.date)) where student_id=? and a1.subject_id=? and day(a2.date)=? and month(a2.date)=? and year(a2.date)=?;
                     <sql:param value="${param.stroll_no}"></sql:param>
                     <sql:param value="${param.subject}"></sql:param>
                     <sql:param value="<%=i%>"></sql:param>
                     <sql:param value="${param.month}"></sql:param>
                     <sql:param value="${param.year}"></sql:param>
                    </sql:query>
              
                     <c:choose>
                         <c:when test="${th_result.rowCount==0}">
                         <td class="m3">-/-</td>
                         </c:when>    
                         <c:otherwise>
                         <c:forEach var="r" items="${th_result.rows}">
                         <td class="m3"><c:out value="${r.theory_attend}"></c:out>/<c:out value="${r.theory_conduct}"></c:out></td>
                           <c:set var="theory_attend_sum" value="${theory_attend_sum+r.theory_attend}"></c:set>
                           <c:set var="theory_conduct_sum" value="${theory_conduct_sum+r.theory_conduct}"></c:set>
                          </c:forEach>
                         </c:otherwise>
                     </c:choose>
                     
                    <% } %>
                    <c:choose>
                        <c:when test="${theory_conduct_sum==0}">
                          <td class="m3">Not Applicable</td>       
                        </c:when>
                        <c:otherwise>
                          <td class="m3"><c:out value="${(100*theory_attend_sum)/theory_conduct_sum}"></c:out>%</td>                
                    </c:otherwise>
                    </c:choose>
                    
                  
                </tr>  
                    
                <tr>
                    <td style="background-color: pink;"class="m3">Practical</td>
                    <% for(int i=1;i<32;i++){ %>
                    <sql:query dataSource="${db}" var="prac_result">
                     select prac_attend ,prac_conduct from ((attendance_1 a1 JOIN attendance_2 a2 on a1.subject_id=a2.subject_id and a1.date=a2.date)) where student_id=? and a1.subject_id=? and day(a2.date)=? and month(a2.date)=? and year(a2.date)=?;
                     <sql:param value="${param.stroll_no}"></sql:param>
                     <sql:param value="${param.subject}"></sql:param>
                     <sql:param value="<%=i%>"></sql:param>
                     <sql:param value="${param.month}"></sql:param>
                     <sql:param value="${param.year}"></sql:param>
                    </sql:query>
              
                     <c:choose>
                         <c:when test="${prac_result.rowCount==0}">
                         <td class="m3">-/-</td>
                         </c:when>    
                         <c:otherwise>
                         <c:forEach var="r" items="${prac_result.rows}">
                      <td class="m3"><c:out value="${r.prac_attend}"></c:out>/<c:out value="${r.prac_conduct}"></c:out></td>
                           <c:set var="prac_attend_sum" value="${prac_attend_sum+r.prac_attend}"></c:set>
                           <c:set var="prac_conduct_sum" value="${prac_conduct_sum+r.prac_conduct}"></c:set>
  
                         </c:forEach>
                         </c:otherwise>
                     </c:choose>
                     
                    
                    
                    <% } %>
                    <c:choose>
                        <c:when test="${prac_conduct_sum==0}">
                            <td class="m3">Not Applicable</td>       
                        </c:when>
                        <c:otherwise>
                        <td class="m3"><c:out value="${(100*prac_attend_sum)/prac_conduct_sum}"></c:out>%</td>                
                        </c:otherwise>
                    </c:choose>
                   
                </tr>
                <tr>
                    <td style="background-color: pink;"class="m3">Tutorials</td>
                    
                    <% for(int i=1;i<32;i++){ %>
                    
                    <sql:query dataSource="${db}" var="tu_result">
                     select tut_attend ,tut_conduct from ((attendance_1 a1 JOIN attendance_2 a2 on a1.subject_id=a2.subject_id and a1.date=a2.date)) where student_id=? and a1.subject_id=? and day(a2.date)=? and month(a2.date)=? and year(a2.date)=?;
                     <sql:param value="${param.stroll_no}"></sql:param>
                     <sql:param value="${param.subject}"></sql:param>
                     <sql:param value="<%=i%>"></sql:param>
                     <sql:param value="${param.month}"></sql:param>
                     <sql:param value="${param.year}"></sql:param>
                    </sql:query>
              
                     <c:choose>
                         <c:when test="${tu_result.rowCount==0}">
                         <td class="m3">-/-</td>
                         </c:when>    
                         <c:otherwise>
                         <c:forEach var="r" items="${tu_result.rows}">
                      <td class="m3"><c:out value="${r.tut_attend}"></c:out>/<c:out value="${r.tut_conduct}"></c:out></td>
                          <c:set var="tut_attend_sum" value="${tut_attend_sum+r.tut_attend}"></c:set>
                          <c:set var="tut_conduct_sum" value="${tut_conduct_sum+r.tut_conduct}"></c:set>
  
                         </c:forEach>
                         </c:otherwise>
                     </c:choose>
                     
                    
                    
                    <% } %>
                    <c:choose>
                        <c:when test="${tut_conduct_sum==0}">
                            <td class="m3">Not Applicable</td>          
                        </c:when>
                        <c:otherwise>
                          <td class="m3"><c:out value="${(100*tut_attend_sum)/tut_conduct_sum}"></c:out>%</td>
                        </c:otherwise>
                    </c:choose>
                    
                </tr>
            
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
