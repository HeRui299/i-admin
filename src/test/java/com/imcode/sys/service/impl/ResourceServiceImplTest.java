package com.imcode.sys.service.impl;

import com.imcode.common.model.TreeNode;
import com.imcode.sys.service.IResourceService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml")
public class ResourceServiceImplTest {

    @Autowired
    private IResourceService resourceService;
    @Test
    public void getTreeById() {
        TreeNode treeNode = resourceService.getTreeById(0);
    }
}