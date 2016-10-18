package com.sykj.app.service.hqsystem.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.hqsystem.HeadResourcesDao;
import com.sykj.app.entity.hqsystem.HeadResources;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.HeadResourcesM;
import com.sykj.app.service.hqsystem.HeadResourcesService;
import com.sykj.app.util.HeadResourcesComparator;

@Service("headResourcesService")
@SuppressWarnings("unchecked")
public class HeadResourcesServiceImpl implements HeadResourcesService{

	@Resource
	private HeadResourcesDao headResourcesDao;
	
	public List<EasyuiTreeNode> tree(String id) {

		List<HeadResources> resourceses = headResourcesDao.find(id);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
		for (HeadResources Resources : resourceses) {
			tree.add(tree(Resources, false));
		}
		return tree;
	}

	private EasyuiTreeNode tree(HeadResources Resources, boolean recursive) {
		EasyuiTreeNode node = new EasyuiTreeNode();
		node.setId(Resources.getId());
		node.setText(Resources.getText());
		Map<String, Object> attributes = new HashMap<String, Object>();
		attributes.put("src", Resources.getSrc());
		node.setAttributes(attributes);
		if (Resources.getResourceses() != null && Resources.getResourceses().size() > 0) {
			node.setState("closed");
			if (recursive) {// 递归查询子节点
				List<HeadResources> ResourcesList = new ArrayList<HeadResources>(Resources.getResourceses());
				Collections.sort(ResourcesList, new HeadResourcesComparator());// 排序
				List<EasyuiTreeNode> children = new ArrayList<EasyuiTreeNode>();
				for (HeadResources r : ResourcesList) {
					EasyuiTreeNode t = tree(r, true);
					children.add(t);
				}
				node.setChildren(children);
			}
		}
		return node;
	}

	public List<HeadResourcesM> treegrid(String id) {
		List<HeadResourcesM> treegrid = new ArrayList<HeadResourcesM>();

		List<HeadResources> Resourceses = headResourcesDao.find(id);
		for (HeadResources Resources : Resourceses) {
			HeadResourcesM r = new HeadResourcesM();
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

	public HeadResourcesM add(HeadResourcesM resources) {
		HeadResources Resources = new HeadResources();
		BeanUtils.copyProperties(resources, Resources);
		if (resources.getParentId() != null && !resources.getParentId().trim().equals("")) {
			Resources.setResources(headResourcesDao.getResources(resources.getParentId()));
		}
		headResourcesDao.addResources(Resources);
		return resources;
	}

	public void del(HeadResourcesM resources) {
		HeadResources Resources = headResourcesDao.getResources(resources.getId());
		if (resources != null) {
			recursiveDelete(Resources);
		}
	}

	
	private void recursiveDelete(HeadResources Resources) {
		if (Resources.getResourceses() != null && Resources.getResourceses().size() > 0) {
			Set<HeadResources> Resourceses = Resources.getResourceses();
			for (HeadResources t : Resourceses) {
				recursiveDelete(t);
			}
		}

//		List<RoleResources> roleResourcesList = roleResourcesDao.findRoleResources( Resources);
//		if (roleResourcesList != null) {// 删除资源前,需要现将角色资源关系表中的相关记录删除
//			for (RoleResources roleResources : roleResourcesList) {
//				roleResourcesDao.deleteRoleResources(roleResources.getId());
//			}
//		}

		headResourcesDao.deleteResources(Resources.getId());
	}

	public HeadResourcesM edit(HeadResourcesM resourcesM) {
		HeadResources resources = headResourcesDao.getResources(resourcesM.getId());
		if (resources != null) {
			BeanUtils.copyProperties(resourcesM, resources);
			if (!resources.getId().equals("0")) {// 跟节点不可以修改上级节点
				resources.setResources(headResourcesDao.getResources(resourcesM.getParentId()));
			}
			headResourcesDao.updateResources(resources);
		}
		return resourcesM;
	}

	@Override
	public HeadResources getResourcesBySrc(String src) {
		
		return headResourcesDao.getResourcesBySrc(src);
	}

//	@Override
//	public boolean checkAuth(String userId, String src) {
//		UserRole ur = userRoleDao.getUserRoleByUserId(userId);
//		RoleResources roleResources = roleResourcesDao.getRoleResourcesByRS(ur.getRole().getId(),src);
//		if(roleResources!=null){
//			return true;
//		}else{
//		return false;
//		}
//	}
}
