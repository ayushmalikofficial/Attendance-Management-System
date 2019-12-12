<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<html>
    <head>
        <title>
            Untitled Page
        </title>
        <link rel="icon" type="image/gif" href="Favicon.ico" />
    </head>
    <body  onload='attedn_sucess()'>
       
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/attendance"
                           user="root" password="amalik"></sql:setDataSource>
         <% int i=0;%>
         <c:choose>
             <c:when test="${param.attendance_type=='theory'}">
        <c:forEach begin="1" end="${param.num_update}" step="1">
            
           
        <sql:update dataSource="${db}">
            update attendance_1 set theory_attend=? where date=? and subject_id=? and student_id=?
            <sql:param value='<%=request.getParameter("stu"+i)%>'></sql:param>
            <sql:param value='${param.date}'></sql:param>
            <sql:param value='${param.subject}'></sql:param>
            <sql:param value='<%=request.getParameter("roll"+i)%>'></sql:param>
        </sql:update>
            <%i++;%>
        </c:forEach>
             </c:when>
            <c:when test="${param.attendance_type=='practical'}">
                <c:forEach begin="1" end="${param.num_update}" step="1">
            
           
        <sql:update dataSource="${db}">
            update attendance_1 set prac_attend=? where date=? and subject_id=? and student_id=?
            <sql:param value='<%=request.getParameter("stu"+i)%>'></sql:param>
            <sql:param value='${param.date}'></sql:param>
            <sql:param value='${param.subject}'></sql:param>
            <sql:param value='<%=request.getParameter("roll"+i)%>'></sql:param>
        </sql:update>
            <%i++;%>
        </c:forEach>
            </c:when>
            <c:when test="${param.attendance_type=='tut'}">
                <c:forEach begin="1" end="${param.num_update}" step="1">
            
           
        <sql:update dataSource="${db}">
            update attendance_1 set tut_attend=? where date=? and subject_id=? and student_id=?
            <sql:param value='<%=request.getParameter("stu"+i)%>'></sql:param>
            <sql:param value='${param.date}'></sql:param>
            <sql:param value='${param.subject}'></sql:param>
            <sql:param value='<%=request.getParameter("roll"+i)%>'></sql:param>
        </sql:update>
            <%i++;%>
        </c:forEach>
            </c:when>
            </c:choose>
            
            
            
            
           
        <script type="text/javascript">
                function attedn_sucess()
                {
                    alert("Attendance Edited Successfully !");
                    document.myform.submit();
                }
                
            </script>
            <form action="faculty_home.jsp" name="myform">
                <input type="hidden" value="${param.user_id}" name="user_id"/> 
                <input type="hidden" value="${param.password}" name="password"/>
            </form>
    </body>
</html>