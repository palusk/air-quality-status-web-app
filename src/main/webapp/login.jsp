<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Login Page with Background Image Example</title>
  <link rel="stylesheet" href="login_style.css">

</head>
<body>

<div id="bg"></div>

<form>
  <div class="form-field">
    <input type="email" placeholder="Email / Username" required/>
  </div>

  <div class="form-field">
    <input type="password" placeholder="Password" required/>
  </div>

  <div class="form-field">
    <button class="btn" type="submit">Log in</button>

    <a href="index.html"><button class="btn" type="button">Log in as guest</button></a>


  </div>
</form>

</body>
</html>
