<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html>
<html>
    <head>
            <link rel="stylesheet" type="text/css" href="css/styles.css">
            <link rel="icon" type="image/gif" href="Favicon.ico" />
            <title>Teacher</title>
        
            <script>
                function Unhide1(form1)
                {
                    var x = document.getElementById("myDIV1");
                    if (x.style.display === "none") 
                    {
                        x.style.display = "block";
                    } 
                    else 
                    {
                        x.style.display = "none";
                    }
                
                }
                function Unhide2(form1)
                {
                    var x = document.getElementById("myDIV2");
                    if (x.style.display === "none") 
                    {
                        x.style.display = "block";
                    } 
                    else 
                    {
                        x.style.display = "none";
                    }
                
                }
                function Unhide3(form1)
                {
                    var x = document.getElementById("myDIV3");
                    if (x.style.display === "none") 
                    {
                        x.style.display = "block";
                    } 
                    else 
                    {
                        x.style.display = "none";
                    }
                
                }
                
            
                function takeattendance(form1)
                {   
                    form1.action="take_attendance.jsp";
                }
                function viewattendance(form1)
                {    
                    form1.action="view_attendance.jsp";
                }
                function editattendance(form1)
                {   
                    form1.action="edit_attendance.jsp";
                }   
            
            </script>
    
    
    </head>
    
    <body>     
        <form method="POST">
             <c:set var="flag" value="0"/> 
            <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/attendance"
                           user="root" password="amalik"></sql:setDataSource>
        
            <sql:query dataSource="${db}" var="result">
                    select Name,Department,Teacher_id from Teacher where user_id=? and password=?;
                    <sql:param value="${param.user_id}"></sql:param>
                    <sql:param value="${param.password}"></sql:param>
            </sql:query>
           
             <c:choose>
                
                <c:when test="${result.rowCount== 0}">  
                      <h2 style="margin-top: 100px;">Record Not Found</h2>  
                      <div>
                          <p style="text-align:center;font-size:18px;">Invalid Credentials</p>
                       <c:set var="flag" value="1"/> 
                      </div> 
                 <br>
      
      
                </c:when> 
                      
                <c:otherwise>
                    
                
                <h2 style="margin-top:20px;">Your Details</h2>
                    <div style="padding:15px;margin-left:200px;margin-right:200px;">
                        <table style="width:100%;border-spacing:10px">
             
                            <c:forEach var="row" items="${result.rows}">
            
                                <tr>
                                    <td class="m1">Name:</td>
                                    <td class="m2"><c:out value="${row.Name}"></c:out></td>
                                    <c:set var="x" value="${row.Teacher_Id}"></c:set>
                                    <input type="hidden" name="tname" value="${row.Name}"/>
                                </tr>
    
                                <tr>
                        
                                    <td class="m1">Department:</td>
                                    <td class="m2"><c:out value="${row.Department}"></c:out></td> 
                              
                                </tr>
                
                                <tr>
                    
                                    <sql:query dataSource="${db}" var="result2">
                                        select su.name,subject_id from subject su,teacher t where t.teacher_id=? and t.teacher_id=su.teacher_id;
                                        <sql:param value="${x}"></sql:param>
                                    </sql:query>
             
                                    <td class="m1">Select Subject</td>
                                    <td class="m1">
                                        <select required="required" style="border-radius:5px;width:80px;"name="subject">
                                                <option value="0" selected></option>
                                                <c:forEach var="j" items="${result2.rows}">
                                                <option value="${j.subject_id}">  <c:out value="${j.subject_id}"></c:out>   <c:out value="${j.name}"></c:out>  </option>
                                                </c:forEach> 
                        
                                     </select>
                                    </td>
                                </tr>
                               
                            </c:forEach>
                                <tr>
                        
                                    <td class="m1">Select Class Type:</td>
                                    <td  style="text-align:left;padding:5px;font-size:17px;border:0px; ">
                                            <input type="radio" name="attendance_type" value="theory" required="required"/>Theory
                                            <input type="radio" name="attendance_type" value="practical"/>Practical
                                            <input type="radio" name="attendance_type" value="tut"/>Tutorial
                                    
                                    </td> 
                              
                                </tr>
                               
                         </table>          
                         
                        <br>
                        <input style="text-align:center;font-size:18px;width:450px;height: 38px;border-radius:10px;background-color:tomato;color:white;border:0px;" class="mybutton2" type="button"  value="Mark Attendance" name="take_attendance" onClick="Unhide3(this.form)">

                        <div id="myDIV3" style="display:none;">
                           <table style="width:70%;border-spacing:10px;">    
                                 <tr>
                        
                                    <td class="m1">Select the No of Classes:</td>
                                    

                                    <td class='m1'>
                                        <select required="required" style="border-radius:5px;width:80px"name="num_class" required="required">
                                        
                                                <option value="0" ></option>
                                                <option value="1" >1</option>
                                                <option value="2" >2</option>
                                                <option value="3" >3</option>
                                                <option value="4" >4</option>
                                                <option value="5" >5</option>
                                                <option value="6" >6</option>
                                                <option value="7" >7</option>
                                                <option value="8" >8</option>
                                                 
                        
                                         </select>
                                    </td>
                                </tr>
                                 
                                 <tr>
                                     <td></td>
                                     <td class="m1">
                                        <input class="mybutton" style="width:100px;border-radius:6px;"type="submit" value="SUBMIT" onClick="takeattendance(this.form)" >
                                    </td>
                                    
                                </tr>
                            </table>
                        </div>
                        <br>
                        <br>
                        <input style="text-align:center;font-size:18px;width:450px;height: 38px;border-radius:10px;background-color:blueviolet;color:white;border:0px;" class="mybutton2" type="button"  value="Edit Attendance" name="edit_attendance" onClick="Unhide1(this.form)">
                        <div id="myDIV1" style="display:none" >
                            <table style="width:100%;border-spacing:10px;">    
                                <tr>
                                    <td class="m1">Enter the Date:</td>
                                    <td class="m1">
                                        <input style="border-radius: 6px; "type="date" name="abc">
                                    </td>
                                 </tr>   
                                 
                                 <tr>
                                     <td class="m1"></td>
                                     <td class="m1">
                                        <input class="mybutton" style="width:100px;border-radius:6px;"type="submit" value="SUBMIT" onClick="editattendance(this.form)" >
                                    </td>
                                    
                                </tr>
                            </table>
                        </div>
                        <br>
                        <br>
                        <input style="text-align:center;font-size:18px;width:450px;height: 38px;border-radius:10px;background-color:blueviolet;color:white;border:0px;" type="button" class="mybutton2" value="View Attendance" name="view_attendance" onClick="Unhide2(this.form)">
                        <br>
                        <div id="myDIV2" style="display:none;">
                            <table style="width:100%;border-spacing:10px;">    
                                <tr>
                                    <td class="m1">Enter the Date:</td>
                                
                                    <td class="m1">
                                        <input style="border-radius: 6px; "type="date" name="date">
                                    </td>
                                 </tr>   
                                 
                                 <tr>
                                     <td class="m1"></td>
                                     <td class="m1">
                                        <input class="mybutton" style="width:100px;border-radius:6px;"type="submit" value="SUBMIT" onClick="viewattendance(this.form)">
                                    </td>
                                    
                                    
                                </tr>
                            </table>
                        </div>
                        <br>
                        <br>
                      
                              
                
                    </div>
                <br>
                
                                    
                </c:otherwise>
                      
                      
             </c:choose>
                
                
                
                <input type="hidden" value="${param.college}" name="college"/>
                <input type="hidden" name="user_id" value="${param.user_id}"/>
                <input type="hidden" name="password" value="${param.password}"/>
                
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
    

