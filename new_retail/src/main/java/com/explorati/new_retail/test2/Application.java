package com.explorati.new_retail.test2;

import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import redis.clients.jedis.Jedis;

public class Application {

	public static ThreadPoolExecutor pool = new ThreadPoolExecutor(10, 100, 10, TimeUnit.SECONDS,
			new LinkedBlockingQueue<Runnable>());

	public static void main(String[] args) {
		// 连接Redis
		Jedis jedis = new Jedis("192.168.204.129", 6379);
		// 登录密码
		jedis.auth("wl520000");
		// 选择Redis缓存库
		jedis.select(0);
		// 设值
		jedis.set("kill_num", "50");
		jedis.del("kill_user");
		jedis.close();
		for (int i = 0; i < 1000; i++) {
			pool.execute(new KillTask());
		}
	}
}
