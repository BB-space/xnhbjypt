package com.sykj.app.service.area.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.area.SubcenterDao;
import com.sykj.app.entity.area.City;
import com.sykj.app.entity.area.Subcenter;
import com.sykj.app.entity.system.Role;
import com.sykj.app.model.EasyuiDataGridJson;
import com.sykj.app.model.EasyuiTreeNode;
import com.sykj.app.model.Pager;
import com.sykj.app.model.SystemContext;
import com.sykj.app.service.area.SubcenterService;
import com.sykj.app.service.impl.BaseServiceImpl;
import com.sykj.app.util.RoleComparator;

@Service("subcenterService")
public class SubcenterServiceImpl extends BaseServiceImpl implements SubcenterService{

	@Resource
	private SubcenterDao subcenterDao;

	@Override
	public Subcenter addSubcenter(Subcenter subcenter) {
		Subcenter s = new Subcenter();
		subcenter.setCreateDateTime(new Date());
		subcenter.setId(UUID.randomUUID().toString());
		BeanUtils.copyProperties(subcenter, s);
		return subcenterDao.add(s);
	}

	@Override
	public void deleteSubcenter(String ids) {
		for (String id : ids.split(",")) {
			Subcenter subcenter = subcenterDao.getSubcenter(id);
			if (subcenter != null) {
				subcenterDao.deleteSubcenter(id);
			}
		}
		
	}

	@Override
	public Subcenter editSubcenter(Subcenter subcenter) {
		Subcenter c = subcenterDao.getSubcenter(subcenter.getId());
		if(subcenter.getSubcenterName() != null && !subcenter.getSubcenterName().equals("")){
			c.setSubcenterName(subcenter.getSubcenterName());
		}
		if(subcenter.getSubcenterNumber() != null && !subcenter.getSubcenterNumber().equals("")){
			c.setSubcenterNumber(subcenter.getSubcenterNumber());
		}
		subcenterDao.update(c);
		return c;
	}

	@Override
	public EasyuiDataGridJson datagrid(SystemContext syct, Subcenter subcenter) {
		EasyuiDataGridJson j = new EasyuiDataGridJson();
		Pager<Subcenter> pSubcenter = subcenterDao.findSubcenter(syct, subcenter);
		j.setRows(pSubcenter.getDatas());
		j.setTotal(pSubcenter.getTotalCount());
		return j;
	}

	@Override
	public List<Subcenter> getAllSubcenter() {
		
		return subcenterDao.getAllSubcenter();
	}

	@Override
	public Subcenter getById(String id) {
		return subcenterDao.getById(id);
	}

	@Override
	public List<EasyuiTreeNode> tree(String id) {
		List<Subcenter> subcenterList = subcenterDao.getAllSubcenter();
		List<EasyuiTreeNode> tree = new ArrayList<EasyuiTreeNode>();
		for (Subcenter subcenter : subcenterList) {
			tree.add(tree(subcenter, false));
		}
		return tree;
	}
	
	private EasyuiTreeNode tree(Subcenter subcenter, boolean recursive) {
		EasyuiTreeNode node = new EasyuiTreeNode();
		node.setId(subcenter.getId());
		node.setText(subcenter.getSubcenterName());
		Map<String, Object> attributes = new HashMap<String, Object>();
		node.setAttributes(attributes);
		return node;
	}
}
