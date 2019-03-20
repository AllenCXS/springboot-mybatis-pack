package com.test;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

/**
 * @description:
 * @author: yuanfeiZheng
 * @Date: 2019年3月19日 下午2:40:43
 */
@SpringBootApplication
@Configuration
@ImportResource(locations = { "classpath:config/spring/*-context.xml" })
@MapperScan("com.test.dao")
public class Main {
	public static void main(String[] args) {
		SpringApplication.run(Main.class, args);
	}
}
