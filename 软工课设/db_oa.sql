/*
 Navicat Premium Data Transfer

 Source Server         : aliyun
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : rm-2ze306jhy51d8446c8o.mysql.rds.aliyuncs.com:3306
 Source Schema         : db_oa

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 26/07/2021 14:02:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for attendance
-- ----------------------------
DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance`  (
  `attandance_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `work_date` date NOT NULL,
  `out_time` time(0) NULL DEFAULT NULL,
  `out_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `in_time` time(0) NULL DEFAULT NULL,
  `in_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_leave` tinyint(1) NOT NULL,
  PRIMARY KEY (`attandance_id`) USING BTREE,
  INDEX `FK_fk_staff_attendance`(`job_num`) USING BTREE,
  CONSTRAINT `FK_staff_attendance` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_calendar
-- ----------------------------
DROP TABLE IF EXISTS `business_calendar`;
CREATE TABLE `business_calendar`  (
  `schedule_num` int(11) NOT NULL AUTO_INCREMENT,
  `depart_num` int(11) NOT NULL,
  `headline` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `business_describe` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `business_level` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `start_time` date NOT NULL,
  `end_time` date NOT NULL,
  PRIMARY KEY (`schedule_num`) USING BTREE,
  INDEX `FK_fk_business_calendar_department`(`depart_num`) USING BTREE,
  CONSTRAINT `FK_department_business_calendar` FOREIGN KEY (`depart_num`) REFERENCES `department` (`depart_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of business_calendar
-- ----------------------------
INSERT INTO `business_calendar` VALUES (1, 0, '加班到晚九点', '加班写日程报告并且继续对代码进行编写，以及明天任务的分配', '低', '2021-06-28', '2021-06-28');
INSERT INTO `business_calendar` VALUES (3, 1, '开发', '关于外包项目，研发部门必须在限定的日期内提交源码文件，并且进行测试和维护', '高', '2021-06-14', '2021-06-22');
INSERT INTO `business_calendar` VALUES (4, 0, '休息', '公司给大家放两天假，不用上班', '低', '2021-06-29', '2021-06-30');
INSERT INTO `business_calendar` VALUES (5, 5, '后勤整治', '最近后勤部门的岗位出现人员变动，希望后勤部门有关人员对工作积极配合和保障', '低', '2021-06-30', '2021-07-01');
INSERT INTO `business_calendar` VALUES (6, 3, '人事进行校招', '人事部门负责在制定日期内去各大高校进行企业校招', '高', '2021-07-07', '2021-07-14');
INSERT INTO `business_calendar` VALUES (7, 5, '协调工作', '后勤部门负责服务、协调总经理办公室工作,检查落实总经理室安排的各项工作。并及时反馈总经理室,保证总经理办公室各项工作的正常运作。', '高', '2021-07-03', '2021-07-05');
INSERT INTO `business_calendar` VALUES (114, 3, '正常', '无其他日程，正常工作', '低', '2021-06-29', '2021-06-30');
INSERT INTO `business_calendar` VALUES (119, 3, '测试', '测试系统', '高', '2021-07-07', '2021-08-11');

-- ----------------------------
-- Table structure for car_msg
-- ----------------------------
DROP TABLE IF EXISTS `car_msg`;
CREATE TABLE `car_msg`  (
  `car_num` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `situation` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `department` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `car_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`car_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of car_msg
-- ----------------------------
INSERT INTO `car_msg` VALUES ('云A4546M', '使用中', '总裁部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云A4556M', '使用中', '总裁部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云A4573M', '使用中', '总裁部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云A9090M', '使用中', '总裁部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云D1234L', '空闲中', '后勤部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云F0000D', '空闲中', '人事部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云F1111D', '使用中', '财务部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云F1234W', '空闲中', '人事部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云F9999H', '空闲中', '人事部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云G0000H', '使用中', '财务部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('云J4677L', '使用中', '总裁部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('京A0000H', '使用中', '总裁部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('京A1111G', '空闲中', '财务部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('京A2222D', '空闲中', '财务部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('京A3333T', '使用中', '后勤部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('京A4444T', '使用中', '财务部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('京A5555Y', '空闲中', '财务部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('冀F8888G', '使用中', '总裁部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('冀F9999F', '使用中', '总裁部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('冀R4444R', '空闲中', '人事部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('冀R5555F', '使用中', '财务部', '2021款 S 480 4MATIC');
INSERT INTO `car_msg` VALUES ('冀T6666T', '空闲中', '总裁部', '2021款 S 480 4MATIC');

-- ----------------------------
-- Table structure for car_record
-- ----------------------------
DROP TABLE IF EXISTS `car_record`;
CREATE TABLE `car_record`  (
  `record_num` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `car_num` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `really_time` date NULL DEFAULT NULL,
  `return_time` date NULL DEFAULT NULL,
  `borrow_time` date NULL DEFAULT NULL,
  `use_reason` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`record_num`) USING BTREE,
  INDEX `FK_staff_car_record`(`job_num`) USING BTREE,
  INDEX `FK_car_msg_car_record`(`car_num`) USING BTREE,
  CONSTRAINT `FK_car_msg_car_record` FOREIGN KEY (`car_num`) REFERENCES `car_msg` (`car_num`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_staff_car_record` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of car_record
-- ----------------------------
INSERT INTO `car_record` VALUES (1, 1, '云F1111D', '2021-06-18', '2021-06-18', '2021-06-17', '出差');
INSERT INTO `car_record` VALUES (3, 1, '云F0000D', '2021-06-18', '2021-06-18', '2021-06-17', '出差');
INSERT INTO `car_record` VALUES (4, 1, '云F1111D', '2021-06-19', '2021-07-18', '2021-06-09', '出差');
INSERT INTO `car_record` VALUES (7, 1, '云F1234W', NULL, '2021-07-07', '2021-06-26', '出差');
INSERT INTO `car_record` VALUES (8, 1, '云F0000D', NULL, '2021-06-26', '2021-06-11', '出差');
INSERT INTO `car_record` VALUES (9, 1, '云F1234W', NULL, '2021-06-26', '2021-06-11', '出差');
INSERT INTO `car_record` VALUES (10, 1, '云F1234W', NULL, '2021-06-30', '2021-06-26', '出差');
INSERT INTO `car_record` VALUES (11, 1, '云F1234W', NULL, '2021-06-19', '2021-06-17', '出差');
INSERT INTO `car_record` VALUES (12, 1, '云F1234W', NULL, '2021-06-19', '2021-06-17', '出差');
INSERT INTO `car_record` VALUES (13, 1, '云F1234W', NULL, '2021-07-03', '2021-07-02', '出差');
INSERT INTO `car_record` VALUES (14, 1, '云F1234W', NULL, '2021-06-12', '2021-06-10', '出差');
INSERT INTO `car_record` VALUES (15, 1, '云F1234W', NULL, '2021-06-12', '2021-06-10', '出差');
INSERT INTO `car_record` VALUES (16, 1, '云F1234W', NULL, '2021-06-12', '2021-06-10', '出差');
INSERT INTO `car_record` VALUES (17, 1, '云F1234W', NULL, '2021-06-12', '2021-06-10', '出差');
INSERT INTO `car_record` VALUES (18, 1, '云F1234W', NULL, '2021-06-12', '2021-06-10', '出差');
INSERT INTO `car_record` VALUES (19, 1, '云F1234W', NULL, '2021-06-03', '2021-06-04', '出差');
INSERT INTO `car_record` VALUES (20, 1, '云F1234W', NULL, '2021-06-26', '2021-06-12', '出差');
INSERT INTO `car_record` VALUES (21, 1, '云F1234W', NULL, '2021-06-26', '2021-06-12', '出差');
INSERT INTO `car_record` VALUES (22, 1, '云F1234W', NULL, '2021-06-26', '2021-06-12', '出差');
INSERT INTO `car_record` VALUES (23, 1, '云F1234W', NULL, '2021-07-02', '2021-06-26', '出差');
INSERT INTO `car_record` VALUES (24, 1, '云F9999H', NULL, '2021-07-03', '2021-06-26', '出差');
INSERT INTO `car_record` VALUES (25, 1, '云F1111D', NULL, '2021-07-03', '2021-06-26', '出差');
INSERT INTO `car_record` VALUES (80, 1, '云F1111D', '2021-06-18', '2021-06-18', '2021-06-17', '出差');

-- ----------------------------
-- Table structure for contract_form
-- ----------------------------
DROP TABLE IF EXISTS `contract_form`;
CREATE TABLE `contract_form`  (
  `contract_num` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `contractheadline` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `firstparty` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `secondparty` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `signdate` date NOT NULL,
  `reward` double NOT NULL,
  `contractstate` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`contract_num`) USING BTREE,
  INDEX `FK_fk_staff_contract_form`(`job_num`) USING BTREE,
  CONSTRAINT `FK_staff_contract_form` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 78788 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract_form
-- ----------------------------
INSERT INTO `contract_form` VALUES (1, 3, '关于开发手机app', '小岛科技', '腾讯', '2021-06-20', 100000, '已完成');
INSERT INTO `contract_form` VALUES (2, 1, 'Javaweb开发合同', '小岛科技', '阿里巴巴', '2021-06-29', 189999, '已完成');
INSERT INTO `contract_form` VALUES (3, 1, '外包公司', '东软', '小岛科技', '2021-06-15', 10000, '未完成');
INSERT INTO `contract_form` VALUES (4, 2, '食品公司合同', '海底捞', '小岛科技', '2021-06-24', 30000, '未完成');
INSERT INTO `contract_form` VALUES (5, 2, '关于公司搬家', '小岛科技', '易丰搬家', '2021-06-29', 5600, '已完成');
INSERT INTO `contract_form` VALUES (6, 4, '关于公司拆迁', '小岛科技', '拆迁公司', '2021-06-28', 8900000, '已完成');
INSERT INTO `contract_form` VALUES (7, 5, '半导体研发', '华为', '小岛科技', '2021-06-30', 156800, '未完成');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `depart_num` int(11) NOT NULL,
  `depart_tel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `depart_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `depart_level` int(5) NOT NULL,
  PRIMARY KEY (`depart_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (0, '408208810', '总裁办', 1);
INSERT INTO `department` VALUES (1, '8008208820', '研发部', 2);
INSERT INTO `department` VALUES (2, '8008208821', '人力资源部', 3);
INSERT INTO `department` VALUES (3, '4008208820', '人事部', 3);
INSERT INTO `department` VALUES (4, '4008208825', '行政部', 3);
INSERT INTO `department` VALUES (5, '4008208828', '后勤部', 5);
INSERT INTO `department` VALUES (6, '4008208890', '财务部', 3);
INSERT INTO `department` VALUES (7, '8008208810', '计划营销部', 4);
INSERT INTO `department` VALUES (8, '4300852070', '保卫部', 5);

-- ----------------------------
-- Table structure for departure_info
-- ----------------------------
DROP TABLE IF EXISTS `departure_info`;
CREATE TABLE `departure_info`  (
  `departure_num` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `departure_time` date NOT NULL,
  `departure_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `departure_cause` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `transactor` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trans_time` date NOT NULL,
  PRIMARY KEY (`departure_num`) USING BTREE,
  INDEX `FK_staff_departure_info`(`job_num`) USING BTREE,
  CONSTRAINT `FK_staff_departure_info` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment`  (
  `equipment_num` int(11) NOT NULL AUTO_INCREMENT,
  `use_situation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `equipment_situation` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `equipment_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `equipment_life` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`equipment_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES (1, '使用中', '损坏过一次', '服务器', 5);
INSERT INTO `equipment` VALUES (2, '使用中', '无损坏', '服务器', 5);
INSERT INTO `equipment` VALUES (3, '使用中', '无损坏', '服务器', 5);
INSERT INTO `equipment` VALUES (4, '空闲中', '损坏', '服务器', 5);
INSERT INTO `equipment` VALUES (5, '使用中', '损坏过两次', '鼠标', 4);
INSERT INTO `equipment` VALUES (6, '空闲中', '无损坏', '鼠标', 4);
INSERT INTO `equipment` VALUES (7, '使用中', '损坏过一次', '电脑', 5);
INSERT INTO `equipment` VALUES (8, '使用中', '损坏过一次', '电脑', 5);
INSERT INTO `equipment` VALUES (9, '空闲中', '无损坏', '键盘', 6);
INSERT INTO `equipment` VALUES (10, '使用中', '无损坏', '键盘', 5);
INSERT INTO `equipment` VALUES (11, '使用中', '损坏过一次', '服务器', 8);
INSERT INTO `equipment` VALUES (12, '使用中', '损坏过一次', '服务器', 6);
INSERT INTO `equipment` VALUES (13, '使用中', '损坏过一次', '键盘', 5);
INSERT INTO `equipment` VALUES (14, '空闲中', '无损坏', '耳机', 4);
INSERT INTO `equipment` VALUES (15, '空闲中', '损坏过一次', '键盘', 5);
INSERT INTO `equipment` VALUES (16, '使用中', '无损坏', '电脑', 6);
INSERT INTO `equipment` VALUES (17, '空闲中', '无损坏', '鼠标', 6);
INSERT INTO `equipment` VALUES (18, '空闲中', '损坏过一次', '键盘', 5);
INSERT INTO `equipment` VALUES (19, '使用中', '损坏过两次', '服务器', 6);
INSERT INTO `equipment` VALUES (20, '使用中', '损坏过两次', '服务器', 5);

-- ----------------------------
-- Table structure for inform
-- ----------------------------
DROP TABLE IF EXISTS `inform`;
CREATE TABLE `inform`  (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `inform_type_name` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inform_des` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `inform_state` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inform_receive_date` date NOT NULL,
  `inform_concrete_des` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`news_id`) USING BTREE,
  INDEX `FK_staff_inform`(`job_num`) USING BTREE,
  CONSTRAINT `FK_staff_inform` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inform
-- ----------------------------
INSERT INTO `inform` VALUES (2, 1, '公告', '企业员工大会', '已删除', '2021-06-22', '1、通过大会主席团名单，主席团人员入座 2、宣布大会开始，奏国歌 3、大会筹备工作情况汇报 4、作公司行政工作报告 5、作2006年上半年度劳动保护技措计划完成情况汇报 6、大会书面文件 （1）2006年上半年业务招待费使用情况汇报 （2）2005年度公司审计工作报告 蒋 旻 张耀庆 万 峰 9：45 ↓ 11：00 分 组 会 议 各 组 长 1、讨论公司行政工作报告 2、审议2006年上半年度劳动保护技措计划实施情况汇报（草案） 3、讨论2006年上半年业务招待费使用情况汇报 5、讨论2005年度公司审计工作报告 6、讨论大会决议（草案） 12：00 ↓ 12：45 讨论汇报 张耀庆 听取各代表组讨论情况汇报 各组长 13：00 ↓ 15：00 全 体 会 议 林哲明 1、对职工代表意见进行说明 2、代表对大会《决议》作无记名投票表决 关于2006年上半年度劳动保护技措计划实施情况汇报的大会决议（草案） 3、 大会报告无记名投票表决结果 4、 宣读大会决议 5、 领导讲话 6、 宣布大会结束');
INSERT INTO `inform` VALUES (3, 1, '公告', '总裁办员工集合会议', '已关注', '2021-06-22', '1、通过大会主席团名单，主席团人员入座 2、宣布大会开始，奏国歌 3、大会筹备工作情况汇报 4、作公司行政工作报告 5、作2006年上半年度劳动保护技措计划完成情况汇报 6、大会书面文件 （1）2006年上半年业务招待费使用情况汇报 （2）2005年度公司审计工作报告 蒋 旻 张耀庆 万 峰 9：45 ↓ 11：00 分 组 会 议 各 组 长 1、讨论公司行政工作报告 2、审议2006年上半年度劳动保护技措计划实施情况汇报（草案） 3、讨论2006年上半年业务招待费使用情况汇报 5、讨论2005年度公司审计工作报告 6、讨论大会决议（草案） 12：00 ↓ 12：45 讨论汇报 张耀庆 听取各代表组讨论情况汇报 各组长 13：00 ↓ 15：00 全 体 会 议 林哲明 1、对职工代表意见进行说明 2、代表对大会《决议》作无记名投票表决 关于2006年上半年度劳动保护技措计划实施情况汇报的大会决议（草案） 3、 大会报告无记名投票表决结果 4、 宣读大会决议 5、 领导讲话 6、 宣布大会结束');
INSERT INTO `inform` VALUES (4, 1, '公告', '员工表扬公告', '已关注', '2021-06-29', '员工李四在正常工作时间玩手机被发现并被制止。');
INSERT INTO `inform` VALUES (5, 1, '公告', '关于开除员工', '未关注', '2021-06-23', '员工张三被开除');
INSERT INTO `inform` VALUES (6, 1, '公告', '关于涨薪', '未关注', '2021-06-23', '由于疫情原因影响，这次进行集体涨薪通知。');
INSERT INTO `inform` VALUES (8, 1, '公告', '关于辞退李四员工的通知', '已删除', '2021-06-19', '由于疫情原因影响，公司现下决定辞退部分员工李四。');
INSERT INTO `inform` VALUES (9, 1, '公告', '关于辞退员工的通知', '已删除', '2021-06-15', '由于疫情原因影响，公司现下决定辞退部分员工。');
INSERT INTO `inform` VALUES (10, 1, '通知', '全体员工大会', '未关注', '2021-06-26', '举办第39届全体员工大会。');
INSERT INTO `inform` VALUES (11, 1, '通知', '企业放假通知', '已删除', '2021-06-22', '时逢公司庆典，放假三天');
INSERT INTO `inform` VALUES (12, 1, '通知', '换届', '已删除', '2021-06-22', '换届各个部门领导');
INSERT INTO `inform` VALUES (13, 1, '通知', '小组项目计划', '已删除', '2021-06-22', '关于此次项目的这次小组项目计划');
INSERT INTO `inform` VALUES (14, 1, '通知', '企业准则', '未关注', '2021-06-22', '更改企业准则');
INSERT INTO `inform` VALUES (15, 1, '通知', '企业换总裁', '未关注', '2021-06-22', '换总裁张洒洒');
INSERT INTO `inform` VALUES (16, 1, '通知', '新一批辞退员工名单', '未关注', '2021-06-22', '总裁办 ： 张三 李四 王五 马六');
INSERT INTO `inform` VALUES (29, 1, '通知', '关于企业优秀人物之星的选取', '已关注', '2021-06-22', '这次企业优秀人物的选举将在6月30号举办。');
INSERT INTO `inform` VALUES (30, 1, '通知', '关于企业的延迟放假通知', '已关注', '2021-06-22', '延迟此次年假的休息时间，必须加班加点赶出项目');
INSERT INTO `inform` VALUES (31, 1, '通知', '企业通知下届董事会人选', '已关注', '2021-06-22', '这次董事会人选将会进行大换血，所以请全体员工注意');
INSERT INTO `inform` VALUES (36, 1, '通知', '企业100周年庆典', '已删除', '2021-06-22', '举办企业100周年庆典的计划方案');
INSERT INTO `inform` VALUES (38, 1, '通知', '关于企业准则的设定', '已关注', '2021-06-22', '关于修改企业准则的设定');
INSERT INTO `inform` VALUES (39, 1, '通知', '企业文化普及', '已关注', '2021-06-22', '企业文化是一个企业的命门');
INSERT INTO `inform` VALUES (40, 1, '通知', '辞退员工名单', '已删除', '2021-06-22', '行政部 ： 张三 李四 王五 马六');
INSERT INTO `inform` VALUES (66, 6, '通知', '哈哈哈哈', '未关注', '2021-06-29', '啊实打实打算');
INSERT INTO `inform` VALUES (67, 10, '公告', '反反复复', '未关注', '2021-06-07', '反反复复');
INSERT INTO `inform` VALUES (68, 10, '公告', '反反复复', '未关注', '2021-06-07', '反反复复');
INSERT INTO `inform` VALUES (69, 1, '通知', '公司季度总结会', '已关注', '2021-06-29', '公司召开季度总结会');
INSERT INTO `inform` VALUES (70, 11, '通知', '公司季度总结会', '未关注', '2021-06-29', '公司召开季度总结会');
INSERT INTO `inform` VALUES (76, 2, '通知', '关于企业优秀人物之星的选取', '已关注', '2021-06-24', '这次企业优秀人物的选举将在6月30号举办。');
INSERT INTO `inform` VALUES (77, 1, '公告', '员工批评公告', '未关注', '1970-01-01', '员工张三在正常工作时间玩手机被发现并被制止。');
INSERT INTO `inform` VALUES (78, 1, '公告', '员工批评公告', '未关注', '1970-01-01', '员工张三在正常工作时间玩手机被发现并被制止。');
INSERT INTO `inform` VALUES (79, 1, '公告', '员工批评公告', '未关注', '1970-01-01', '员工张三在正常工作时间玩手机被发现并被制止。');
INSERT INTO `inform` VALUES (80, 1, '通知', '好吧', '未关注', '2021-07-01', '今天要答辩');
INSERT INTO `inform` VALUES (81, 11, '通知', '好吧', '未关注', '2021-07-01', '今天要答辩');
INSERT INTO `inform` VALUES (82, 19, '通知', '今天答辩哟', '未关注', '2021-07-01', '今天答辩，不要迟到');
INSERT INTO `inform` VALUES (83, 4, '通知', '今天答辩哟', '已删除', '2021-07-01', '今天答辩，不要迟到');
INSERT INTO `inform` VALUES (84, 1, '公告', '员工批评公告', '未关注', '1970-01-01', '员工张三在正常工作时间玩手机被发现并被制止。');
INSERT INTO `inform` VALUES (85, 1, '公告', '员工批评公告', '未关注', '1970-01-01', '员工张三在正常工作时间玩手机被发现并被制止。');
INSERT INTO `inform` VALUES (86, 5, '通知', '今天答辩', '未关注', '2021-07-01', '不要忘记答辩');
INSERT INTO `inform` VALUES (87, 2, '通知', '今天答辩', '已关注', '2021-07-01', '不要忘记答辩');
INSERT INTO `inform` VALUES (88, 25, '通知', '测试', '未关注', '2021-07-01', '测试');
INSERT INTO `inform` VALUES (89, 5, '通知', '测试', '未关注', '2021-07-01', '测试');
INSERT INTO `inform` VALUES (90, 2, '通知', '测试', '已删除', '2021-07-01', '测试');

-- ----------------------------
-- Table structure for job
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job`  (
  `post_num` int(11) NOT NULL,
  `post_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `post_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `post_level` int(11) NOT NULL,
  `super_post` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `responsibilities` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `entry_requirement` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `post_overview` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `vacation` int(5) NOT NULL,
  PRIMARY KEY (`post_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job
-- ----------------------------
INSERT INTO `job` VALUES (1, '总经理', '运营非研发', 1, '无', '负责公司的各项活动和运营', 'MBA、博士、测试', '处理公司的大小事务', 15);
INSERT INTO `job` VALUES (2, '副总经理', '运营非研发', 2, '总经理', '协助总经理', '博士', '协助总经理处理公司的大小事务', 12);
INSERT INTO `job` VALUES (3, '人事总监', '运营非研发', 2, '总经理', '管理人事事务', '硕士、测试', '处理人事部门的大小事务', 10);
INSERT INTO `job` VALUES (4, '行政总监', '运营非研发', 2, '总经理', '负责行政部门的事务处理                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ', '硕士', '处理行政部的大小事务', 10);
INSERT INTO `job` VALUES (5, '后勤总监', '运营非研发', 3, '副总经理', '管理公司的后勤事务', '硕士', '处理后勤部的大小事务', 10);
INSERT INTO `job` VALUES (6, '职员', '非研发', 5, '总监', '为资本家的幸福生活奋斗', '本科生', '为资本家的幸福生活奋斗', 8);
INSERT INTO `job` VALUES (7, '研发部总监', '研发', 2, '总经理', '负责制定集团研发技术发展的战略方针，并协助集团总裁完成研发计划和各项技术经济指标', '硕士', '研究决策公司技术发展路线、规划公司产品、根据公司整体战略目标及发展计划，制定年度研发技术工作目标、计划及预算等，并负责实施', 10);
INSERT INTO `job` VALUES (8, '人力资源部总监', '运营非研发', 2, '总经理', '统筹规划集团人力资源战略，制定适应公司发展的中长期人才战略规划及整体人力资源规划', '博士', '参与公司战略规划及重大问题的决策，向公司高层决策者提供有关人力战略、组织建设等方面的建议', 10);
INSERT INTO `job` VALUES (9, '财务部总监', '运营非研发', 2, '总经理', '制定公司的财务目标、政策及操作程序，并根据授权向总经理、董事会报告', '博士', '建立健全该公司内部财务管理、审计制度并组织实施、主持公司财务战略的制定、财务管理及内部控制工作', 10);
INSERT INTO `job` VALUES (10, '营销总监', '运营非研发', 3, '副总经理', '市场变化分析、市场占有率调查、竞争环境分析', '硕士', '为企业制定短期及长期战略规划及实施策略、组织新老产品的成功上市销售、为企业打造一支高效、稳定的销售团队', 10);
INSERT INTO `job` VALUES (11, '安保总监', '运营非研发', 3, '副总经理', '健全安全生产的规章制度和安全生产标准化的建设以及做好安全生产报表、计划、总结上报和公司安全台账工作', '硕士', '制定公司安全制度与工作计划', 10);

-- ----------------------------
-- Table structure for meeting_booking
-- ----------------------------
DROP TABLE IF EXISTS `meeting_booking`;
CREATE TABLE `meeting_booking`  (
  `booking_num` int(11) NOT NULL,
  `meetingroom_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_num` int(11) NOT NULL,
  `begin_time` datetime(0) NOT NULL,
  `finish_time` datetime(0) NOT NULL,
  `meeting_headline` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `participant_num` int(11) NOT NULL,
  PRIMARY KEY (`booking_num`) USING BTREE,
  INDEX `FK_meetingroom_meeting_booking`(`meetingroom_num`) USING BTREE,
  INDEX `FK_staff_meeting_booking`(`job_num`) USING BTREE,
  CONSTRAINT `FK_meetingroom_meeting_booking` FOREIGN KEY (`meetingroom_num`) REFERENCES `meetingroom` (`meetingroom_num`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_staff_meeting_booking` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for meeting_record
-- ----------------------------
DROP TABLE IF EXISTS `meeting_record`;
CREATE TABLE `meeting_record`  (
  `meeting_record_id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_num` int(5) NOT NULL,
  `meeting_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detailrecord` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `meetingtime` date NOT NULL,
  `job_num` int(11) NOT NULL,
  `meetingroom_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`meeting_record_id`) USING BTREE,
  INDEX `FK_staff_meeting_record`(`job_num`) USING BTREE,
  INDEX `FK_meeting_booking_meeting_record`(`booking_num`) USING BTREE,
  INDEX `FK_meetingroom_meeting_record`(`meetingroom_num`) USING BTREE,
  CONSTRAINT `FK_meeting_booking_meeting_record` FOREIGN KEY (`booking_num`) REFERENCES `meeting_booking` (`booking_num`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_meetingroom_meeting_record` FOREIGN KEY (`meetingroom_num`) REFERENCES `meetingroom` (`meetingroom_num`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_staff_meeting_record` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for meetingroom
-- ----------------------------
DROP TABLE IF EXISTS `meetingroom`;
CREATE TABLE `meetingroom`  (
  `meetingroom_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `people_num` int(11) NOT NULL,
  `place` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`meetingroom_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for official_document
-- ----------------------------
DROP TABLE IF EXISTS `official_document`;
CREATE TABLE `official_document`  (
  `official_document_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `document_concrete_des` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `theme` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `send_person` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `draft_person` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del_state` tinyint(1) NOT NULL,
  `attention_state` tinyint(1) NOT NULL,
  `document_state` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `document_type_name` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `document_draft_date` date NULL DEFAULT NULL,
  `send_date` date NULL DEFAULT NULL,
  `read_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`official_document_id`) USING BTREE,
  INDEX `FK_staff_official_document`(`job_num`) USING BTREE,
  CONSTRAINT `FK_staff_official_document` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for personal_constract
-- ----------------------------
DROP TABLE IF EXISTS `personal_constract`;
CREATE TABLE `personal_constract`  (
  `personal_contract_num` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `begin_time` date NOT NULL,
  `end_time` date NOT NULL,
  `contract_ages` int(5) NOT NULL,
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `contract_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`personal_contract_num`) USING BTREE,
  INDEX `FK_staff_personal_contract`(`job_num`) USING BTREE,
  CONSTRAINT `FK_staff_personal_contract` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for personal_schedule
-- ----------------------------
DROP TABLE IF EXISTS `personal_schedule`;
CREATE TABLE `personal_schedule`  (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `schedule_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schedule_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `schedule_date` date NULL DEFAULT NULL,
  `ask_endtime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fact_endtime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `schedule_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `concrete_schedulecontent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `delay` tinyint(1) NULL DEFAULT NULL,
  `job_num` int(11) NOT NULL,
  `process` int(8) NULL DEFAULT NULL,
  `schedule_state` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `schedule_process` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remind_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`schedule_id`) USING BTREE,
  INDEX `FK_staff_personal_schedule`(`job_num`) USING BTREE,
  CONSTRAINT `FK_staff_personal_schedule` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_schedule
-- ----------------------------
INSERT INTO `personal_schedule` VALUES (1, '拼命写代码', '个人日程', '2021-07-01T06:06:47.995Z', '2021-06-15', '2021-07-01T06:06:47.995Z', '15:00:00', '熬夜写代码', '拼死熬夜写代码', 0, 1, 60, '已开始', '60', NULL);
INSERT INTO `personal_schedule` VALUES (2, '和平写代码', '个人日程', '2021-07-01T07:27:47.653Z', '2021-06-24', '2021-07-01T07:27:47.653Z', '15:00:00', '今天写代码任务', '完成一个模块的具体实现', 0, 1, 60, '已开始', '60', NULL);
INSERT INTO `personal_schedule` VALUES (3, '完成软件测试报告', '个人日程', '2021-06-29T06:21:14.000Z', '2021-06-24', '2021-06-29T06:21:14.000Z', '15:00:00', '个人模块测试', '听具体的课程内容，根据模块测试的指导，完成一个模块测试的报告', 0, 1, 20, '已开始', '20', NULL);
INSERT INTO `personal_schedule` VALUES (4, '完成个人工作日报', '个人日程', '2021-06-28T03:10:35.436Z', '2021-06-25', '2021-06-28T03:10:35.436Z', '15:00:00', '个人日报内容的编写', '具体一天的工作日程的汇报', 0, 1, 10, '已开始', '10', NULL);
INSERT INTO `personal_schedule` VALUES (5, '关于软件集成', '个人日程', '2021-06-29T06:21:14.000Z', '2021-06-15', '2021-06-29T06:21:14.000Z', '15:00:00', '软件集成的测试', '使用特定的工具，进行软件集成', 0, 1, 100, '已开始', '100', NULL);
INSERT INTO `personal_schedule` VALUES (6, '平淡写代码', '个人日程', '2021-06-28T03:10:35.436Z', '2021-06-17', '2021-06-28T03:10:35.436Z', '19:00:00', '上课写代码', '平平淡淡写代码', 0, 1, 50, '已开始', '50', NULL);
INSERT INTO `personal_schedule` VALUES (7, '宿舍写代码', '个人日程', '2021-06-28T10:10:35.436Z', '2021-06-20', '2021-06-28T19:10:35.436Z', '15:00:00', '宿舍打灯写代码', '宿舍打灯好好写代码', 0, 1, 60, '已开始', '60', NULL);
INSERT INTO `personal_schedule` VALUES (8, '写文档', '个人日程', '2021-06-29T11:10:35.436Z', '2021-06-24', '2021-06-30T18:10:35.436Z', '15:00:00', '今天写文档', '文档的具体内容编写', 0, 1, 0, '未开始', '0', NULL);
INSERT INTO `personal_schedule` VALUES (9, '完成初步测试', '个人日程', '2021-06-29T06:21:14.000Z', '2021-06-30', '2021-06-29T06:21:14.000Z', '15:00:00', '模块测试', '根据模块测试的指导，完成一个模块测试的报告，汇合模块的测试报告', 0, 1, 0, '未开始', '0', NULL);
INSERT INTO `personal_schedule` VALUES (10, '新建个人工作日报', '个人日程', '2021-06-28T03:10:35.436Z', '2021-06-25', '2021-06-28T03:10:35.436Z', '15:00:00', '关于个人日报内容的编写', '详细个人日报内容的编写', 0, 1, 100, '已开始', '100', NULL);
INSERT INTO `personal_schedule` VALUES (12, '吃饭饭', '周期性任务', '2021-06-30T16:53:19.751Z', '2021-06-26', '2021-06-30T16:53:19.751Z', '15:00:00', '每顿都要吃饭哦！', '吃饭不积极，脑子有问题！', NULL, 1, 0, NULL, NULL, '按日提醒');
INSERT INTO `personal_schedule` VALUES (13, '睡个午觉吧', '周期性任务', '2021-06-29T11:54:36.641Z', '2021-06-18', '2021-06-29T11:54:36.641Z', '15:00:00', '午休下午更精神', '至少小睡半个小时', NULL, 1, 0, NULL, NULL, '按日提醒');
INSERT INTO `personal_schedule` VALUES (14, '详细汇报本周任务进度', '周期性任务', '2021-06-28T03:10:35.436Z', '2021-06-23', '2021-06-29T06:21:14.000Z', '15:00:00', '详细的本周任务更有利于信息管理', '本周任务帮助了解项目进度', NULL, 1, 0, NULL, NULL, '按周提醒');
INSERT INTO `personal_schedule` VALUES (15, '关于本月进度汇报', '周期性任务', '2021-06-29T04:58:31.000Z', '2021-06-17', '2021-06-29T06:58:31.000Z', '15:00:00', '本月进度具体汇报', '月任务汇报的总体流程', NULL, 1, 0, NULL, NULL, '按月提醒');
INSERT INTO `personal_schedule` VALUES (16, '回家', '周期性任务', '2021-06-28T08:39:40.000Z', '2021-06-25', '2021-06-28T10:10:35.436Z', '15:00:00', '该回家休息了', '好好休息', NULL, 1, 0, NULL, NULL, '按日提醒');
INSERT INTO `personal_schedule` VALUES (17, '考勤', '周期性任务', '2021-06-29T06:21:14.000Z', '2021-06-17', '2021-06-29T11:10:35.436Z', '15:00:00', '每日考勤别忘了', '考勤和工资有关哦！', NULL, 1, 0, NULL, NULL, '按日提醒');
INSERT INTO `personal_schedule` VALUES (18, '上班打卡', '周期性任务', '2021-06-30T17:18:32.638Z', '2021-06-23', '2021-06-30T17:18:32.639Z', '15:00:00', '上班打卡是考勤', '考勤是帮助领导知道的必要助手', NULL, 1, 0, NULL, NULL, '按周提醒');
INSERT INTO `personal_schedule` VALUES (19, '喝水', '周期性任务', '2021-06-29T06:21:14.000Z', '2021-06-17', '2021-06-28T03:10:35.436Z', '15:00:00', '喝水喝水喝水', '、有利于身体健康', NULL, 1, 0, NULL, NULL, '按月提醒');
INSERT INTO `personal_schedule` VALUES (25, '吃饭', '周期性任务', '2021-06-28T08:39:40.000Z', '2021-06-25', '2021-06-29T11:13:21.000Z', '15:00:00', '吃饭吃饭吃饭', '吃饭必须', NULL, 1, 0, NULL, NULL, '按日提醒');
INSERT INTO `personal_schedule` VALUES (26, '午休', '周期性任务', '2021-06-29T06:21:14.000Z', '2021-06-17', '2021-06-29T06:21:14.000Z', '15:00:00', '午休午休午休', '天天记得午休！', NULL, 1, 0, NULL, NULL, '按日提醒');
INSERT INTO `personal_schedule` VALUES (27, '汇报本周任务进度', '周期性任务', '2021-06-28T03:10:35.436Z', '2021-06-23', '2021-06-28T03:10:35.436Z', '15:00:00', '每周的任务汇报是不可缺少的', '任务进度汇报的大致内容标题', NULL, 1, 0, NULL, NULL, '按周提醒');
INSERT INTO `personal_schedule` VALUES (31, '本月进度汇报', '周期性任务', '2021-06-29T06:21:14.000Z', '2021-06-17', '2021-06-29T08:09:17.000Z', '15:00:00', '每月的任务汇报是不可缺少的', '月任务汇报的总体流程', NULL, 1, 0, NULL, NULL, '按月提醒');
INSERT INTO `personal_schedule` VALUES (52, 'hhhh', '个人日程', '2021-06-30T17:01:00.861Z', '1970-01-01', '2021-06-30T17:01:00.861Z', NULL, '熬夜写代码babbbb', '熬夜写代码', NULL, 1, 0, NULL, NULL, NULL);
INSERT INTO `personal_schedule` VALUES (53, 'hhhh', '个人日程', '2021-06-30T17:01:00.861Z', '1970-01-01', '2021-06-30T17:01:00.861Z', NULL, '熬夜写代码', '熬夜写代码', NULL, 1, 0, NULL, NULL, NULL);
INSERT INTO `personal_schedule` VALUES (54, 'hhhh', '个人日程', '2021-06-30T17:01:00.861Z', '1970-01-01', '2021-06-30T17:01:00.861Z', NULL, '熬夜写代码babbbb', '熬夜写代码', NULL, 1, 0, NULL, NULL, NULL);
INSERT INTO `personal_schedule` VALUES (55, 'hhhh', '个人日程', '2021-06-30T17:01:00.861Z', '1970-01-01', '2021-06-30T17:01:00.861Z', NULL, '熬夜写代码', '熬夜写代码', NULL, 1, 0, NULL, NULL, NULL);
INSERT INTO `personal_schedule` VALUES (56, 'hhhh', '个人日程', '2021-06-30T17:01:00.861Z', '1970-01-01', '2021-06-30T17:01:00.861Z', NULL, '熬夜写代码babbbb', '熬夜写代码', NULL, 1, 0, NULL, NULL, NULL);
INSERT INTO `personal_schedule` VALUES (57, 'hhhh', '个人日程', '2021-06-30T17:01:00.861Z', '1970-01-01', '2021-06-30T17:01:00.861Z', NULL, '熬夜写代码', '熬夜写代码', NULL, 1, 0, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire`;
CREATE TABLE `questionnaire`  (
  `questionnaire_num` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `questionnairheadline` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `questionnairdetail` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `questionnaire_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`questionnaire_num`) USING BTREE,
  INDEX `FK_staff_questionnaire`(`job_num`) USING BTREE,
  CONSTRAINT `FK_staff_questionnaire` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for repair
-- ----------------------------
DROP TABLE IF EXISTS `repair`;
CREATE TABLE `repair`  (
  `repair_num` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `equipment_num` int(11) NOT NULL,
  `repair_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repair_money` double NOT NULL,
  `repair_description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `take_date` date NOT NULL,
  `repair_date` date NOT NULL,
  PRIMARY KEY (`repair_num`) USING BTREE,
  INDEX `FK_staff_repair`(`job_num`) USING BTREE,
  INDEX `FK_equipment_repair`(`equipment_num`) USING BTREE,
  CONSTRAINT `FK_equipment_repair` FOREIGN KEY (`equipment_num`) REFERENCES `equipment` (`equipment_num`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_staff_repair` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of repair
-- ----------------------------
INSERT INTO `repair` VALUES (0, 1, 7, '设备', 1200, '屏幕坏了', '2021-02-11', '2021-06-17');
INSERT INTO `repair` VALUES (2, 1, 1, '设备', 5000, '屏幕损坏', '2021-06-19', '2021-06-18');
INSERT INTO `repair` VALUES (3, 1, 1, '设备', 5000, '屏幕损坏', '2021-06-19', '2021-06-18');
INSERT INTO `repair` VALUES (4, 1, 1, '设备', 5000, '屏幕损坏', '2021-06-19', '2021-06-18');
INSERT INTO `repair` VALUES (5, 1, 1, '设备', 5000, '屏幕损坏', '2021-06-19', '2021-06-18');
INSERT INTO `repair` VALUES (6, 1, 1, '设备', 1900, '零件损坏', '2021-06-25', '2021-06-23');
INSERT INTO `repair` VALUES (10, 1, 1, '设备', 1300, '零件损坏', '2021-07-03', '2021-06-09');
INSERT INTO `repair` VALUES (11, 1, 1, '设备', 1230, '零件损坏', '2021-06-26', '2021-06-25');
INSERT INTO `repair` VALUES (12, 1, 1, '设备', 1200, '零件损坏', '2021-06-26', '2021-06-26');
INSERT INTO `repair` VALUES (13, 1, 1, '设备', 1000, '零件损坏', '2021-07-03', '2021-06-26');
INSERT INTO `repair` VALUES (14, 1, 1, '设备', 1000, '零件损坏', '2021-07-03', '2021-06-26');
INSERT INTO `repair` VALUES (15, 1, 1, '设备', 450, '零件损坏', '2021-07-10', '2021-08-08');
INSERT INTO `repair` VALUES (18, 1, 2, '设备', 9000, '屏幕坏了', '2021-06-30', '2021-07-11');
INSERT INTO `repair` VALUES (19, 1, 3, '设备', 800, '无法正常按键', '2021-06-02', '2021-07-04');
INSERT INTO `repair` VALUES (20, 1, 4, '设备', 7000, '无法正常操作', '2021-07-02', '2021-07-09');
INSERT INTO `repair` VALUES (21, 1, 5, '设备', 1000, '屏幕坏了', '2021-07-02', '2021-07-04');
INSERT INTO `repair` VALUES (22, 1, 6, '设备', 1300, '无法正常操作', '2021-07-11', '2021-07-04');
INSERT INTO `repair` VALUES (24, 1, 8, '设备', 1400, '无法正常操作', '2021-06-03', '2021-06-27');
INSERT INTO `repair` VALUES (25, 1, 9, '设备', 1600, '屏幕坏了', '2021-06-06', '2021-07-04');
INSERT INTO `repair` VALUES (26, 1, 10, '设备', 1700, '无法正常操作', '2021-06-23', '2021-07-11');
INSERT INTO `repair` VALUES (27, 1, 7, '设备', 1200, '屏幕坏了', '2021-02-11', '2021-06-17');

-- ----------------------------
-- Table structure for right_map
-- ----------------------------
DROP TABLE IF EXISTS `right_map`;
CREATE TABLE `right_map`  (
  `account` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `right_id` int(11) NOT NULL,
  PRIMARY KEY (`account`, `right_id`) USING BTREE,
  INDEX `FK_right_map`(`right_id`) USING BTREE,
  CONSTRAINT `FK_right_map` FOREIGN KEY (`right_id`) REFERENCES `staff_right` (`right_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_staff_right` FOREIGN KEY (`account`) REFERENCES `staff` (`account`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of right_map
-- ----------------------------
INSERT INTO `right_map` VALUES ('201811040808', 1);
INSERT INTO `right_map` VALUES ('201811040809', 1);
INSERT INTO `right_map` VALUES ('201811040783', 2);
INSERT INTO `right_map` VALUES ('201811040809', 2);
INSERT INTO `right_map` VALUES ('201811040783', 3);
INSERT INTO `right_map` VALUES ('201811040792', 3);
INSERT INTO `right_map` VALUES ('201811040808', 3);
INSERT INTO `right_map` VALUES ('201811040809', 3);
INSERT INTO `right_map` VALUES ('201811040783', 4);
INSERT INTO `right_map` VALUES ('201811040792', 4);
INSERT INTO `right_map` VALUES ('201811040808', 4);
INSERT INTO `right_map` VALUES ('201811040809', 4);
INSERT INTO `right_map` VALUES ('201811040792', 5);
INSERT INTO `right_map` VALUES ('201811040809', 5);
INSERT INTO `right_map` VALUES ('201811040792', 6);
INSERT INTO `right_map` VALUES ('201811040809', 6);

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `job_num` int(11) NOT NULL,
  `depart_num` int(11) NOT NULL,
  `post_num` int(11) NOT NULL,
  `staff_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `account` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `staff_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `staff_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gender` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nationality` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nation` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `identity_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `birthday` date NULL DEFAULT NULL,
  `native_place` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `politics_statues` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `staff_image` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `in_office` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `service_length` int(11) NULL DEFAULT NULL,
  `staff_tel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`job_num`) USING BTREE,
  INDEX `FK_department_staff`(`depart_num`) USING BTREE,
  INDEX `FK_job_staff`(`post_num`) USING BTREE,
  INDEX `account`(`account`) USING BTREE,
  CONSTRAINT `FK_department_staff` FOREIGN KEY (`depart_num`) REFERENCES `department` (`depart_num`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_job_staff` FOREIGN KEY (`post_num`) REFERENCES `job` (`post_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (1, 0, 1, '乔翱吧', '201811040809', '1102825926251130220231815830', '正式员工', '男', '中国', '汉族', '111111111111111111', '2000-05-02', '河北', '群众', '789522@qq.com', '1624880427741.jpg', '是', 12, '13685555');
INSERT INTO `staff` VALUES (2, 3, 3, '白阜玉', '201811040783', '1102825926251130220231815830', '正式员工', '女', '中国', '汉族', '222222222222222222', '2002-02-02', '河北', '群众', '55855@163.com', '1625110478952.jpg', '是', 5, '15376232');
INSERT INTO `staff` VALUES (3, 4, 4, '刘祺', '201811040808', '1102825926251130220231815830', '正式员工', '男', '中国', '汉族', '455632522178798', '2000-01-01', '辽宁', '群众', '48552@163.com', NULL, '是', 5, '14786633');
INSERT INTO `staff` VALUES (4, 5, 5, '赵晓晴', '201811040792', '1102825926251130220231815830', '正式员工', '女', '中国', '汉族', '4523213', '2000-01-01', '河北', '群众', '48532@163.com', '1625069751228.jpg', '是', 5, '45451252');
INSERT INTO `staff` VALUES (5, 3, 6, '张璇', '201811040781', '1102825926251130220231815830', '正式员工', '女', '中国', '汉族', '11111111111111111x', '2000-02-02', '河北', '群众', '161616@163.com', NULL, '是', 1, '4565465');
INSERT INTO `staff` VALUES (6, 1, 7, '老研', '111111111111', '123456', '正式员工', '男', '中国', '汉族', '4546546546464654', '1984-06-13', '河北', '党员', '4654651@qq.com', NULL, '是', 4, '96396352');
INSERT INTO `staff` VALUES (7, 2, 8, '老力', '222222222222', '123456', '正式员工', '女', '中国', '汉族', '4684646465465465', '1999-11-29', '北京', '党员', '56562@qq.com', NULL, '是', 5, '89556552');
INSERT INTO `staff` VALUES (8, 6, 9, '老财', '666666666666', '123456', '正式员工', '女', '中国', '汉族', '9565655655656', '1990-06-29', '上海', '党员', '895454@qq.com', NULL, '是', 3, '88552236');
INSERT INTO `staff` VALUES (9, 7, 10, '老营', '777777777777', '123456', '正式员工', '男', '中国', '少数民族', '5454542156565', '1989-07-13', '南京', '党员', '474555@163.com', NULL, '是', 2, '77888955');
INSERT INTO `staff` VALUES (10, 8, 11, '老安', '888888888888', '123456', '正式员工', '男', '中国', '汉族', '454565656562', '1994-04-28', '黑龙江', '党员', '8552223@163.com', NULL, '是', 7, '46514986');
INSERT INTO `staff` VALUES (11, 0, 2, '老副', '222222222222', '123456', '正式员工', '女', '中国', '汉族', '744562465265', '1990-07-27', '河北', '党员', '888553165@163.com', NULL, '是', 10, '56566565');
INSERT INTO `staff` VALUES (19, 5, 6, '赵黑客', '4566321', '123456', '正式员工', '女', '', '', '130624255562681253', NULL, '', '', '4555@qq.com', '1625110478952.jpg', '是', 0, '');
INSERT INTO `staff` VALUES (25, 3, 6, '白白白', '589622', '123456', '正式员工', '男', '', '', '132562222496223322', NULL, '', '', '5563@qq.com', '1625118371488.jpg', '否', 0, '');
INSERT INTO `staff` VALUES (59, 0, 6, '拜拜', '45622', '123456', '正式员工', '男', '', '汉族', '130625585232535631', NULL, '', '', '54354@qq.com', '1625124570868.jpg', '是', 0, '');

-- ----------------------------
-- Table structure for staff_right
-- ----------------------------
DROP TABLE IF EXISTS `staff_right`;
CREATE TABLE `staff_right`  (
  `right_id` int(11) NOT NULL,
  `right_content` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`right_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff_right
-- ----------------------------
INSERT INTO `staff_right` VALUES (1, '行政管理');
INSERT INTO `staff_right` VALUES (2, '人事管理');
INSERT INTO `staff_right` VALUES (3, '通知公告');
INSERT INTO `staff_right` VALUES (4, '个人日程');
INSERT INTO `staff_right` VALUES (5, '设备管理');
INSERT INTO `staff_right` VALUES (6, '车辆管理');

-- ----------------------------
-- Table structure for vote
-- ----------------------------
DROP TABLE IF EXISTS `vote`;
CREATE TABLE `vote`  (
  `vote_num` int(11) NOT NULL AUTO_INCREMENT,
  `job_num` int(11) NOT NULL,
  `vote_headline` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `poll` int(11) NOT NULL,
  `highestoptions` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `vote_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`vote_num`) USING BTREE,
  INDEX `FK_staff_vote`(`job_num`) USING BTREE,
  CONSTRAINT `FK_staff_vote` FOREIGN KEY (`job_num`) REFERENCES `staff` (`job_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
