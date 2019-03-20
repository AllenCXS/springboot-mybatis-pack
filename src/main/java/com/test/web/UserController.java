package com.test.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.test.bean.User;
import com.test.service.UserService;

@RestController
@RequestMapping("/user")
public class UserController {
	@Autowired
	public UserService userService;

	private Logger logger = LoggerFactory.getLogger(UserController.class);

	@GetMapping("/getAllUsers")
	public List<User> getAllUsers() {
		List<User> allUsers = userService.getAllUsers();
		logger.info("users:{}", allUsers);
		return allUsers;
	}
}
