package com.explorati.new_retail.test1;

import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

public class Demo1 {

	public static String createOrderCode(String type, String organizationId, String spgId, String date) {
		StringBuffer sb = new StringBuffer();
		sb.append(type);
		sb.append(organizationId);
		sb.append(spgId);
		sb.append(date);
		ThreadLocalRandom.current().ints(0,9).limit(10).forEach((one) -> {
			sb.append(one);	
		});
		return sb.toString();
	}
}
