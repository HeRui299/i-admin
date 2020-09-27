package com.imcode.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.imcode.common.exception.BizException;
import com.imcode.sys.entity.Role;
import com.imcode.sys.mapper.RoleMapper;
import com.imcode.sys.mapper.RoleResourceMapper;
import com.imcode.sys.mapper.UserRoleMapper;
import com.imcode.sys.service.IRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.io.Serializable;
import java.util.Collection;

/**
 * <p>
 * 角色 服务实现类
 * </p>
 *
 * @author jack
 * @since 2019-11-04
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
    private RoleResourceMapper roleResourceMapper;


    @Override
    public boolean save(Role role) {
        String roleName = role.getName();
        if (StringUtils.isEmpty(roleName)) {
            throw new BizException("角色名称不能为空");
        }

        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("name", roleName);
        if (this.count(queryWrapper) > 0) {
            throw new BizException("角色名称已经被使用");
        }
        return super.save(role);
    }

    @Override
    public boolean updateById(Role role) {
        String roleName = role.getName();
        if (StringUtils.isEmpty(roleName)) {
            throw new BizException("角色名称不能为空");
        }
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("name", roleName);
        queryWrapper.ne("role_id", role.getRoleId());
        if (this.count(queryWrapper) > 0) {
            throw new BizException("角色名称已经被使用");
        }
        return super.updateById(role);
    }

//    将sys_user_role表中该角色的信息一并删除
//    将sys_role_resource表中该角色的信息一并删除


    @Override
    @Transactional
    public boolean removeById(Serializable id) {
        // 将sys_user_role表中该角色的信息一并删除
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("role_id", id);
        userRoleMapper.delete(queryWrapper);
        //将sys_role_resource表中该角色的信息一并删除
        roleResourceMapper.delete(queryWrapper);
        return super.removeById(id);
    }

    @Override
    @Transactional
    public boolean removeByIds(Collection<? extends Serializable> idList) {
        // 将sys_user_role表中该角色的信息一并删除
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.in("role_id", idList);
        userRoleMapper.delete(queryWrapper);
        //将sys_role_resource表中该角色的信息一并删除
        roleResourceMapper.delete(queryWrapper);
        return super.removeByIds(idList);
    }
}
