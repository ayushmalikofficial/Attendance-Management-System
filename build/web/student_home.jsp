<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html>
<html>
        <head>
                    <link rel="stylesheet" type="text/css" href="css/styles.css">
                    <link rel="icon" type="image/gif" href="Favicon.ico" />
                    <title>Student</title>
        
                    <script>
                                function Unhide(form1)
                                        {
                                            var x = document.getElementById("myDIV");
                                            if (x.style.display === "none") 
                                            {
                                                x.style.display = "block";
                                            } 
                                            else 
                                            {
                                                x.style.display = "none";
                                            }
                                            
                                            }
                                                
                                function monthly_attendance(form1)
                                        {
                                            form1.action="monthly_attendance_temp.jsp";
                                        }
                                 function summative_attendance(form1)
                                        {
                                            form1.action="summative_attendance.jsp";
                                        }
            
                    </script>
    
    
        </head>
    
        <body>
         <form method="POST">
                     <c:set var="flag" value="0"/>    
                    <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/attendance"
                                       user="root" password="amalik"></sql:setDataSource>
         
            
                    <sql:query dataSource="${db}" var="result">
                                        select Roll_No,Name,Year_of_Admission,University_Enrollment_No,Class_Name,Semester,Section from Student s,Class c
                                        where s.User_Id=? and s.Password=? and s.class_id=c.class_id;
                                        <sql:param value="${param.user_id}"></sql:param>
                                        <sql:param value="${param.password}"></sql:param>
                    </sql:query>
           
            
                    <c:choose>
                
                       
                                <c:when test="${result.rowCount== 0}">  
                                        <h2 style="margin-top: 100px;">Record Not Found</h2>  
                                        <div>
                                            <p style="text-align:center;font-size:18px;">Check Your Credentials</p>
                                        </div> 
                                             <br>
                                          <c:set var="flag" value="1"/>   
                                             
                                </c:when> 
                  
                                <c:otherwise>
                 
                                        <h2 style="margin-top:20px;">Your Details</h2>
                                        <div style="padding:15px;margin-left:200px;margin-right:200px";>
            
                                                <table style="width:100%;border-spacing:10px">
             
                                                        <c:forEach var="row" items="${result.rows}">
            
                                                                <tr>
                                                                    <td class="m1">Name:</td>
                                                                    <td class="m2"><c:out value="${row.Name}"></c:out></td>
                                                                    <c:set var="x" value="${row.Roll_No}"></c:set>
                                                                    <input type="hidden" value="${row.Name}" name="stname"/>
                                                                </tr>
    
                                                                <tr>
                                                                    <td class="m1">Roll Number:</td>
                                                                    <td class="m2"><c:out value="${row.Roll_No}"></c:out></td>
                                                                    <input type="hidden" value="${row.Roll_No}" name="stroll_no"/>
                                                                
                                                                </tr>

                                                                <tr>
                                                                    <td class="m1">Class:</td>
                                                                    <td class="m2"><c:out value="${row.Class_Name}"></c:out></td> 
                                                                    <input type="hidden" value="${row.Class_Name}" name="stclass_name"/>
                                                                </tr>
                        
                                                                <tr>
                                                                    <td class="m1">Semester:</td>
                                                                    <td class="m2"><c:out value="${row.Semester}"></c:out></td> 
                                                                    <input type="hidden" value="${row.Semester}" name="stsemester"/>
                                                                </tr>

                                                                <tr>
                                                                    <td class="m1">Section:</td>
                                                                    <td class="m2"> <c:out value="${row.Section}"></c:out></td> 
                                                                    <input type="hidden" value="${row.Section}" name="stsection"/>
                                                                </tr>
                         
                                                                <tr>
                                                                    <td class="m1">Year of Admission:</td>
                                                                    <td class="m2"> <c:out value="${row.Year_of_Admission}"></c:out></td> 
                                                                    <input type="hidden" value="${row.Year_of_Admission}" name="styear_of_admission"/>
                                                                </tr>
                         
                                                                <tr>
                                                                    <td class="m1">Enrollment Number:</td>
                                                                    <td class="m2"><c:out value="${row.University_Enrollment_No}"></c:out></td> 
                                                                    <input type="hidden" value="${row.University_Enrollment_No}" name="stuniversity_enrollment_no"/>
                                                                </tr>
                             
                                                            </c:forEach>
            
                                                    </table>
           
                                                    <br>
                                                    <br>
            
                                                    <input type="button" style="text-align:center;font-size:18px;width:450px;height: 38px;border-radius:10px;background-color:tomato;color:white;border:0px;" class="mybutton2" value="View Monthly Attendance" name="monthly" onClick="Unhide(this.form)">
                                                    <br>
     
                                                <div id="myDIV" style="display:none">
                                                    <br>
               
                                                    <table style="width:83%;border-spacing:10px">
                                                                <tr>
                                                                    
                                                                    <td class="m1"  >Select Month</td>
                                                                    <td class="m1">
                                                                        <select style="border-radius:5px;width:90px;"name="month">
                 
                                                                        <option value="0" selected></option>
                                                                        <option value="1">January</option>
                                                                        <option value="2">February</option>
                                                                        <option value="3">March</option>
                                                                        <option value="4">April</option>
                                                                        <option value="5">May</option>
                                                                        <option value="6">June</option>
                                                                        <option value="7">July</option>
                                                                        <option value="8">August</option>
                                                                        <option value="9">September</option>
                                                                        <option value="10">October</option>
                                                                        <option value="11">November</option>
                                                                        <option value="12">December</option>
                                                                        
                                                                        </select>
                                                                    </td>
                                                                </tr>
                
                
                                                                <tr>
                                                                    <td class="m1" >Select Year</td>
                                                                    <td class="m1">
                                                                        
                                                                        <select style="border-radius:5px;width:90px;"name="year" >
                 
                                                                        <option value="0" selected></option>
                                                                        <option value="2017">2017</option>
                                                                        <option value="2018">2018</option>
                                                                        <option value="2019">2019</option>
                                                                        <option value="2020">2020</option>
                                                                        <option value="2021">2021</option>
                                                                        <option value="2022">2022</option>
                                                                        <option value="2023">2023</option>
                                                                        <option value="2024">2024</option>
                                                                        <option value="2025">2025</option>
                                                                        <option value="2026">2026</option>
                                                                        <option value="2027">2027</option>
                                                                        <option value="2028">2028</option>
                                                                        <option value="2029">2029</option>
                                                                        <option value="2030">2030</option>
                                                                        <option value="2031">2031</option>
                                                                        <option value="2032">2032</option>
                                                                        <option value="2033">2033</option>
                                                                        <option value="2034">2034</option>
                                                                        <option value="2035">2035</option>
                                                                        <option value="2036">2036</option>
                                                                        <option value="2037">2037</option>
                                      
                                                                        </select>
                                                                    </td>
                                                                </tr>
                
                                                                <tr>
                    
                                                                        <sql:query dataSource="${db}" var="result2">
                                                                                select name,ss.subject_id from student_subject ss,subject su where student_id=? and ss.subject_id=su.subject_id;
                                                                                <sql:param value="${x}"></sql:param>
                                                                        </sql:query>
             
                                                                    <td class="m1">Select Subject</td>
                                                                    <td class="m1">
                                                                        <select style="border-radius:5px;width:80px;"name="subject">
                                                                                <option value="0" selected></option>
                                                                                    <c:forEach var="j" items="${result2.rows}">
                                                                                <option value="${j.subject_id}">  <c:out value="${j.subject_id}"></c:out>   <c:out value="${j.name}"></c:out>  </option>
                                                                                    </c:forEach> 
                                                                        </select>
                                                                    </td>
                                                                
                                                                </tr>
                                                                <tr>
                                                                    <td class="m1"></td>
                                                                    <td class="m1">
                                                                    <input class="mybutton" style="width:100px;border-radius:6px;"type="submit" value="SUBMIT" onClick="monthly_attendance(this.form);">
                                                                    <td>                                 
                                                                </tr>                                 
                                                         </table>
                                                    <br>
                
                                                </div>
                                                    <br>
                                                    <input style="text-align:center;font-size:18px;width:450px;height: 38px;border-radius:10px;background-color:tomato;color:white;border:0px;" class="mybutton2"type="submit" class="mybutton2" value="View Summative Attendance" name="summative" onClick="summative_attendance(this.form);">
                                        </div>

                 <br>
      
      
            
                                </c:otherwise>
            
            
            
            
                      
                    </c:choose> 
                    <input type="hidden" value="${param.college}" name="college"/>
        
         <input type="hidden" value="${param.user_id}" name="user_id"/> 
         <input type="hidden" value="${param.password}" name="password"/>
         </form>   
        
        <c:choose>
         
        <c:when test="${flag==1}"> 
        <form action="login.jsp">
          
            <input style="width: 225px;height :30px;" class="mybutton" type="Submit" value="Back" > 
          
        </form>
        </c:when>
        <c:otherwise>
                
            
         <form action="login.jsp">
         
          <input style="width: 225px;height :30px;" class="mybutton" type="Submit" value="Log Out" > 
        </form>
        </c:otherwise>
        </c:choose>           
        
          </body>
</html>
