/**
 * Copyright @2006 Hangzhou Hoson Co.Ltd
 * All right reserved
 * 2006-6-7 Hemin 创建本文件
 */
package com.hoson.app;

import java.util.List;

import com.hoson.commons.db.DBManager;
import com.hoson.commons.db.DBManagerJdbcImpl;

/**
 * AreaManager
 */
public class AreaManager {
    private DBManager dbmgr;
    
    public AreaManager(){
        dbmgr = new DBManagerJdbcImpl();
    }
    
    public List getAreaByParentArea(String pid){
        String sql = "select b.area_id,b.area_name,a.area_pid,count(*) as child_count "+ 
            "from t_cfg_area a,t_cfg_area b where a.area_pid in( "+
            "select area_id from t_cfg_area where area_pid=?) "+
            "and b.area_id=a.area_pid "+
            "group by a.area_pid,b.area_id,b.area_name ";
        List list = dbmgr.excuteQuery(sql,pid);
        if (null == list || list.size()==0) {
            sql = "select area_id,area_name,0 as child_count from t_cfg_area where area_pid=?";
            list = dbmgr.excuteQuery(sql,pid);
        }
        return list;
    }
    
    public List getAllAreaByParentArea(String pid){
        String sql = "select * from t_cfg_area where area_pid like '"+pid+"%' order by area_id";
        return dbmgr.excuteQuery(sql);
    }
    
    public List getAreaIdByParentArea(String pid){
        String sql = "select area_id from t_cfg_area where area_pid="+pid+" order by area_id";
        return dbmgr.excuteQueryAsArray(sql);
    }
    
    public List getAllAreaIdByParentArea(String pid){
        String sql = "select area_id from t_cfg_area where area_pid like '"+pid+"%' order by area_id";
        return dbmgr.excuteQueryAsArray(sql);
    }
}
