<!DOCTYPE HTML>
<html dir="ltr" lang="pt-BR">
<head>
<meta charset="UTF-8" />
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="http://getbootstrap.com/dist/js/bootstrap.min.js"></script>
    
   
    <script>
        $(document).ready(function(){            
                       
            $("[data-toggle=tooltip]").tooltip();
            getSchedule();
                        
            // Cadastra agendamento
            $('#add-schedule').submit( function(e){
		e.preventDefault();

		var info = {};
                info['action'] = $('input[name=add-action]').val();
                info['date'] = $('input[name=add-date]').val();
                info['name'] = $('input[name=add-name]').val();
                info['car'] = $('input[name=add-car]').val();
                info['phone'] = $('input[name=add-phone]').val();

		$.ajax({
                    type:       'POST',
                    url:        'http://localhost:8084/Sujinho/schedule-process.jsp',
                    data:       info,
                    dataType:   'json',
                    beforeSend:     function() {
                        $('.btn-add-schedule').html('Enviando...').attr('disabled', true);
                    },
                    success: function( r ){
                        if ( !r.success ) {
                            $('.btn-add-schedule').html(r.message).attr('disabled', true);
                            setTimeout( function() {
                                $('.btn-add-schedule').html('Adicionar').attr('disabled', false);
                            }, 5000 );
                        } else {
                            $('.btn-add-schedule').html(r.message).attr('disabled', true);
                            getSchedule();
                        }
                    },
                    error: function(r){
                        $('.btn-add-schedule').html(r).attr('disabled', false);
                    }
		});
            });
        });
               
        function getSchedule() {
            var info = {};
            info['action'] = "get-schedule";

            $.ajax({
                type:       'POST',
                url:        'http://localhost:8084/Sujinho/schedule-process.jsp',
                data:       info,
                dataType:   'json',
                beforeSend:     function() {
                    $('#mytable').css('opacity', .5);
                },
                success: function(r){
                    $('tbody').html(r.message);
                    $('#mytable').css('opacity', 1);
                    editSchedule();
                    deleteSchedule();
                },
                error: function(r){
                   console.log(r);
                   $('tbody').html(r);
                   $('#mytable').css('opacity', 1);
                }
            });
        }
        
        function editSchedule() {
            $('.btn-edit').click(function (e){
                $('input[name=edit-name]').val($(this).attr('data-name'));
                $('input[name=edit-car]').val($(this).attr('data-car'));
                $('input[name=edit-id]').val($(this).attr('data-id'));
            });
            
            $('#edit-schedule').submit( function(e){
		e.preventDefault();

		var info = {};
                info['action'] = $('input[name=edit-action]').val();
                info['id'] = $('input[name=edit-id]').val();
                info['status'] = $('select[name=edit-status]').val();

		$.ajax({
                    type:       'POST',
                    url:        'http://localhost:8084/Sujinho/schedule-process.jsp',
                    data:       info,
                    dataType:   'json',
                    beforeSend:     function() {
                        $('.btn-edit-schedule').html('Enviando...').attr('disabled', true);
                    },
                    success: function( r ){
                        if ( !r.success ) {
                            $('.btn-edit-schedule').html(r.message).attr('disabled', true);
                            setTimeout( function() {
                                $('.btn-edit-schedule').html('Adicionar').attr('disabled', false);
                            }, 5000 );
                        } else {
                            $('.btn-edit-schedule').html(r.message).attr('disabled', true);
                            getSchedule();
                        }
                    },
                    error: function(r){
                        $('.btn-edit-schedule').html(r).attr('disabled', false);
                    }
		});
            });
        }
        
        function deleteSchedule() {
            $('.btn-delete').click(function (e){
                $('input[name=delete-id]').val($(this).attr('data-id'));
            });
            
            $('#delete-schedule').submit( function(e){
		e.preventDefault();

		var info = {};
                info['action'] = $('input[name=delete-action]').val();
                info['id'] = $('input[name=delete-id]').val();

		$.ajax({
                    type:       'POST',
                    url:        'http://localhost:8084/Sujinho/schedule-process.jsp',
                    data:       info,
                    dataType:   'json',
                    beforeSend:     function() {
                        $('.btn-delete-schedule').html('Enviando...').attr('disabled', true);
                    },
                    success: function( r ){
                        if ( !r.success ) {
                            $('.btn-delete-schedule').html(r.message).attr('disabled', true);
                            setTimeout( function() {
                                $('.btn-delete-schedule').html('Adicionar').attr('disabled', false);
                            }, 5000 );
                        } else {
                            $('.btn-delete-schedule').html(r.message).attr('disabled', true);
                            getSchedule();
                        }
                    },
                    error: function(r){
                        $('.btn-delete-schedule').html(r).attr('disabled', false);
                    }
		});
            });
        }
    </script>
</head>
<body>
    <div class="container" style="margin-top:30px">
        <div class="col-md-12 text-center">
            <img src="resouces/img/sujinho.png" alt="Sujinho LavaCar">
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h4>Agenda</h4>
                <button class="btn btn-xs btn-success" data-title="Adicionar" data-toggle="modal" data-target="#add"><span class="glyphicon glyphicon-plus"></span> Adicionar</button>
                <hr />
                <div class="table-responsive">

                    <table id="mytable" class="table table-bordred table-striped">
                        <thead>
                            <th>Data</th>
                            <th>Nome</th>
                            <th>Carro</th>
                            <th>Telefone</th>
                            <th>Status</th>
                            <th>Editar</th>
                            <th>Excluir</th>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>              

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="add" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                    <h4 class="modal-title custom_align" id="Heading">Adicionar</h4>
                </div>
                <form id="add-schedule">
                    <div class="modal-body">
                        <div class="form-group">
                            <input class="form-control" type="text" name="add-date" placeholder="Data">
                        </div>
                        <div class="form-group">
                            <input class="form-control" type="text" name="add-name" placeholder="Nome">
                        </div>
                        <div class="form-group">
                            <input class="form-control " type="text" name="add-car" placeholder="Carro">
                        </div>
                        <div class="form-group">
                            <input class="form-control " type="text" name="add-phone" placeholder="Telefone">
                        </div>
                    </div>
                    <div class="modal-footer ">
                        <button type="submit" class="btn btn-success btn-lg btn-add-schedule" style="width: 100%;"><span class="glyphicon glyphicon-ok-sign"></span>Adicionar</button>
                        <input type="hidden" name="add-action" value="add-schedule">
                    </div>
                </form>
            </div>
            <!-- /.modal-content --> 
        </div>
        <!-- /.modal-dialog --> 
    </div>

    <div class="modal fade" id="edit" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                    <h4 class="modal-title custom_align" id="Heading">Editar Status</h4>
                </div>
                <form id="edit-schedule">
                    <div class="modal-body">
                        <div class="form-group">
                            <input class="form-control" type="text" name="edit-name" placeholder="Mohsin" disabled>
                        </div>
                        <div class="form-group">
                            <input class="form-control " type="text" name="edit-car" placeholder="Fusca Azul 83" disabled>
                        </div>
                        <div class="form-group">
                            <select name="edit-status" class="form-control">
                                <option value="Aguardando">Aguardando</option>
                                <option value="Lavando">Lavando</option>
                                <option value="Finalizado">Finalizado</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer ">
                        <button type="submit" class="btn btn-warning btn-lg btn-edit-schedule" style="width: 100%;"><span class="glyphicon glyphicon-ok-sign"></span>Atualizar Status</button>
                        <input type="hidden" name="edit-action" value="edit-schedule">
                        <input type="hidden" name="edit-id" value="">
                    </div>
                </form>
            </div>
            <!-- /.modal-content --> 
        </div>
        <!-- /.modal-dialog --> 
    </div>
    
    <div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                    <h4 class="modal-title custom_align" id="Heading">Excluir</h4>
                </div>
                <form id="delete-schedule">
                    <div class="modal-body">
                        <div class="alert alert-danger"><span class="glyphicon glyphicon-warning-sign"></span> Tem certeza que deseja excluir?</div>
                    </div>
                    <div class="modal-footer ">
                        <button type="submit" class="btn btn-success btn-delete-schedule" ><span class="glyphicon glyphicon-ok-sign"></span> Sim</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> N�o</button>
                        <input type="hidden" name="delete-action" value="delete-schedule">
                        <input type="hidden" name="delete-id" value="">
                </div>
                </form>
            </div>
            <!-- /.modal-content --> 
        </div>
        <!-- /.modal-dialog --> 
    </div>
</body>
</html>