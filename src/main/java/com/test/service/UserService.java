package com.test.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.bean.User;
import com.test.dao.UserDao;

@Service
public class UserService {
	@Autowired
	public UserDao userDao;
	
	public List<User> getAllUsers(){
		return userDao.getAllUser();
	}
	
}
