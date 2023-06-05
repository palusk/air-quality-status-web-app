<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Registration Page</title>
  <link rel="stylesheet" href="login_style.css">

</head>
<body>

<div id="bg"></div>

<form action="login" method="post">

  <div class="form-field">
    <input type="email" name="regemail" placeholder="Email" required/>
  </div>

  <div class="form-field">
    <input type="text" name="regname" placeholder="Name" required/>
  </div>

  <div class="form-field">
    <input type="text" name="regusername" placeholder="Username" required/>
  </div>

  <div class="form-field">
    <input type="password" name="regpassword" placeholder="Password" required/>
  </div>


  <div class="form-field">

    <a href="login.jsp"><button class="btn" type="button">Zaloguj</button></a>

    <button class="btn" type="submit" name="register" value="register">Zarejestruj</button>


  </div>
</form>

</body>
</html>