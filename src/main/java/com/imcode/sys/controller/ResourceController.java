package com.imcode.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.imcode.common.model.R;
import com.imcode.common.model.TreeNode;
import com.imcode.sys.entity.Resource;
import com.imcode.sys.service.IResourceService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import java.util.List;

/**
 * <p>
 * 菜单管理 前端控制器
 * </p>
 *
 * @author jack
 * @since 2019-11-04
 */
@Controller
@RequestMapping("/sys/resource")
public class ResourceController {

    @Autowired
    private IResourceService resourceService;

    /**
     * 跳转到资源管理的初始化页面
     * @return
     */
    @GetMapping
    public String index(@RequestParam(defaultValue = "66") Integer parentId,Model model) {
        model.addAttribute("parentId",parentId);
        return "sys/resource_index";
    }

    /**
     * 获取左侧菜单树
     * @return
     */
    @GetMapping("/tree")
    @ResponseBody
    @RequiresPermissions("sys:resource:list")
    public R tree() {
        // 为左边树形菜单提供数据
        TreeNode treeNode = resourceService.getTreeById(66);
        return R.ok("请求成功", treeNode);
    }

    /**
     * 跳转到资源列表页面
     * @return
     */
    @GetMapping("/list")
    @RequiresPermissions("sys:resource:list")
    public String list(@RequestParam(defaultValue = "0") Integer parentId,Model model){
        // 查询出父节点的详细信息传递给resource_list.jsp
        Resource parent = resourceService.getById(parentId);
        model.addAttribute("parent",parent);
        return "sys/resource_list";
    }

    /**
     * 获取列表数据
     * @param parentId
     * @param page
     * @return
     */
    @GetMapping("/data")
    @ResponseBody
    @RequiresPermissions("sys:resource:list")
    public R data(@RequestParam(defaultValue = "0") Integer parentId, Page<Resource> page){
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("parent_id",parentId);
        queryWrapper.orderByAsc("order_num");
        resourceService.page(page,queryWrapper);
        return R.ok(page);
    }

    /**
     * 跳转到新增资源页面
     * @param parentId
     * @return
     */
    @GetMapping("/add/{parentId}")
    public String add(@PathVariable Integer parentId,Model model){
        model.addAttribute("parent",resourceService.getById(parentId));
        return "sys/resource_add";
    }

    /**
     * 新增
     * @param resource
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public R add(Resource resource) {
        resourceService.save(resource);
        return R.ok();
    }

    /**
     * 跳转到修改页面
     * @param resourceId
     * @param model
     * @return
     */
    @GetMapping("/update/{resourceId}")
    public String update(@PathVariable Integer resourceId,Model model) {
        // 查询当前资源
        Resource resource = resourceService.getById(resourceId);
        model.addAttribute("resource",resource);
        // 查询上级资源
        Resource parent = resourceService.getById(resource.getParentId());
        model.addAttribute("parent",parent);
        return "sys/resource_update";
    }

    /**
     * 更新数据
     * @param resource
     * @return
     */
    @PostMapping("/update")
    @ResponseBody
    public R update(Resource resource){
        resourceService.updateById(resource);
        return R.ok();
    }

    /**
     * 删除资源
     * @param resourceId
     * @return
     */
    @GetMapping("/delete/{resourceId}")
    @ResponseBody
    public R delete(@PathVariable Integer resourceId){
        resourceService.removeById(resourceId);
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
        resourceService.removeByIds(ids);
        return R.ok();
    }
}












