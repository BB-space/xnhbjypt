package com.sykj.util;

import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

public class RunTest {

	 public void f() {
	       // other operations should not be locked...
	       System.out.println(Thread.currentThread().getName()
	              + "f" );

	          
	        	   timeInMillis();

	    }
	 
	    public void g() {
	       // other operations should not be locked...
	       System.out.println(Thread.currentThread().getName()
	              + "g");

	           
	        	   timeInMillis();

	    }
	 
	    public void h(int i) {
	       // other operations should not be locked...
	       System.out.println(Thread.currentThread().getName()
	              +"NO." +i);
	       
	           


	           
	       
	    }
	 
	    public synchronized void timeInMillis(){
	    	
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			long time1 = cal.getTimeInMillis();
			String str = String.format("%tF %<tT", time1);
		    System.out.println("时间："+time1+"*"+str);
		    try {
                TimeUnit.SECONDS.sleep(3);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
	    	
		}
	    
	    public static void main(String[] args) {
	        final RunTest rs = new RunTest();
	 for(int i=0;i<10;i++){
		 new Thread() {
	           public void run() {
	              rs.f();
	           }
	       }.start();
	       new Thread() {
	           public void run() {
	              rs.g();
	           }
	       }.start();
	       rs.h(i);
	 }
	      
	 
//	       new Thread() {
//	           public void run() {
//	              rs.g();
//	           }
//	       }.start();
//	 
//	       rs.h();
	    }
}
