package com.sykj.app.service.system.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.system.BusinessDao;
import com.sykj.app.dao.system.BusinessMenuDao;
import com.sykj.app.dao.system.MenuDao;
import com.sykj.app.dao.system.RoleDao;
import com.sykj.app.dao.system.RoleMenuDao;
import com.sykj.app.dao.user.UserRoleDao;
import com.sykj.app.entity.system.Business;
import com.sykj.app.entity.system.BusinessMenu;
import com.sykj.app.entity.system.Menu;
import com.sykj.app.entity.system.Role;
import com.sykj.app.entity.system.RoleMenu;
import com.sykj.app.entity.user.User;
import com.sykj.app.entity.user.UserRole;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.MenuM;
import com.sykj.app.model.UserM;
import com.sykj.app.service.system.MenuService;
import com.sykj.app.util.MenuComparator;
import com.sykj.app.util.SortList;

@Service("menuService")
public class MenuServiceImpl implements MenuService{
	
	@Resource
	private MenuDao menuDao;
	@Resource
	private RoleMenuDao roleMenuDao;
	@Resource
	private UserRoleDao userRoleDao;
	@Resource
	private RoleDao roleDao;
	@Resource
	private BusinessDao businessDao;
	@Resource
	private BusinessMenuDao businessMenuDao;
	
	@Override
	public List<EasyuiTreeNode> tree(String id) {
		
		List<Menu> menus = menuDao.find(id);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
		for (Menu menu : menus) {
			tree.add(tree(menu, false));
		}
		return tree;
	}
	@Override
	public List<MenuM> treegrid(String id) {
		List<MenuM> treegrid = new ArrayList<MenuM>();
		List<Menu> menus = menuDao.find(id);
		for (Menu menu : menus) {
			MenuM m = new MenuM();
			BeanUtils.copyProperties(menu, m);
			if (menu.getMenu() != null) {
				m.setParentId(menu.getMenu().getId());
				m.setParentText(menu.getMenu().getText());
			}
			m.setIconCls(menu.getIconcls());
			if (menu.getMenus() != null && menu.getMenus().size() > 0) {
				m.setState("closed");
			}
			treegrid.add(m);
		}
		return treegrid;
	}
	@Override
	public MenuM add(MenuM menuM) {
		Menu menu = new Menu();
		BeanUtils.copyProperties(menuM, menu);
		menu.setIconcls(menuM.getIconCls());
		if (menuM.getParentId() != null && !menuM.getParentId().trim().equals("")) {
			menu.setMenu(menuDao.getMenu(menuM.getParentId()));
		}
		menuDao.addMenu(menu);
		return menuM;
	}
	@Override
	public void del(MenuM menuM) {
		Menu menu = menuDao.getMenu(menuM.getId());
		if (menu != null) {
			recursiveDelete(menu);
		}
		
	}
	@Override
	public MenuM edit(MenuM menuM) {
		//System.out.println(menuM.getShowStatus()+"****");
		Menu menu = menuDao.getMenu(menuM.getId());
		if (menu != null) {
			BeanUtils.copyProperties(menuM, menu);
			menu.setIconcls(menuM.getIconCls());
			if (!menu.getId().equals("0")) {// 根节点不可以修改上级节点
				menu.setMenu(menuDao.getMenu(menuM.getParentId()));
			}
			menuDao.updateMenu(menu);
		}
		return menuM;
	}
	
	private EasyuiTreeNode tree(Menu menu, boolean recursive) {
		EasyuiTreeNode node = new EasyuiTreeNode();
		node.setId(menu.getId());
		node.setText(menu.getText());
		node.setIconCls(menu.getIconcls());
		Map<String, Object> attributes = new HashMap<String, Object>();
		attributes.put("src", menu.getSrc());
		node.setAttributes(attributes);
		if (menu.getMenus() != null && menu.getMenus().size() > 0) {
			node.setState("closed");
			if (recursive) {// 递归查询子节点
				List<Menu> menuList = new ArrayList<Menu>(menu.getMenus());
				SortList<Menu> sl = new SortList<Menu>();
				sl.Sort(menuList, "seq", null);
//				Collections.sort(menuList, new MenuComparator());// 排序
				List<EasyuiTreeNode> children = new ArrayList<EasyuiTreeNode>();
				for (Menu m : menuList) {
					EasyuiTreeNode t = tree(m, true);
					children.add(t);
				}
				node.setChildren(children);
			}
		}
		return node;
	}
	
	private void recursiveDelete(Menu menu) {
		if (menu.getMenus() != null && menu.getMenus().size() > 0) {
			Set<Menu> menus = menu.getMenus();
			for (Menu t : menus) {
				recursiveDelete(t);
			}
		}
		//删除角色与菜单的关系
		List<RoleMenu> roleMenuList = roleMenuDao.findRoleMenu(menu);
		if(roleMenuList!=null&&roleMenuList.size()>0){
		for (RoleMenu roleMenu : roleMenuList) {
			roleMenuDao.deleteRoleMenu(roleMenu.getId());
		}
		
	}
		menuDao.deleteMenu(menu.getId());
	}
	@Override
	public List<EasyuiTreeNode> backgroundTree(UserM userM,String id) {
		List<Menu> menus = menuDao.findByShowStatus(id);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
//		for(Menu menu : menus){
//			tree.add(tree(menu,false));
//		}
		//用户菜单
		HashSet<String> set= userM.getRoleMenuIdSet();
		if(set!=null){
			List<Menu> menuList = new ArrayList<Menu>();
			for(Menu menu:menus){
				if(set.contains(menu.getId())){
					menuList.add(menu);
				}
			}
			menus=menuList;
		}
		//用户菜单树
		for(Menu menu : menus){
			tree.add(tree(menu,false));
		}
		return tree;
	}
	
	@Override
	public HashSet<String> roleMenuIdSet(UserM user) {
		Role role =roleDao.getRole(user.getRoleId());
		
		List<RoleMenu> listrm = roleMenuDao.findRoleMenu(role);
		HashSet<String> menuSet = new HashSet<String>();
		for(RoleMenu rm : listrm){
			Menu menu = menuDao.getMenu(rm.getMenu().getId());
			menuSet.add(menu.getId());
			menu = menu.getMenu();
			while(menu!=null){
				menuSet.add(menu.getId());
				menu=menu.getMenu();
			}
		}
		
		if(user.getBusinessId() != null) {
			Business business = businessDao.getBusiness(user.getBusinessId());
			List<BusinessMenu> bMenuList = businessMenuDao.findBusinessMenu(business);
			for(BusinessMenu bm : bMenuList) {
				Menu menu = menuDao.getMenu(bm.getMenu().getId());
				menuSet.add(menu.getId());
				menu = menu.getMenu();
				while(menu != null) {
					menuSet.add(menu.getId());
					menu = menu.getMenu();
				}
			}
		}
		return menuSet;
	}
	
	@Override
	public List<MenuM> findAllMenus() {
		List<Menu> list = menuDao.findAllMenus();
		List<MenuM> mList = new ArrayList<MenuM>();
		for (Menu menu : list) {
			MenuM menuM = new MenuM();
			BeanUtils.copyProperties(menu, menuM);
			mList.add(menuM);
		}
		return mList;
	}
}
