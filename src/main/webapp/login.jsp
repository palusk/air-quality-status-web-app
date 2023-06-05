<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Login Page</title>
  <link rel="stylesheet" href="login_style.css">

</head>
<body>

<div id="bg"></div>

<form action="login" method="post">
  <div class="form-field">
    <input type="text" name="username" placeholder="Username" required/>
  </div>

  <div class="form-field">
    <input type="password" name="password" placeholder="Password" required/>
  </div>

  <div class="form-field">
    <button class="btn" type="submit" name="login" value="login">Zaloguj</button>

    <a href="index.jsp"><button class="btn" type="button">Zaloguj jako gość</button></a>

    <a href="registration.jsp"><button class="btn" type="button" value="register">Zarejestruj</button></a>


  </div>
</form>

</body>
</html>
