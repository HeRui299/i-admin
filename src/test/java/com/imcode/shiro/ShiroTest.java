package com.imcode.shiro;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml")
public class ShiroTest {

    @Autowired
    private SecurityManager securityManager;

    @Test
    public void test04(){
        // 模拟从客户端接收到用户登录的信息
        String username = "admin";
        String password = "123456";

        AuthenticationToken token =
                new UsernamePasswordToken(username,password);

        Subject subject = SecurityUtils.getSubject();
        // 登录认证
        subject.login(token);

        System.out.println("subject.hasRole(\"系统管理员\") = " + subject.hasRole("系统管理员"));
        System.out.println("subject.hasRole(\"asdas\") = " + subject.hasRole("asdas"));

    }
}