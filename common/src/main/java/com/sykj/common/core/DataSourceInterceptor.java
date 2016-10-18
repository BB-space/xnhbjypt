package com.sykj.common.core;

import org.aspectj.lang.JoinPoint;
import org.springframework.stereotype.Component;

@Component  
public class DataSourceInterceptor {  
  
    public void setdataSourceOne(JoinPoint jp) {  
        DatabaseContextHolder.setCustomerType("dataSourceOne");  
    }  
      
    public void setdataSourceTwo(JoinPoint jp) {  
        DatabaseContextHolder.setCustomerType("dataSourceTwo");  
    }
    
    public void setdataSourceThree(JoinPoint jp) {  
    	DatabaseContextHolder.setCustomerType("dataSourceThree");  
    }  
    
    public void setdataSourceFour(JoinPoint jp) {  
    	DatabaseContextHolder.setCustomerType("dateSourceFour");  
    }  
}  
