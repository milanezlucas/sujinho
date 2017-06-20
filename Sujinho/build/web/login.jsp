<%@page import="model.dao.MySQLSujinhoDAOFactory"%>
<%@page import="model.dao.interfaces.UserDAO"%>
<%@page import="model.beans.User"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%
    String txtUser = request.getParameter("user");
    String txtPass = request.getParameter("pass");
    
    JSONObject rs = new JSONObject();
    
    try {
        if (txtUser != null && txtPass != null && !txtUser.equals("") && 
                !txtPass.equals("")) {
            try {
                User user = new User();
                user.setUser(txtUser);
                user.setPassword(txtPass);
                UserDAO userDAO = MySQLSujinhoDAOFactory.getUserDAO();
                if (userDAO.login(user)) {
                    rs.put("success", true);
                    rs.put("message", "Login Realizado com sucesso");
                } else {
                    rs.put("success", false);
                    rs.put("message", "Usuário ou senha incorretos");
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
    
    
    
    /*
    //instancia um novo JSONObject
    JSONObject my_obj = new JSONObject();

    //preenche o objeto
    my_obj.put("titulo", "JSON x XML: a Batalha Final");
    my_obj.put("ano", 2012);

    //cria um JSONArray e preenche com valores string
    JSONArray my_genres = new JSONArray();

    my_genres.add("aventura");
    my_genres.add("ação");
    my_genres.add("ficção");

    //insere o array no JSONObject com o rótulo "generos"
    my_obj.put("generos", my_genres);
    
    String json_string = my_obj.toString();
    out.print(json_string);
*/
%>