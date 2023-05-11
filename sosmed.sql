/*
 Navicat Premium Data Transfer

 Source Server         : mySQL local
 Source Server Type    : MySQL
 Source Server Version : 100121
 Source Host           : localhost:3306
 Source Schema         : sosmed

 Target Server Type    : MySQL
 Target Server Version : 100121
 File Encoding         : 65001

 Date: 11/05/2023 10:14:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `post_id` int NULL DEFAULT NULL,
  `comment` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comments
-- ----------------------------

-- ----------------------------
-- Table structure for followers
-- ----------------------------
DROP TABLE IF EXISTS `followers`;
CREATE TABLE `followers`  (
  `follower_user_id` bigint UNSIGNED NOT NULL,
  `followed_user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE INDEX `followers_follower_user_id_followed_user_id_unique`(`follower_user_id`, `followed_user_id`) USING BTREE,
  INDEX `followers_followed_user_id_foreign`(`followed_user_id`) USING BTREE,
  CONSTRAINT `followers_followed_user_id_foreign` FOREIGN KEY (`followed_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `followers_follower_user_id_foreign` FOREIGN KEY (`follower_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of followers
-- ----------------------------

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`  (
  `like_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `post_id` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`like_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of likes
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2016_06_01_000001_create_oauth_auth_codes_table', 1);
INSERT INTO `migrations` VALUES (4, '2016_06_01_000002_create_oauth_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1);
INSERT INTO `migrations` VALUES (6, '2016_06_01_000004_create_oauth_clients_table', 1);
INSERT INTO `migrations` VALUES (7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1);
INSERT INTO `migrations` VALUES (8, '2023_05_11_020928_create_followers_table', 2);

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int NULL DEFAULT NULL,
  `client_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `scopes` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_access_tokens_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_access_tokens
-- ----------------------------
INSERT INTO `oauth_access_tokens` VALUES ('0d09ac495c422d584b191b52c3f4d00c1af855f87693e3613e2ce08917f6d551da7713049e260847', 4, 1, 'Personal Access Token', '[]', 0, '2023-05-08 23:28:39', '2023-05-08 23:28:39', '2024-05-08 23:28:39');
INSERT INTO `oauth_access_tokens` VALUES ('11f13fad18db9b5f4af21f584fdc171e44fbde115a380cfe96f40251443fee9b7727ddcd32db1403', 1, 1, 'Personal Access Token', '[]', 0, '2023-05-10 12:00:39', '2023-05-10 12:00:39', '2024-05-10 12:00:39');
INSERT INTO `oauth_access_tokens` VALUES ('1e7ead7239601ee15e717a7fbdc3d3f6f40eaa108676feb83f13f0fffa2c45dc3570e80fb10ad2e6', 3, 1, NULL, '[]', 0, '2023-05-08 23:27:33', '2023-05-08 23:27:33', '2024-05-08 23:27:33');
INSERT INTO `oauth_access_tokens` VALUES ('282345a5fb6d6b6425a894d7cb1c678e40e2b5cd2b0ef9b18a93ab69f1485789617c87d60f7a7520', 1, 1, NULL, '[]', 0, '2023-05-08 23:22:22', '2023-05-08 23:22:22', '2024-05-08 23:22:22');
INSERT INTO `oauth_access_tokens` VALUES ('3316b744ec45ad46567ddcdc9d8b9c8c5a60f9975094b047b9d38a5eb3d62c0b8a5e00a42aa6daf8', 2, 1, 'Personal Access Token', '[]', 0, '2023-05-09 02:37:45', '2023-05-09 02:37:45', '2024-05-09 02:37:45');
INSERT INTO `oauth_access_tokens` VALUES ('3e8bf1ba9cd776e03ac1567831a750d3b1e9521763bb8bd74a49f4483d7b9b661a30faca484b9b52', 3, 1, 'Personal Access Token', '[]', 0, '2023-05-11 03:06:31', '2023-05-11 03:06:31', '2024-05-11 03:06:31');
INSERT INTO `oauth_access_tokens` VALUES ('4f8e3e11bca588d1fdd1225f598f4edb043bc6b2784b8663f251d7ec85e24d724c31d6791e5b7c62', 5, 1, 'Personal Access Token', '[]', 0, '2023-05-08 23:30:30', '2023-05-08 23:30:30', '2024-05-08 23:30:30');
INSERT INTO `oauth_access_tokens` VALUES ('606745661d377e83dd0d5caf665609fb7ec8b01dff4abc8e8b5089430b8d77cc346b19b738e70d13', NULL, 1, 'Personal Access Token', '[]', 0, '2023-05-10 23:36:35', '2023-05-10 23:36:35', '2024-05-10 23:36:35');
INSERT INTO `oauth_access_tokens` VALUES ('607e12b3a32cb61d033795b580274ff66b006efd922581af311e990b28f670dc9f7486d400d5d3d2', 2, 1, NULL, '[]', 0, '2023-05-08 23:23:33', '2023-05-08 23:23:33', '2024-05-08 23:23:33');
INSERT INTO `oauth_access_tokens` VALUES ('65a1d1f51da806666c34a0e2d5373f8ca485f89324a94feab869b5d4403e967743f27967a0d5ed3b', 1, 1, 'Personal Access Token', '[]', 0, '2023-05-10 04:20:21', '2023-05-10 04:20:21', '2024-05-10 04:20:21');
INSERT INTO `oauth_access_tokens` VALUES ('bb68472054ef620404b2c580d4398d5f00bdef6a15d4644103ecae14a3f216196cc7674f2c6f8e9e', 1, 1, 'Personal Access Token', '[]', 1, '2023-05-10 10:51:18', '2023-05-10 10:51:18', '2024-05-10 10:51:18');
INSERT INTO `oauth_access_tokens` VALUES ('d5ebed338218d00ea87e8719e35a355b8b261012d410d39008cf9a39e9e7d3d178121d704f88bf1c', 1, 1, 'Personal Access Token', '[]', 0, '2023-05-10 23:40:40', '2023-05-10 23:40:40', '2024-05-10 23:40:40');
INSERT INTO `oauth_access_tokens` VALUES ('f85839471983d530b159bec98c5f86e631de4e9595f9e34d971533abe48c73b0b111013dde3d69cc', 1, 1, 'Personal Access Token', '[]', 0, '2023-05-08 23:41:27', '2023-05-08 23:41:27', '2024-05-08 23:41:27');
INSERT INTO `oauth_access_tokens` VALUES ('fbd6834b658dae44b149399855e03fb463b5bb18b08468257984cfd8c335a1001286835326779171', 1, 1, NULL, '[]', 0, '2023-05-08 23:21:16', '2023-05-08 23:21:16', '2024-05-08 23:21:16');

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `client_id` int NOT NULL,
  `scopes` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_auth_codes
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `redirect` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_clients_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_clients
-- ----------------------------
INSERT INTO `oauth_clients` VALUES (1, NULL, 'Laravel Personal Access Client', 'BebwurBId3Jjs2PBqs8vA0QthQvbFXupm7Jv9bAA', 'http://localhost', 1, 0, 0, '2023-05-08 22:58:46', '2023-05-08 22:58:46');
INSERT INTO `oauth_clients` VALUES (2, NULL, 'Laravel Password Grant Client', 'YyxFASOhWbaBErkqGZaBLKzOAQH7aLRWFLr74YQg', 'http://localhost', 0, 1, 0, '2023-05-08 22:58:46', '2023-05-08 22:58:46');

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_personal_access_clients_client_id_index`(`client_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_personal_access_clients
-- ----------------------------
INSERT INTO `oauth_personal_access_clients` VALUES (1, 1, '2023-05-08 22:58:46', '2023-05-08 22:58:46');

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_refresh_tokens_access_token_id_index`(`access_token_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_refresh_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  INDEX `password_resets_username_index`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `caption` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `likes_count` int NULL DEFAULT NULL,
  `comments_count` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of posts
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `users_username_unique`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'veri', 'ano', '0838383', 'gbr.jpg', '1990-09-09', 'verianoo', '$2y$10$hnKF/GBf5GxBZ9ttO1.CU.cHTuk8JsLQ0JpNeIQsCPWdqq.IhF5Hy', NULL, '2023-05-08 23:41:26', '2023-05-08 23:41:26');
INSERT INTO `users` VALUES (2, 'veri', 'ano', '0838383', 'gbr.jpg', '1990-09-09', 'verianoo2', '$2y$10$eeDTwI.RN.W4eCpePSxCTe6qzGZ/KRcx/fb7JaI5FSCWzT1p4gZFy', NULL, '2023-05-09 02:37:42', '2023-05-09 02:37:42');
INSERT INTO `users` VALUES (3, 'veri', 'ano', '0838383', 'gbr.jpg', '1990-09-09', 'verianoo3', '$2y$10$FSIo4UZfZI2bpE9hzt4pWunBwp/qOBawmwknn/Kvctocb39LghgE.', NULL, '2023-05-11 03:06:31', '2023-05-11 03:06:31');

SET FOREIGN_KEY_CHECKS = 1;
