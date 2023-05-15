/*
 Navicat Premium Data Transfer

 Source Server         : mySQL local2
 Source Server Type    : MySQL
 Source Server Version : 100428
 Source Host           : localhost:3306
 Source Schema         : sosmed

 Target Server Type    : MySQL
 Target Server Version : 100428
 File Encoding         : 65001

 Date: 15/05/2023 17:46:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for followers
-- ----------------------------
DROP TABLE IF EXISTS `followers`;
CREATE TABLE `followers`  (
  `follower_user_id` int NOT NULL,
  `followed_user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE INDEX `followers_follower_user_id_followed_user_id_unique`(`follower_user_id`, `followed_user_id`) USING BTREE,
  INDEX `followers_followed_user_id_foreign`(`followed_user_id`) USING BTREE,
  CONSTRAINT `followers_followed_user_id_foreign` FOREIGN KEY (`followed_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `followers_follower_user_id_foreign` FOREIGN KEY (`follower_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of followers
-- ----------------------------
INSERT INTO `followers` VALUES (1, 1, '2023-05-15 02:34:08', '2023-05-15 02:34:08');
INSERT INTO `followers` VALUES (1, 2, '2023-05-15 10:35:55', '2023-05-15 10:35:55');
INSERT INTO `followers` VALUES (1, 3, '2023-05-15 02:34:36', '2023-05-15 02:34:36');
INSERT INTO `followers` VALUES (5, 1, '2023-05-15 02:25:27', '2023-05-15 02:25:27');

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`  (
  `like_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`like_id`) USING BTREE,
  INDEX `likes_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `likes_post_id_foreign`(`post_id`) USING BTREE,
  CONSTRAINT `likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of likes
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `migrations` VALUES (8, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (9, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (10, '2023_05_15_030145_create_likes_table', 2);
INSERT INTO `migrations` VALUES (11, '2023_05_15_030849_create_comments_table', 3);

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_access_tokens_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_access_tokens
-- ----------------------------
INSERT INTO `oauth_access_tokens` VALUES ('1b651029efc759bfcf7973998d4e25c64a6864310e1d58bcfc09ff5faac54a7633bd60b7a375743b', 1, 7, 'sosmed-api', '[]', 0, '2023-05-14 14:11:53', '2023-05-14 14:11:53', '2024-05-14 14:11:53');
INSERT INTO `oauth_access_tokens` VALUES ('1b87bb202864cb6a6de725bb02d746e4a64b362e693a53b19c173b580cd0f17440dc048c6de8671c', 1, 7, 'sosmed-api', '[]', 1, '2023-05-15 01:46:29', '2023-05-15 01:46:29', '2024-05-15 01:46:29');
INSERT INTO `oauth_access_tokens` VALUES ('278a66ef8e73e5d13cab8220aae61ca0cd0d194536847151f7827c90f00ad66f62808ae8a5475ce6', 2, 3, 'sosmed-api', '[]', 0, '2023-05-14 13:39:13', '2023-05-14 13:39:13', '2024-05-14 13:39:13');
INSERT INTO `oauth_access_tokens` VALUES ('303701f933b81226cc800c4de02b733d8d10528b6d182ebca092428137323eec9331c60cf10c4948', 5, 7, 'sosmed-api', '[]', 0, '2023-05-15 02:24:40', '2023-05-15 02:24:40', '2024-05-15 02:24:40');
INSERT INTO `oauth_access_tokens` VALUES ('380ca6cc9403526e6dd799a19bce4b02b6630fbad62bdb150ab7f0c653131c43cc6ea81302782e66', 1, 7, 'sosmed-api', '[]', 0, '2023-05-15 02:33:45', '2023-05-15 02:33:45', '2024-05-15 02:33:45');
INSERT INTO `oauth_access_tokens` VALUES ('3ad471a6d1ed5017cd1d5d41c4ece6d30e36ae155130fa11d818b64e850673a4fd0e99ecde6fff71', 3, 7, 'sosmed-api', '[]', 0, '2023-05-15 02:30:51', '2023-05-15 02:30:51', '2024-05-15 02:30:51');
INSERT INTO `oauth_access_tokens` VALUES ('4fea6b425d1049ddfe04eaac2bd0e705214e8f981798b8cb84e8f9f3080e19ba63b9ff23850ea431', 6, 7, 'sosmed-api', '[]', 0, '2023-05-15 10:07:18', '2023-05-15 10:07:18', '2024-05-15 10:07:18');
INSERT INTO `oauth_access_tokens` VALUES ('613f6452d52375701008a3041c272787b8f55756673e21bed5d10cc0072b7c34119a7e9ff0c3ae6c', 2, 7, 'sosmed-api', '[]', 0, '2023-05-15 01:01:00', '2023-05-15 01:01:00', '2024-05-15 01:01:00');
INSERT INTO `oauth_access_tokens` VALUES ('7ac13ae101f880688e00fb1add531ca44fb6e45273829c49f2b652e66a1ea0d59e75a55cf8727b03', 1, 7, 'sosmed-api', '[]', 0, '2023-05-15 01:00:20', '2023-05-15 01:00:20', '2024-05-15 01:00:20');
INSERT INTO `oauth_access_tokens` VALUES ('9a5135486907d0d0fdf1c7929a99cf31aa87018a58e9b7c4cf13deb16153caec3a501b2d23eb8a62', 1, 7, 'sosmed-api', '[]', 1, '2023-05-14 15:13:55', '2023-05-14 15:13:55', '2024-05-14 15:13:55');
INSERT INTO `oauth_access_tokens` VALUES ('abaacf389c1e2ec6b81cfba8098a154413635e42f56ef0fc6c22bda2a3628879c6d923632fbce2e5', 3, 7, 'sosmed-api', '[]', 0, '2023-05-15 01:06:20', '2023-05-15 01:06:20', '2024-05-15 01:06:20');
INSERT INTO `oauth_access_tokens` VALUES ('b312e91191535202f7ff0b36c7fc7a63e7870134d150e2946489bcc6d931ab9b9b5243291ed10ebd', 2, 7, 'sosmed-api', '[]', 1, '2023-05-14 13:56:12', '2023-05-14 13:56:12', '2024-05-14 13:56:12');
INSERT INTO `oauth_access_tokens` VALUES ('b60fdde6bde6b9f6b5dc04ee9d64749e0b65c6a3cbb8933db46c3df23c84108e4621be8ec35dca73', 2, 7, 'sosmed-api', '[]', 0, '2023-05-14 15:57:44', '2023-05-14 15:57:44', '2024-05-14 15:57:44');
INSERT INTO `oauth_access_tokens` VALUES ('cbce3ebc4d5dcc25dfe5cabe0e91d4308656629a63815338f6a0e048580138fff73018041c56d2d6', 1, 7, 'sosmed-api', '[]', 1, '2023-05-14 15:04:17', '2023-05-14 15:04:17', '2024-05-14 15:04:17');
INSERT INTO `oauth_access_tokens` VALUES ('cf8d20c8d03134127b87fd2224a69988dc503fef382cb66e547ec7a476fcc57c7ab8a4eaa3effd83', 3, 7, 'sosmed-api', '[]', 0, '2023-05-15 02:07:34', '2023-05-15 02:07:34', '2024-05-15 02:07:34');
INSERT INTO `oauth_access_tokens` VALUES ('d2e1abc327379d664955a0900b4fc8c7a12fdaa257e7d6fba78e3552ac6ae60fff994a8a412ce373', 3, 7, 'sosmed-api', '[]', 0, '2023-05-14 13:53:25', '2023-05-14 13:53:25', '2024-05-14 13:53:25');
INSERT INTO `oauth_access_tokens` VALUES ('d3e74dbbb46b240d26361303651e7efd67943bf2176c7ae2e91273c1b1e197d7cecbd7a812c2e67d', 1, 7, 'sosmed-api', '[]', 1, '2023-05-15 10:09:25', '2023-05-15 10:09:25', '2024-05-15 10:09:25');
INSERT INTO `oauth_access_tokens` VALUES ('d51fe212d58a9a40507d8472a85f6de3124d2b7bf7b4f8b0db56e7eaccd0d96e2d69b593e6bada66', 2, 7, 'sosmed-api', '[]', 1, '2023-05-14 15:07:13', '2023-05-14 15:07:13', '2024-05-14 15:07:13');
INSERT INTO `oauth_access_tokens` VALUES ('e14704e72672d6fa7d15d19d49bb514e5447ff3057450f22bd888dc6a6982f4f170e4a5bfba43c7e', 1, 7, 'sosmed-api', '[]', 0, '2023-05-15 00:43:42', '2023-05-15 00:43:42', '2024-05-15 00:43:42');
INSERT INTO `oauth_access_tokens` VALUES ('ea5452dbdd53b4557d594067308827298e86368a8ae94cbbeddc8f2474ca917262475ef346496419', 3, 7, 'sosmed-api', '[]', 0, '2023-05-15 01:01:18', '2023-05-15 01:01:18', '2024-05-15 01:01:18');
INSERT INTO `oauth_access_tokens` VALUES ('eef9035344982b7393b2ccbc237316d1f96026ad5fd49bb40a0ab70ff62142b3baada3f7010e0aec', 1, 7, 'sosmed-api', '[]', 1, '2023-05-15 01:01:59', '2023-05-15 01:01:59', '2024-05-15 01:01:59');
INSERT INTO `oauth_access_tokens` VALUES ('f8991579428441a5e0ada6191a49fa9d46ab656ec96e88c7b36e01b420b172702dad3b10c88708d7', 4, 7, 'sosmed-api', '[]', 0, '2023-05-15 01:01:32', '2023-05-15 01:01:32', '2024-05-15 01:01:32');

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_auth_codes_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_auth_codes
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_clients_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_clients
-- ----------------------------
INSERT INTO `oauth_clients` VALUES (1, NULL, 'sosmed-api Personal Access Client', 'EVoANbqHUfq6k3z9ozhHnPOlHM3a17wxM0wXi0Q0', NULL, 'http://localhost', 1, 0, 0, '2023-05-12 11:35:08', '2023-05-12 11:35:08');
INSERT INTO `oauth_clients` VALUES (2, NULL, 'sosmed-api Password Grant Client', 'BmS20fIZxfyxh0iCIY9NChnDFfAaNfuh5KkFUt18', 'users', 'http://localhost', 0, 1, 0, '2023-05-12 11:35:08', '2023-05-12 11:35:08');
INSERT INTO `oauth_clients` VALUES (3, NULL, 'sosmed-api Personal Access Client', 's76oIShWs0i851piqXqhUJ9dTxjBNwWPlfT4ttsH', NULL, 'http://localhost', 1, 0, 0, '2023-05-12 11:35:15', '2023-05-12 11:35:15');
INSERT INTO `oauth_clients` VALUES (4, NULL, 'sosmed-api Password Grant Client', 'EZL0WNskoF7CFJBGqFQysYzJpkVKOKMdtnoSziNd', 'users', 'http://localhost', 0, 1, 0, '2023-05-12 11:35:15', '2023-05-12 11:35:15');
INSERT INTO `oauth_clients` VALUES (5, NULL, 'laravel9-passport Personal Access Client', 'U2xQbXQLrVTBrN48iGZo8vAg295qhF16BZ34AbSF', NULL, 'http://localhost', 1, 0, 0, '2023-05-14 13:43:49', '2023-05-14 13:43:49');
INSERT INTO `oauth_clients` VALUES (6, NULL, 'laravel9-passport Password Grant Client', '6W7X7MSHpq9XWr1b4SBYfsPIojt0ZFImgqG16Y06', 'users', 'http://localhost', 0, 1, 0, '2023-05-14 13:43:50', '2023-05-14 13:43:50');
INSERT INTO `oauth_clients` VALUES (7, NULL, 'laravel9-passport Personal Access Client', 'RUzUadoXBh0GjoiELEHU6lahMR8w4MdsfkeBp9Pp', NULL, 'http://localhost', 1, 0, 0, '2023-05-14 13:44:00', '2023-05-14 13:44:00');
INSERT INTO `oauth_clients` VALUES (8, NULL, 'laravel9-passport Password Grant Client', 'cZjXx3W19qySNUZFh1jK9Fez62s8MsZV1iJEkufJ', 'users', 'http://localhost', 0, 1, 0, '2023-05-14 13:44:00', '2023-05-14 13:44:00');

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_personal_access_clients
-- ----------------------------
INSERT INTO `oauth_personal_access_clients` VALUES (1, 1, '2023-05-12 11:35:08', '2023-05-12 11:35:08');
INSERT INTO `oauth_personal_access_clients` VALUES (2, 3, '2023-05-12 11:35:15', '2023-05-12 11:35:15');
INSERT INTO `oauth_personal_access_clients` VALUES (3, 5, '2023-05-14 13:43:50', '2023-05-14 13:43:50');
INSERT INTO `oauth_personal_access_clients` VALUES (4, 7, '2023-05-14 13:44:00', '2023-05-14 13:44:00');

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_refresh_tokens_access_token_id_index`(`access_token_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_refresh_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token`) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type`, `tokenable_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `caption` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `likes_count` int NULL DEFAULT NULL,
  `comments_count` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`post_id`) USING BTREE,
  INDEX `user_id_fk`(`user_id`) USING BTREE,
  CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (1, 1, 'images/dUOauw95SyErssYLMpOtYdTlcl5DCVOCDTfjJABP.jpg', 'ini gambar posingan dari verianoo1', NULL, NULL, '2023-05-15 01:03:50', '2023-05-15 01:03:50');
INSERT INTO `posts` VALUES (2, 3, 'images/sJW9K0LOEmhhfJwfGCyT8bZXD9zskqoxPJxN7vxy.jpg', 'ini gambar posingan dari verianoo3', NULL, NULL, '2023-05-15 01:32:43', '2023-05-15 01:32:43');
INSERT INTO `posts` VALUES (3, 1, 'images/oWa9fAT4Zy17sQMDmTNU9RAUtikcfvL4tOWpwdpH.jpg', 'ini gambar posingan 2 dari verianoo1', NULL, NULL, '2023-05-15 01:47:11', '2023-05-15 01:47:11');
INSERT INTO `posts` VALUES (4, 3, 'images/6Ij2hhUfJe4U6qt4kmNo2JhBBqcZXHNqBvNsqDFL.jpg', 'ini gambar posingan 2 dari verianoo3', NULL, NULL, '2023-05-15 10:32:07', '2023-05-15 10:32:07');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `users_username_unique`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'veri1', 'ano 1', '0838383', 'gbr.jpg', '1990-09-09', 'verianoo1', '$2y$10$qDw3i2Y3VkLUpz7BIutvwOVrjTw9AxmTy4qKydxfIJ.zs8YY.5DQG', NULL, '2023-05-15 01:00:20', '2023-05-15 01:00:20');
INSERT INTO `users` VALUES (2, 'veri2', 'ano 2', '0838383', 'gbr.jpg', '1990-09-09', 'verianoo2', '$2y$10$QcVZlUpzxHWn/DpWJPwceOI8.YB3jkj4d4rcNLTVQZ1BjghPDwNOy', NULL, '2023-05-15 01:01:00', '2023-05-15 01:01:00');
INSERT INTO `users` VALUES (3, 'veri3', 'ano 3', '0838383', 'gbr.jpg', '1990-09-09', 'verianoo3', '$2y$10$TmLymYa4M/M6KnO7qP3Q0eB02nakh7jfHxsl0By1Ks0TFH2hF4/qy', NULL, '2023-05-15 01:01:18', '2023-05-15 01:01:18');
INSERT INTO `users` VALUES (4, 'veri4', 'ano 4', '0838383', 'gbr.jpg', '1990-09-09', 'verianoo4', '$2y$10$Iukr7hQ2gR51oujArGJAD.ITs0OQ0A6J4pqmM6aW1Fj4rGcFM1yoK', NULL, '2023-05-15 01:01:32', '2023-05-15 01:01:32');
INSERT INTO `users` VALUES (5, 'veri5', 'ano 5', '0838383', 'gbr.jpg', '1990-09-09', 'verianoo5', '$2y$10$OtRhz/ayWELIS8IKmxbtq.qcrJe6Xdoh8u/6NLklCXH0R9WZTA1BW', NULL, '2023-05-15 02:24:40', '2023-05-15 02:24:40');
INSERT INTO `users` VALUES (6, 'veri6', 'ano 6', '0838383', 'gbr.jpg', '1990-09-09', 'verianoo6', '$2y$10$D9PW9h1FAZfDXZB1VVrg6.KqoDQmdUp4mlzE2henl8T9Bsf/dfqoe', NULL, '2023-05-15 10:07:15', '2023-05-15 10:07:15');

SET FOREIGN_KEY_CHECKS = 1;
