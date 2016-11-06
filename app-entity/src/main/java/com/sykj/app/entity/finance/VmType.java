package com.sykj.app.entity.finance;



/**
 * 虚拟币类型表
 * XnhbVmVmtype entity. @author MyEclipse Persistence Tools
 */

public class VmType  implements java.io.Serializable {


    // Fields    

     private String vmtypeId;
     private String createdatetime;
     private String createuser;
     private String updatedatetime;
     private String updateuser;
     private Integer seq;
     private String description;
     private String jttypename;
     private String fttypename;
     private String entypename;
     private String vmnumber;
     private String pid;
     private String language;
     private String status;
     private String shortname;
     private String symbol;
     private String ip;
     private String url;
     private String port;
     private String istrading;
     private String iswithdrawal;
     private String isuspended;
     private String opendatetime;
     private String closedatetime;
     private String introduction;
     private String accesskey;
     private String secrtkey;
     private String logo;
     private String keyword;


    // Constructors

    /** default constructor */
    public VmType() {
    }

	/** minimal constructor */
    public VmType(String vmtypeId, Integer seq) {
        this.vmtypeId = vmtypeId;
        this.seq = seq;
    }
    
    /** full constructor */
    public VmType(String vmtypeId, String createdatetime, String createuser, String updatedatetime, String updateuser, Integer seq, String description, String jttypename, String fttypename, String entypename, String vmnumber, String pid, String language, String status, String shortname, String symbol, String ip, String url, String port, String istrading, String iswithdrawal, String isuspended, String opendatetime, String closedatetime, String introduction, String accesskey, String secrtkey, String logo, String keyword) {
        this.vmtypeId = vmtypeId;
        this.createdatetime = createdatetime;
        this.createuser = createuser;
        this.updatedatetime = updatedatetime;
        this.updateuser = updateuser;
        this.seq = seq;
        this.description = description;
        this.jttypename = jttypename;
        this.fttypename = fttypename;
        this.entypename = entypename;
        this.vmnumber = vmnumber;
        this.pid = pid;
        this.language = language;
        this.status = status;
        this.shortname = shortname;
        this.symbol = symbol;
        this.ip = ip;
        this.url = url;
        this.port = port;
        this.istrading = istrading;
        this.iswithdrawal = iswithdrawal;
        this.isuspended = isuspended;
        this.opendatetime = opendatetime;
        this.closedatetime = closedatetime;
        this.introduction = introduction;
        this.accesskey = accesskey;
        this.secrtkey = secrtkey;
        this.logo = logo;
        this.keyword = keyword;
    }

   
    // Property accessors

    public String getVmtypeId() {
        return this.vmtypeId;
    }
    
    public void setVmtypeId(String vmtypeId) {
        this.vmtypeId = vmtypeId;
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

    public String getUpdatedatetime() {
        return this.updatedatetime;
    }
    
    public void setUpdatedatetime(String updatedatetime) {
        this.updatedatetime = updatedatetime;
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

    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

    public String getJttypename() {
        return this.jttypename;
    }
    
    public void setJttypename(String jttypename) {
        this.jttypename = jttypename;
    }

    public String getFttypename() {
        return this.fttypename;
    }
    
    public void setFttypename(String fttypename) {
        this.fttypename = fttypename;
    }

    public String getEntypename() {
        return this.entypename;
    }
    
    public void setEntypename(String entypename) {
        this.entypename = entypename;
    }

    public String getVmnumber() {
        return this.vmnumber;
    }
    
    public void setVmnumber(String vmnumber) {
        this.vmnumber = vmnumber;
    }

    public String getPid() {
        return this.pid;
    }
    
    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getLanguage() {
        return this.language;
    }
    
    public void setLanguage(String language) {
        this.language = language;
    }

    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }

    public String getShortname() {
        return this.shortname;
    }
    
    public void setShortname(String shortname) {
        this.shortname = shortname;
    }

    public String getSymbol() {
        return this.symbol;
    }
    
    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }

    public String getIp() {
        return this.ip;
    }
    
    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getUrl() {
        return this.url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }

    public String getPort() {
        return this.port;
    }
    
    public void setPort(String port) {
        this.port = port;
    }

    public String getIstrading() {
        return this.istrading;
    }
    
    public void setIstrading(String istrading) {
        this.istrading = istrading;
    }

    public String getIswithdrawal() {
        return this.iswithdrawal;
    }
    
    public void setIswithdrawal(String iswithdrawal) {
        this.iswithdrawal = iswithdrawal;
    }

    public String getIsuspended() {
        return this.isuspended;
    }
    
    public void setIsuspended(String isuspended) {
        this.isuspended = isuspended;
    }

    public String getOpendatetime() {
        return this.opendatetime;
    }
    
    public void setOpendatetime(String opendatetime) {
        this.opendatetime = opendatetime;
    }

    public String getClosedatetime() {
        return this.closedatetime;
    }
    
    public void setClosedatetime(String closedatetime) {
        this.closedatetime = closedatetime;
    }

    public String getIntroduction() {
        return this.introduction;
    }
    
    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getAccesskey() {
        return this.accesskey;
    }
    
    public void setAccesskey(String accesskey) {
        this.accesskey = accesskey;
    }

    public String getSecrtkey() {
        return this.secrtkey;
    }
    
    public void setSecrtkey(String secrtkey) {
        this.secrtkey = secrtkey;
    }

    public String getLogo() {
        return this.logo;
    }
    
    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getKeyword() {
        return this.keyword;
    }
    
    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
   








}