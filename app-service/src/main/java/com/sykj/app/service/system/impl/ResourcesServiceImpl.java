package com.sykj.app.service.system.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.system.ResourcesDao;
import com.sykj.app.dao.system.RoleResourcesDao;
import com.sykj.app.dao.user.UserRoleDao;
import com.sykj.app.entity.system.Resources;
import com.sykj.app.entity.system.RoleResources;
import com.sykj.app.entity.user.UserRole;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.ResourcesM;
import com.sykj.app.service.system.ResourcesService;
import com.sykj.app.util.ResourcesComparator;

@Service("resourcesService")
public class ResourcesServiceImpl implements ResourcesService{

	@Resource
	private ResourcesDao resourcesDao;
	@Resource
	private RoleResourcesDao roleResourcesDao;
	@Resource
	private UserRoleDao userRoleDao;
	
	public List<EasyuiTreeNode> tree(String id) {

		List<Resources> resourceses = resourcesDao.find(id);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
		for (Resources Resources : resourceses) {
			tree.add(tree(Resources, false));
		}
		return tree;
	}

	private EasyuiTreeNode tree(Resources Resources, boolean recursive) {
		EasyuiTreeNode node = new EasyuiTreeNode();
		node.setId(Resources.getId());
		node.setText(Resources.getText());
		Map<String, Object> attributes = new HashMap<String, Object>();
		attributes.put("src", Resources.getSrc());
		node.setAttributes(attributes);
		if (Resources.getResourceses() != null && Resources.getResourceses().size() > 0) {
			node.setState("closed");
			if (recursive) {// 递归查询子节点
				List<Resources> ResourcesList = new ArrayList<Resources>(Resources.getResourceses());
				Collections.sort(ResourcesList, new ResourcesComparator());// 排序
				List<EasyuiTreeNode> children = new ArrayList<EasyuiTreeNode>();
				for (Resources r : ResourcesList) {
					EasyuiTreeNode t = tree(r, true);
					children.add(t);
				}
				node.setChildren(children);
			}
		}
		return node;
	}

	public List<ResourcesM> treegrid(String id) {
		List<ResourcesM> treegrid = new ArrayList<ResourcesM>();

		List<Resources> Resourceses = resourcesDao.find(id);
		for (Resources Resources : Resourceses) {
			ResourcesM r = new ResourcesM();
			BeanUtils.copyProperties(Resources, r);
			if (Resources.getResources() != null) {
				r.setParentId(Resources.getResources().getId());
				r.setParentText(Resources.getResources().getText());
			}
			if (Resources.getResourceses() != null && Resources.getResourceses().size() > 0) {
				r.setState("closed");
			}
			treegrid.add(r);
		}
		return treegrid;
	}

	public ResourcesM add(ResourcesM resources) {
		Resources Resources = new Resources();
		BeanUtils.copyProperties(resources, Resources);
		if (resources.getParentId() != null && !resources.getParentId().trim().equals("")) {
			Resources.setResources(resourcesDao.getResources(resources.getParentId()));
		}
		resourcesDao.addResources(Resources);
		return resources;
	}

	public void del(ResourcesM resources) {
		Resources Resources = resourcesDao.getResources(resources.getId());
		if (resources != null) {
			recursiveDelete(Resources);
		}
	}

	private void recursiveDelete(Resources Resources) {
		if (Resources.getResourceses() != null && Resources.getResourceses().size() > 0) {
			Set<Resources> Resourceses = Resources.getResourceses();
			for (Resources t : Resourceses) {
				recursiveDelete(t);
			}
		}

		List<RoleResources> roleResourcesList = roleResourcesDao.findRoleResources( Resources);
		if (roleResourcesList != null) {// 删除资源前,需要现将角色资源关系表中的相关记录删除
			for (RoleResources roleResources : roleResourcesList) {
				roleResourcesDao.deleteRoleResources(roleResources.getId());
			}
		}

		resourcesDao.deleteResources(Resources.getId());
	}

	public ResourcesM edit(ResourcesM resourcesM) {
		Resources resources = resourcesDao.getResources(resourcesM.getId());
		if (resources != null) {
			BeanUtils.copyProperties(resourcesM, resources);
			if (!resources.getId().equals("0")) {// 跟节点不可以修改上级节点
				resources.setResources(resourcesDao.getResources(resourcesM.getParentId()));
			}
			resourcesDao.updateResources(resources);
		}
		return resourcesM;
	}

	@Override
	public Resources getResourcesBySrc(String src) {
		
		return resourcesDao.getResourcesBySrc(src);
	}
	
	@Override
	public List<Resources> getListBySrc(String src) {
		
		return resourcesDao.getListBySrc(src);
	}

	@Override
	public boolean checkAuth(String userId, String src) {
		UserRole ur = userRoleDao.getUserRoleByUserId(userId);
		RoleResources roleResources = roleResourcesDao.getRoleResourcesByRS(ur.getRole().getId(),src);
		if(roleResources!=null){
			return true;
		}else{
		return false;
		}
	}

	@Override
	public Resources getResourcesBySrc(String src, String parameter) {
		return resourcesDao.getResourcesBySrc(src,parameter);
	}
}
