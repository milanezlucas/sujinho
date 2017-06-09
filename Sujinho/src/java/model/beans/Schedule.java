package model.beans;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author Lucas
 */
@Entity
@Table(name="Schedule")
public class Schedule implements Serializable {
    @Id
    private Integer id;
    @Column(name="date")
    private String date;
    @Column(name="name")
    private String name;
    @Column(name="car")
    private String car;
    @Column(name="phone")
    private String phone;
    @Column(name="status")
    private String status;
    
    public Schedule () {
        date    = "";
        name    = "";
        car     = "";
        phone   = "";
        status  = "";
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCar() {
        return car;
    }

    public void setCar(String car) {
        this.car = car;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
