package com.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.client.RestTemplate;

/** 
 * @description: 
 * @author: yuanfeiZheng
 * @Date: 2019年3月20日 上午11:48:47
 */
@RunWith(SpringJUnit4ClassRunner.class)
public class HttpTest {
	private  final  static String url =  "http://127.0.0.1:9086/server";

    private static RestTemplate restTemplate = new RestTemplate();

    @SuppressWarnings("rawtypes")
	@Test
    public void test(){
        ResponseEntity<String> response = restTemplate.exchange(url + "/user/getAllUsers" ,
                HttpMethod.GET,
                new HttpEntity(null),
                String.class);
        System.out.println("result: " + response.getBody());
    }
}
