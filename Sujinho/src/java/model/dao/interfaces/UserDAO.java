package model.dao.interfaces;

import model.beans.User;

/**
 * Esta interface define quais métodos manipularão os dados da tabela Usuario do banco
 */
public interface UserDAO {
    public abstract boolean login(User usuario);
}