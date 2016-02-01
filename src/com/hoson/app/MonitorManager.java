/**
 * Copyright @2006 Hangzhou Hoson Co.Ltd
 * All right reserved
 * 2006-6-8 Hemin �������ļ�
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
     * ��ȡȫ���������
     * @return
     */
    public List getAllInfectantParam(){
        String sql = "select * from t_cfg_infectant_base order by infectant_id";
        return dbmgr.excuteQuery(sql);
    }
    
    /**
     * ��ȡָ��������͵ļ������
     * @param type
     * @return
     */
    public List getInfectantByType(String type){
        String sql = "select infectant_id,infectant_name from t_cfg_infectant_base " +
                "where station_type='"+type+"' order by infectant_id";
        return dbmgr.excuteQuery(sql);
    }
    
    /**
     * ��ȡվ������������
     * @param stationId վ����
     * @return List
     */
    public List getAllMonitorByStationId(String stationId){
        String sql = "select b.infectant_id,b.infectant_name from t_cfg_monitor_param a,t_cfg_infectant_base b " +
                "where a.station_id=? and a.infectant_id=b.infectant_id order by b.infectant_id";
        return dbmgr.excuteQuery(sql,new Object[]{stationId});
    }
    
    /**
     * ��ȡ�ɴ�ӡ��վ��������
     * @param stationId վ����
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
     * ��ȡվ��δ���õļ������
     * @param stationId վ��ID
     * @return
     */
    public List getNoSetupMonitorByStationId(String stationId){
        String sql = "select infectant_id,infectant_name from t_cfg_infectant_base where infectant_id not in("
            + "select infectant_id from t_cfg_monitor_param where station_id=?) order by infectant_id";
        return dbmgr.excuteQuery(sql,new Object[]{stationId});
    }
    
    /**
     * ��ȡ���������Ϣ
     * @param monitorId ����ID
     * @return
     */
    public Map getMonitorById(String monitorId,String stationId){
        String sql = "select * from t_cfg_monitor_param " +
            "where infectant_id='"+monitorId+"' and station_id='"+stationId+"'";
        return (Map)dbmgr.querySingle(sql);
    }
    
    /**
     * ����վ��ļ����������
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
     * ��������Ӵ����ÿ���ӵ�վ��
     * @param infectantId
     * @return ����Ӱ���¼��
     */
    public int addInfectantToStation(Map columnValueMap){
        String tableName = "t_cfg_monitor_param";
        if(columnValueMap.get("infectant_id")==null || "".equals(columnValueMap.get("infectant_id")))
            throw new DataAccessException("����ѡ��һ��Ҫ��ӵ�����!");
        if(columnValueMap.get("station_id")==null || "".equals(columnValueMap.get("station_id")))
            throw new DataAccessException("����ѡ��һ��վ��!");
        if(columnValueMap.get("group_id")==null || "".equals(columnValueMap.get("group_id")))
            throw new DataAccessException("group_id��ֵ����Ϊ��!");
        
        //�����ӻ������в��Ҷ�Ӧinfectant_column��ֵ
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
     * ��������Ӵ�վ��������ɾ��
     * @param infectantId
     * @return ����Ӱ���¼��
     */
    public int removeInfectantFromStation(String infectantId,String stationId){
        String sql = "delete t_cfg_monitor_param where infectant_id=? and station_id=?";
        Object[] params = new Object[]{infectantId, stationId};
        return dbmgr.update(sql,params);
    }
}
