<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<html>
    <head>
        <link rel="icon" type="image/gif" href="Favicon.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Untitled Page</title>
    </head>
        <c:set var="d" value="<%= new java.sql.Date(System.currentTimeMillis()) %>"></c:set>
        <input type="hidden" value="${param.college}" name="college"/>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/attendance" user="root" password="amalik"></sql:setDataSource>
       <sql:query dataSource="${db}" var="result">
           select * from attendance_2 where Date=? and subject_id=?;
           <sql:param value="${d}"></sql:param>
           <sql:param value="${param.scode}"></sql:param>
       </sql:query>
            <c:if test="${result.rowCount==0}">
                <sql:query dataSource="${db}" var="stu_id">
                     select roll_no,name from student,(select student_id from student_subject where subject_id=? ) s where roll_no=s.student_id;
                    <sql:param value="${param.scode}"></sql:param>
                </sql:query>
                    <c:forEach var="student" items="${stu_id.rows}">
                        <sql:update dataSource="${db}">
                            insert into attendance_1 values(?,?,?,0,0,0);   
                            <sql:param value="${param.scode}"></sql:param>
                            <sql:param value="${student.roll_no}"></sql:param>
                            <sql:param value="${d}"></sql:param>
                        </sql:update>
                    </c:forEach>    
                <sql:update dataSource="${db}">
                        insert into attendance_2 values(?,?,0,0,0);
                        <sql:param value="${param.scode}"></sql:param>
                        <sql:param value="${d}"></sql:param>
                </sql:update>    
            </c:if> 
                        
        <c:choose>
            <c:when test="${param.attend_type=='theory'}">
                <sql:update dataSource="${db}">
                    update attendance_2 set theory_conduct=theory_conduct+? where Date=? and subject_id=?;
                    <sql:param value="${param.num_class}"></sql:param>
                    <sql:param value="${d}"></sql:param>
                    <sql:param value="${param.scode}"></sql:param>
                </sql:update>
                <c:forEach var="prsnt_stu" items="${paramValues.attend}">
                    <sql:update dataSource="${db}">
                        update attendance_1 set theory_attend=theory_attend+? where student_id=? and date=? and subject_id=?;
                        <sql:param value="${param.num_class}"></sql:param>
                        <sql:param value="${prsnt_stu}"></sql:param>
                        <sql:param value="${d}"></sql:param>
                        <sql:param value="${param.scode}"></sql:param>
                    </sql:update>
                </c:forEach>
            </c:when>
            <c:when test="${param.attend_type=='practical'}">
                <sql:update dataSource="${db}">
                    update attendance_2 set prac_conduct=prac_conduct+? where Date=? and subject_id=?;
                    <sql:param value="${param.num_class}"></sql:param>
                    <sql:param value="${d}"></sql:param>
                    <sql:param value="${param.scode}"></sql:param>
                </sql:update>
                <c:forEach var="prsnt_stu" items="${paramValues.attend}">
                    <sql:update dataSource="${db}">
                        update attendance_1 set prac_attend=prac_attend+? where student_id=? and subject_id=? and date=?;
                        <sql:param value="${param.num_class}"></sql:param>
                        <sql:param value="${prsnt_stu}"></sql:param>
                        <sql:param value="${param.scode}"></sql:param>
                        <sql:param value="${d}"></sql:param>
                       </sql:update>
                </c:forEach>
            </c:when>
            <c:when test="${param.attend_type=='tut'}">
                <sql:update dataSource="${db}">
                    update attendance_2 set tut_conduct=tut_conduct+? where Date=? and subject_id=?;
                    <sql:param value="${param.num_class}"></sql:param>
                    <sql:param value="${d}"></sql:param>
                    <sql:param value="${param.scode}"></sql:param>
                
                </sql:update>
                <c:forEach var="prsnt_stu" items="${paramValues.attend}">
                    <sql:update dataSource="${db}">
                        update attendance_1 set tut_attend=tut_attend+? where student_id=? and subject_id=? and date=?;
                        <sql:param value="${param.num_class}"></sql:param>
                        <sql:param value="${prsnt_stu}"></sql:param>
                        <sql:param value="${param.scode}"></sql:param>
                        <sql:param value="${d}"></sql:param>
                    </sql:update>
                </c:forEach>
            </c:when>
        </c:choose>
                        
    <body onload='attedn_sucess()'>
        <script type="text/javascript">
                function attedn_sucess()
                {
                    alert("Attendance Marked Successfully !");
                    document.myform.submit();
                }
                
            </script>
            <form action="faculty_home.jsp" name="myform">
                <input type="hidden" value="${param.user_id}" name="user_id"/> 
                <input type="hidden" value="${param.password}" name="password"/>
            </form>
    
    </body>
    
    
    
    
</html>
