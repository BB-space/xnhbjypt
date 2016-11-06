package com.sykj.app.entity.finance;



/**
 * 人民币提现手续费
 * XnhbVmWdlevel entity. @author MyEclipse Persistence Tools
 */

public class Wdlevel  implements java.io.Serializable {


    // Fields    

     private String id;
     private String createdatetime;
     private String createuser;
     private String updateuser;
     private String updatedatetime;
     private Integer seq;
     private String description;
     private String wdlevel;
     private Double wdratecny;


    // Constructors

    /** default constructor */
    public Wdlevel() {
    }

	/** minimal constructor */
    public Wdlevel(String id, Integer seq) {
        this.id = id;
        this.seq = seq;
    }
    
    /** full constructor */
    public Wdlevel(String id, String createdatetime, String createuser, String updateuser, String updatedatetime, Integer seq, String description, String wdlevel, Double wdratecny) {
        this.id = id;
        this.createdatetime = createdatetime;
        this.createuser = createuser;
        this.updateuser = updateuser;
        this.updatedatetime = updatedatetime;
        this.seq = seq;
        this.description = description;
        this.wdlevel = wdlevel;
        this.wdratecny = wdratecny;
    }

   
    // Property accessors

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getCreatedatetime() {
        return this.createdatetime;
    }
    
    public void setCreatedatetime(String createdatetime) {
        this.createdatetime = createdatetime;
    }

    public String getCreateuser() {
        return this.createuser;
    }
    
    public void setCreateuser(String createuser) {
        this.createuser = createuser;
    }

    public String getUpdateuser() {
        return this.updateuser;
    }
    
    public void setUpdateuser(String updateuser) {
        this.updateuser = updateuser;
    }

    public String getUpdatedatetime() {
        return this.updatedatetime;
    }
    
    public void setUpdatedatetime(String updatedatetime) {
        this.updatedatetime = updatedatetime;
    }

    public Integer getSeq() {
        return this.seq;
    }
    
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

    public String getWdlevel() {
        return this.wdlevel;
    }
    
    public void setWdlevel(String wdlevel) {
        this.wdlevel = wdlevel;
    }

    public Double getWdratecny() {
        return this.wdratecny;
    }
    
    public void setWdratecny(Double wdratecny) {
        this.wdratecny = wdratecny;
    }
   








}