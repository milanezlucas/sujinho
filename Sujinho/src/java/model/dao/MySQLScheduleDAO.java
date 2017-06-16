package model.dao;

import java.util.List;
import model.beans.Schedule;
import model.dao.interfaces.ScheduleDAO;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class MySQLScheduleDAO implements ScheduleDAO {
    private Session session;

    @Override
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
            tx.rollback();
        } finally {
            session.close();
        }
        return false;
    }
    
    @Override
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
    
    @Override
    public boolean editSchedule(Schedule schedule) {
        session = MySQLSujinhoDAOFactory.getInstance();
        
        Transaction tx = null;
        try {
            Query query = session.createQuery("UPDATE Schedule SET status = :status WHERE id = :id");
            query.setParameter("status", schedule.getStatus());
            query.setParameter("id", schedule.getIdSchedule());
            
            int rs = query.executeUpdate();
            if (rs > 0) {
                return true;
            } else {
                return false;
            }
        } catch (HibernateException ex) {
            ex.printStackTrace();
            tx.rollback();
        } finally {
            session.close();
        }
        return false;
    }
    
    @Override
    public boolean deleteSchedule(Schedule schedule) {
        session = MySQLSujinhoDAOFactory.getInstance();
        
        Transaction tx = null;
        try {
            Query query = session.createQuery("UPDATE Schedule SET del = :del WHERE id = :id");
            query.setParameter("del", "1");
            query.setParameter("id", schedule.getIdSchedule());
            
            int rs = query.executeUpdate();
            if (rs > 0) {
                return true;
            } else {
                return false;
            }
        } catch (HibernateException ex) {
            ex.printStackTrace();
            tx.rollback();
        } finally {
            session.close();
        }
        return false;
    }
}