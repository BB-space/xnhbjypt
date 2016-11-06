package com.sykj.app.entity.finance;



/**
 * 虚拟币可用地址表
 * XnhbVmVmtypeaddress entity. @author MyEclipse Persistence Tools
 */

public class VmTypeAddress  implements java.io.Serializable {


    // Fields    

     private String vmtypeaddressId;
     private String createdatetime;
     private String createuser;
     private String updateuser;
     private Integer seq;
     private String updatedatetime;
     private String description;
     private String vmtypename;
     private Integer addressnum;


    // Constructors

    /** default constructor */
    public VmTypeAddress() {
    }

	/** minimal constructor */
    public VmTypeAddress(String vmtypeaddressId, Integer seq, Integer addressnum) {
        this.vmtypeaddressId = vmtypeaddressId;
        this.seq = seq;
        this.addressnum = addressnum;
    }
    
    /** full constructor */
    public VmTypeAddress(String vmtypeaddressId, String createdatetime, String createuser, String updateuser, Integer seq, String updatedatetime, String description, String vmtypename, Integer addressnum) {
        this.vmtypeaddressId = vmtypeaddressId;
        this.createdatetime = createdatetime;
        this.createuser = createuser;
        this.updateuser = updateuser;
        this.seq = seq;
        this.updatedatetime = updatedatetime;
        this.description = description;
        this.vmtypename = vmtypename;
        this.addressnum = addressnum;
    }

   
    // Property accessors

    public String getVmtypeaddressId() {
        return this.vmtypeaddressId;
    }
    
    public void setVmtypeaddressId(String vmtypeaddressId) {
        this.vmtypeaddressId = vmtypeaddressId;
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

    public Integer getSeq() {
        return this.seq;
    }
    
    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getUpdatedatetime() {
        return this.updatedatetime;
    }
    
    public void setUpdatedatetime(String updatedatetime) {
        this.updatedatetime = updatedatetime;
    }

    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

    public String getVmtypename() {
        return this.vmtypename;
    }
    
    public void setVmtypename(String vmtypename) {
        this.vmtypename = vmtypename;
    }

    public Integer getAddressnum() {
        return this.addressnum;
    }
    
    public void setAddressnum(Integer addressnum) {
        this.addressnum = addressnum;
    }
   








}