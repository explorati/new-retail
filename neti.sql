/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : 192.168.204.128:3306
 Source Schema         : neti

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 06/11/2019 09:45:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_backstock
-- ----------------------------
DROP TABLE IF EXISTS `t_backstock`;
CREATE TABLE `t_backstock`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '订单ID',
  `sku` json NOT NULL COMMENT '退货商品',
  `reason` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '退货原因',
  `qa_id` int(10) UNSIGNED NOT NULL COMMENT '质检员ID',
  `payment` decimal(10, 2) UNSIGNED NOT NULL COMMENT '退款金额',
  `payment_type` tinyint(3) UNSIGNED NOT NULL COMMENT '退款方式：1.借记卡，2.信用卡，3.微信，4.支付宝，5.现金',
  `status` tinyint(3) UNSIGNED NOT NULL COMMENT '状态：1.退货成功，2.无法退货',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id`) USING BTREE,
  INDEX `idx_qa_id`(`qa_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '退货表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_backstock
-- ----------------------------
INSERT INTO `t_backstock` VALUES (1, 2, '[3]', '质量问题', 15, 2999.00, 5, 1, '2019-04-11 21:18:06');

-- ----------------------------
-- Table structure for t_brand
-- ----------------------------
DROP TABLE IF EXISTS `t_brand`;
CREATE TABLE `t_brand`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品牌名称',
  `image` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片网址',
  `letter` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品牌首字母',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_name`(`name`) USING BTREE,
  INDEX `idx_letter`(`letter`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '品牌表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_brand
-- ----------------------------
INSERT INTO `t_brand` VALUES (1, '联想', NULL, 'L');
INSERT INTO `t_brand` VALUES (2, '华为', NULL, 'H');
INSERT INTO `t_brand` VALUES (3, '小米', NULL, 'X');
INSERT INTO `t_brand` VALUES (4, '苹果', NULL, 'A');
INSERT INTO `t_brand` VALUES (5, 'OPPO', NULL, 'O');
INSERT INTO `t_brand` VALUES (6, '三星', NULL, 'S');
INSERT INTO `t_brand` VALUES (7, 'LG', NULL, 'L');
INSERT INTO `t_brand` VALUES (8, 'vivo', NULL, 'V');
INSERT INTO `t_brand` VALUES (9, '飞利浦', NULL, 'F');
INSERT INTO `t_brand` VALUES (10, '红米', NULL, 'H');
INSERT INTO `t_brand` VALUES (11, 'IBM', NULL, 'I');
INSERT INTO `t_brand` VALUES (12, '戴尔', NULL, 'D');

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `parent_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '上级分类ID',
  `if_parent` tinyint(1) NOT NULL COMMENT '时候含有下级分类',
  `sort` int(10) UNSIGNED NOT NULL COMMENT '排名指数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id`) USING BTREE,
  INDEX `idx_sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES (1, '手机\\数码\\配件', NULL, 1, 1);
INSERT INTO `t_category` VALUES (2, '手机通讯', 1, 1, 1);
INSERT INTO `t_category` VALUES (3, '手机', 2, 0, 1);
INSERT INTO `t_category` VALUES (4, '手机配件', 1, 1, 2);
INSERT INTO `t_category` VALUES (5, '移动电源', 4, 0, 2);
INSERT INTO `t_category` VALUES (6, '蓝牙耳机', 4, 0, 5);
INSERT INTO `t_category` VALUES (7, '保护壳', 4, 0, 2);
INSERT INTO `t_category` VALUES (8, '数码配件', 1, 1, 3);
INSERT INTO `t_category` VALUES (9, ' 存储卡', 8, 0, 10);
INSERT INTO `t_category` VALUES (10, '读卡器', 8, 0, 10);
INSERT INTO `t_category` VALUES (11, '电脑\\办公\\外设', NULL, 1, 1);
INSERT INTO `t_category` VALUES (12, '电脑整机', 11, 1, 1);
INSERT INTO `t_category` VALUES (13, '笔记本', 12, 0, 1);
INSERT INTO `t_category` VALUES (14, '台式电脑', 12, 0, 1);
INSERT INTO `t_category` VALUES (15, '平板电脑', 12, 0, 1);

-- ----------------------------
-- Table structure for t_category_brand
-- ----------------------------
DROP TABLE IF EXISTS `t_category_brand`;
CREATE TABLE `t_category_brand`  (
  `category_id` int(10) UNSIGNED NOT NULL COMMENT '分类id',
  `brand_id` int(10) UNSIGNED NOT NULL COMMENT '品牌id',
  PRIMARY KEY (`category_id`, `brand_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类与品牌关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_category_brand
-- ----------------------------
INSERT INTO `t_category_brand` VALUES (3, 1);
INSERT INTO `t_category_brand` VALUES (3, 2);
INSERT INTO `t_category_brand` VALUES (3, 3);
INSERT INTO `t_category_brand` VALUES (3, 4);
INSERT INTO `t_category_brand` VALUES (3, 5);
INSERT INTO `t_category_brand` VALUES (3, 6);
INSERT INTO `t_category_brand` VALUES (3, 8);
INSERT INTO `t_category_brand` VALUES (3, 10);
INSERT INTO `t_category_brand` VALUES (13, 1);
INSERT INTO `t_category_brand` VALUES (13, 2);
INSERT INTO `t_category_brand` VALUES (13, 12);

-- ----------------------------
-- Table structure for t_city
-- ----------------------------
DROP TABLE IF EXISTS `t_city`;
CREATE TABLE `t_city`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `city` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '城市',
  `province_id` int(10) UNSIGNED NOT NULL COMMENT '省份ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '城市表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_city
-- ----------------------------
INSERT INTO `t_city` VALUES (1, '沈阳', 5);
INSERT INTO `t_city` VALUES (2, '大连', 5);
INSERT INTO `t_city` VALUES (3, '鞍山', 5);
INSERT INTO `t_city` VALUES (4, '长春', 6);
INSERT INTO `t_city` VALUES (5, '吉林', 6);
INSERT INTO `t_city` VALUES (6, '哈尔滨', 7);
INSERT INTO `t_city` VALUES (7, '齐齐哈尔', 7);
INSERT INTO `t_city` VALUES (8, '牡丹江', 7);

-- ----------------------------
-- Table structure for t_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_customer`;
CREATE TABLE `t_customer`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码(AES加密)',
  `wechat` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信号',
  `tel` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `level_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '会员等级',
  `ceate_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `last_update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_username`(`username`) USING BTREE,
  INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer
-- ----------------------------
INSERT INTO `t_customer` VALUES (1, 'scott123', 'BDC0253EF1EFF8B5D6D62F5073972493', NULL, NULL, 1, '2019-04-06 22:50:50', '2019-04-06 22:50:50');
INSERT INTO `t_customer` VALUES (2, 'jack123', 'CBB577666CE2963533369D1AA9D229D5', 'jack123', '15912345678', NULL, '2019-11-04 16:45:10', '2019-11-04 16:45:10');

-- ----------------------------
-- Table structure for t_customer_address
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_address`;
CREATE TABLE `t_customer_address`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_id` int(10) UNSIGNED NOT NULL COMMENT '客户ID',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人姓名',
  `tel` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人电话',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货地址',
  `prime` tinyint(1) NOT NULL COMMENT '是否为缺省收货地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer_address
-- ----------------------------
INSERT INTO `t_customer_address` VALUES (1, 1, '陈浩', '13312345678', '辽宁省大连市高新园区6号9#11-1', 1);
INSERT INTO `t_customer_address` VALUES (2, 1, '李娜', '18912345678', '辽宁省大连市沙河口区星月街17号2#1-3', 0);

-- ----------------------------
-- Table structure for t_delivery
-- ----------------------------
DROP TABLE IF EXISTS `t_delivery`;
CREATE TABLE `t_delivery`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` int(10) UNSIGNED NOT NULL COMMENT '订单ID',
  `sku` json NOT NULL COMMENT '商品',
  `qa_id` int(10) UNSIGNED NOT NULL COMMENT '质检员ID',
  `de_id` int(10) UNSIGNED NOT NULL COMMENT '发货员ID',
  `postid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '快递单号',
  `price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '快递费',
  `ecp` tinyint(3) UNSIGNED NOT NULL COMMENT '快递公司编号',
  `address_id` int(10) UNSIGNED NOT NULL COMMENT '收货地址ID',
  `warehouse_id` int(10) UNSIGNED NOT NULL COMMENT '仓库ID',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id`) USING BTREE,
  INDEX `idx_qa_id`(`qa_id`) USING BTREE,
  INDEX `idx_de_id`(`de_id`) USING BTREE,
  INDEX `idx_postid`(`postid`) USING BTREE,
  INDEX `idx_warehouse_id`(`warehouse_id`) USING BTREE,
  INDEX `idx_address_id`(`address_id`) USING BTREE,
  INDEX `idx_ecp`(`ecp`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '快递表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_delivery
-- ----------------------------
INSERT INTO `t_delivery` VALUES (1, 2, '[3, 3]', 15, 17, '125488611212545', 60.00, 1, 1, 1, '2019-04-11 21:14:38');

-- ----------------------------
-- Table structure for t_dept
-- ----------------------------
DROP TABLE IF EXISTS `t_dept`;
CREATE TABLE `t_dept`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_dname`(`dname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dept
-- ----------------------------
INSERT INTO `t_dept` VALUES (6, '售后部');
INSERT INTO `t_dept` VALUES (2, '总裁办');
INSERT INTO `t_dept` VALUES (5, '技术部');
INSERT INTO `t_dept` VALUES (4, '网商部');
INSERT INTO `t_dept` VALUES (1, '董事会');
INSERT INTO `t_dept` VALUES (3, '零售部');

-- ----------------------------
-- Table structure for t_emp
-- ----------------------------
DROP TABLE IF EXISTS `t_emp`;
CREATE TABLE `t_emp`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `wid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工号',
  `ename` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `married` tinyint(1) NOT NULL COMMENT '婚否',
  `education` tinyint(4) NOT NULL COMMENT '学历：1.大专，2.本科，3.研究生，4.博士，5.其他',
  `tel` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `email` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '住址',
  `job_id` int(10) UNSIGNED NOT NULL COMMENT '职位ID',
  `dept_id` int(10) UNSIGNED NOT NULL COMMENT '部门ID',
  `mgr_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '上司ID',
  `hiredate` date NOT NULL COMMENT '入职日期',
  `termdate` date NULL DEFAULT NULL COMMENT '离职日期',
  `status` tinyint(3) UNSIGNED NOT NULL COMMENT '状态：1.在职，2.休假，3.离职，4.死亡',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_wid`(`wid`) USING BTREE,
  INDEX `idx_job_id`(`job_id`) USING BTREE,
  INDEX `idx_dept_id`(`dept_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_mgr_id`(`mgr_id`) USING BTREE,
  INDEX `idx_wid`(`wid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_emp
-- ----------------------------
INSERT INTO `t_emp` VALUES (1, 'S10010E', '李娜', '女', 1, 2, '18912345678', NULL, NULL, 5, 3, NULL, '2018-12-06', NULL, 1);
INSERT INTO `t_emp` VALUES (2, 'S10014A', '刘畅', '女', 1, 2, '13312345678', NULL, NULL, 6, 3, 1, '2019-04-11', NULL, 1);
INSERT INTO `t_emp` VALUES (3, 'TE0023', '陈婷婷', '女', 0, 1, '13322334545', NULL, NULL, 9, 3, NULL, '2019-05-16', NULL, 1);
INSERT INTO `t_emp` VALUES (4, 'TE0024', '徐刚', '男', 0, 1, '13322334545', NULL, NULL, 9, 4, NULL, '2019-05-16', NULL, 1);

-- ----------------------------
-- Table structure for t_job
-- ----------------------------
DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `job` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '职位名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_job`(`job`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '职位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_job
-- ----------------------------
INSERT INTO `t_job` VALUES (4, '主管');
INSERT INTO `t_job` VALUES (7, '保安');
INSERT INTO `t_job` VALUES (8, '保管员');
INSERT INTO `t_job` VALUES (6, '售货员');
INSERT INTO `t_job` VALUES (5, '店长');
INSERT INTO `t_job` VALUES (2, '总经理');
INSERT INTO `t_job` VALUES (1, '董事长');
INSERT INTO `t_job` VALUES (3, '部门经理');

-- ----------------------------
-- Table structure for t_level
-- ----------------------------
DROP TABLE IF EXISTS `t_level`;
CREATE TABLE `t_level`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `level` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '等级',
  `discount` decimal(10, 2) UNSIGNED NOT NULL COMMENT '折扣',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员登记表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_level
-- ----------------------------
INSERT INTO `t_level` VALUES (1, '铜牌会员', 0.99);
INSERT INTO `t_level` VALUES (2, '银牌会员', 0.98);
INSERT INTO `t_level` VALUES (3, '金牌会员', 0.97);
INSERT INTO `t_level` VALUES (4, '白金会员', 0.95);
INSERT INTO `t_level` VALUES (5, '钻石会员', 0.92);

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `id` int(10) UNSIGNED NOT NULL COMMENT '主键',
  `code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号',
  `type` tinyint(4) NOT NULL COMMENT '订单类型：1.实体销售，2.网络销售',
  `shop_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '零售店ID',
  `customer_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '会员ID',
  `amount` decimal(10, 2) UNSIGNED NOT NULL COMMENT '总金额',
  `payment_type` decimal(10, 2) UNSIGNED NOT NULL COMMENT '支付方式：1.借记卡，2.信用卡，3.微信，4.支付宝，5.现金',
  `status` tinyint(3) UNSIGNED NOT NULL COMMENT '状态：1.未付款，2.已付款，3.已发货，4.已签收',
  `postage` decimal(10, 2) UNSIGNED NULL DEFAULT NULL COMMENT '邮费',
  `weight` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '重量(克)',
  `voucher_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '购物券ID',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_code`(`code`) USING BTREE,
  INDEX `idx_code`(`code`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_create_time`(`create_time`) USING BTREE,
  INDEX `idx_type`(`type`) USING BTREE,
  INDEX `idx_shop_id`(`shop_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES (1, 'CX0000000120160522', 1, 3, 1, 5998.00, 5.00, 2, NULL, NULL, NULL, '2019-04-11 01:07:05');
INSERT INTO `t_order` VALUES (2, 'CX0000000120160523', 2, NULL, 1, 5998.00, 1.00, 2, 60.00, 530, NULL, '2019-04-11 21:22:37');

-- ----------------------------
-- Table structure for t_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE `t_order_detail`  (
  `order_id` int(10) UNSIGNED NOT NULL COMMENT '订单ID',
  `sku_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '原价格',
  `actual_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '实际购买价',
  `num` int(10) UNSIGNED NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`order_id`, `sku_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order_detail
-- ----------------------------
INSERT INTO `t_order_detail` VALUES (1, 3, 2999.00, 2999.00, 1);
INSERT INTO `t_order_detail` VALUES (1, 4, 2999.00, 2999.00, 1);
INSERT INTO `t_order_detail` VALUES (2, 3, 2999.00, 2999.00, 2);

-- ----------------------------
-- Table structure for t_productin
-- ----------------------------
DROP TABLE IF EXISTS `t_productin`;
CREATE TABLE `t_productin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `storekeeper_id` int(10) UNSIGNED NOT NULL COMMENT '保管员ID',
  `amount` decimal(15, 2) UNSIGNED NOT NULL COMMENT '总金额',
  `supplier_id` int(10) UNSIGNED NOT NULL COMMENT '供应商ID',
  `payment` decimal(15, 2) UNSIGNED NOT NULL COMMENT '实付金额',
  `payment_type` tinyint(3) UNSIGNED NOT NULL COMMENT '支付方式',
  `invoice` tinyint(1) NOT NULL COMMENT '是否开票',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_storekeeper_id`(`storekeeper_id`) USING BTREE,
  INDEX `idx_supplier_id`(`supplier_id`) USING BTREE,
  INDEX `idx_payment_type`(`payment_type`) USING BTREE,
  INDEX `idx_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '入库信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_productin
-- ----------------------------
INSERT INTO `t_productin` VALUES (1, 42, 150000.00, 1, 150000.00, 1, 1, NULL, '2019-04-12 19:17:10');

-- ----------------------------
-- Table structure for t_productin_purchase
-- ----------------------------
DROP TABLE IF EXISTS `t_productin_purchase`;
CREATE TABLE `t_productin_purchase`  (
  `productin_id` int(10) UNSIGNED NOT NULL COMMENT '入库ID',
  `purchase_id` int(10) UNSIGNED NOT NULL COMMENT '采购ID',
  PRIMARY KEY (`productin_id`, `purchase_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '入库商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_productin_purchase
-- ----------------------------
INSERT INTO `t_productin_purchase` VALUES (1, 1);

-- ----------------------------
-- Table structure for t_province
-- ----------------------------
DROP TABLE IF EXISTS `t_province`;
CREATE TABLE `t_province`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `province` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '省份',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_province`(`province`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '省份表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_province
-- ----------------------------
INSERT INTO `t_province` VALUES (2, '上海');
INSERT INTO `t_province` VALUES (30, '云南');
INSERT INTO `t_province` VALUES (22, '内蒙古');
INSERT INTO `t_province` VALUES (1, '北京');
INSERT INTO `t_province` VALUES (34, '台湾');
INSERT INTO `t_province` VALUES (6, '吉林');
INSERT INTO `t_province` VALUES (28, '四川');
INSERT INTO `t_province` VALUES (3, '天津');
INSERT INTO `t_province` VALUES (23, '宁夏');
INSERT INTO `t_province` VALUES (11, '安徽');
INSERT INTO `t_province` VALUES (8, '山东');
INSERT INTO `t_province` VALUES (21, '山西');
INSERT INTO `t_province` VALUES (14, '广东');
INSERT INTO `t_province` VALUES (15, '广西');
INSERT INTO `t_province` VALUES (27, '新疆');
INSERT INTO `t_province` VALUES (9, '江苏');
INSERT INTO `t_province` VALUES (13, '江西');
INSERT INTO `t_province` VALUES (20, '河北');
INSERT INTO `t_province` VALUES (17, '河南');
INSERT INTO `t_province` VALUES (10, '浙江');
INSERT INTO `t_province` VALUES (16, '海南');
INSERT INTO `t_province` VALUES (19, '湖北');
INSERT INTO `t_province` VALUES (18, '湖南');
INSERT INTO `t_province` VALUES (33, '澳门');
INSERT INTO `t_province` VALUES (26, '甘肃');
INSERT INTO `t_province` VALUES (12, '福建');
INSERT INTO `t_province` VALUES (31, '西藏');
INSERT INTO `t_province` VALUES (29, '贵州');
INSERT INTO `t_province` VALUES (5, '辽宁');
INSERT INTO `t_province` VALUES (4, '重庆');
INSERT INTO `t_province` VALUES (25, '陕西');
INSERT INTO `t_province` VALUES (24, '青海');
INSERT INTO `t_province` VALUES (32, '香港');
INSERT INTO `t_province` VALUES (7, '黑龙江');

-- ----------------------------
-- Table structure for t_purchase
-- ----------------------------
DROP TABLE IF EXISTS `t_purchase`;
CREATE TABLE `t_purchase`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sku_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `num` int(10) UNSIGNED NOT NULL COMMENT '数量',
  `warehouse_id` int(10) UNSIGNED NOT NULL COMMENT '仓库ID',
  `in_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '采购价格',
  `out_price` decimal(10, 2) UNSIGNED NULL DEFAULT NULL COMMENT '建议零售价',
  `buyer_id` int(10) UNSIGNED NOT NULL COMMENT '采购员ID',
  `status` tinyint(3) UNSIGNED NOT NULL COMMENT '状态：1.未完成，2.已完成',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sku_id`(`sku_id`) USING BTREE,
  INDEX `idx_warehouse_id`(`warehouse_id`) USING BTREE,
  INDEX `idx_buyer_id`(`buyer_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '采购表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_purchase
-- ----------------------------
INSERT INTO `t_purchase` VALUES (1, 1, 50, 1, 3000.00, 3299.00, 20, 2, '2019-04-12 19:16:03');

-- ----------------------------
-- Table structure for t_rating
-- ----------------------------
DROP TABLE IF EXISTS `t_rating`;
CREATE TABLE `t_rating`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `order_id` int(10) UNSIGNED NOT NULL COMMENT '订单ID',
  `sku_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `img` json NULL COMMENT '买家晒图',
  `rating` tinyint(3) UNSIGNED NOT NULL COMMENT '评分',
  `comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id`) USING BTREE,
  INDEX `idx_sku_id`(`sku_id`) USING BTREE,
  INDEX `idx_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_rating
-- ----------------------------
INSERT INTO `t_rating` VALUES (1, 2, 3, '[\"http://192.168.99.184/1.jpg\"]', 5, '很好用，很漂亮', '2019-04-12 00:17:40');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_role`(`role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (6, '保管员');
INSERT INTO `t_role` VALUES (3, '售货员');
INSERT INTO `t_role` VALUES (5, '客服');
INSERT INTO `t_role` VALUES (2, '管理员');
INSERT INTO `t_role` VALUES (7, '质检员');
INSERT INTO `t_role` VALUES (1, '超级管理员');
INSERT INTO `t_role` VALUES (4, '零售店长');

-- ----------------------------
-- Table structure for t_shop
-- ----------------------------
DROP TABLE IF EXISTS `t_shop`;
CREATE TABLE `t_shop`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `city_id` int(10) UNSIGNED NOT NULL COMMENT '城市ID',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `tel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_city_id`(`city_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '零售店表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_shop
-- ----------------------------
INSERT INTO `t_shop` VALUES (1, 1, '辽宁省沈阳市黄河北大街12号', '024-11112222');
INSERT INTO `t_shop` VALUES (2, 1, '辽宁省沈阳市皇姑区长江街40号', '024-12341234');
INSERT INTO `t_shop` VALUES (3, 1, '辽宁省沈阳市铁西区卫工街19号', '024-12312345');
INSERT INTO `t_shop` VALUES (4, 2, '大连市西岗区五四路38号', '0411-12345678');
INSERT INTO `t_shop` VALUES (5, 2, '大连市沙河口区星云街1号', '0411-98213210');

-- ----------------------------
-- Table structure for t_shop_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_sku`;
CREATE TABLE `t_shop_sku`  (
  `shop_id` int(10) UNSIGNED NOT NULL COMMENT '零售店ID',
  `sku_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `num` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '库存数量',
  `unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '库存单位',
  PRIMARY KEY (`shop_id`, `sku_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '零售店商品库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_shop_sku
-- ----------------------------
INSERT INTO `t_shop_sku` VALUES (1, 1, 3, '部');
INSERT INTO `t_shop_sku` VALUES (1, 2, 3, '部');
INSERT INTO `t_shop_sku` VALUES (1, 3, 1, '部');
INSERT INTO `t_shop_sku` VALUES (1, 4, 0, '部');
INSERT INTO `t_shop_sku` VALUES (2, 1, 3, '部');
INSERT INTO `t_shop_sku` VALUES (2, 2, 0, '部');
INSERT INTO `t_shop_sku` VALUES (2, 3, 0, '部');
INSERT INTO `t_shop_sku` VALUES (2, 4, 1, '部');

-- ----------------------------
-- Table structure for t_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_sku`;
CREATE TABLE `t_sku`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spu_id` int(10) UNSIGNED NOT NULL COMMENT '产品ID',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品标题',
  `images` json NULL COMMENT '商品图片',
  `price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '价格',
  `param` json NOT NULL COMMENT '参数',
  `saleable` tinyint(1) NOT NULL COMMENT '是否上架',
  `valid` tinyint(1) NOT NULL COMMENT '是否有效',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `last_update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spu_id`(`spu_id`) USING BTREE,
  INDEX `idx_saleable`(`saleable`) USING BTREE,
  INDEX `idx_valid`(`valid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sku
-- ----------------------------
INSERT INTO `t_sku` VALUES (1, 1, 'Xiaomi/小米 小米9 8GB+128GB 全息幻影紫 移动联通电信全网通4G手机', '{\"desc\": [\"http://127.0.0.1/3.jpg\", \"http://127.0.0.1/4.jpg\"], \"facade\": [\"http://127.0.0.1/1.jpg\", \"http://127.0.0.1/2.jpg\"]}', 3299.00, '{\"CPU\": \"骁龙855\", \"内存\": 128, \"电池\": 4000, \"运存\": 8, \"屏幕尺寸\": 6.39}', 1, 1, '2019-11-01 11:54:28', '2019-11-01 11:54:31');
INSERT INTO `t_sku` VALUES (2, 1, 'Xiaomi/小米 小米9 8GB+128GB 全息幻影蓝 移动联通电信全网通4G手机', '{\"desc\": [\"http://127.0.0.1/3.jpg\", \"http://127.0.0.1/4.jpg\"], \"facade\": [\"http://127.0.0.1/1.jpg\", \"http://127.0.0.1/2.jpg\"]}', 3299.00, '{\"CPU\": \"骁龙855\", \"内存\": 128, \"电池\": 4000, \"运存\": 8, \"屏幕尺寸\": 6.39}', 1, 1, '2019-11-01 11:56:36', '2019-11-01 11:56:36');
INSERT INTO `t_sku` VALUES (3, 1, 'Xiaomi/小米 小米9 6GB+128GB 全息幻影蓝 移动联通电信全网通4G手机', '{\"desc\": [\"http://127.0.0.1/3.jpg\", \"http://127.0.0.1/4.jpg\"], \"facade\": [\"http://127.0.0.1/1.jpg\", \"http://127.0.0.1/2.jpg\"]}', 2999.00, '{\"CPU\": \"骁龙855\", \"内存\": 128, \"电池\": 4000, \"运存\": 6, \"屏幕尺寸\": 6.39}', 1, 1, '2019-11-01 11:57:29', '2019-11-01 11:57:29');
INSERT INTO `t_sku` VALUES (4, 1, 'Xiaomi/小米 小米9 6GB+128GB 深空灰 移动联通电信全网通4G手机', '{\"desc\": [\"http://127.0.0.1/3.jpg\", \"http://127.0.0.1/4.jpg\"], \"facade\": [\"http://127.0.0.1/1.jpg\", \"http://127.0.0.1/2.jpg\"]}', 2999.00, '{\"CPU\": \"骁龙855\", \"内存\": 128, \"电池\": 4000, \"运存\": 6, \"屏幕尺寸\": 6.39}', 1, 1, '2019-11-01 11:58:56', '2019-11-01 11:58:56');

-- ----------------------------
-- Table structure for t_spec_group
-- ----------------------------
DROP TABLE IF EXISTS `t_spec_group`;
CREATE TABLE `t_spec_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spg_id` int(10) UNSIGNED NOT NULL COMMENT '品类编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品类名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_spg_id`(`spg_id`) USING BTREE,
  UNIQUE INDEX `unq_name`(`name`) USING BTREE,
  INDEX `idx_spg_id`(`spg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '品类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_spec_group
-- ----------------------------
INSERT INTO `t_spec_group` VALUES (1, 10001, '手机');
INSERT INTO `t_spec_group` VALUES (2, 10002, '手机线');
INSERT INTO `t_spec_group` VALUES (3, 10003, '手机电池');
INSERT INTO `t_spec_group` VALUES (4, 11001, '液晶电视');
INSERT INTO `t_spec_group` VALUES (5, 11002, '投影电视');

-- ----------------------------
-- Table structure for t_spec_param
-- ----------------------------
DROP TABLE IF EXISTS `t_spec_param`;
CREATE TABLE `t_spec_param`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spg_id` int(10) UNSIGNED NOT NULL COMMENT '品类编号',
  `spp_id` int(10) UNSIGNED NOT NULL COMMENT '参数编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数名称',
  `numeric` tinyint(1) NOT NULL COMMENT '是否为数字参数',
  `unit` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位(量词)',
  `generic` tinyint(1) NOT NULL COMMENT '是否为通用参数',
  `searching` tinyint(1) NOT NULL COMMENT '是否用于通用搜索',
  `segements` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数值',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spg_id`(`spg_id`) USING BTREE,
  INDEX `idx_spp_id`(`spp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_spec_param
-- ----------------------------
INSERT INTO `t_spec_param` VALUES (1, 10001, 1, 'CPU', 0, NULL, 1, 0, NULL);
INSERT INTO `t_spec_param` VALUES (2, 10001, 2, '运存', 1, 'GB', 1, 1, NULL);
INSERT INTO `t_spec_param` VALUES (3, 10001, 3, '内存', 1, 'GB', 1, 1, NULL);
INSERT INTO `t_spec_param` VALUES (4, 10001, 4, '屏幕尺寸', 1, '英寸', 1, 1, NULL);
INSERT INTO `t_spec_param` VALUES (5, 10001, 5, '电池', 1, '毫安时', 1, 0, NULL);
INSERT INTO `t_spec_param` VALUES (6, 11001, 1, '屏幕尺寸', 1, '英寸', 1, 1, NULL);
INSERT INTO `t_spec_param` VALUES (7, 11001, 2, '长度', 1, '厘米', 1, 0, NULL);
INSERT INTO `t_spec_param` VALUES (8, 11001, 3, '高度', 1, '厘米', 1, 0, NULL);
INSERT INTO `t_spec_param` VALUES (9, 11001, 4, '宽度', 1, '厘米', 1, 0, NULL);
INSERT INTO `t_spec_param` VALUES (10, 11001, 5, '分辨率', 0, '像素', 1, 1, '720P\\1080P\\4K\\8K');

-- ----------------------------
-- Table structure for t_spu
-- ----------------------------
DROP TABLE IF EXISTS `t_spu`;
CREATE TABLE `t_spu`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `sub_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '副标题',
  `category_id` int(10) UNSIGNED NOT NULL COMMENT '分类ID',
  `brand_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '品牌ID',
  `spg_id` int(10) UNSIGNED NOT NULL COMMENT '品类ID',
  `saleable` tinyint(1) NOT NULL COMMENT '是否上架',
  `valid` tinyint(1) NOT NULL COMMENT '是否有效',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `last_update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_id`(`category_id`) USING BTREE,
  INDEX `idx_brand_id`(`brand_id`) USING BTREE,
  INDEX `idx_spg_id`(`spg_id`) USING BTREE,
  INDEX `idx_saleable`(`saleable`) USING BTREE,
  INDEX `idx_valid`(`valid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_spu
-- ----------------------------
INSERT INTO `t_spu` VALUES (1, '小米9', NULL, 3, 3, 10001, 1, 1, '2019-11-01 11:46:08', '2019-11-01 11:46:11');

-- ----------------------------
-- Table structure for t_supplier
-- ----------------------------
DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE `t_supplier`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '供货商编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '供货商名称',
  `type` tinyint(3) UNSIGNED NOT NULL COMMENT '类型：1.厂家，2.代理商，3.个人',
  `link_man` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系人',
  `tel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系地址',
  `bank_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开户银行名称',
  `bank_account` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '银行账号',
  `status` tinyint(3) UNSIGNED NOT NULL COMMENT '状态：1.可用，2.不可用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_code`(`code`) USING BTREE,
  INDEX `idx_code`(`code`) USING BTREE,
  INDEX `idx_type`(`type`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '供货商表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_supplier
-- ----------------------------
INSERT INTO `t_supplier` VALUES (1, '2394125', 'A供货商', 1, '李强', '13312345678', '辽宁省大连市高新园区121号', NULL, NULL, 1);

-- ----------------------------
-- Table structure for t_supplier_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_supplier_sku`;
CREATE TABLE `t_supplier_sku`  (
  `supplier_id` int(10) UNSIGNED NOT NULL COMMENT '供货商ID',
  `sku_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  PRIMARY KEY (`supplier_id`, `sku_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '供货商关联商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_supplier_sku
-- ----------------------------
INSERT INTO `t_supplier_sku` VALUES (1, 1);
INSERT INTO `t_supplier_sku` VALUES (1, 2);
INSERT INTO `t_supplier_sku` VALUES (1, 3);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码(AES加密)',
  `emp_id` int(10) UNSIGNED NOT NULL COMMENT '员工ID',
  `role_id` int(10) UNSIGNED NOT NULL COMMENT '角色ID',
  `status` tinyint(3) UNSIGNED NOT NULL COMMENT '状态：1.可用，2.禁用',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `last_update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_username`(`username`) USING BTREE,
  INDEX `idx_username`(`username`) USING BTREE,
  INDEX `idx_emp_id`(`emp_id`) USING BTREE,
  INDEX `idx_role_id`(`role_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'demo123', 'C55E8E99B7745306F1B30AE2C8C8D54B', 1, 4, 1, '2019-10-05 15:26:33', '2019-10-05 15:26:33');

-- ----------------------------
-- Table structure for t_voucher
-- ----------------------------
DROP TABLE IF EXISTS `t_voucher`;
CREATE TABLE `t_voucher`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `deno` decimal(10, 2) UNSIGNED NOT NULL COMMENT '面值',
  `condition` decimal(10, 2) UNSIGNED NOT NULL COMMENT '订单满多少钱可以使用',
  `start_date` date NULL DEFAULT NULL COMMENT '起始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '截止日期',
  `max_num` int(11) NULL DEFAULT NULL COMMENT '代金券发放最大数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物券表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_voucher
-- ----------------------------
INSERT INTO `t_voucher` VALUES (1, 50.00, 1000.00, '2019-11-25', '2019-12-25', 1000);
INSERT INTO `t_voucher` VALUES (2, 20.00, 500.00, '2019-11-25', '2019-12-25', NULL);

-- ----------------------------
-- Table structure for t_voucher_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_voucher_customer`;
CREATE TABLE `t_voucher_customer`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `voucher_id` int(10) UNSIGNED NOT NULL COMMENT '购物券ID',
  `customer_id` int(10) UNSIGNED NOT NULL COMMENT '顾客ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户关联购物券数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_voucher_customer
-- ----------------------------
INSERT INTO `t_voucher_customer` VALUES (1, 1, 1);
INSERT INTO `t_voucher_customer` VALUES (2, 1, 1);
INSERT INTO `t_voucher_customer` VALUES (3, 1, 1);
INSERT INTO `t_voucher_customer` VALUES (4, 2, 1);
INSERT INTO `t_voucher_customer` VALUES (5, 2, 1);

-- ----------------------------
-- Table structure for t_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse`;
CREATE TABLE `t_warehouse`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `city_id` int(10) UNSIGNED NOT NULL COMMENT '城市ID',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `tel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_city_id`(`city_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '仓库表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_warehouse
-- ----------------------------
INSERT INTO `t_warehouse` VALUES (1, 1, '辽宁省沈阳市沈河区青年大街100号', '024-12345678');
INSERT INTO `t_warehouse` VALUES (2, 1, '辽宁省沈阳市皇姑区崇山路41号', '024-22331234');
INSERT INTO `t_warehouse` VALUES (3, 2, '辽宁省大连市西岗区五四路38号', '0411-12345678');
INSERT INTO `t_warehouse` VALUES (4, 2, '辽宁省大连市沙河口区星云街1号', '0411-98213210');

-- ----------------------------
-- Table structure for t_warehouse_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_sku`;
CREATE TABLE `t_warehouse_sku`  (
  `warehouse_id` int(10) UNSIGNED NOT NULL COMMENT '仓库ID',
  `sku_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `num` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '库存数量',
  `unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '库存单位',
  PRIMARY KEY (`warehouse_id`, `sku_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '仓库商品库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_warehouse_sku
-- ----------------------------
INSERT INTO `t_warehouse_sku` VALUES (1, 1, 20, '部');
INSERT INTO `t_warehouse_sku` VALUES (1, 2, 15, '部');
INSERT INTO `t_warehouse_sku` VALUES (1, 3, 40, '部');
INSERT INTO `t_warehouse_sku` VALUES (1, 4, 0, '部');
INSERT INTO `t_warehouse_sku` VALUES (2, 1, 70, '部');
INSERT INTO `t_warehouse_sku` VALUES (2, 2, 0, '部');
INSERT INTO `t_warehouse_sku` VALUES (2, 3, 5, '部');
INSERT INTO `t_warehouse_sku` VALUES (2, 4, 19, '部');

SET FOREIGN_KEY_CHECKS = 1;
