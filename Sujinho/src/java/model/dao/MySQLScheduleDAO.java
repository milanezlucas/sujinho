package model.dao;

import java.util.List;
import model.beans.Schedule;
import model.dao.interfaces.ScheduleDAO;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class MySQLScheduleDAO implements ScheduleDAO {
    private Session session;

    public boolean insertSchedule(Schedule schedule) {
        session = MySQLSujinhoDAOFactory.getInstance();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(schedule);
            tx.commit();
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            tx.rollback(); //Desfaz a operação de inserção
        } finally {
            session.close();
        }
        return false;
    }
    
    public List<Schedule> getSchedule() {
        List<Schedule> list = null;

        session = MySQLSujinhoDAOFactory.getInstance();

         try {
           session.beginTransaction();
           list = session.createQuery("SELECT s FROM Schedule s").list();
           session.getTransaction().commit();

           return list;
        } catch (HibernateException e) {
           if (session.getTransaction() != null) {
               session.getTransaction().rollback();
           }
        } finally {
           session.close();
        }
         
        return null;
    }
}