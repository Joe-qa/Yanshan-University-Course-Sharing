/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : game

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 28/06/2020 15:01:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `activity_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` datetime(0) NOT NULL,
  `end_time` datetime(0) NOT NULL,
  PRIMARY KEY (`activity_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES (1, '活动1', '新海岛抢滩登陆战！看军团战赢ss8赛季手册', '2020-06-28 09:20:05', '2020-07-01 09:20:13');
INSERT INTO `activity` VALUES (2, '活动2', '和平精英SS8赛季集结战', '2020-06-03 09:22:45', '2020-07-05 09:22:51');
INSERT INTO `activity` VALUES (3, '活动3', '和平精英ss8赛季爆热袭来，冲分还能赢QB大礼，快来微视赢取！', '2020-06-03 09:49:29', '2020-07-04 09:49:34');
INSERT INTO `activity` VALUES (4, '活动4', '快手携手和平精英开启SS8全新赛季！勇闯险', '2020-06-02 09:49:52', '2020-06-19 09:49:57');

-- ----------------------------
-- Table structure for commodity
-- ----------------------------
DROP TABLE IF EXISTS `commodity`;
CREATE TABLE `commodity`  (
  `commodity_id` int(11) NOT NULL AUTO_INCREMENT,
  `commodity_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `commodity_price` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`commodity_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of commodity
-- ----------------------------
INSERT INTO `commodity` VALUES (1, 'AKM', 20);
INSERT INTO `commodity` VALUES (2, 'Kar98K', 20);
INSERT INTO `commodity` VALUES (3, 'GROZA', 20);
INSERT INTO `commodity` VALUES (4, 'M416', 20);
INSERT INTO `commodity` VALUES (5, '幻影战神', 30);
INSERT INTO `commodity` VALUES (6, '旷野奇兵', 40);
INSERT INTO `commodity` VALUES (7, '万圣娃娃', 30);
INSERT INTO `commodity` VALUES (8, '快乐主宰', 40);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goods_id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`goods_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (23, 'Kar98K', 6);
INSERT INTO `goods` VALUES (24, 'GROZA', 6);
INSERT INTO `goods` VALUES (25, 'GROZA', 6);
INSERT INTO `goods` VALUES (27, 'GROZA', 6);
INSERT INTO `goods` VALUES (28, 'GROZA', 6);
INSERT INTO `goods` VALUES (29, 'M416', 6);
INSERT INTO `goods` VALUES (37, 'GROZA', 6);
INSERT INTO `goods` VALUES (38, 'AKM', 6);
INSERT INTO `goods` VALUES (39, 'AKM', 6);
INSERT INTO `goods` VALUES (40, 'Kar98K', 9);
INSERT INTO `goods` VALUES (41, 'AKM', 9);
INSERT INTO `goods` VALUES (42, 'GROZA', 9);

-- ----------------------------
-- Table structure for participate_activities
-- ----------------------------
DROP TABLE IF EXISTS `participate_activities`;
CREATE TABLE `participate_activities`  (
  `participate_id` int(11) NOT NULL AUTO_INCREMENT,
  `participate_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `user_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  PRIMARY KEY (`participate_id`) USING BTREE,
  INDEX `activity_id`(`activity_id`) USING BTREE,
  INDEX `user_id0`(`user_id`) USING BTREE,
  CONSTRAINT `activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_id0` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of participate_activities
-- ----------------------------
INSERT INTO `participate_activities` VALUES (4, '2020-06-28 11:40:42', 6, 1);
INSERT INTO `participate_activities` VALUES (5, '2020-06-28 11:40:46', 6, 2);
INSERT INTO `participate_activities` VALUES (6, '2020-06-28 12:12:14', 6, 2);
INSERT INTO `participate_activities` VALUES (7, '2020-06-28 14:53:12', 6, 1);
INSERT INTO `participate_activities` VALUES (8, '2020-06-28 14:53:16', 6, 2);

-- ----------------------------
-- Table structure for purchase_commodity
-- ----------------------------
DROP TABLE IF EXISTS `purchase_commodity`;
CREATE TABLE `purchase_commodity`  (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `user_id` int(11) NOT NULL,
  `commodity_id` int(11) NOT NULL,
  PRIMARY KEY (`purchase_id`) USING BTREE,
  INDEX `commodity_id`(`commodity_id`) USING BTREE,
  INDEX `user_id1`(`user_id`) USING BTREE,
  CONSTRAINT `commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`commodity_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_id1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_commodity
-- ----------------------------
INSERT INTO `purchase_commodity` VALUES (2, '2020-06-28 08:30:34', 6, 4);
INSERT INTO `purchase_commodity` VALUES (3, '2020-06-28 08:30:46', 6, 6);
INSERT INTO `purchase_commodity` VALUES (4, '2020-06-28 13:26:02', 6, 4);
INSERT INTO `purchase_commodity` VALUES (5, '2020-06-28 13:26:05', 6, 2);
INSERT INTO `purchase_commodity` VALUES (6, '2020-06-28 13:26:26', 6, 1);
INSERT INTO `purchase_commodity` VALUES (7, '2020-06-28 13:26:44', 6, 7);
INSERT INTO `purchase_commodity` VALUES (8, '2020-06-28 13:28:44', 6, 8);
INSERT INTO `purchase_commodity` VALUES (9, '2020-06-28 13:30:04', 6, 1);
INSERT INTO `purchase_commodity` VALUES (10, '2020-06-28 13:30:21', 6, 3);
INSERT INTO `purchase_commodity` VALUES (11, '2020-06-28 13:30:24', 6, 1);
INSERT INTO `purchase_commodity` VALUES (12, '2020-06-28 13:31:01', 6, 1);
INSERT INTO `purchase_commodity` VALUES (13, '2020-06-28 14:46:52', 9, 2);
INSERT INTO `purchase_commodity` VALUES (14, '2020-06-28 14:46:55', 9, 1);
INSERT INTO `purchase_commodity` VALUES (15, '2020-06-28 14:46:57', 9, 3);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` int(11) NULL DEFAULT 1000,
  `character_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zone_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `register_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (6, '乔翱', '123456', '1223954783@qq.com', 860, 'QAQqq', '3', '2020-06-27 20:20:34');
INSERT INTO `user` VALUES (7, 'administrator', '123456', '1223954783@qq.com', 1000, 'QAQ', '2', '2020-06-28 09:59:48');
INSERT INTO `user` VALUES (9, 'qa', '123456', '1223954783@qq.com', 940, 'QAQ', '1', '2020-06-28 14:46:39');
INSERT INTO `user` VALUES (10, 'balloon666', '123456', '1223954783@qq.com', 1000, '', '1', '2020-06-28 14:51:32');

SET FOREIGN_KEY_CHECKS = 1;
