package com.sykj.app.service.hqsystem.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;







import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.hqsystem.HeadMenuDao;
import com.sykj.app.entity.hqsystem.HeadMenu;
import com.sykj.app.entity.hquser.HeadUser;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.HeadMenuM;
import com.sykj.app.service.hqsystem.HeadMenuService;
import com.sykj.app.util.SortList;

@Service("headMenuService")
public class HeadMenuServiceImpl implements HeadMenuService{
	
	@Autowired
	private HeadMenuDao headDao;
	
	@Override
	public List<EasyuiTreeNode> tree(String id) {
		
		List<HeadMenu> menus = headDao.find(id);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
		for (HeadMenu menu : menus) {
			tree.add(tree(menu, false));
		}
		return tree;
	}
	@Override
	public List<HeadMenuM> treegrid(String id) {
		List<HeadMenuM> treegrid = new ArrayList<HeadMenuM>();
		List<HeadMenu> menus = headDao.find(id);
		for (HeadMenu menu : menus) {
			HeadMenuM m = new HeadMenuM();
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
	public HeadMenuM add(HeadMenuM headMenuM) {
		HeadMenu menu = new HeadMenu();
		BeanUtils.copyProperties(headMenuM, menu);
		menu.setIconcls(headMenuM.getIconCls());
		if (headMenuM.getParentId() != null && !headMenuM.getParentId().trim().equals("")) {
			menu.setMenu(headDao.getMenu(headMenuM.getParentId()));
		}
		headDao.addMenu(menu);
		return headMenuM;
	}
	@Override
	public void del(HeadMenuM headMenuM) {
		HeadMenu menu = headDao.getMenu(headMenuM.getId());
		if (menu != null) {
			recursiveDelete(menu);
		}
		
	}
	@Override
	public HeadMenuM edit(HeadMenuM headMenuM) {
		//System.out.println(headMenuM.getShowStatus()+"****");
		HeadMenu menu = headDao.getMenu(headMenuM.getId());
		if (menu != null) {
			BeanUtils.copyProperties(headMenuM, menu);
			menu.setIconcls(headMenuM.getIconCls());
			if (!menu.getId().equals("0")) {// 根节点不可以修改上级节点
				menu.setMenu(headDao.getMenu(headMenuM.getParentId()));
			}
			headDao.updateMenu(menu);
		}
		return headMenuM;
	}
	
	@SuppressWarnings("unchecked")
	private EasyuiTreeNode tree(HeadMenu menu, boolean recursive) {
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
				List<HeadMenu> menuList = new ArrayList<HeadMenu>(menu.getMenus());
				SortList<HeadMenu> sl = new SortList<HeadMenu>();
				sl.Sort(menuList, "seq", null);
//				Collections.sort(menuList, new MenuComparator());// 排序
				List<EasyuiTreeNode> children = new ArrayList<EasyuiTreeNode>();
				for (HeadMenu m : menuList) {
					EasyuiTreeNode t = tree(m, true);
					children.add(t);
				}
				node.setChildren(children);
			}
		}
		return node;
	}
	
	@SuppressWarnings("unchecked")
	private void recursiveDelete(HeadMenu menu) {
		if (menu.getMenus() != null && menu.getMenus().size() > 0) {
			Set<HeadMenu> menus = menu.getMenus();
			for (HeadMenu t : menus) {
				recursiveDelete(t);
			}
		}
//		//删除角色与菜单的关系
//		List<RoleMenu> roleMenuList = roleMenuDao.findRoleMenu(menu);
//		if(roleMenuList!=null&&roleMenuList.size()>0){
//		for (RoleMenu roleMenu : roleMenuList) {
//			roleMenuDao.deleteRoleMenu(roleMenu.getId());
//		}
		
//	}
		headDao.deleteMenu(menu.getId());
	}
	@Override
	public List<EasyuiTreeNode> backgroundTree(String id) {
		List<HeadMenu> menus = headDao.findByShowStatus(id);
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
//		for(Menu menu : menus){
//			tree.add(tree(menu,false));
//		}
//		//用户菜单
//		HashSet<String> set= store.getRoleMenuIdSet();
//		if(set!=null){
//			List<Menu> menuList = new ArrayList<Menu>();
//			for(Menu menu:menus){
//				if(set.contains(menu.getId())){
//					menuList.add(menu);
//				}
//			}
//			menus=menuList;
//		}
		//用户菜单树
		for(HeadMenu menu : menus){
			tree.add(tree(menu,false));
		}
		return tree;
	}
	
//	@Override
//	public HashSet<String> roleMenuIdSet(StoreUser store) {
//		//Role role =roleDao.getRole(store.getRoleId());
//		
//		//List<RoleMenu> listrm = roleMenuDao.findRoleMenu(role);
//		HashSet<String> menuSet = new HashSet<String>();
//		for(RoleMenu rm : listrm){
//			Menu menu = menuDao.getMenu(rm.getMenu().getId());
//			menuSet.add(menu.getId());
//			menu = menu.getMenu();
//			while(menu!=null){
//				menuSet.add(menu.getId());
//				menu=menu.getMenu();
//			}
//		}
//		return menuSet;
//	}
	
}
