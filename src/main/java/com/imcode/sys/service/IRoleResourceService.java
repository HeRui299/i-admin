package com.imcode.sys.service;

import com.imcode.common.model.TreeNode;
import com.imcode.sys.entity.RoleResource;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 角色与菜单对应关系 服务类
 * </p>
 *
 * @author jack
 * @since 2019-11-05
 */
public interface IRoleResourceService extends IService<RoleResource> {

    /**
     * 根据角色id查询角色拥有的资源树
     * @param roleId
     * @return
     */
    TreeNode getTreeByRoleId(Integer roleId);


    /**
     * 保存 给当前角色分配的资源
     * @param roleId
     * @param roleResourceList
     * @return
     */
    boolean save(Integer roleId,List<RoleResource> roleResourceList);

}
