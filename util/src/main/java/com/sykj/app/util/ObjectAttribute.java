package com.sykj.app.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

/**
 * 对象属性值操作
 * @author swh
 *
 */
public class ObjectAttribute {

	/** 
	* 获取对象属性，返回一个非空属性字符串数组     
	*  
	* @param  o 对象 
	* @return String[] 非空属性名字符串数组 
	*/  
	public static String[] getFiledName(Object o) {
	try
	{
	Field[] fields = o.getClass().getDeclaredFields();  
	String[] fieldNames = new String[fields.length];  
	List<Object> obList = new ArrayList<Object>();
	for (int i=0; i < fields.length; i++)  
	{
		Object obj = getFieldValueByName(fields[i].getName(),o);
		if(null!=obj){
			obList.add(fields[i].getName());
		}     
	}    
	System.out.println(obList.size());
	String [] returnNames = new String[obList.size()]; 
	for(int i=0;i<obList.size();i++){
		returnNames[i]=(String) obList.get(i);
	}
	return returnNames;  
	} catch (SecurityException e)   
	{  
	e.printStackTrace();  
	System.out.println(e.toString());  
	}  
	    return null;  
	}
	  
	/** 
	* 使用反射根据属性名称获取属性值  
	*  
	* @param  fieldName 属性名称 
	* @param  o 操作对象 
	* @return Object 属性值 
	*/  
	  
	public static Object getFieldValueByName(String fieldName, Object o) {      
	   try   
	   {      
	       String firstLetter = fieldName.substring(0, 1).toUpperCase();      
	       String getter = "get" + firstLetter + fieldName.substring(1);
	      // System.out.println(firstLetter+ fieldName.substring(1)+"*");
	       Method method = o.getClass().getMethod(getter, new Class[] {});      
	       Object value = method.invoke(o, new Object[] {});      
	       return value;      
	   } catch (Exception e)
	   {      
	       System.out.println("属性不存在");      
	       return null;      
	   }      
	}
	
	/** 
     * 对象属性值复制，仅复制指定名称的属性值 
     * @param from 
     * @param to 
     * @param includsArray 
     * @throws Exception 
     */ 
	 public static void copyPropertiesInclude(Object from, Object to, String[] includsArray) throws Exception {  
	        List<String> includesList = null;  
	        if(includsArray != null && includsArray.length > 0) {  
	            includesList = Arrays.asList(includsArray); //构造列表对象  
	        } else {  
	            return;  
	        }  
	        Method[] fromMethods = from.getClass().getDeclaredMethods();  
	        Method[] toMethods = to.getClass().getDeclaredMethods();  
	        Method fromMethod = null, toMethod = null;  
	        String fromMethodName = null, toMethodName = null;  
	        for (int i = 0; i < fromMethods.length; i++) {  
	            fromMethod = fromMethods[i];  
	            fromMethodName = fromMethod.getName();  
	            if (!fromMethodName.contains("get"))  
	                continue;  
	            //排除列表检测  
	            String str = fromMethodName.substring(3);  
	            if(!includesList.contains(str.substring(0,1).toLowerCase() + str.substring(1))) {  
	                continue;  
	            }  
	            toMethodName = "set" + fromMethodName.substring(3);  
	            toMethod = findMethodByName(toMethods, toMethodName);  
	            if (toMethod == null)  
	                continue;  
	            Object value = fromMethod.invoke(from, new Object[0]);  
	            if(value == null)  
	                continue;  
	            //集合类判空处理  
	            if(value instanceof Collection) {  
	                Collection newValue = (Collection)value;  
	                if(newValue.size() <= 0)  
	                    continue;  
	            }  
	            toMethod.invoke(to, new Object[] {value});  
	        }  
	    } 
	 
	 /** 
	     * 从方法数组中获取指定名称的方法 
	     *  
	     * @param methods 
	     * @param name 
	     * @return 
	     */  
	    public static Method findMethodByName(Method[] methods, String name) {  
	        for (int j = 0; j < methods.length; j++) {  
	            if (methods[j].getName().equals(name))  
	                return methods[j];  
	        }  
	        return null;  
	    }
	    
	    /**
	     * 复制非空属性值到另一相同对象
	     * @param from(复制源对象)
	     * @param to(目标对象)
	     */
	    public static void copyAttributeToOther(Object from, Object to) {
	    	try {
	    		String[] includsArray=getFiledName(from);
				copyPropertiesInclude(from,to,includsArray);
			} catch (Exception e) {
				e.printStackTrace();
			}
	    }
}
