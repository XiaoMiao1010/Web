/*
 Navicat Premium Data Transfer

 Source Server         : study
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : shopping

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 10/06/2025 00:15:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT 1,
  `tp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of car
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '饮品');
INSERT INTO `category` VALUES (2, '蛋糕');
INSERT INTO `category` VALUES (3, '雪梅娘');
INSERT INTO `category` VALUES (4, '甜甜圈');
INSERT INTO `category` VALUES (5, '泡芙');
INSERT INTO `category` VALUES (6, '布丁');
INSERT INTO `category` VALUES (7, '三明治');
INSERT INTO `category` VALUES (11, 'ss');

-- ----------------------------
-- Table structure for gonggao
-- ----------------------------
DROP TABLE IF EXISTS `gonggao`;
CREATE TABLE `gonggao`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gonggao
-- ----------------------------
INSERT INTO `gonggao` VALUES (3, '这是最新的公告', '这是最新的公告', '2024-12-20 12:00:48');
INSERT INTO `gonggao` VALUES (4, '广告', '牛乳茶限时八折', '2024-12-21 14:56:11');
INSERT INTO `gonggao` VALUES (5, '公告', '牛乳茶限时八折', '2024-12-23 14:00:42');
INSERT INTO `gonggao` VALUES (6, '新公告', '牛乳茶限时七折', '2025-01-07 14:58:44');

-- ----------------------------
-- Table structure for lunbotu
-- ----------------------------
DROP TABLE IF EXISTS `lunbotu`;
CREATE TABLE `lunbotu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lunbotu
-- ----------------------------
INSERT INTO `lunbotu` VALUES (4, '/file/bd122b5b-a74d-4185-a310-0cb5462be6cf_01.jpg', '123');
INSERT INTO `lunbotu` VALUES (7, '/file/76c3890a-0554-43a8-8b27-7b329122c0f1_01.jpg', '123123');
INSERT INTO `lunbotu` VALUES (8, '/file/1db29535-49b5-47ec-8a43-30c1d372ad3d_01.jpg', '123123');
INSERT INTO `lunbotu` VALUES (10, '/file/bc08ef10-ef35-4a4a-862b-142636b9199b_01.jpg', '02');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `quantity` int NOT NULL,
  `totle` decimal(10, 2) NOT NULL,
  `img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` int NOT NULL DEFAULT 1,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ischeck` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (30, 8, '这是', 20.00, 1, 20.00, '/images/register.jpeg', 1, 'asd', 'asd', 'asd', '2024-12-20 15:47:22', '雪梅娘', 1);
INSERT INTO `order` VALUES (31, 3, '芝士抹茶牛乳茶', 18.00, 1, 18.00, '/file/images/1ab327d2-3df7-4274-a2d6-705ea7f93570_.jpg', 1, 'xxxx', '18219264769', 'miaodingqin', '2024-12-21 14:48:16', NULL, 0);
INSERT INTO `order` VALUES (32, 3, '芝士抹茶牛乳茶', 18.00, 1, 18.00, '/file/images/1ab327d2-3df7-4274-a2d6-705ea7f93570_.jpg', 1, 'xxxx', '18219264769', 'miaodingqin', '2024-12-21 14:51:06', NULL, 0);
INSERT INTO `order` VALUES (33, 3, '抹茶奶盖', 22.00, 1, 22.00, '/file/images/a92465eb-c43c-492d-b16c-c2d43866a27f_.jpg', 2, 'xxxx', '18219264769', 'miaodingqin', '2024-12-21 15:02:19', NULL, 0);
INSERT INTO `order` VALUES (34, 3, '芝士抹茶牛乳茶', 18.00, 1, 18.00, '/file/images/1ab327d2-3df7-4274-a2d6-705ea7f93570_.jpg', 1, 'xxxx', '18219264769', 'miaodingqin', '2024-12-23 14:05:15', NULL, 0);
INSERT INTO `order` VALUES (35, 3, '抹茶奶盖', 22.00, 1, 22.00, '/file/images/1578e45e-6c64-4af2-9736-d7219b6519e3_.jpg', 1, 'xxxx', '18219264769', 'miaodingqin', '2024-12-23 14:05:15', NULL, 0);
INSERT INTO `order` VALUES (36, 3, '抹茶奶盖', 22.00, 1, 22.00, '/file/images/96d13706-79b7-4733-970c-6e5cf8d45162_.jpg', 1, 'xxxx', '18219264769', 'miaodingqin', '2025-06-09 23:22:40', '饮品', 1);
INSERT INTO `order` VALUES (37, 3, '芋泥波波牛乳茶', 18.00, 1, 18.00, '/images/饮料1.jpg', 1, 'xxxx', '18219264769', 'miaodingqin1', '2025-06-09 23:23:13', 'cehsi', 1);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` int NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `category_id` int NULL DEFAULT NULL,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `number` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (4, '芋泥波波牛乳茶', 18, '/images/饮料1.jpg', NULL, 'cehsi', 99);
INSERT INTO `product` VALUES (5, '紫薯牛乳热茶', 18, '/images/饮料1.jpg', NULL, 'cehsi', 100);
INSERT INTO `product` VALUES (7, '紫薯牛乳热茶', 18, '/images/饮料1.jpg', NULL, 'cehsi', 100);
INSERT INTO `product` VALUES (15, '抹茶奶盖', 22, '/file/images/96d13706-79b7-4733-970c-6e5cf8d45162_.jpg', 1, '饮品', 99);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (3, 'admin', '1');
INSERT INTO `user` VALUES (4, 'asd', 'asd');
INSERT INTO `user` VALUES (6, 'miao', '1');
INSERT INTO `user` VALUES (7, 'miaodingqin', '111');
INSERT INTO `user` VALUES (8, 'user1', 'pass1');
INSERT INTO `user` VALUES (9, 'user2', 'pass2');
INSERT INTO `user` VALUES (10, 'user3', 'pass3');
INSERT INTO `user` VALUES (11, 'user4', 'pass4');
INSERT INTO `user` VALUES (14, 'admin', 'admin');

SET FOREIGN_KEY_CHECKS = 1;
