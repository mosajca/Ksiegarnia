package project.services;

import project.entity.User;

public interface UserService {

    void saveUser(User user);

    User getUser(String userId);

}
