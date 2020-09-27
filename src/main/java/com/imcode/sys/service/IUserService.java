package com.imcode.sys.service;

import com.imcode.common.model.TreeNode;
import com.imcode.sys.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 系统用户 服务类
 * </p>
 *
 * @author jack
 * @since 2019-10-31
 */
public interface IUserService extends IService<User> {


    /**
     * 根据用户id获取用户的菜单树
     * @param id
     * @return
     */
    List<TreeNode> getMenuTreeByUserId(Integer id);

}
