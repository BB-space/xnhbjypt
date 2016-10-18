package com.sykj.app.service.system.impl;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.sykj.app.dao.system.SysDictionaryDao;
import com.sykj.app.entity.system.SysDictionary;
import com.sykj.app.model.SysDictionaryM;
import com.sykj.app.service.system.SysDictionaryService;

@Service("sysDictionaryService")
public class SysDictionaryServiceImpl implements SysDictionaryService{
	@Resource
	private SysDictionaryDao sysDictionaryDao;
	
	@Override
	public void addSysDictionary(SysDictionary t) {
		this.addSysDictionary(t);
	}

	@Override
	public SysDictionary getSysDictionary(String id) {
		SysDictionaryM sysDictionaryM = new SysDictionaryM();
		SysDictionary sysDictionary = sysDictionaryDao.getSysDictionary(id);
		if(sysDictionary!=null){
			BeanUtils.copyProperties(sysDictionary,sysDictionaryM);
		}else{
			sysDictionaryM=null;
		}
		return sysDictionary;
	}

}
