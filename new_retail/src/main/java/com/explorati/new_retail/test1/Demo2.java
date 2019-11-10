package com.explorati.new_retail.test1;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.UUID;

public class Demo2 {
	public static void main(String[] args) {
		try {
			// 字符输出流
			FileWriter w = new FileWriter("D:/新零售数据库/1.txt");
			// 缓冲流(提高效率)
			BufferedWriter bw = new BufferedWriter(w);
			for (int i = 1; i < 10000000; i++) {
				String uuid = UUID.randomUUID().toString();
				// i为主键，uuid为val
				bw.write(i + ", " + uuid + "\n");
			}
			bw.close();
			w.close();
			System.out.println("执行完毕");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
