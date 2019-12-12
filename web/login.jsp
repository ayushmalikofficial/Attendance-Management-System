
<html>
        
    <head>

                    <link rel="stylesheet" href="css/styles.css" >
                    <title>Login</title>   
                    <link rel="icon" type="image/gif" href="Favicon.ico" />
                    
                    <script language="Javascript">
                                function choice(form1)
                                    {
                                        if(form1.role[0].checked === true)
                                        {
                                            form1.action="student_home.jsp";
                                        }
                                        else
                                        {
                                         form1.action="faculty_home.jsp";
                                        }
                                    }
                    </script>
        
    </head>
    
        
    <body > 
                
                <h2 style="margin-top:100px">Welcome</h2>
    
        
                <form   method="POST">
    
    
                        <div style="margin-bottom:20px ;margin-top:20px ;margin-left:440px ;margin-right:440px;">
        
                                    <br>
                            
                                    <p style="text-align:left; margin-bottom:5px;margin-left: 117px">User Name</p>
        
                                    <input style="width: 225px;height :30px;" class="mybutton2" type="text" name="user_id" required="required">
        
                                    <p style="text-align:left; margin-bottom:5px;margin-left: 117px">Password</p>
        
                                    <input style="width: 225px;height :30px;"class="mybutton2" type="password" name="password" >
        
                                    <br>
                                    <br>
        
                                    <input type="radio" name="role" value="student" required="required">Student
                                    <input type="radio" name="role" value="faculty" >Faculty     
        
                                    <br>
                                    <br>
        
                                    <input style="width: 225px;height :30px;" class="mybutton" type="Submit" onClick="choice(this.form)"value="Login" name="login" >
                                        
                                    <br>    
                                    <br>
    
                        </div>
                           <input type="hidden" value="${param.college}" name="college"/>
               </form>
                
    </body> 
   

</html>
