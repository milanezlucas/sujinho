package model.dao;

import java.util.List;

import model.beans.User;
import model.dao.interfaces.UserDAO;
import org.hibernate.Query;
import org.hibernate.Session;

public class MySQLUserDAO implements UserDAO {
    private Session session;

    @Override
    public boolean login(User user) {
        session = MySQLSujinhoDAOFactory.getInstance();
        Query q = session.createQuery("SELECT u FROM User u WHERE u.user=? AND u.password=MD5(?)");
        q.setString(0, user.getUser());
        q.setString(1, user.getPassword());

        List l = q.list();
        if (!l.isEmpty()) {
            return true;
        }
        return false;
    }
}