package com.imcode.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.imcode.common.model.R;
import com.imcode.common.model.TreeNode;
import com.imcode.sys.entity.Role;
import com.imcode.sys.entity.RoleResource;
import com.imcode.sys.entity.User;
import com.imcode.sys.entity.UserRole;
import com.imcode.sys.service.IRoleResourceService;
import com.imcode.sys.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 角色 前端控制器
 * </p>
 *
 * @author jack
 * @since 2019-11-04
 */
@Controller
@RequestMapping("/sys/role")
public class RoleController {


    @Autowired
    private IRoleService roleService;

    @Autowired
    private IRoleResourceService roleResourceService;

    /**
     * 跳转到列表
     *
     * @return
     */
    @GetMapping
    public String list() {
        return "sys/role_list";
    }

    /**
     * 获取列表数据
     */
    @GetMapping("/data")
    @ResponseBody
    public R data(String roleName, Page<Role> page) {
        //1.构造查询条件构造器
        QueryWrapper queryWrapper = new QueryWrapper();
        if (!StringUtils.isEmpty(roleName)) {
            queryWrapper.like("name", roleName);
        }
        //2.分页查询
        roleService.page(page, queryWrapper);
        //3.返回分页数据
        return R.ok(page);
    }

    /**
     * 跳转到新增页面
     *
     * @return
     */
    @GetMapping("/add")
    public String add() {
        return "sys/role_add";
    }

    /**
     * 新增
     *
     * @param role
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public R add(Role role) {
        roleService.save(role);
        return R.ok();
    }

    /**
     * 跳转到修改页面
     *
     * @param roleId
     * @param model
     * @return
     */
    @GetMapping("/update/{roleId}")
    public String update(@PathVariable Integer roleId, Model model) {
        model.addAttribute("role", roleService.getById(roleId));
        return "sys/role_update";
    }

    /**
     * 更新数据
     *
     * @param role
     * @return
     */
    @PostMapping("/update")
    @ResponseBody
    public R update(Role role) {
        roleService.updateById(role);
        return R.ok();
    }

    /**
     * 删除
     *
     * @param roleId
     * @return
     */
    @GetMapping("/delete/{roleId}")
    @ResponseBody
    public R delete(@PathVariable Integer roleId) {
        roleService.removeById(roleId);
        return R.ok();
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    @PostMapping("/deletebatch")
    @ResponseBody
    public R deletebatch(@RequestBody List<Integer> ids) {
        roleService.removeByIds(ids);
        return R.ok();
    }

    /**
     * 跳转到给角色分配资源页面
     *
     * @param roleId
     * @return
     */
    @GetMapping("/assign/resource/{roleId}")
    public String assignResource(@PathVariable Integer roleId, Model model) {
        model.addAttribute("roleId", roleId);
        return "sys/assign_resource";
    }

    /**
     * 获取选中资源菜单的数据
     *
     * @param roleId
     * @return
     */
    @GetMapping("/assign/resourceTree/{roleId}")
    @ResponseBody
    public R assignResourceTree(@PathVariable Integer roleId) {
        TreeNode treeNode = roleResourceService.getTreeByRoleId(roleId);
        return R.ok("请求成功", treeNode);
    }


    /**
     * 保存给角色分配的资源
     * @param roleId
     * @param roleResourceList
     * @return
     */
    @PostMapping("/assign/resource/{roleId}")
    @ResponseBody
    public R assignResource(@PathVariable Integer roleId, @RequestBody List<RoleResource> roleResourceList) {
        roleResourceService.save(roleId, roleResourceList);
        return R.ok();
    }
}
