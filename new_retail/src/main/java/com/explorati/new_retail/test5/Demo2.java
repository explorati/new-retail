package com.explorati.new_retail.test5;

import java.nio.file.Paths;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import com.hankcs.lucene.HanLPAnalyzer;

public class Demo2 {

	public static void main(String[] args) {
		try {
			// 打开索引目录
			Directory directory = FSDirectory.open(Paths.get("D:/新零售数据库/中文分词/123"));
			// 索引阅读器
			IndexReader reader = DirectoryReader.open(directory);
			// 索引扫描器
			IndexSearcher searcher = new IndexSearcher(reader);
			// 需要扫描的内容
			String text = "我想要苹果手机";
			// 搜索字段的名称
			String field = "title";

			Analyzer analyzer = new HanLPAnalyzer();
			//查询解析器 参数为 搜索字段名 和  解析器
			QueryParser parser = new QueryParser(field, analyzer);
			Query query = parser.parse(text);
			TopDocs docs = searcher.search(query, 100);
			System.out.println("命中的记录数：" + docs.totalHits);

			ScoreDoc[] scoreDocs = docs.scoreDocs;
			for (ScoreDoc scoreDoc : scoreDocs) {
				Document document = searcher.doc(scoreDoc.doc);
				String id = document.get("id");
				String title = document.get("title");
				System.out.println("id -> " + id);
				System.out.println("title -> " + title);
			}
			reader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
