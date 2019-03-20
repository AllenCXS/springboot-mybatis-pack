package com.test.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.test.bean.User;

@Repository
public interface UserDao {
	User addUser(User user);

	List<User> getAllUser();
}
