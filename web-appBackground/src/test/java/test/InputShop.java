package test;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import jxl.read.biff.BiffException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;

import com.sykj.app.entity.area.Shop;
import com.sykj.app.service.area.ShopService;
import com.sykj.app.util.ExcelFileUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath*:beans.xml")
@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = false)
public class InputShop {

	@Resource
	private ShopService shopService;
	

	public void inputShop() throws BiffException, IOException{
		File file = new File("E:\\文档资料\\数据\\门店统计1012.xls");
		List<Shop> sl = new ArrayList<Shop>();
		
		List<String[][]> shopList = ExcelFileUtil.read(file);
        String[][] row_contents = shopList.get(0);
        for(int j=1;j<row_contents.length;j++) {
        	Shop shop = new Shop();
            for(int k=0;k<row_contents[j].length;k++){
               String contents = row_contents[j][k];
               if(k==0){
            	   shop.setShopNumber(contents);
               }
               if(k==1){
            	   shop.setShopName(contents);
               }
               if(k==2){
            	   shop.setShortName(contents);
               }
               sl.add(shop);
            }

        } 
        
        List<Shop> slr  = shopService.addOrUpdateShop(sl);
        for(Shop s:slr){
        	System.out.println("缺失门店编码："+s.getShopNumber()+"  缺失门店名称："+s.getShopName());
        }
	}
}
