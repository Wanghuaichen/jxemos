/**
 * Copyright @2006 Hangzhou Hoson Co.Ltd
 * All right reserved
 * 2006-6-8 Hemin 创建本文件
 */
package com.hoson.app;

import java.util.*;

import com.hoson.commons.db.DBManager;
import com.hoson.commons.db.DBManagerJdbcImpl;
import com.hoson.commons.exception.DataAccessException;

/**
 * MonitorManager
 */
public class MonitorManager {
    private DBManager dbmgr;
    
    public MonitorManager(){dbmgr = new DBManagerJdbcImpl();}
    
    /**
     * 获取全部监测因子
     * @return
     */
    public List getAllInfectantParam(){
        String sql = "select * from t_cfg_infectant_base order by infectant_id";
        return dbmgr.excuteQuery(sql);
    }
    
    /**
     * 获取指定监测类型的监测因子
     * @param type
     * @return
     */
    public List getInfectantByType(String type){
        String sql = "select infectant_id,infectant_name from t_cfg_infectant_base " +
                "where station_type='"+type+"' order by infectant_id";
        return dbmgr.excuteQuery(sql);
    }
    
    /**
     * 获取站点监测因子配置
     * @param stationId 站点编号
     * @return List
     */
    public List getAllMonitorByStationId(String stationId){
        String sql = "select b.infectant_id,b.infectant_name from t_cfg_monitor_param a,t_cfg_infectant_base b " +
                "where a.station_id=? and a.infectant_id=b.infectant_id order by b.infectant_id";
        return dbmgr.excuteQuery(sql,new Object[]{stationId});
    }
    
    /**
     * 获取可打印的站点监测因子
     * @param stationId 站点编号
     * @return Map
     */
    public Map getPrintMonitorByStationIdAsMap(String stationId){
        String sql = "select infectant_column,infectant_name from v_cfg_monitor_param "
            + "where station_id='" + stationId
            + "' and report_flag='1' "
            + "order by show_order,infectant_column";
        return dbmgr.excuteQueryAsMap(sql);
    }
    
    /**
     * 获取站点未配置的监测因子
     * @param stationId 站点ID
     * @return
     */
    public List getNoSetupMonitorByStationId(String stationId){
        String sql = "select infectant_id,infectant_name from t_cfg_infectant_base where infectant_id not in("
            + "select infectant_id from t_cfg_monitor_param where station_id=?) order by infectant_id";
        return dbmgr.excuteQuery(sql,new Object[]{stationId});
    }
    
    /**
     * 获取监测因子信息
     * @param monitorId 因子ID
     * @return
     */
    public Map getMonitorById(String monitorId,String stationId){
        String sql = "select * from t_cfg_monitor_param " +
            "where infectant_id='"+monitorId+"' and station_id='"+stationId+"'";
        return (Map)dbmgr.querySingle(sql);
    }
    
    /**
     * 更新站点的监测因子配置
     * @param monitorId
     * @param columnMap
     * @return
     */
    public int updateMonitorInfo(String monitorId,String stantionId,Map columnMap){
        String tableName = "t_cfg_monitor_param";
        Map conditionMap = new HashMap(1);
        conditionMap.put("infectant_id",monitorId);
        conditionMap.put("station_id",stantionId);
        return dbmgr.update(tableName,columnMap,conditionMap);
    }
    
    /**
     * 将监测因子从配置库添加到站点
     * @param infectantId
     * @return 操作影响记录数
     */
    public int addInfectantToStation(Map columnValueMap){
        String tableName = "t_cfg_monitor_param";
        if(columnValueMap.get("infectant_id")==null || "".equals(columnValueMap.get("infectant_id")))
            throw new DataAccessException("必须选择一个要添加的因子!");
        if(columnValueMap.get("station_id")==null || "".equals(columnValueMap.get("station_id")))
            throw new DataAccessException("必须选择一个站点!");
        if(columnValueMap.get("group_id")==null || "".equals(columnValueMap.get("group_id")))
            throw new DataAccessException("group_id的值不能为空!");
        
        //从因子基本表中查找对应infectant_column的值
        String sql = "select infectant_column from t_cfg_infectant_base where infectant_id="+columnValueMap.get("infectant_id");
        String infectant_column = dbmgr.querySingleValue(sql);
        
        int valId = Integer.parseInt(infectant_column.replaceFirst("VAL",""));
        if(valId>30){
            sql = "select max(infectant_column) from t_cfg_monitor_param where station_id=4";
            infectant_column = (String)dbmgr.querySingleValue(sql);
            if(infectant_column==null || "".equals(infectant_column) || "null".equalsIgnoreCase(infectant_column))
                valId = 30;
            else
                valId = Integer.parseInt(infectant_column.replaceFirst("VAL",""))+1;
            infectant_column = "VAL"+valId;
        }
        columnValueMap.put("infectant_column",infectant_column);
        
        return dbmgr.insert(tableName,columnValueMap,null);
    }
    
    /**
     * 将监测因子从站点配置中删除
     * @param infectantId
     * @return 操作影响记录数
     */
    public int removeInfectantFromStation(String infectantId,String stationId){
        String sql = "delete t_cfg_monitor_param where infectant_id=? and station_id=?";
        Object[] params = new Object[]{infectantId, stationId};
        return dbmgr.update(sql,params);
    }
}
