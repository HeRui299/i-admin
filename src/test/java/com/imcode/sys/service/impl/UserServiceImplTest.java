package com.imcode.sys.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.imcode.common.model.TreeNode;
import com.imcode.sys.entity.User;
import com.imcode.sys.service.IUserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml")
public class UserServiceImplTest {

    @Autowired
    private IUserService userService;


    @Test
    public void test02() {
        List<TreeNode> list = userService.getMenuTreeByUserId(1);
        System.out.println(list);

    }

    @Test
    public void test01() {
        IPage<User> pageInfo = new Page<>();
        pageInfo.setCurrent(1);
        pageInfo.setSize(5);

        pageInfo = userService.page(pageInfo);

    }
}