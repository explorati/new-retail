package com.explorati.new_retail.test4;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import com.mysql.cj.jdbc.Driver;

import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSON;
import cn.hutool.json.JSONUtil;

/**
 * 根据高德开发者工具返回相应地址的经纬度和详细信息
 * 
 * @author explorati
 *
 */
public class Demo1 {

	public static void main(String[] args) {
		HashMap map = new HashMap();
		// 若报错10001，注意前面不要有空格....
		map.put("key", "cc9b49c441d224c60a15a817f3b496ad");
		map.put("address", "营口市盼盼工业园");
		// 发送HTTP请求，返回信息(格式为字符串)
		String resp = HttpUtil.get("https://restapi.amap.com/v3/geocode/geo", map);
		// System.out.println(resp);
		// 将字符串信息解析为JSON格式
		JSON json = JSONUtil.parse(resp);
		String location = json.getByPath("geocodes[0].location", String.class);
		// 获取经度
		String lng = location.split(",")[0];
		// 获取纬度
		String lat = location.split(",")[1];
		// System.out.println(lng);
		// System.out.println(lat);

		try {
			// 获取数据库驱动，注意连接8.0版本是com.mysql.cj.jdbc.Driver
			DriverManager.registerDriver(new Driver());
			// 连接MySQL8.0s时 结尾必须加上时区信息
			String url = "jdbc:mysql://192.168.204.128:3306/neti?serverTimeZone=GMT%2B8";
			String username = "root";
			String password = "wl520000";
			// 连接数据库
			Connection conn = DriverManager.getConnection(url, username, password);
			//加了占位符的SQL语句
			String sql = "SELECT\r\n " 
							+ "t.id \r\n " 
							+ "from\r\n" 
							+ "(select \r\n" 
								+ "w.id,\r\n" 
								+ "st_distance(\r\n"
											+ "point(?, ?),\r\n" 
											+ "point(w.lng, w.lat) \r\n" 
								+ ")*111195/1000 as dis\r\n"
								+ "from t_warehouse w\r\n" 
								+"join t_warehouse_sku ws on ws.warehouse_id = w.id\r\n"
								+ "AND ws.sku_id = ? AND ws.num >= ?\r\n"
								+ "order by dis\r\n"
								+ "limit 1) t;" ;
							
			// 执行SQL语句
			PreparedStatement pst = conn.prepareStatement(sql);
			// 经度
			pst.setObject(1, lng);
			// 纬度
			pst.setObject(2, lat);
			// 购买商品的编号
			pst.setObject(3, 1);
			// 购买商品数量
			pst.setObject(4, 1);
			// 执行查询
			ResultSet set = pst.executeQuery();
			while(set.next()){
				int id = set.getInt("id");
				System.out.println(id);
			}
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
