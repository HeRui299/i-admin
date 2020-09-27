package com.imcode.sys.service.impl;

import com.imcode.sys.entity.UserRole;
import com.imcode.sys.service.IUserRoleService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml")
public class UserRoleServiceImplTest {

    @Autowired
    private IUserRoleService userRoleService;

    @Test
    public void getByUserId() {
        List<UserRole> list = userRoleService.getByUserId(2);
        System.out.println(list);
    }
}