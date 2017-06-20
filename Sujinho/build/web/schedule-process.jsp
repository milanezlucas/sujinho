<%@page import="model.dao.interfaces.ScheduleDAO"%>
<%@page import="model.dao.MySQLSujinhoDAOFactory"%>
<%@page import="model.beans.Schedule"%>
<%@page import="net.sf.json.JSONObject"%>
<%
String txtAction = request.getParameter("action");
JSONObject rs = new JSONObject();

if (txtAction.contains("add-schedule")) {
    String txtDate  = request.getParameter("date");
    String txtName  = request.getParameter("name");
    String txtCar   = request.getParameter("car");
    String txtPhone = request.getParameter("phone");
    
    try {
        if (txtDate != null && txtName != null && txtCar != null && txtPhone != null && !txtDate.equals("") && !txtName.equals("") && !txtCar.equals("") && !txtPhone.equals("")) {
            try {
                Schedule schedule = new Schedule();
                schedule.setDate(txtDate);
                schedule.setName(txtName);
                schedule.setCar(txtCar);
                schedule.setPhone(txtPhone);
                
                ScheduleDAO scheduleDAO = MySQLSujinhoDAOFactory.getScheduleDAO();
                if (scheduleDAO.insertSchedule(schedule)) {
                    rs.put("success", true);
                    rs.put("message", "Cadastro realizado com sucesso");
                } else {
                    rs.put("success", false);
                    rs.put("message", "Não foi possível realizar o cadastro");
                }
            } catch (Exception ex) {
                rs.put("success", false);
                rs.put("message", ex.getMessage());
            }
        } else {
            rs.put("success", false);
            rs.put("message", "Todos os campos devem ser preenchidos");
        }
        out.print(rs.toString());
    } finally {
        out.close();
    }
} else if (txtAction.contains("get-schedule")) {  
    ScheduleDAO scheduleDAO = MySQLSujinhoDAOFactory.getScheduleDAO();
    
    StringBuilder strBuilder = new StringBuilder("");
    for (Schedule schedule : scheduleDAO.getSchedule()) {
        if (schedule.getDel().equals("")) {
            strBuilder.append("<tr>");
            strBuilder.append("<td>" + schedule.getDate() + "</td>");
            strBuilder.append("<td>" + schedule.getName() + "</td>");
            strBuilder.append("<td>" + schedule.getCar() + "</td>");
            strBuilder.append("<td>" + schedule.getPhone() + "</td>");
            if (schedule.getStatus().equals("")) {
                strBuilder.append("<td>Aguardando</td>");
            } else {
                strBuilder.append("<td>" + schedule.getStatus() + "</td>");
            }
            strBuilder.append("<td><p data-placement='top' data-toggle='tooltip' title='Editar'><button class='btn btn-primary btn-xs btn-edit' data-title='Editar' data-toggle='modal' data-target='#edit' data-id='" + schedule.getIdSchedule() + "' data-name='" + schedule.getName() + "' data-car='" + schedule.getCar() + "'><span class='glyphicon glyphicon-pencil'></span></button></p></td>");
            strBuilder.append("<td><p data-placement='top' data-toggle='tooltip' title='Deletar'><button class='btn btn-danger btn-xs btn-delete' data-title='Deletar' data-toggle='modal' data-target='#delete' data-id='" + schedule.getIdSchedule() + "'><span class='glyphicon glyphicon-trash'></span></button></p></td>");
            strBuilder.append("</tr>");
        }
    }
    
    rs.put("success", true);
    rs.put("message", strBuilder.toString());
    
    out.print(rs.toString());
} else if (txtAction.contains("edit-schedule")) {
    String txtStatus = request.getParameter("status");
    
    try {
        try {
            Schedule schedule = new Schedule();
            schedule.setIdSchedule(Integer.parseInt(request.getParameter("id")));
            schedule.setStatus(txtStatus);

            ScheduleDAO scheduleDAO = MySQLSujinhoDAOFactory.getScheduleDAO();
            if (scheduleDAO.editSchedule(schedule)) {
                rs.put("success", true);
                rs.put("message", "Cadastro editado com sucesso");
            } else {
                rs.put("success", false);
                rs.put("message", "Não foi possível editar o cadastro");
            }
        } catch (Exception ex) {
            rs.put("success", false);
            rs.put("message", ex.getMessage());
        }
        out.print(rs.toString());
    } finally {
        out.close();
    }    
} else if (txtAction.contains("delete-schedule")) {    
    try {
        try {
            Schedule schedule = new Schedule();
            schedule.setIdSchedule(Integer.parseInt(request.getParameter("id")));

            ScheduleDAO scheduleDAO = MySQLSujinhoDAOFactory.getScheduleDAO();
            if (scheduleDAO.deleteSchedule(schedule)) {
                rs.put("success", true);
                rs.put("message", "Cadastro excluido com sucesso");
            } else {
                rs.put("success", false);
                rs.put("message", "Não foi possível excluir o cadastro");
            }
        } catch (Exception ex) {
            rs.put("success", false);
            rs.put("message", ex.getMessage());
        }
        out.print(rs.toString());
    } finally {
        out.close();
    }
}else {
    rs.put("success", false);
    rs.put("message", "Sem ação");
}
%>