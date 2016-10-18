package com.sykj.app.service.system.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.system.BusinessDao;
import com.sykj.app.dao.system.BusinessMenuDao;
import com.sykj.app.dao.system.BusinessResourcesDao;
import com.sykj.app.dao.system.MenuDao;
import com.sykj.app.dao.system.ResourcesDao;
import com.sykj.app.dao.user.UserBusinessDao;
import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.system.BusinessMenu;
import com.sykj.app.entity.system.BusinessResources;
import com.sykj.app.entity.system.Menu;
import com.sykj.app.entity.system.Resources;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.system.RoleMenu;
import com.sykj.app.entity.system.RoleResources;
import com.sykj.app.entity.user.UserBusiness;
import com.sykj.app.entity.user.UserRole;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.system.BusinessM;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.service.system.BusinessService;
import com.sykj.app.util.BusinessComparator;

/**
 * @author wjl 2016年10月12日 上午11:16:04
 */
@Service("businessService")
public class BusinessServiceImpl extends BaseServiceImpl implements BusinessService{

	@Resource
	private BusinessDao businessDao;
	@Resource
	private BusinessResourcesDao businessResourcesDao;
	@Resource
	private ResourcesDao resourcesDao;
	@Resource
	private BusinessMenuDao businessMenuDao;
	@Resource
	private MenuDao menuDao;
	@Resource
	private UserBusinessDao userBusinessDao;
	
	@Override
	public List<BusinessM> treegrid(String id) {
		List<BusinessM> treegrid = new ArrayList<BusinessM>();
		List<Business> businessList = businessDao.findBusiness(id);
		for (Business business : businessList) {
			BusinessM b = new BusinessM();
			BeanUtils.copyProperties(business, b);
			if (business.getBusiness() != null) {
				b.setParentId(business.getBusiness().getId());
				b.setParentText(business.getBusiness().getText());
			}
			if(business.getBusinesses() != null && business.getBusinesses().size() > 0) {
				b.setState("closed");
			}
			//获取资源集合
			if(business.getBusinessResourceses() != null && business.getBusinessResourceses().size() > 0) {
				String resourcesTextList = "";
				String resourcesIdList = "";
				boolean flag = false;
				Set<BusinessResources> businessResourcesSet = business.getBusinessResourceses();
				for(BusinessResources businessResources : businessResourcesSet) {
					Resources resources = businessResources.getResources();
					if(!flag) {
						flag = true;
					}else {
						resourcesTextList += ",";
						resourcesIdList += ",";
					}
					resourcesTextList += resources.getText();
					resourcesIdList += resources.getId();
				}
				b.setResourcesId(resourcesIdList);
				b.setResourcesText(resourcesTextList);
			}
			//获取菜单集合
			if(business.getBusinessMenus() != null && business.getBusinessMenus().size() > 0) {
				String menuTextList = "";
				String menuIdList = "";
				boolean flag = false;
				Set<BusinessMenu> businessMenuSet = business.getBusinessMenus();
				for(BusinessMenu businessMenu : businessMenuSet) {
					Menu menu = businessMenu.getMenu();
					if(!flag) {
						flag = true;
					}else {
						menuTextList += ",";
						menuIdList += ",";
					}
					menuTextList += menu.getText();
					menuIdList += menu.getId();
				}
				b.setMenuId(menuIdList);
				b.setMenuText(menuTextList);
			}
			treegrid.add(b);
		}
		return treegrid;
	}

	@Override
	public List<EasyuiTreeNode> tree(String id) {
		List<Business> businessList = businessDao.findBusiness(id);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
		for (Business business : businessList) {
			tree.add(tree(business, false));
		}
		return tree;
	}

	private EasyuiTreeNode tree(Business business, boolean recursive) {
		EasyuiTreeNode node = new EasyuiTreeNode();
		node.setId(business.getId());
		node.setText(business.getText());
		Map<String, Object> attributes = new HashMap<String, Object>();
		node.setAttributes(attributes);
		if (business.getBusinesses() != null && business.getBusinesses().size() > 0) {
			node.setState("closed");
			if (recursive) {// 递归查询子节点
				List<Business> businessList = new ArrayList<Business>(business.getBusinesses());
				Collections.sort(businessList, new BusinessComparator());// 排序
				List<EasyuiTreeNode> children = new ArrayList<EasyuiTreeNode>();
				for (Business b : businessList) {
					EasyuiTreeNode t = tree(b, true);
					children.add(t);
				}
				node.setChildren(children);
			}
		}
		return node;
	}

	@Override
	public BusinessM add(BusinessM business) {
		Business b = new Business();
		BeanUtils.copyProperties(business, b);
		if (business.getParentId() != null && !business.getParentId().trim().equals("")) {
			b.setBusiness(businessDao.getBusiness(business.getParentId()));
		}
		businessDao.addBusiness(b);
		return business;
	}

	@Override
	public BusinessM edit(BusinessM business) {
		Business b = businessDao.getBusiness(business.getId());
		if (b != null) {
			BeanUtils.copyProperties(business, b);
			if (!b.getId().equals("0")) {// 跟节点不可以修改上级节点
				b.setBusiness(businessDao.getBusiness(business.getParentId()));
			}

			//删除职务与资源的关系
			List<BusinessResources> businessResourcesList = businessResourcesDao.findBusinessResources(b);
			for (BusinessResources businessResources : businessResourcesList) {
				businessResourcesDao.deleteBusinessResources(businessResources.getId());
			}
			// 保存职务和资源的关系
			if(business.getResourcesId() != null && !business.getResourcesId().equals("")) {
				String[] resourceIds = business.getResourcesId().split(",");
				for(String resourceId : resourceIds) {
					BusinessResources businessResources = new BusinessResources();//关系
					Resources resources = resourcesDao.getResources(resourceId);//资源
					businessResources.setId(UUID.randomUUID().toString());
					businessResources.setBusiness(b);
					businessResources.setResources(resources);
					businessResourcesDao.addBusinessResources(businessResources);
				}
			}
			
			//删除职务与菜单的关系
			List<BusinessMenu> businessMenuList = businessMenuDao.findBusinessMenu(b);
			for(BusinessMenu businessMenu : businessMenuList) {
				businessMenuDao.deleteBusinessMenu(businessMenu.getId());
			}
			// 保存职务和菜单的关系
			if(business.getMenuId() != null && !business.getMenuId().equals("")) {
				String[] menuIds = business.getMenuId().split(",");
				for(String menuId : menuIds) {
					BusinessMenu businessMenu = new BusinessMenu();//关系
					Menu menu = menuDao.getMenu(menuId);//菜单
					businessMenu.setId(UUID.randomUUID().toString());
					businessMenu.setBusiness(b);
					businessMenu.setMenu(menu);
					businessMenuDao.addBusinessMenu(businessMenu);
				}
			}
		}
		return business;
	}

	@Override
	public void del(BusinessM business) {
		Business b = businessDao.getBusiness(business.getId());
		System.out.println(b.getId()+"****"+b.getText());
		if (business != null) {
			recursiveDelete(b);
		}
	}
	
	private void recursiveDelete(Business b) {
		if(b.getBusinesses() != null && b.getBusinesses().size() > 0) {
			Set<Business> businessSet = b.getBusinesses();
			for(Business t : businessSet) {
				recursiveDelete(t);
			}
		}

		//删除职务与资源关系
		List<BusinessResources> businessResourcesList = businessResourcesDao.findBusinessResources(b);
		if (businessResourcesList != null && businessResourcesList.size() > 0) {
			for (BusinessResources businessResources : businessResourcesList) {
				businessResourcesDao.deleteBusinessResources(businessResources.getId());
			}
		}
		//删除职务与菜单的关系
		List<BusinessMenu> businessMenuList = businessMenuDao.findBusinessMenu(b);
		if(businessMenuList != null&& businessMenuList.size() > 0){
			for (BusinessMenu businessMenu : businessMenuList) {
				businessMenuDao.deleteBusinessMenu(businessMenu.getId());
			}
		}
		//删除职务与用户的关系
		List<UserBusiness> userBusinessList = userBusinessDao.findByBusiness(b);
		if(userBusinessList != null && userBusinessList.size() > 0) {
			for(UserBusiness userBusiness : userBusinessList) {
				userBusinessDao.deleteUserBusiness(userBusiness.getId());
			}
		}
		businessDao.deleteBusiness(b.getId());
	}
}
