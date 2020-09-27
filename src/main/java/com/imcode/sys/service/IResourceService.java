package com.imcode.sys.service;

import com.imcode.common.model.TreeNode;
import com.imcode.sys.entity.Resource;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 菜单管理 服务类
 * </p>
 *
 * @author jack
 * @since 2019-11-04
 */
public interface IResourceService extends IService<Resource> {

    /**
     * 通过id查询该节点的树形结构数据
     *
     * @param
     * @return
     */
    TreeNode getTreeById(Integer id);
}
