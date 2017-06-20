<!DOCTYPE HTML>
<html dir="ltr" lang="pt-BR">
<head>
<meta charset="UTF-8" />
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    
    <!-- jQuery -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>
        jQuery( document ).ready( function () {
            $('#login').submit(function(e) {
                e.preventDefault();
                
                var info = {};
                info['user'] = $('input[name=user]').val();
                info['pass'] = $('input[name=pass]').val();

                $.ajax( {
                    type:       'POST',
                    url:        'http://localhost:8084/Sujinho/login.jsp',
                    data:       info,
                    dataType:   'json',
                    beforeSend: function() {
                        $('.btn-login').text('Carregando...');
                    },
                    success: function(r) {
                        console.log(r);
                        if (!r.success) {
                            $('.alert').removeClass('hide').html(r.message);
                        } else {
                            window.document.location.href = "http://localhost:8084/Sujinho/schedule.jsp";
                        }
                        $('.btn-login').text('Entrar');
                    },
                    error: function(r){
                        console.log(r);
                    }
                });
            });
        });
    </script>
</head>
<body>
    <div class="container" style="margin-top:30px">
        <div class="col-md-12 text-center">
            <img src="resouces/img/sujinho.png" alt="Sujinho LavaCar">
        </div>
    </div>
    <div class="container" style="margin-top:30px">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>Login</strong></h3>
                </div>
                
                <div class="panel-body">
                    <form method="POST" id="login" role="form">
                        <div class="alert alert-danger hide"></div>
                        <div style="margin-bottom: 12px" class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input id="login-username" type="text" class="form-control" name="user" value="" placeholder="usuário">                                        
                        </div>
                                                        
                        <div style="margin-bottom: 12px" class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input id="login-password" type="password" class="form-control" name="pass" placeholder="senha">
                        </div>
                                                                                                                            
                        <button type="submit" class="btn btn-success btn-login">Entrar</button>
                    
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>