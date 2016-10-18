package test;

import com.sykj.app.entity.area.Shop;
import com.sykj.app.util.ObjectAttribute;

public class TestCopy {

	  public static void main(String[] args) throws Exception {
		Shop s1 = new Shop();
		Shop s2 = new Shop();
		s1.setShopName("s1");
		s1.setAddress("zhuhai");
		s1.setBed(5);
		s1.setHoliday(0.05);
		s2.setShortName("s2");
		//String[] array = new String[] {"shopName", "address","bed","holiday"};
		String[] includsArray=ObjectAttribute.getFiledName(s1);

			System.out.println(includsArray.length);
		
		
		ObjectAttribute.copyPropertiesInclude(s1,s2,includsArray);
		//ObjectAttribute.copyAttributeToOther(s1,s2);
		
		System.out.println(s2.getAddress()+"*"+s2.getShopName()+"*"+s2.getShortName()+"*"+s2.getHoliday());
//		for(String str:a1){
////			Object o = ObjectAttribute.getFieldValueByName(str, s2);
//			System.out.println(str);
//		}
		
	}  
}
