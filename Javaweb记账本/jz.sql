/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : jz

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 26/06/2020 08:40:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for home
-- ----------------------------
DROP TABLE IF EXISTS `home`;
CREATE TABLE `home`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` decimal(11, 2) NULL DEFAULT NULL,
  `date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of home
-- ----------------------------
INSERT INTO `home` VALUES (90, '粥', 15.00, '2020-06-13 16:22:39', '好', 'qa');
INSERT INTO `home` VALUES (91, '娱乐', 150.00, '2020-06-13 16:22:49', NULL, 'qa325');
INSERT INTO `home` VALUES (92, '书费', 500.00, '2020-06-13 16:22:57', NULL, 'qa325');
INSERT INTO `home` VALUES (93, '衣服', 400.00, '2020-06-13 16:23:11', NULL, 'qa325');
INSERT INTO `home` VALUES (97, '早饭饭', 50.00, '2020-06-14 21:08:37', 'null', 'qa325');
INSERT INTO `home` VALUES (98, '晚饭', 100.00, '2020-06-14 21:13:02', '麻辣烫', 'qa');
INSERT INTO `home` VALUES (99, '午饭', 500.00, '2020-06-14 22:17:33', '有蒸羊羔、蒸熊掌、蒸鹿尾儿、烧花鸭、烧雏鸡、烧子鹅、卤猪、卤鸭、酱鸡、腊肉、松花小肚儿、晾肉、香肠、什锦苏盘、熏鸡白肚儿、清蒸八宝猪、江米酿鸭子、罐儿野鸡、罐儿鹌鹑、卤什锦、卤子鹅、山鸡、兔脯、菜蟒、银鱼、清蒸哈什蚂。', 'qa');
INSERT INTO `home` VALUES (100, '西游记', 50.00, '2020-06-15 17:14:33', '好看', 'qa');
INSERT INTO `home` VALUES (101, '夜宵', 500.00, '2020-06-15 17:22:04', '城市当中，夜宵跟正餐的选择几乎没有分别，夜宵较晚餐多了一些不容易吃饱的小吃，例如烧烤、糖水（即甜汤）、以及小炒等。因消费比酒吧、迪斯科便宜，故也是成年人把酒谈天，放松心情或观看夜间球赛的另一场合。', 'qa');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `birthday` date NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('hqy520_', '小气鬼', '123456Qa@', '13546051452', 'female', '2020-06-06', '1378446627@qq.com');
INSERT INTO `users` VALUES ('qa', '小乔', '12297804qa', '18234236305', 'male', '2020-04-04', '1223954783@qq.com');
INSERT INTO `users` VALUES ('qa325', '小明', '123456', '13546051134', 'female', '2020-06-11', '2251456282@qq.com');

SET FOREIGN_KEY_CHECKS = 1;
