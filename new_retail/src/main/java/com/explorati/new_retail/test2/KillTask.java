package com.explorati.new_retail.test2;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.Transaction;

public class KillTask implements Runnable {

	@Override
	public void run() {
		// 连接Redis
		Jedis jedis = new Jedis("192.168.204.129", 6379);
		// 登录密码
		jedis.auth("wl520000");
		// 选择Redis缓存库
		jedis.select(0);
		// 将字符串转换为int
		int num = Integer.parseInt(jedis.get("kill_num"));
		// 开启观察
		jedis.watch("kill_num", "kill_user");
		// 如果库存大于0
		if (num > 0) {
			// 开启事务
			Transaction transaction = jedis.multi();
			// 库存减1
			transaction.decr("kill_num");
			// 向秒杀成功的用户列表中添加用户id
			transaction.rpush("kill_user", "9527");
			// 提交事务
			transaction.exec();
		} else {
			// 关闭线程池
			Application.pool.shutdown();
		}
		jedis.close();
	}

}
