package com.steven.demo.controller;


import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

/**
 * 微信客户端通过wx.login将code发到后台，后台将code、appId、appSecret发到微信服务器获取openid、session_key。
 * 返回结果如右所示	{"session_key":"LQldABDYB5NeUZZXaG2zgg==","openid":"oyMvT5Lihfbj04qU6EVanyq3g9Fo"}
 * 微信服务器获取openid、session_key的地址如下
 * https://api.weixin.qq.com/sns/jscode2session?appid=APPID&secret=SECRET&js_code=JSCODE&grant_type=authorization_code
 * @author Administrator
 */
@Service
@RequestMapping("/login")
public class LoginController {

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/login")
	public Object login(@RequestBody Map<String,Object> obj,HttpServletRequest request) {
		// 获取服务器传送过来的数据
		String key = (String) obj.get("code");
		System.err.println(key);
		Map<String,Object> userInfo = (Map<String,Object>)obj.get("userInfo");
		System.out.println(userInfo);
		
		//微信服务器返回的openid和session_key数据
		String res = request(key);
		
		// 解析数据
		String[] wxres = res.replace("\"", "").split(",");
		String openid = wxres[1].split(":")[1].replace("}", "");
		String session_key = wxres[0].split(":")[1];
		
		// 查找数据库是否有该用户，没有则新增，有的话不做处理
		int count = select(openid);
		if(count < 1) {
			//插入数据库
			System.out.println("新用户，插入数据库");
			insert(openid,session_key,userInfo);
		}else {
			System.out.println("老用户，返回openid");
		}
		
		//整理数据，向客户端返回openid
		return "{\"openid\":\""+openid+"\"}";
	}
	
	//存入数据库
	public static int insert(String openid, String session_key, Map<String,Object> userInfo) {
		String url = "jdbc:mysql://127.0.0.1:3306/ssm?useUnicode=true&amp;characterEncoding=utf-8";
		String username = "root";
		String passwd = "root";
		
		try {
			//加载驱动
			Class.forName("com.mysql.jdbc.Driver");
			//连接数据库 
			Connection conn = (Connection) DriverManager.getConnection(url, username, passwd);
			//操作数据库
			Statement st = (Statement) conn.createStatement();
			String sql = "insert into wx_login(session_key,openid,nickName,gender,city,province,country,avatarUrl,addTime) values('"
					+session_key+"','"+openid+"','"+userInfo.get("nickName")+"',"+userInfo.get("gender")+",'"+userInfo.get("city")
					+"','"+userInfo.get("province")+"','"+userInfo.get("country")+"','"+userInfo.get("avatarUrl")+"','"
					+new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date())+"')";
			
			int count = st.executeUpdate(sql);
			System.out.println("插入成功返回影响条数："+count);
			
			if(count > 0) {
				return count;
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
	/**
	 * 通过openid查找是否有该用户
	 * @param openid
	 * @return
	 */
	public static int select(String openid) {
		String url = "jdbc:mysql://127.0.0.1:3306/ssm?useUnicode=true&amp;characterEncoding=utf-8";
		String username = "root";
		String passwd = "root";
		int count = 0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			//	创建；连接
			Connection conn = (Connection) DriverManager.getConnection(url, username, passwd);
			//	操作数据库
			Statement st = (Statement) conn.createStatement();
			String sql = "select count(1) from wx_login where openid = '"+openid+"'";
			ResultSet rs = st.executeQuery(sql);
			while(rs.next()) {
				count = rs.getInt(1);//太久没用原生jdbc了，这里的columnIndex默认是从1开始的
			}
			System.out.println("查找到该用户的数据条数："+count);
			
			return count;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	/**
	 * 发起网络请求
	 * @param code	小程序发过来的code
	 * @return	微信服务器返回的数据
	 */
	public String request(String code) {
		try {
			String str = "https://api.weixin.qq.com/sns/jscode2session?";
			str += "appid=你的小程序的appId";
			str += "&secret=你的小程序的appSecret";
			str += "&js_code="+code+"&grant_type=authorization_code";
			URL url = new URL(str);
			
			//	请求微信服务器
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setReadTimeout(5000);
			conn.setRequestMethod("POST");
			
			if(conn.getResponseCode() == 200) {
				//用getInputStream()方法获得服务器返回的输入流
			    InputStream in = conn.getInputStream();
			    
			    //	获取服务器返回数据,将数据转成字符串
			    ByteArrayOutputStream swapStream = new ByteArrayOutputStream(); 
			    byte[] buff = new byte[100];
			    int rc = 0; 
			    while ((rc = in.read(buff, 0, 100)) > 0) { 
			    	swapStream.write(buff, 0, rc); 
			    } 
			    byte[] byteData = swapStream.toByteArray();
			    
			    String data = new String(byteData, "UTF-8");
			    System.out.println("成功获取微信服务器返回的数据"+data);

			    in.close();
			    return data;
			}
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "";
	}
}
