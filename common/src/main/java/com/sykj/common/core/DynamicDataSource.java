package com.sykj.common.core;

import java.util.Map;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;
import org.springframework.jdbc.datasource.lookup.DataSourceLookup;

public class DynamicDataSource extends AbstractRoutingDataSource{  
	  

	@Override
	public Object determineCurrentLookupKey() {
		return DatabaseContextHolder.getCustomerType();
	}

  
}  
