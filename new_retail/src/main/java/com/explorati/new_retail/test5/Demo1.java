package com.explorati.new_retail.test5;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import com.hankcs.lucene.HanLPAnalyzer;
import com.mysql.cj.jdbc.Driver;

public class Demo1 {

	public static void main(String[] args) {
		try {
			// 创建存储目录
			Directory directory = FSDirectory.open(new File("D:/新零售数据库/中文分词/123").toPath());
			// 创建中文分词分析器
			Analyzer analyzer = new HanLPAnalyzer();
			// 创建索引配置对象
			IndexWriterConfig config = new IndexWriterConfig(analyzer);
			// 创建索引写入器
			IndexWriter writer = new IndexWriter(directory, config);

			DriverManager.registerDriver(new Driver());
			String url = "jdbc:mysql://192.168.204.128:3306/neti?serverTimezone=GMT%2B8";
			String username = "root";
			String password = "wl520000";
			Connection conn = DriverManager.getConnection(url, username, password);

			String sql = "SELECT id, title FROM t_sku";
			PreparedStatement pst = conn.prepareStatement(sql);
			ResultSet set = pst.executeQuery();
			//将索引写入Document中
			while (set.next()) {
				String id = set.getString("id");
				String title = set.getString("title");
				Document document = new Document();
				document.add(new TextField("id", id, Field.Store.YES));
				document.add(new TextField("title", title, Field.Store.YES));
				writer.addDocument(document);
			}
			conn.close();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
