package project.dao;

import project.entity.User;

public interface UserDAO {

    void saveUser(User user);

    User getUser(String userId);

}
