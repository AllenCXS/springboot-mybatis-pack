package com.test;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @description:
 * @author: yuanfeiZheng
 * @Date: 2019年3月20日 上午11:40:13
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Main.class) // 这里的Application是springboot的启动类名
@WebAppConfiguration
public class MockTest {
	@Autowired
	private WebApplicationContext context;

	private MockMvc mockMvc;

	private ObjectMapper mapper = new ObjectMapper();

	@Before
	public void setupMockMvc() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void testSend() throws Exception {
		Long id = 1l;
		// 调用接口，传入添加的用户参数
		mockMvc.perform(MockMvcRequestBuilders.get("/style/listStyleById").contentType(MediaType.APPLICATION_JSON_UTF8)
				.content(mapper.writeValueAsString(id))).andExpect(MockMvcResultMatchers.status().isOk())
				.andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON_UTF8))
				.andDo(MockMvcResultHandlers.print());

	}

	@Test
    public void testGetAll() throws Exception {
    	//调用接口，传入添加的用户参数
    	mockMvc.perform(MockMvcRequestBuilders.get("/user/getAllUsers"))
    	.andExpect(MockMvcResultMatchers.status().isOk())
    	.andDo(MockMvcResultHandlers.print());
    	
    }
}
