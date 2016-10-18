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

import com.sykj.app.dao.system.MenuDao;
import com.sykj.app.dao.system.ResourcesDao;
import com.sykj.app.dao.system.RoleDao;
import com.sykj.app.dao.system.RoleMenuDao;
import com.sykj.app.dao.system.RoleResourcesDao;
import com.sykj.app.dao.user.UserRoleDao;
import com.sykj.app.entity.system.Menu;
import com.sykj.app.entity.system.Resources;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.system.RoleMenu;
import com.sykj.app.entity.system.RoleResources;
import com.sykj.app.entity.user.UserRole;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.RoleM;
import com.sykj.app.service.system.RoleService;
import com.sykj.app.util.RoleComparator;

@Service("roleService")
public class RoleServiceImpl implements RoleService{

	@Resource
	private RoleDao roleDao;
	@Resource
	private ResourcesDao resourcesDao;
	@Resource
	private RoleResourcesDao roleResourcesDao;
	@Resource
	private MenuDao menuDao;
	@Resource
	private RoleMenuDao roleMenuDao;
	@Resource
	private UserRoleDao userRoleDao;
	
	@Override
	public List<EasyuiTreeNode> tree(String id) {
		
		List<Role> roleList = roleDao.findRole(id);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
		for (Role role : roleList) {
			tree.add(tree(role, false));
		}
		return tree;
	}

	@Override
	public List<RoleM> treegrid(String id) {
		List<RoleM> treegrid = new ArrayList<RoleM>();
		List<Role> roleList = roleDao.findRole(id);
		for (Role role : roleList) {
			RoleM r = new RoleM();
			BeanUtils.copyProperties(role, r);
			if (role.getRole() != null) {
				r.setParentId(role.getRole().getId());
				r.setParentText(role.getRole().getText());
			}
			if (role.getRoles() != null && role.getRoles().size() > 0) {
				r.setState("closed");
			}
			//获取资源集合
			if (role.getRoleResourceses() != null && role.getRoleResourceses().size() > 0) {
				String resourcesTextList = "";
				String resourcesIdList = "";
				boolean b = false;
				Set<RoleResources> roleResourcesSet = role.getRoleResourceses();
				for (RoleResources roleResources : roleResourcesSet) {
					Resources resources = roleResources.getResources();
					if (!b) {
						b = true;
					} else {
						resourcesTextList += ",";
						resourcesIdList += ",";
					}
					resourcesTextList += resources.getText();
					resourcesIdList += resources.getId();
				}
				r.setResourcesId(resourcesIdList);
				r.setResourcesText(resourcesTextList);
			}
			//获取菜单集合
			if (role.getRoleMenus() != null && role.getRoleMenus().size() > 0) {
				String menuTextList = "";
				String menuIdList = "";
				boolean b = false;
				Set<RoleMenu> roleMenuSet = role.getRoleMenus();
				for (RoleMenu roleMenu : roleMenuSet) {
					Menu menu = roleMenu.getMenu();
					if (!b) {
						b = true;
					} else {
						menuTextList += ",";
						menuIdList += ",";
					}
					menuTextList += menu.getText();
					menuIdList += menu.getId();
				}
				r.setMenuId(menuIdList);
				r.setMenuText(menuTextList);
			}
			treegrid.add(r);
		}
		return treegrid;
	}

	@Override
	public RoleM add(RoleM role) {
		Role r = new Role();
		BeanUtils.copyProperties(role, r);
		if (role.getParentId() != null && !role.getParentId().trim().equals("")) {
			r.setRole(roleDao.getRole(role.getParentId()));
		}
		roleDao.addRole(r);
		return role;
	}

	@Override
	public void del(RoleM role) {
		
		Role r = roleDao.getRole(role.getId());
		System.out.println(r.getId()+"****"+r.getText());
		if (role != null) {
			recursiveDelete(r);
		}
		
	}

	@Override
	public RoleM edit(RoleM role) {
		Role r = roleDao.getRole(role.getId());
		if (r != null) {
			BeanUtils.copyProperties(role, r);
			if (!r.getId().equals("0")) {// 跟节点不可以修改上级节点
				r.setRole(roleDao.getRole(role.getParentId()));
			}

			//删除角色与资源的关系
			List<RoleResources> roleResourcesList = roleResourcesDao.findRoleResources(r);
			for (RoleResources roleResources : roleResourcesList) {
				roleResourcesDao.deleteRoleResources(roleResources.getId());
			}
			// 保存角色和资源的关系
			if (role.getResourcesId() != null && !role.getResourcesId().equals("")) {
				String[] resourceIds = role.getResourcesId().split(",");
				for (String resourceId : resourceIds) {
					RoleResources roleResources = new RoleResources();// 关系
					Resources resources = resourcesDao.getResources(resourceId);// 资源
					roleResources.setId(UUID.randomUUID().toString());
					roleResources.setRole(r);
					roleResources.setResources(resources);
					roleResourcesDao.addRoleResources(roleResources);
				}
			}
			
			//删除角色与菜单的关系
			List<RoleMenu> roleMenuList = roleMenuDao.findRoleMenu(r);
			for (RoleMenu roleMenu : roleMenuList) {
				roleMenuDao.deleteRoleMenu(roleMenu.getId());
			}
			// 保存角色和菜单的关系
			if (role.getMenuId() != null && !role.getMenuId().equals("")) {
				String[] menuIds = role.getMenuId().split(",");
				for (String menuId : menuIds) {
					RoleMenu roleMenu = new RoleMenu();// 关系
					Menu menu = menuDao.getMenu(menuId);// 菜单
					roleMenu.setId(UUID.randomUUID().toString());
					roleMenu.setRole(r);
					roleMenu.setMenu(menu);
					roleMenuDao.addRoleMenu(roleMenu);
				}
			}
		}
		return role;
	}

	private EasyuiTreeNode tree(Role role, boolean recursive) {
		EasyuiTreeNode node = new EasyuiTreeNode();
		node.setId(role.getId());
		node.setText(role.getText());
		Map<String, Object> attributes = new HashMap<String, Object>();
		node.setAttributes(attributes);
		if (role.getRoles() != null && role.getRoles().size() > 0) {
			node.setState("closed");
			if (recursive) {// 递归查询子节点
				List<Role> roleList = new ArrayList<Role>(role.getRoles());
				Collections.sort(roleList, new RoleComparator());// 排序
				List<EasyuiTreeNode> children = new ArrayList<EasyuiTreeNode>();
				for (Role r : roleList) {
					EasyuiTreeNode t = tree(r, true);
					children.add(t);
				}
				node.setChildren(children);
			}
		}
		return node;
	}
	
	private void recursiveDelete(Role r) {
		if (r.getRoles() != null && r.getRoles().size() > 0) {
			Set<Role> roleSet = r.getRoles();
			for (Role t : roleSet) {
				recursiveDelete(t);
			}
		}

		//删除角色与资源关系
		List<RoleResources> roleResourcesList = roleResourcesDao.findRoleResources(r);
		if (roleResourcesList != null && roleResourcesList.size() > 0) {
			for (RoleResources roleResources : roleResourcesList) {
				roleResourcesDao.deleteRoleResources(roleResources.getId());
			}
		}
		//删除角色与菜单的关系
		List<RoleMenu> roleMenuList = roleMenuDao.findRoleMenu(r);
		if(roleMenuList!=null&&roleMenuList.size()>0){
		for (RoleMenu roleMenu : roleMenuList) {
			roleMenuDao.deleteRoleMenu(roleMenu.getId());
		}
		}
		//删除角色与用户的关系
		List<UserRole> userRoleList = userRoleDao.findByRole(r);
		if (userRoleList != null && userRoleList.size() > 0) {
			for (UserRole userRole : userRoleList) {
				userRoleDao.deleteUserRole(userRole.getId());
			}
		}
		roleDao.deleteRole(r.getId());
	}

	@Override
	public Role getUserType(String userType) {
		
		return roleDao.findByuserType(userType);
	}
}
