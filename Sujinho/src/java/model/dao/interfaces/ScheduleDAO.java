package model.dao.interfaces;
import java.util.List;
import model.beans.Schedule;

/**
 *
 * @author Lucas
 */
public interface ScheduleDAO {
    public abstract boolean insertSchedule(Schedule schedule);
    public abstract List<Schedule> getSchedule();
    public abstract boolean editSchedule(Schedule schedule);
}
