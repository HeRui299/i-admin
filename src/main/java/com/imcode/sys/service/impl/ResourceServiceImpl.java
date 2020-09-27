package com.imcode.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.imcode.common.exception.BizException;
import com.imcode.common.model.TreeNode;
import com.imcode.common.util.TreeUtil;
import com.imcode.sys.entity.Resource;
import com.imcode.sys.mapper.ResourceMapper;
import com.imcode.sys.mapper.RoleResourceMapper;
import com.imcode.sys.service.IResourceService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * <p>
 * 菜单管理 服务实现类
 * </p>
 *
 * @author jack
 * @since 2019-11-04
 */
@Service
public class ResourceServiceImpl extends ServiceImpl<ResourceMapper, Resource> implements IResourceService {


    @Autowired
    private RoleResourceMapper roleResourceMapper;

    /**
     * 通过id查询该节点的树形结构数据
     *
     * @param
     * @return
     */
    public TreeNode getTreeById(Integer id) {
        Resource r = this.getById(id); // 传进来的是1也就是顶级节点
        //1.查询所有节点
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.likeRight("path", r.getPath());
        queryWrapper.orderByAsc("order_num");
        List<Resource> list = this.list(queryWrapper); // 这里list查出来所有的资源了

        //2.对象数据转换
        List<TreeNode> treeNodeList = new ArrayList<>(); // 把从表中的数据转化为简洁的树对象
        for (Resource resource : list) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId(resource.getResourceId());
            treeNode.setName(resource.getName());
            treeNode.setParentId(resource.getParentId());
            treeNodeList.add(treeNode);
        }
        TreeUtil treeUtil = new TreeUtil(treeNodeList);
        // 生成一个完整的树对象
        TreeNode treeNode = treeUtil.generateTree(id);
        return treeNode;
    }


    /**
     * 保存资源之前生成资源的path
     *
     * @param resource
     * @return
     */
    @Override
    @Transactional
    public boolean save(Resource resource) {
        //保存以后会自动将生成的主键回写到resource对象上
        super.save(resource);
        //1.获取父资源的路径
        Resource parent = this.getById(resource.getParentId());
        String path = parent.getPath() + "/" + resource.getResourceId(); // path/id
        //2.将生成的path更新到资源表
        resource.setPath(path);
        this.updateById(resource);
        return true;
    }


    /**
     * 如果该资源下有子资源，不能删除，只能删除叶子节点
     * 将sys_role_resource表中该资源的信息一并删除
     *
     * @param id
     * @return
     */
    @Override
    @Transactional
    public boolean removeById(Serializable id) {
        //检查该节点是否有子节点
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("parent_id", id); //select * from sys_resource where parent_id = 10
        if (this.count(queryWrapper) > 0) {
            throw new BizException("请先删除该资源下的子资源");
        }
        // 删除该资源分配的角色信息
        QueryWrapper queryRoleResource = new QueryWrapper();
        queryRoleResource.eq("resource_id", id);
        roleResourceMapper.delete(queryRoleResource);

        return super.removeById(id);
    }

    @Override
    @Transactional
    public boolean removeByIds(Collection<? extends Serializable> idList) {

        StringBuilder sb = new StringBuilder();
        for (Serializable id : idList) {
            QueryWrapper queryWrapper = new QueryWrapper();
            queryWrapper.eq("parent_id", id); //select * from sys_resource where parent_id = 10
            if (this.count(queryWrapper) > 0) {
                // 获取当前资源的详情
                Resource resource = this.getById(id);
                sb.append("请先删除资源【" + resource.getName() + "】下的子资源<br>");
            }
        }
        if (!StringUtils.isEmpty(sb.toString())) {
            throw new BizException(sb.toString());
        }
        // 删除该资源分配的角色信息
        QueryWrapper queryRoleResource = new QueryWrapper();
        queryRoleResource.in("resource_id", idList);
        roleResourceMapper.delete(queryRoleResource);
        return super.removeByIds(idList);
    }
}
