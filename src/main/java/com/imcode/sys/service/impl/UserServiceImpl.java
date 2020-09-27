package com.imcode.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.imcode.common.exception.BizException;
import com.imcode.common.model.TreeNode;
import com.imcode.common.util.MD5Util;
import com.imcode.common.util.TreeUtil;
import com.imcode.sys.entity.Menu;
import com.imcode.sys.entity.User;
import com.imcode.sys.mapper.ResourceMapper;
import com.imcode.sys.mapper.UserMapper;
import com.imcode.sys.mapper.UserRoleMapper;
import com.imcode.sys.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

/**
 * 系统用户 服务实现类
 *
 * @author jack
 * @since 2019-10-31
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private ResourceMapper resourceMapper;

    @Override
    public boolean save(User user) {
        String username = user.getUsername();
        String password = user.getPassword();
        String email = user.getEmail();
        String mobile = user.getMobile();
        // 校验用户名不能为空
        if (StringUtils.isEmpty(username)) {
            throw new BizException("用户名不能为空");
        }
        // 校验用户名不能为空
        if (StringUtils.isEmpty(password)) {
            throw new BizException("密码不能为空");
        }

        // 校验用户名是否被占用
        QueryWrapper queryUsername = new QueryWrapper();
        queryUsername.eq("username", username);
        if (this.count(queryUsername) > 0) {
            throw new BizException("用户名已存在");
        }

        if (!StringUtils.isEmpty(mobile)) {
            QueryWrapper queryMobile = new QueryWrapper();
            queryMobile.eq("mobile", user.getMobile());
            if (this.count(queryMobile) > 0) {
                throw new BizException("手机号已经被使用");
            }
        }


        if (!StringUtils.isEmpty(email)) {
            QueryWrapper queryEmail = new QueryWrapper();
            queryEmail.eq("email", user.getEmail());
            if (this.count(queryEmail) > 0) {
                throw new BizException("邮箱已经被使用");
            }
        }


        String salt = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        password = MD5Util.md5_private_salt(password, salt);
        user.setPassword(password);
        user.setSalt(salt);
        return super.save(user);
    }


    @Override
    public boolean updateById(User user) {
        String email = user.getEmail();
        String mobile = user.getMobile();

        // 不是当前用户使用了该手机号，表示手机号被占用
        if (!StringUtils.isEmpty(mobile)) {
            QueryWrapper queryMobile = new QueryWrapper();
            queryMobile.eq("mobile", user.getMobile());
            queryMobile.ne("user_id",user.getUserId());
            // where mobile="13800000000" and user_id != 1;
            if (this.count(queryMobile) > 0) {
                throw new BizException("手机号已经被使用");
            }
        }
        if (!StringUtils.isEmpty(email)) {
            QueryWrapper queryEmail = new QueryWrapper();
            queryEmail.eq("email", user.getEmail());
            queryEmail.ne("user_id",user.getUserId());
            if (this.count(queryEmail) > 0) {
                throw new BizException("邮箱已经被使用");
            }
        }
        return super.updateById(user);
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @Override
    @Transactional
    public boolean removeById(Serializable id) {
        // 删除用户已经分配的角色信息
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("user_id", id);
        userRoleMapper.delete(queryWrapper);
        return super.removeById(id);
    }

    /**
     * 批量删除
     *
     * @param idList
     * @return
     */
    @Override
    @Transactional
    public boolean removeByIds(Collection<? extends Serializable> idList) {
        // 删除用户已经分配的角色信息
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.in("user_id", idList);
        userRoleMapper.delete(queryWrapper);
        // delete from sys_user_role where user_id id (5,6);
        return super.removeByIds(idList);
    }

    /**
     * 获取用户的菜单树
     * @param id
     * @return
     */
    @Override
    public List<TreeNode> getMenuTreeByUserId(Integer id) {
        // 查询用户拥有的菜单资源
        List<Menu> menuList = userMapper.selectMenuList(id);
        if(menuList.isEmpty()){
            return new ArrayList<>();
        }

        // 存储父id是0的节点的id
        List<Integer> nodeIds = new ArrayList<>();

        List<TreeNode> treeNodeList = new ArrayList<>();
        for (Menu menu : menuList) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId(menu.getResourceId());
            treeNode.setName(menu.getName());
            treeNode.setParentId(menu.getParentId());
            treeNode.setUrl(menu.getUrl());
            treeNode.setIcon(menu.getIcon());
            treeNodeList.add(treeNode);
            if(treeNode.getParentId() == 66) {
                nodeIds.add(treeNode.getId());
            }
        }
        TreeUtil treeUtil = new TreeUtil(treeNodeList);
        List<TreeNode> treeNodeData = new ArrayList<>();
        for (Integer nodeId : nodeIds) {
            treeNodeData.add(treeUtil.generateTree(nodeId));
        }
        return treeNodeData;
    }
}