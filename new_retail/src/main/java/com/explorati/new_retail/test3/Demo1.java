package com.explorati.new_retail.test3;

import org.owasp.validator.html.AntiSamy;
import org.owasp.validator.html.Policy;
import org.owasp.validator.html.PolicyException;
import org.owasp.validator.html.ScanException;

public class Demo1 {

	public static void main(String[] args) {
		String temp = "HelloWorld<img src='null' onerror='alert(1234)'>";		
		String path = Demo1.class.getResource("antisamy-tinymce.xml").getPath().toString();
		try {
			Policy policy = Policy.getInstance(path);
			AntiSamy samy = new AntiSamy();
			String result = samy.scan(temp, policy).getCleanHTML();
			System.out.println(result);
		} catch (PolicyException e) {
			e.printStackTrace();
		} catch (ScanException e) {
			e.printStackTrace();
		}
	}
}
