package com.imcode.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.imcode.common.model.R;
import com.imcode.sys.entity.User;
import com.imcode.sys.entity.UserRole;
import com.imcode.sys.service.IUserRoleService;
import com.imcode.sys.service.IUserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import java.util.List;

/**
 * <p>
 * 系统用户 前端控制器
 * </p>
 *
 * @author jack
 * @since 2019-10-31
 */
@Controller
@RequestMapping("/sys/user")
public class UserController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IUserRoleService userRoleService;
    /**
     * 跳转到列表页面
     *
     * @return
     */
    @GetMapping
    @RequiresPermissions("sys:user:list")
    public String list() {
        return "sys/user_list";
    }

    /**
     * 获取列表数据
     *
     * @param username
     * @return
     */
    @GetMapping("/data")
    @ResponseBody
    @RequiresPermissions("sys:user:list")
    public R data(String username) {

        QueryWrapper<User> param = new QueryWrapper<>();
        if (!StringUtils.isEmpty(username)) {
            param.like("username", username);
        }
        // 查询满足条件的数据集
        List<User> rows = userService.list(param);
        // 查询满足条件的总记录数
        Integer total = userService.count(param);
        return R.ok()
                .put("total", total)
                .put("rows", rows);
    }

    /**
     * 跳转到新增页面
     *
     * @return
     */
    @RequiresPermissions("sys:user:add")
    @GetMapping("/add")
    public String add() {
        return "sys/user_add";
    }

    /**
     * 新增
     *
     * @param user
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    @RequiresPermissions("sys:user:add")
    public R add(User user) {
        userService.save(user);
        return R.ok();
    }


    /**
     * 跳转到更新页面
     *
     * @return
     */
    @GetMapping("/update/{id}")
    @RequiresPermissions("sys:user:update")
    public String update(@PathVariable Integer id, Model model) {
        model.addAttribute("user", userService.getById(id));
        return "sys/user_update";
    }

    /**
     * 更新
     *
     * @param user
     * @return
     */
    @PostMapping("/update")
    @ResponseBody
    @RequiresPermissions("sys:user:update")
    public R update(User user) {
        userService.updateById(user);
        return R.ok();
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @GetMapping("/delete/{id}")
    @ResponseBody
    @RequiresPermissions("sys:user:delete")
    public R delete(@PathVariable Integer id) {
        userService.removeById(id);
        return R.ok();
    }


    /**
     * 批量删除
     * @param ids
     * @return
     */
    @PostMapping("/deletebatch")
    @ResponseBody
    @RequiresPermissions("sys:user:delete")
    public R deletebatch(@RequestBody List<Integer> ids) {
        userService.removeByIds(ids);
        return R.ok();
    }

    /**
     * 跳转到给用户分配角色的页面
     *
     * @param userId
     * @return
     */
    @GetMapping("/assign/role/{userId}")
    @RequiresPermissions("sys:user:assign:role")
    public String assignRole(@PathVariable Integer userId, Model model) {
        List<UserRole> userRoleList = userRoleService.getByUserId(userId);
        model.addAttribute("userRoleList", userRoleList);
        model.addAttribute("userId", userId);
        return "sys/assign_role";
    }

    /**
     * 给用户分配角色
     *
     * @param userId
     * @return
     */
    @PostMapping("/assign/role")
    @ResponseBody
    @RequiresPermissions("sys:user:assign:role")
    public R assignRole(Integer userId,
                        @RequestParam(name = "roleId",required = false) List<Integer> roleIdList) {
        userRoleService.save(userId,roleIdList);
        return R.ok();
    }
}
