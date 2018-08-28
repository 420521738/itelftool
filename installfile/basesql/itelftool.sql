/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.240
Source Server Version : 50640
Source Host           : 192.168.1.240:3306
Source Database       : itelftool

Target Server Type    : MYSQL
Target Server Version : 50640
File Encoding         : 65001

Date: 2018-08-28 17:34:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for appconf_appowner
-- ----------------------------
DROP TABLE IF EXISTS `appconf_appowner`;
CREATE TABLE `appconf_appowner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `qq` varchar(100) DEFAULT NULL,
  `weChat` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appconf_appowner
-- ----------------------------
INSERT INTO `appconf_appowner` VALUES ('1', '陈秋飞', '18665608768', '420521738', 'qiufei_');
INSERT INTO `appconf_appowner` VALUES ('2', '冯志伟', '18818818817', '99875245', 'zhiwei_hello');
INSERT INTO `appconf_appowner` VALUES ('3', '温富有', '17716615514', '18818817', 'fuyouwechat');
INSERT INTO `appconf_appowner` VALUES ('4', '徐汝彬', '19919919919', '77658665', 'rubinwechat');

-- ----------------------------
-- Table structure for appconf_product
-- ----------------------------
DROP TABLE IF EXISTS `appconf_product`;
CREATE TABLE `appconf_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `appconf_product_owner_id_e48e3452_fk_appconf_appowner_id` (`owner_id`),
  CONSTRAINT `appconf_product_owner_id_e48e3452_fk_appconf_appowner_id` FOREIGN KEY (`owner_id`) REFERENCES `appconf_appowner` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appconf_product
-- ----------------------------
INSERT INTO `appconf_product` VALUES ('1', '星星打车项目产品线', '星星打车业务所属产品线', '2');
INSERT INTO `appconf_product` VALUES ('2', '金融专驾项目产品线', '金融专驾产品线', '1');

-- ----------------------------
-- Table structure for appconf_project
-- ----------------------------
DROP TABLE IF EXISTS `appconf_project`;
CREATE TABLE `appconf_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `language_type` varchar(30) DEFAULT NULL,
  `app_type` varchar(30) DEFAULT NULL,
  `server_type` varchar(30) DEFAULT NULL,
  `app_arch` varchar(30) DEFAULT NULL,
  `source_type` varchar(255) NOT NULL,
  `source_address` varchar(255) DEFAULT NULL,
  `appPath` varchar(255) DEFAULT NULL,
  `configPath` varchar(255) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `appconf_project_owner_id_65e78373_fk_appconf_appowner_id` (`owner_id`),
  KEY `appconf_project_product_id_15653260_fk_appconf_product_id` (`product_id`),
  CONSTRAINT `appconf_project_owner_id_65e78373_fk_appconf_appowner_id` FOREIGN KEY (`owner_id`) REFERENCES `appconf_appowner` (`id`),
  CONSTRAINT `appconf_project_product_id_15653260_fk_appconf_product_id` FOREIGN KEY (`product_id`) REFERENCES `appconf_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appconf_project
-- ----------------------------
INSERT INTO `appconf_project` VALUES ('1', '星星打车前台项目', '星星打车前台项目', 'Java', 'Frontend', 'Tomcat', 'Spring boot', 'git', 'https://github.com/420521738/font.git', '/home/app/tomcat/front/', '/home/app/tomcat/front/etc/', '3', '1');
INSERT INTO `appconf_project` VALUES ('2', '星星打车后台项目', '星星打车前台项目', 'Java', 'Backend', 'Tomcat', 'Spring boot', 'git', 'https://github.com/420521738/ggg.git', '/home/app/tomcat/back/', '/home/app/tomcat/back/etc/', '3', '1');
INSERT INTO `appconf_project` VALUES ('3', '金融专驾后台项目', '金融专驾后台项目', 'Java', 'Backend', 'Resin', 'Spring boot', 'git', 'https://github.com/420521738/sss.git', '/home/app/tomcat/front/', '/home/app/tomcat/back/etc/', '4', '2');
INSERT INTO `appconf_project` VALUES ('4', '金融专驾前台项目', '金融专驾前台项目', 'Java', 'Frontend', 'Resin', 'Spring boot', '', 'https://github.com/42051738/itesdsdwdlftool.git', '/home/app/tomcat/front/', '/home/app/tomcat/front/etc/', '4', '2');

-- ----------------------------
-- Table structure for appconf_project_serverList
-- ----------------------------
DROP TABLE IF EXISTS `appconf_project_serverList`;
CREATE TABLE `appconf_project_serverList` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appconf_project_serverList_project_id_asset_id_ca23e819_uniq` (`project_id`,`asset_id`),
  KEY `appconf_project_serverList_asset_id_6720ac07_fk_assets_asset_id` (`asset_id`),
  CONSTRAINT `appconf_project_serv_project_id_b834fba8_fk_appconf_p` FOREIGN KEY (`project_id`) REFERENCES `appconf_project` (`id`),
  CONSTRAINT `appconf_project_serverList_asset_id_6720ac07_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appconf_project_serverList
-- ----------------------------
INSERT INTO `appconf_project_serverList` VALUES ('1', '1', '1');
INSERT INTO `appconf_project_serverList` VALUES ('2', '2', '2');
INSERT INTO `appconf_project_serverList` VALUES ('3', '2', '3');
INSERT INTO `appconf_project_serverList` VALUES ('4', '3', '3');
INSERT INTO `appconf_project_serverList` VALUES ('5', '4', '1');
INSERT INTO `appconf_project_serverList` VALUES ('6', '4', '2');

-- ----------------------------
-- Table structure for assets_asset
-- ----------------------------
DROP TABLE IF EXISTS `assets_asset`;
CREATE TABLE `assets_asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_type` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `sn` varchar(128) NOT NULL,
  `management_ip` char(39) DEFAULT NULL,
  `trade_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `price` double DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `memo` longtext,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `business_unit_id` int(11) DEFAULT NULL,
  `contract_id` int(11) DEFAULT NULL,
  `idc_id` int(11) DEFAULT NULL,
  `manufactory_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `sn` (`sn`),
  KEY `assets_asset_admin_id_db237f4a_fk_assets_userprofile_id` (`admin_id`),
  KEY `assets_asset_business_unit_id_24df8681_fk_assets_businessunit_id` (`business_unit_id`),
  KEY `assets_asset_contract_id_2b07c3cb_fk_assets_contract_id` (`contract_id`),
  KEY `assets_asset_idc_id_4e92fc57_fk_assets_idc_id` (`idc_id`),
  KEY `assets_asset_manufactory_id_b2e34a84_fk_assets_manufactory_id` (`manufactory_id`),
  CONSTRAINT `assets_asset_admin_id_db237f4a_fk_assets_userprofile_id` FOREIGN KEY (`admin_id`) REFERENCES `assets_userprofile` (`id`),
  CONSTRAINT `assets_asset_business_unit_id_24df8681_fk_assets_businessunit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `assets_businessunit` (`id`),
  CONSTRAINT `assets_asset_contract_id_2b07c3cb_fk_assets_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `assets_contract` (`id`),
  CONSTRAINT `assets_asset_idc_id_4e92fc57_fk_assets_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `assets_idc` (`id`),
  CONSTRAINT `assets_asset_manufactory_id_b2e34a84_fk_assets_manufactory_id` FOREIGN KEY (`manufactory_id`) REFERENCES `assets_manufactory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_asset
-- ----------------------------
INSERT INTO `assets_asset` VALUES ('1', 'server', 'LinuxServer1', 'VMware-42 3c 7d ba 4a 67 31 72-c2 15 fb 3c 12 86 23 14', null, null, null, null, '0', '', '2018-08-23 11:55:00.314118', '2018-08-28 09:26:57.661330', '1', '1', null, '1', '1');
INSERT INTO `assets_asset` VALUES ('2', 'server', 'LinuxServer2', 'VMware-42 3c a9 44 29 98 c0 8a-10 64 4d a4 f2 2a ce 75', null, null, null, null, '0', '', '2018-08-23 11:56:21.054977', '2018-08-23 11:57:38.031151', '1', '2', null, '2', '1');
INSERT INTO `assets_asset` VALUES ('3', 'server', 'CentosServer1', 'VMware-42 3c c0 dc 45 88 49 19-51 25 99 0a 16 76 94 17', null, null, null, null, '0', '', '2018-08-23 14:06:39.568022', '2018-08-23 15:32:08.998296', '1', '1', null, '1', '1');
INSERT INTO `assets_asset` VALUES ('4', 'server', 'WindowsServer1', '00426-OEM-8992662-00006', null, null, null, null, '0', '', '2018-08-23 14:09:40.264022', '2018-08-23 14:13:08.122570', '1', '1', null, '2', '2');

-- ----------------------------
-- Table structure for assets_asset_tags
-- ----------------------------
DROP TABLE IF EXISTS `assets_asset_tags`;
CREATE TABLE `assets_asset_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_asset_tags_asset_id_tag_id_ff789690_uniq` (`asset_id`,`tag_id`),
  KEY `assets_asset_tags_tag_id_04269c11_fk_assets_tag_id` (`tag_id`),
  CONSTRAINT `assets_asset_tags_asset_id_85d69be9_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`),
  CONSTRAINT `assets_asset_tags_tag_id_04269c11_fk_assets_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `assets_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_asset_tags
-- ----------------------------

-- ----------------------------
-- Table structure for assets_businessunit
-- ----------------------------
DROP TABLE IF EXISTS `assets_businessunit`;
CREATE TABLE `assets_businessunit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `memo` varchar(64) NOT NULL,
  `parent_unit_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `assets_businessunit_parent_unit_id_b9c536a6_fk_assets_bu` (`parent_unit_id`),
  CONSTRAINT `assets_businessunit_parent_unit_id_b9c536a6_fk_assets_bu` FOREIGN KEY (`parent_unit_id`) REFERENCES `assets_businessunit` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_businessunit
-- ----------------------------
INSERT INTO `assets_businessunit` VALUES ('1', '广州租车业务', '', null);
INSERT INTO `assets_businessunit` VALUES ('2', '中山租车业务', '', null);

-- ----------------------------
-- Table structure for assets_cabinet
-- ----------------------------
DROP TABLE IF EXISTS `assets_cabinet`;
CREATE TABLE `assets_cabinet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `desc` varchar(100) NOT NULL,
  `idc_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assets_cabinet_idc_id_e40c724f_fk_assets_idc_id` (`idc_id`),
  CONSTRAINT `assets_cabinet_idc_id_e40c724f_fk_assets_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `assets_idc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_cabinet
-- ----------------------------
INSERT INTO `assets_cabinet` VALUES ('1', 'H-01-01', '广州金山大厦机房1号机柜', '1');
INSERT INTO `assets_cabinet` VALUES ('2', 'ZS-01-01', '中山联通机房1号机柜', '2');
INSERT INTO `assets_cabinet` VALUES ('3', 'H-01-02', '广州金山大厦机房2号机柜', '1');
INSERT INTO `assets_cabinet` VALUES ('4', 'ZS-01-02', '中山联通机房2号机柜', '2');

-- ----------------------------
-- Table structure for assets_cabinet_serverList
-- ----------------------------
DROP TABLE IF EXISTS `assets_cabinet_serverList`;
CREATE TABLE `assets_cabinet_serverList` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cabinet_id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_cabinet_serverList_cabinet_id_asset_id_bd08f8db_uniq` (`cabinet_id`,`asset_id`),
  KEY `assets_cabinet_serverList_asset_id_c14ac302_fk_assets_asset_id` (`asset_id`),
  CONSTRAINT `assets_cabinet_serve_cabinet_id_2bfbe2eb_fk_assets_ca` FOREIGN KEY (`cabinet_id`) REFERENCES `assets_cabinet` (`id`),
  CONSTRAINT `assets_cabinet_serverList_asset_id_c14ac302_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_cabinet_serverList
-- ----------------------------
INSERT INTO `assets_cabinet_serverList` VALUES ('1', '1', '1');
INSERT INTO `assets_cabinet_serverList` VALUES ('2', '1', '2');
INSERT INTO `assets_cabinet_serverList` VALUES ('3', '2', '3');
INSERT INTO `assets_cabinet_serverList` VALUES ('4', '2', '4');

-- ----------------------------
-- Table structure for assets_contract
-- ----------------------------
DROP TABLE IF EXISTS `assets_contract`;
CREATE TABLE `assets_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) NOT NULL,
  `name` varchar(64) NOT NULL,
  `memo` longtext,
  `price` int(11) NOT NULL,
  `detail` longtext,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `license_num` int(11) NOT NULL,
  `create_date` date NOT NULL,
  `update_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn` (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_contract
-- ----------------------------

-- ----------------------------
-- Table structure for assets_cpu
-- ----------------------------
DROP TABLE IF EXISTS `assets_cpu`;
CREATE TABLE `assets_cpu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpu_model` varchar(128) NOT NULL,
  `cpu_count` smallint(6) NOT NULL,
  `cpu_core_count` smallint(6) NOT NULL,
  `memo` longtext,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`),
  CONSTRAINT `assets_cpu_asset_id_6ead6ace_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_cpu
-- ----------------------------
INSERT INTO `assets_cpu` VALUES ('1', 'Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz', '4', '8', null, '2018-08-23 11:57:06.156263', null, '1');
INSERT INTO `assets_cpu` VALUES ('2', 'Intel(R) Xeon(R) CPU E5-2430 v2 @ 2.50GHz', '4', '8', null, '2018-08-23 11:57:38.036693', null, '2');
INSERT INTO `assets_cpu` VALUES ('3', 'Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz', '8', '32', null, '2018-08-23 14:06:57.615998', null, '3');
INSERT INTO `assets_cpu` VALUES ('4', 'Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz', '1', '2', null, '2018-08-23 14:13:08.127295', null, '4');

-- ----------------------------
-- Table structure for assets_disk
-- ----------------------------
DROP TABLE IF EXISTS `assets_disk`;
CREATE TABLE `assets_disk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) DEFAULT NULL,
  `slot` varchar(64) NOT NULL,
  `manufactory` varchar(128) DEFAULT NULL,
  `model` varchar(128) DEFAULT NULL,
  `capacity` double NOT NULL,
  `iface_type` varchar(64) NOT NULL,
  `memo` longtext,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_disk_asset_id_slot_8f76b712_uniq` (`asset_id`,`slot`),
  CONSTRAINT `assets_disk_asset_id_b8cd1d73_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_disk
-- ----------------------------
INSERT INTO `assets_disk` VALUES ('1', 'unknown', 'unknown', 'unknown', 'unknown', '107.4', 'unknown', null, '2018-08-23 11:57:06.159928', null, '1');
INSERT INTO `assets_disk` VALUES ('2', 'unknown', 'unknown', 'unknown', 'unknown', '107.4', 'unknown', null, '2018-08-23 11:57:38.040899', null, '2');
INSERT INTO `assets_disk` VALUES ('3', '           74I3CCQUT', '0', '(标准磁盘驱动器)', 'TOSHIBA MQ01ACF050 SCSI Disk Device', '465.76', 'SCSI', null, '2018-08-23 14:13:08.131308', null, '4');

-- ----------------------------
-- Table structure for assets_eventlog
-- ----------------------------
DROP TABLE IF EXISTS `assets_eventlog`;
CREATE TABLE `assets_eventlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `event_type` smallint(6) NOT NULL,
  `component` varchar(255) DEFAULT NULL,
  `detail` longtext NOT NULL,
  `date` datetime(6) NOT NULL,
  `memo` longtext,
  `asset_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assets_eventlog_asset_id_150968b8_fk_assets_asset_id` (`asset_id`),
  KEY `assets_eventlog_user_id_3e5400a8_fk_assets_userprofile_id` (`user_id`),
  CONSTRAINT `assets_eventlog_asset_id_150968b8_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`),
  CONSTRAINT `assets_eventlog_user_id_3e5400a8_fk_assets_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_eventlog
-- ----------------------------
INSERT INTO `assets_eventlog` VALUES ('1', 'NewComponentAdded', '2', 'RAM', 'Asset[<id:3 name:CentosServer1>] --> component[RAM] has justed added a new item [{\'sn\': \'Not Specified\', \'model\': \'DRAM\', \'slot\': \'RAM slot #0\', \'capacity\': \'8192\', \'asset_id\': 3}]', '2018-08-23 14:07:38.890247', null, '3', '1');
INSERT INTO `assets_eventlog` VALUES ('2', 'HardwareChanges', '1', '3:00:50:56:bc:b9:05', 'Asset[<id:3 name:CentosServer1>] --> component[3:00:50:56:bc:b9:05] --> is lacking from reporting source data, assume it has been removed or replaced,will also delete it from DB', '2018-08-23 14:58:27.637428', null, '3', '1');

-- ----------------------------
-- Table structure for assets_hostgroup
-- ----------------------------
DROP TABLE IF EXISTS `assets_hostgroup`;
CREATE TABLE `assets_hostgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `desc` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_hostgroup
-- ----------------------------
INSERT INTO `assets_hostgroup` VALUES ('1', 'UbuntuGroup', 'ubuntu 操作系统组');
INSERT INTO `assets_hostgroup` VALUES ('2', 'CentosGroup', 'Centos 操作系统组');
INSERT INTO `assets_hostgroup` VALUES ('3', 'WindowsGroup', 'Windows 操作系统组');
INSERT INTO `assets_hostgroup` VALUES ('4', 'LinuxGroup', 'Linux 操作系统组');

-- ----------------------------
-- Table structure for assets_hostgroup_serverList
-- ----------------------------
DROP TABLE IF EXISTS `assets_hostgroup_serverList`;
CREATE TABLE `assets_hostgroup_serverList` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostgroup_id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_hostgroup_serverList_hostgroup_id_asset_id_1d2e82d1_uniq` (`hostgroup_id`,`asset_id`),
  KEY `assets_hostgroup_serverList_asset_id_2fffa9f6_fk_assets_asset_id` (`asset_id`),
  CONSTRAINT `assets_hostgroup_ser_hostgroup_id_10f90d51_fk_assets_ho` FOREIGN KEY (`hostgroup_id`) REFERENCES `assets_hostgroup` (`id`),
  CONSTRAINT `assets_hostgroup_serverList_asset_id_2fffa9f6_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_hostgroup_serverList
-- ----------------------------
INSERT INTO `assets_hostgroup_serverList` VALUES ('1', '1', '1');
INSERT INTO `assets_hostgroup_serverList` VALUES ('2', '1', '2');
INSERT INTO `assets_hostgroup_serverList` VALUES ('3', '2', '3');
INSERT INTO `assets_hostgroup_serverList` VALUES ('4', '3', '4');
INSERT INTO `assets_hostgroup_serverList` VALUES ('5', '4', '1');
INSERT INTO `assets_hostgroup_serverList` VALUES ('6', '4', '2');
INSERT INTO `assets_hostgroup_serverList` VALUES ('7', '4', '3');

-- ----------------------------
-- Table structure for assets_idc
-- ----------------------------
DROP TABLE IF EXISTS `assets_idc`;
CREATE TABLE `assets_idc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ids` varchar(255) NOT NULL,
  `name` varchar(64) NOT NULL,
  `memo` varchar(128) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `contact` varchar(30) DEFAULT NULL,
  `contact_phone` varchar(30) DEFAULT NULL,
  `jigui` varchar(30) DEFAULT NULL,
  `ip_range` varchar(30) DEFAULT NULL,
  `bandwidth` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ids` (`ids`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_idc
-- ----------------------------
INSERT INTO `assets_idc` VALUES ('1', 'GZJS-01', '广州金山大厦机房', null, null, null, null, null, null, null, null);
INSERT INTO `assets_idc` VALUES ('2', 'ZSLT-01', '中山联通机房', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for assets_manufactory
-- ----------------------------
DROP TABLE IF EXISTS `assets_manufactory`;
CREATE TABLE `assets_manufactory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manufactory` varchar(64) NOT NULL,
  `support_num` varchar(30) NOT NULL,
  `memo` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `manufactory` (`manufactory`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_manufactory
-- ----------------------------
INSERT INTO `assets_manufactory` VALUES ('1', 'VMware, Inc.', '', '');
INSERT INTO `assets_manufactory` VALUES ('2', 'LENOVO', '', '');

-- ----------------------------
-- Table structure for assets_networkdevice
-- ----------------------------
DROP TABLE IF EXISTS `assets_networkdevice`;
CREATE TABLE `assets_networkdevice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_asset_type` smallint(6) NOT NULL,
  `vlan_ip` char(39) DEFAULT NULL,
  `intranet_ip` char(39) DEFAULT NULL,
  `model` varchar(128) DEFAULT NULL,
  `port_num` smallint(6) DEFAULT NULL,
  `device_detail` longtext,
  `asset_id` int(11) NOT NULL,
  `firmware_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`),
  KEY `assets_networkdevice_firmware_id_15f668d8_fk_assets_software_id` (`firmware_id`),
  CONSTRAINT `assets_networkdevice_asset_id_23e1a954_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`),
  CONSTRAINT `assets_networkdevice_firmware_id_15f668d8_fk_assets_software_id` FOREIGN KEY (`firmware_id`) REFERENCES `assets_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_networkdevice
-- ----------------------------

-- ----------------------------
-- Table structure for assets_newassetapprovalzone
-- ----------------------------
DROP TABLE IF EXISTS `assets_newassetapprovalzone`;
CREATE TABLE `assets_newassetapprovalzone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) NOT NULL,
  `asset_type` varchar(64) DEFAULT NULL,
  `manufactory` varchar(64) DEFAULT NULL,
  `model` varchar(128) DEFAULT NULL,
  `ram_size` int(11) DEFAULT NULL,
  `cpu_model` varchar(128) DEFAULT NULL,
  `cpu_count` int(11) DEFAULT NULL,
  `cpu_core_count` int(11) DEFAULT NULL,
  `os_distribution` varchar(64) DEFAULT NULL,
  `os_type` varchar(64) DEFAULT NULL,
  `os_release` varchar(64) DEFAULT NULL,
  `data` longtext NOT NULL,
  `date` datetime(6) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `approved_date` datetime(6) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn` (`sn`),
  KEY `assets_newassetappro_approved_by_id_360d43f1_fk_assets_us` (`approved_by_id`),
  CONSTRAINT `assets_newassetappro_approved_by_id_360d43f1_fk_assets_us` FOREIGN KEY (`approved_by_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_newassetapprovalzone
-- ----------------------------

-- ----------------------------
-- Table structure for assets_nic
-- ----------------------------
DROP TABLE IF EXISTS `assets_nic`;
CREATE TABLE `assets_nic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `sn` varchar(128) DEFAULT NULL,
  `model` varchar(128) DEFAULT NULL,
  `macaddress` varchar(64) NOT NULL,
  `ipaddress` char(39) DEFAULT NULL,
  `netmask` varchar(64) DEFAULT NULL,
  `bonding` varchar(64) DEFAULT NULL,
  `memo` varchar(128) DEFAULT NULL,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `macaddress` (`macaddress`),
  UNIQUE KEY `assets_nic_asset_id_macaddress_c408aecf_uniq` (`asset_id`,`macaddress`),
  CONSTRAINT `assets_nic_asset_id_de9d6d3a_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_nic
-- ----------------------------
INSERT INTO `assets_nic` VALUES ('1', 'eth0', null, 'unknown', '00:50:56:bc:c4:83', '192.168.1.234', '255.255.255.0', '0', null, '2018-08-23 11:57:06.163600', null, '1');
INSERT INTO `assets_nic` VALUES ('2', 'eth0', null, 'unknown', '00:50:56:bc:15:22', '192.168.1.235', '255.255.255.0', '0', null, '2018-08-23 11:57:38.045687', null, '2');
INSERT INTO `assets_nic` VALUES ('3', '9', null, '[00000009] Bluetooth 设备(个人区域网)', '28:B2:BD:51:79:A2', null, '', null, null, '2018-08-23 14:13:08.134029', null, '4');
INSERT INTO `assets_nic` VALUES ('4', '11', null, '[00000011] Intel(R) Wireless-N 7260', '28:B2:BD:51:79:9E', null, '', null, null, '2018-08-23 14:13:08.136688', null, '4');
INSERT INTO `assets_nic` VALUES ('5', '12', null, '[00000012] Intel(R) Ethernet Connection I217-LM', '28:D2:44:B4:CA:14', '192.168.7.199', '[\'255.255.255.0\', \'64\']', null, null, '2018-08-23 14:13:08.140458', null, '4');
INSERT INTO `assets_nic` VALUES ('6', '13', null, '[00000013] Fortinet virtual adapter', '00:09:0F:FE:00:01', null, '', null, null, '2018-08-23 14:13:08.143075', null, '4');
INSERT INTO `assets_nic` VALUES ('8', 'eno16777984', null, 'unknown', '00:50:56:bc:b9:05', '192.168.1.240', '255.255.255.0', '0', null, '2018-08-23 15:32:09.005670', '2018-08-23 15:32:11.000000', '3');

-- ----------------------------
-- Table structure for assets_raidadaptor
-- ----------------------------
DROP TABLE IF EXISTS `assets_raidadaptor`;
CREATE TABLE `assets_raidadaptor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) DEFAULT NULL,
  `slot` varchar(64) NOT NULL,
  `model` varchar(64) DEFAULT NULL,
  `memo` longtext,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_raidadaptor_asset_id_slot_1ebcc4e2_uniq` (`asset_id`,`slot`),
  CONSTRAINT `assets_raidadaptor_asset_id_6838cc4e_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_raidadaptor
-- ----------------------------

-- ----------------------------
-- Table structure for assets_ram
-- ----------------------------
DROP TABLE IF EXISTS `assets_ram`;
CREATE TABLE `assets_ram` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) DEFAULT NULL,
  `model` varchar(128) NOT NULL,
  `slot` varchar(64) NOT NULL,
  `capacity` int(11) NOT NULL,
  `memo` varchar(128) DEFAULT NULL,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_ram_asset_id_slot_0336f41b_uniq` (`asset_id`,`slot`),
  CONSTRAINT `assets_ram_asset_id_e5b50d00_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_ram
-- ----------------------------
INSERT INTO `assets_ram` VALUES ('1', 'Not Specified', 'DRAM', 'RAM slot #0', '4096', null, '2018-08-23 11:57:06.166923', null, '1');
INSERT INTO `assets_ram` VALUES ('2', 'Not Specified', 'DRAM', 'RAM slot #0', '4096', null, '2018-08-23 11:57:38.050730', null, '2');
INSERT INTO `assets_ram` VALUES ('3', 'Not Specified', 'DRAM', 'RAM slot #0', '8192', null, '2018-08-23 14:07:38.881621', null, '3');
INSERT INTO `assets_ram` VALUES ('4', '227AF8D0', 'Physical Memory', 'ChannelA-DIMM0', '4096', null, '2018-08-23 14:13:08.145648', null, '4');
INSERT INTO `assets_ram` VALUES ('5', '43731542', 'Physical Memory', 'ChannelB-DIMM0', '4096', null, '2018-08-23 14:13:08.148470', null, '4');

-- ----------------------------
-- Table structure for assets_securitydevice
-- ----------------------------
DROP TABLE IF EXISTS `assets_securitydevice`;
CREATE TABLE `assets_securitydevice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_asset_type` smallint(6) NOT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`),
  CONSTRAINT `assets_securitydevice_asset_id_6ac19ad5_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_securitydevice
-- ----------------------------

-- ----------------------------
-- Table structure for assets_server
-- ----------------------------
DROP TABLE IF EXISTS `assets_server`;
CREATE TABLE `assets_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_asset_type` smallint(6) NOT NULL,
  `created_by` varchar(32) NOT NULL,
  `model` varchar(128) DEFAULT NULL,
  `raid_type` varchar(512) DEFAULT NULL,
  `os_type` varchar(64) DEFAULT NULL,
  `os_distribution` varchar(64) DEFAULT NULL,
  `os_release` varchar(64) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  `hosted_on_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`),
  KEY `assets_server_hosted_on_id_1f2367ea_fk_assets_server_id` (`hosted_on_id`),
  CONSTRAINT `assets_server_asset_id_e68204e6_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`),
  CONSTRAINT `assets_server_hosted_on_id_1f2367ea_fk_assets_server_id` FOREIGN KEY (`hosted_on_id`) REFERENCES `assets_server` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_server
-- ----------------------------
INSERT INTO `assets_server` VALUES ('1', '0', 'auto', 'VMware Virtual Platform', null, 'linux', 'Ubuntu', 'Ubuntu 14.04 LTS', '1', null);
INSERT INTO `assets_server` VALUES ('2', '0', 'auto', 'VMware Virtual Platform', null, 'linux', 'Ubuntu', 'Ubuntu 14.04 LTS', '2', null);
INSERT INTO `assets_server` VALUES ('3', '0', 'auto', 'VMware Virtual Platform', null, 'linux', 'CentOS', 'CentOS Linux release 7.2.1511 (Core)', '3', null);
INSERT INTO `assets_server` VALUES ('4', '0', 'auto', '20ANCTO1WW', null, 'Windows', 'Microsoft', '7 64bit  6.1.7601 ', '4', null);

-- ----------------------------
-- Table structure for assets_software
-- ----------------------------
DROP TABLE IF EXISTS `assets_software`;
CREATE TABLE `assets_software` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_asset_type` smallint(6) NOT NULL,
  `license_num` int(11) NOT NULL,
  `version` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `version` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_software
-- ----------------------------

-- ----------------------------
-- Table structure for assets_tag
-- ----------------------------
DROP TABLE IF EXISTS `assets_tag`;
CREATE TABLE `assets_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `create_date` date NOT NULL,
  `creator_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `assets_tag_creator_id_cc19142e_fk_assets_userprofile_id` (`creator_id`),
  CONSTRAINT `assets_tag_creator_id_cc19142e_fk_assets_userprofile_id` FOREIGN KEY (`creator_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_tag
-- ----------------------------

-- ----------------------------
-- Table structure for assets_userprofile
-- ----------------------------
DROP TABLE IF EXISTS `assets_userprofile`;
CREATE TABLE `assets_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `name` varchar(32) NOT NULL,
  `token` varchar(128) DEFAULT NULL,
  `department` varchar(32) DEFAULT NULL,
  `tel` varchar(32) DEFAULT NULL,
  `mobile` varchar(32) DEFAULT NULL,
  `memo` longtext,
  `date_joined` datetime(6) NOT NULL,
  `valid_begin_time` datetime(6) NOT NULL,
  `valid_end_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_userprofile
-- ----------------------------
INSERT INTO `assets_userprofile` VALUES ('1', 'pbkdf2_sha256$36000$pOI098jq1qdH$TUwHA0IstEpstbI7+QDCyJJyDttbj6OrgiYPsLEiqoc=', '2018-08-28 06:44:04.454470', '0', '420521738@qq.com', '1', '1', '陈秋飞', '420token', null, null, null, '', '2018-08-23 11:38:09.473073', '2018-08-23 11:38:09.000000', null);

-- ----------------------------
-- Table structure for assets_userprofile_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `assets_userprofile_user_permissions`;
CREATE TABLE `assets_userprofile_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_userprofile_user__userprofile_id_permissio_dd788838_uniq` (`userprofile_id`,`permission_id`),
  KEY `assets_userprofile_u_permission_id_251deddc_fk_auth_perm` (`permission_id`),
  CONSTRAINT `assets_userprofile_u_permission_id_251deddc_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `assets_userprofile_u_userprofile_id_baefe188_fk_assets_us` FOREIGN KEY (`userprofile_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assets_userprofile_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add tag', '6', 'add_tag');
INSERT INTO `auth_permission` VALUES ('17', 'Can change tag', '6', 'change_tag');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete tag', '6', 'delete_tag');
INSERT INTO `auth_permission` VALUES ('19', 'Can add 机房', '7', 'add_idc');
INSERT INTO `auth_permission` VALUES ('20', 'Can change 机房', '7', 'change_idc');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete 机房', '7', 'delete_idc');
INSERT INTO `auth_permission` VALUES ('22', 'Can add 网络设备', '8', 'add_networkdevice');
INSERT INTO `auth_permission` VALUES ('23', 'Can change 网络设备', '8', 'change_networkdevice');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete 网络设备', '8', 'delete_networkdevice');
INSERT INTO `auth_permission` VALUES ('25', 'Can add 硬盘', '9', 'add_disk');
INSERT INTO `auth_permission` VALUES ('26', 'Can change 硬盘', '9', 'change_disk');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete 硬盘', '9', 'delete_disk');
INSERT INTO `auth_permission` VALUES ('28', 'Can add 业务线', '10', 'add_businessunit');
INSERT INTO `auth_permission` VALUES ('29', 'Can change 业务线', '10', 'change_businessunit');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete 业务线', '10', 'delete_businessunit');
INSERT INTO `auth_permission` VALUES ('31', 'Can add host group', '11', 'add_hostgroup');
INSERT INTO `auth_permission` VALUES ('32', 'Can change host group', '11', 'change_hostgroup');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete host group', '11', 'delete_hostgroup');
INSERT INTO `auth_permission` VALUES ('34', 'Can add 新上线待批准资产', '12', 'add_newassetapprovalzone');
INSERT INTO `auth_permission` VALUES ('35', 'Can change 新上线待批准资产', '12', 'change_newassetapprovalzone');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete 新上线待批准资产', '12', 'delete_newassetapprovalzone');
INSERT INTO `auth_permission` VALUES ('37', 'Can add cabinet', '13', 'add_cabinet');
INSERT INTO `auth_permission` VALUES ('38', 'Can change cabinet', '13', 'change_cabinet');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete cabinet', '13', 'delete_cabinet');
INSERT INTO `auth_permission` VALUES ('40', 'Can add RAM', '14', 'add_ram');
INSERT INTO `auth_permission` VALUES ('41', 'Can change RAM', '14', 'change_ram');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete RAM', '14', 'delete_ram');
INSERT INTO `auth_permission` VALUES ('43', 'Can add CPU部件', '15', 'add_cpu');
INSERT INTO `auth_permission` VALUES ('44', 'Can change CPU部件', '15', 'change_cpu');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete CPU部件', '15', 'delete_cpu');
INSERT INTO `auth_permission` VALUES ('46', 'Can add 事件纪录', '16', 'add_eventlog');
INSERT INTO `auth_permission` VALUES ('47', 'Can change 事件纪录', '16', 'change_eventlog');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete 事件纪录', '16', 'delete_eventlog');
INSERT INTO `auth_permission` VALUES ('49', 'Can add raid adaptor', '17', 'add_raidadaptor');
INSERT INTO `auth_permission` VALUES ('50', 'Can change raid adaptor', '17', 'change_raidadaptor');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete raid adaptor', '17', 'delete_raidadaptor');
INSERT INTO `auth_permission` VALUES ('52', 'Can add 网卡', '18', 'add_nic');
INSERT INTO `auth_permission` VALUES ('53', 'Can change 网卡', '18', 'change_nic');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete 网卡', '18', 'delete_nic');
INSERT INTO `auth_permission` VALUES ('55', 'Can add 服务器', '19', 'add_server');
INSERT INTO `auth_permission` VALUES ('56', 'Can change 服务器', '19', 'change_server');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete 服务器', '19', 'delete_server');
INSERT INTO `auth_permission` VALUES ('58', 'Can add 厂商', '20', 'add_manufactory');
INSERT INTO `auth_permission` VALUES ('59', 'Can change 厂商', '20', 'change_manufactory');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete 厂商', '20', 'delete_manufactory');
INSERT INTO `auth_permission` VALUES ('61', 'Can add 资产总表', '21', 'add_asset');
INSERT INTO `auth_permission` VALUES ('62', 'Can change 资产总表', '21', 'change_asset');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete 资产总表', '21', 'delete_asset');
INSERT INTO `auth_permission` VALUES ('64', 'Can add security device', '22', 'add_securitydevice');
INSERT INTO `auth_permission` VALUES ('65', 'Can change security device', '22', 'change_securitydevice');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete security device', '22', 'delete_securitydevice');
INSERT INTO `auth_permission` VALUES ('67', 'Can add 软件/系统', '23', 'add_software');
INSERT INTO `auth_permission` VALUES ('68', 'Can change 软件/系统', '23', 'change_software');
INSERT INTO `auth_permission` VALUES ('69', 'Can delete 软件/系统', '23', 'delete_software');
INSERT INTO `auth_permission` VALUES ('70', 'Can add 用户信息', '24', 'add_userprofile');
INSERT INTO `auth_permission` VALUES ('71', 'Can change 用户信息', '24', 'change_userprofile');
INSERT INTO `auth_permission` VALUES ('72', 'Can delete 用户信息', '24', 'delete_userprofile');
INSERT INTO `auth_permission` VALUES ('73', 'Can add 合同', '25', 'add_contract');
INSERT INTO `auth_permission` VALUES ('74', 'Can change 合同', '25', 'change_contract');
INSERT INTO `auth_permission` VALUES ('75', 'Can delete 合同', '25', 'delete_contract');
INSERT INTO `auth_permission` VALUES ('76', 'Can add navi', '26', 'add_navi');
INSERT INTO `auth_permission` VALUES ('77', 'Can change navi', '26', 'change_navi');
INSERT INTO `auth_permission` VALUES ('78', 'Can delete navi', '26', 'delete_navi');
INSERT INTO `auth_permission` VALUES ('79', 'Can add product', '27', 'add_product');
INSERT INTO `auth_permission` VALUES ('80', 'Can change product', '27', 'change_product');
INSERT INTO `auth_permission` VALUES ('81', 'Can delete product', '27', 'delete_product');
INSERT INTO `auth_permission` VALUES ('82', 'Can add project', '28', 'add_project');
INSERT INTO `auth_permission` VALUES ('83', 'Can change project', '28', 'change_project');
INSERT INTO `auth_permission` VALUES ('84', 'Can delete project', '28', 'delete_project');
INSERT INTO `auth_permission` VALUES ('85', 'Can add app owner', '29', 'add_appowner');
INSERT INTO `auth_permission` VALUES ('86', 'Can change app owner', '29', 'change_appowner');
INSERT INTO `auth_permission` VALUES ('87', 'Can delete app owner', '29', 'delete_appowner');
INSERT INTO `auth_permission` VALUES ('88', 'Can add task result', '30', 'add_taskresult');
INSERT INTO `auth_permission` VALUES ('89', 'Can change task result', '30', 'change_taskresult');
INSERT INTO `auth_permission` VALUES ('90', 'Can delete task result', '30', 'delete_taskresult');
INSERT INTO `auth_permission` VALUES ('91', 'Can add crontab', '31', 'add_crontabschedule');
INSERT INTO `auth_permission` VALUES ('92', 'Can change crontab', '31', 'change_crontabschedule');
INSERT INTO `auth_permission` VALUES ('93', 'Can delete crontab', '31', 'delete_crontabschedule');
INSERT INTO `auth_permission` VALUES ('94', 'Can add interval', '32', 'add_intervalschedule');
INSERT INTO `auth_permission` VALUES ('95', 'Can change interval', '32', 'change_intervalschedule');
INSERT INTO `auth_permission` VALUES ('96', 'Can delete interval', '32', 'delete_intervalschedule');
INSERT INTO `auth_permission` VALUES ('97', 'Can add periodic task', '33', 'add_periodictask');
INSERT INTO `auth_permission` VALUES ('98', 'Can change periodic task', '33', 'change_periodictask');
INSERT INTO `auth_permission` VALUES ('99', 'Can delete periodic task', '33', 'delete_periodictask');
INSERT INTO `auth_permission` VALUES ('100', 'Can add periodic tasks', '34', 'add_periodictasks');
INSERT INTO `auth_permission` VALUES ('101', 'Can change periodic tasks', '34', 'change_periodictasks');
INSERT INTO `auth_permission` VALUES ('102', 'Can delete periodic tasks', '34', 'delete_periodictasks');
INSERT INTO `auth_permission` VALUES ('103', 'Can add solar event', '35', 'add_solarschedule');
INSERT INTO `auth_permission` VALUES ('104', 'Can change solar event', '35', 'change_solarschedule');
INSERT INTO `auth_permission` VALUES ('105', 'Can delete solar event', '35', 'delete_solarschedule');
INSERT INTO `auth_permission` VALUES ('106', 'Can add task result', '36', 'add_taskresult');
INSERT INTO `auth_permission` VALUES ('107', 'Can change task result', '36', 'change_taskresult');
INSERT INTO `auth_permission` VALUES ('108', 'Can delete task result', '36', 'delete_taskresult');

-- ----------------------------
-- Table structure for celery_results_taskresult
-- ----------------------------
DROP TABLE IF EXISTS `celery_results_taskresult`;
CREATE TABLE `celery_results_taskresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `content_type` varchar(128) NOT NULL,
  `content_encoding` varchar(64) NOT NULL,
  `result` longtext,
  `date_done` datetime(6) NOT NULL,
  `traceback` longtext,
  `hidden` tinyint(1) NOT NULL,
  `meta` longtext,
  `task_args` longtext,
  `task_kwargs` longtext,
  `task_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `celery_results_taskresult_hidden_e8bf928b` (`hidden`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of celery_results_taskresult
-- ----------------------------
INSERT INTO `celery_results_taskresult` VALUES ('1', '2aace0b8-e61d-48fb-ae11-d328c05c04b5', 'SUCCESS', 'application/json', 'utf-8', '\" 16:27:05 up 36 days,  1:45,  1 user,  load average: 0.00, 0.01, 0.05\\n\"', '2018-08-28 08:28:00.611596', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('2', '2b99a701-f2e9-4453-8326-c7ef5e6c09e8', 'SUCCESS', 'application/json', 'utf-8', '\" 16:29:05 up 36 days,  1:47,  1 user,  load average: 0.02, 0.02, 0.05\\n\"', '2018-08-28 08:30:00.508361', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('3', 'e268755d-8712-4655-8694-9c1002c4c3b5', 'SUCCESS', 'application/json', 'utf-8', '\" 16:31:05 up 36 days,  1:49,  1 user,  load average: 0.00, 0.01, 0.05\\n\"', '2018-08-28 08:32:00.478102', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('4', 'e54335e6-f862-42d9-a0cd-ddb9f435e53b', 'SUCCESS', 'application/json', 'utf-8', '\" 16:33:05 up 36 days,  1:51,  1 user,  load average: 0.00, 0.01, 0.05\\n\"', '2018-08-28 08:34:00.403835', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('5', 'd0f481fb-190a-4185-ad02-404f8351a479', 'SUCCESS', 'application/json', 'utf-8', '\" 16:35:05 up 36 days,  1:53,  1 user,  load average: 0.32, 0.08, 0.07\\n\"', '2018-08-28 08:36:00.424646', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('6', '8a901d98-86df-42e7-808b-0f97b36596c6', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1398103 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620182 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452233218 (452.2 MB)  TX bytes:106643502 (106.6 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:36:00.818515', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('7', 'f5637bb8-7d3d-4624-a91a-75dc07c0c19e', 'SUCCESS', 'application/json', 'utf-8', '\" 16:37:05 up 36 days,  1:55,  1 user,  load average: 0.20, 0.09, 0.07\\n\"', '2018-08-28 08:38:00.439385', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('8', '0051a5bf-8eb6-44e5-98dd-4983caf950ff', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1398208 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620257 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452251758 (452.2 MB)  TX bytes:106658387 (106.6 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:38:00.811077', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('9', '51957df6-5e3a-4577-89f2-15e3c53f5c89', 'SUCCESS', 'application/json', 'utf-8', '\" 16:39:05 up 36 days,  1:57,  1 user,  load average: 0.04, 0.07, 0.06\\n\"', '2018-08-28 08:40:00.262643', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('10', '456c8984-49c1-4355-a061-6e546d4521d4', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1398310 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620332 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452270199 (452.2 MB)  TX bytes:106673222 (106.6 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:40:00.476859', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('11', '072b0eb5-7dbd-44dd-8952-10758339614e', 'SUCCESS', 'application/json', 'utf-8', '\" 16:41:05 up 36 days,  1:59,  1 user,  load average: 0.02, 0.06, 0.05\\n\"', '2018-08-28 08:42:00.461063', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('12', '6516d64f-2c2d-42fd-82a2-d1ed051c57c7', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1398409 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620408 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452288688 (452.2 MB)  TX bytes:106688159 (106.6 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:42:00.987411', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('13', 'cc6390e6-397d-4e92-ac95-22623d43e1cb', 'SUCCESS', 'application/json', 'utf-8', '\" 16:43:05 up 36 days,  2:01,  1 user,  load average: 0.05, 0.07, 0.05\\n\"', '2018-08-28 08:44:00.381169', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('14', '4e5585f7-7f15-4138-b313-8d736451d396', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1398509 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620484 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452306778 (452.3 MB)  TX bytes:106703086 (106.7 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:44:00.755593', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('15', '98fc0510-d23c-4fc2-8e02-42c724ef9b54', 'SUCCESS', 'application/json', 'utf-8', '\" 16:45:05 up 36 days,  2:03,  1 user,  load average: 0.01, 0.04, 0.05\\n\"', '2018-08-28 08:46:00.413671', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('16', 'c661d442-a8df-4fea-9049-faa8d617d75e', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1398617 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620559 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452325260 (452.3 MB)  TX bytes:106718156 (106.7 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:46:00.796668', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('17', '892b836f-829e-4b79-9c4f-edce35572032', 'FAILURE', 'application/json', 'utf-8', '{\"exc_message\": [\"\'PicklingError(\\\"Can\\\\\'t pickle <class \\\\\'sh.ErrorReturnCode_1\\\\\'>: it\\\\\'s not the same object as sh.ErrorReturnCode_1\\\",)\'\", \"\\\"(1, <ExceptionInfo: ErrorReturnCode_1(\'\\\\\\\\n\\\\\\\\n  RAN: /usr/bin/ssh chenqiufei@192.168.1.234  df -h\\\\\\\\n\\\\\\\\n  STDOUT:\\\\\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\\\\\nnone            100M   28K  100M   1% /run/user\\\\\\\\n\\\\\\\\n\\\\\\\\n  STDERR:\\\\\\\\ndf: \\u2018/run/user/112/gvfs\\u2019: Permission denied\\\\\\\\n\',)>, None)\\\"\"], \"exc_type\": \"MaybeEncodingError\", \"exc_module\": \"billiard.pool\"}', '2018-08-28 08:46:35.725209', null, '0', '{\"children\": []}', null, null, '<@task: setup.tasks.command of itelftool at 0x7fb5e1094588>');
INSERT INTO `celery_results_taskresult` VALUES ('18', '3af973ff-55f2-4315-896a-1138782a233c', 'SUCCESS', 'application/json', 'utf-8', '\" 16:47:05 up 36 days,  2:05,  1 user,  load average: 0.01, 0.04, 0.05\\n\"', '2018-08-28 08:48:00.439291', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('19', 'fb1a6395-0d17-4da4-9f2a-c2fe43463f5a', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1398736 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620656 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452348688 (452.3 MB)  TX bytes:106737812 (106.7 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:48:00.781238', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('20', 'af70f5c5-461e-437a-a575-059905330177', 'SUCCESS', 'application/json', 'utf-8', '\" 16:49:05 up 36 days,  2:07,  1 user,  load average: 0.00, 0.03, 0.05\\n\"', '2018-08-28 08:50:00.529552', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('21', '0fd872a9-49a9-4073-a980-f803a8cf43ad', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1398837 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620731 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452366979 (452.3 MB)  TX bytes:106752733 (106.7 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:50:00.927524', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('22', '9308d26e-4f5b-467f-af64-c8c855562cb1', 'SUCCESS', 'application/json', 'utf-8', '\" 16:50:40 up 36 days,  2:08,  1 user,  load average: 0.00, 0.02, 0.05\\n\"', '2018-08-28 08:51:35.643801', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('23', '5ec1c9ab-c2d3-4b14-acc0-d8db94890672', 'SUCCESS', 'application/json', 'utf-8', '\" 16:51:05 up 36 days,  2:09,  1 user,  load average: 0.00, 0.02, 0.05\\n\"', '2018-08-28 08:52:00.415101', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('24', '511ea877-c948-4628-ac0f-ce0916d3ba1f', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1398956 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620830 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452390053 (452.3 MB)  TX bytes:106772067 (106.7 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:52:00.796085', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('25', '6656c369-9c64-48ec-9984-28581ddcfe62', 'SUCCESS', 'application/json', 'utf-8', '\" 16:53:05 up 36 days,  2:11,  1 user,  load average: 0.00, 0.01, 0.05\\n\"', '2018-08-28 08:54:00.462355', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('26', '416da44b-ba55-4718-a4d9-51d4417cd728', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1399057 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620907 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452408020 (452.4 MB)  TX bytes:106787060 (106.7 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:54:00.884531', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('27', '969dde75-b3fd-4448-82c8-31849d7100a9', 'SUCCESS', 'application/json', 'utf-8', '\" 16:55:05 up 36 days,  2:13,  1 user,  load average: 0.00, 0.01, 0.05\\n\"', '2018-08-28 08:56:00.458914', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('28', 'd5c46c35-7afe-4fc2-8c2a-b98699c0c9fd', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1399151 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:620981 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452425674 (452.4 MB)  TX bytes:106801853 (106.8 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:56:00.885338', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('29', 'c833301e-d93e-43a1-b3a4-6142d17b7451', 'SUCCESS', 'application/json', 'utf-8', '\" 16:55:40 up 36 days,  2:13,  1 user,  load average: 0.00, 0.01, 0.05\\n\"', '2018-08-28 08:56:35.627870', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('30', '6a5b48b4-4049-4e44-91c7-8cdd56f76acd', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 16:57:05 up 36 days,  2:15,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 08:58:00.574189', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('31', '3520f7ce-a8df-4849-a038-c2c2caa54759', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1399277 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621082 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452450580 (452.4 MB)  TX bytes:106821504 (106.8 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 08:58:00.933389', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('32', '5cc92351-1bfa-40b3-b480-009b0a1053d1', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 16:59:05 up 36 days,  2:17,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:00:00.430280', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('33', 'd7dd7563-b97e-4d04-b50b-c49bfbb8b3e5', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1399375 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621158 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452468542 (452.4 MB)  TX bytes:106836353 (106.8 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:00:00.796383', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('34', 'a5465eef-79b4-4daf-9ceb-cf14ac35ba19', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'Filesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:01:35.721564', null, '0', '{\"children\": []}', '[]', '{\'name\': \'df -h\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('35', '3e5c0bd7-b3ab-4a07-b47b-03aafdef56e7', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:01:05 up 36 days,  2:19,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:02:00.422481', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('36', 'e9c8e0df-6220-4166-bae8-286d3c183cbd', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1399512 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621255 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452492677 (452.4 MB)  TX bytes:106855879 (106.8 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:02:00.795470', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('37', 'ecfa604d-7059-4b50-bdbf-c9dac4591d4d', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:03:05 up 36 days,  2:21,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:04:00.420002', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('38', '2a4c5c70-02ad-44ca-8251-c3b250d9be2a', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1399621 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621333 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452512067 (452.5 MB)  TX bytes:106870922 (106.8 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:04:00.847101', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('39', 'bde09029-44bc-4e03-b053-51122cdd3f22', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:05:05 up 36 days,  2:23,  1 user,  load average: 0.04, 0.03, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:06:00.500809', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('40', '9336e9b2-3418-4465-896c-496715e958e3', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1399719 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621408 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452530538 (452.5 MB)  TX bytes:106885741 (106.8 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:06:00.808085', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('41', 'c3f3343e-6a55-4036-b369-6a683c5bfdae', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'Filesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:06:35.649845', null, '0', '{\"children\": []}', '[]', '{\'name\': \'df -h\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('42', 'b583db71-b98c-4194-af43-2b08b4540536', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:07:05 up 36 days,  2:25,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:08:00.422877', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('43', '0aed8dd7-8c0c-46b8-926a-5835bac34287', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1399840 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621510 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452554252 (452.5 MB)  TX bytes:106905611 (106.9 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:08:00.787529', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('44', '1ec398d9-ad2f-45ee-a7f3-bc37839d8574', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:09:05 up 36 days,  2:27,  1 user,  load average: 0.02, 0.02, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:10:00.424126', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('45', 'fc166c09-8221-4734-ae3f-c3aa3667794b', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1399940 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621586 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452572981 (452.5 MB)  TX bytes:106920695 (106.9 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:10:00.825717', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('46', '37de56b0-a771-4580-8f13-c5164e574cb0', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'Filesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:11:35.680600', null, '0', '{\"children\": []}', '[]', '{\'name\': \'df -h\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('47', '92976f5c-bf26-4417-8107-fdff9c4cfe53', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:11:05 up 36 days,  2:29,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:12:00.454294', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('48', 'faa3b6db-f953-40d3-bb83-7724a7b0b596', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1400061 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621685 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452596355 (452.5 MB)  TX bytes:106940329 (106.9 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:12:00.853960', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('49', '0ec59429-7b2d-4e99-837a-2887d28a4915', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:13:05 up 36 days,  2:31,  1 user,  load average: 0.05, 0.03, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:14:00.415968', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('50', '69e8ae6c-f808-45df-a753-7eddd728198e', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1400171 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621762 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452615127 (452.6 MB)  TX bytes:106955294 (106.9 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:14:00.817058', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('51', '73f6e931-c875-4f1f-ba01-dbf0474c69a7', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:15:05 up 36 days,  2:33,  1 user,  load average: 0.01, 0.02, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:16:00.444456', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('52', '58dd9162-5527-4b3b-bcf3-4f077fd01586', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1400274 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621836 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452633087 (452.6 MB)  TX bytes:106970035 (106.9 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:16:00.818311', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('53', '3e492e2e-8de7-4122-ab73-9203407bf12b', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'Filesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:16:35.661735', null, '0', '{\"children\": []}', '[]', '{\'name\': \'df -h\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('54', 'b2269b88-234b-4526-b619-53e2d3b7d6bd', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:17:05 up 36 days,  2:35,  1 user,  load average: 0.03, 0.03, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:18:00.245077', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('55', '51718e49-e264-4bd7-9344-2b014d5b75ad', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1400395 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:621935 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452656448 (452.6 MB)  TX bytes:106989693 (106.9 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:18:00.453798', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('56', '6c69d458-d8c9-4781-ae11-323c02f0fcc4', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:19:05 up 36 days,  2:37,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:20:00.421959', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('57', '0303e771-b54d-468c-896c-db4961015b25', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1400502 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:622012 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452675064 (452.6 MB)  TX bytes:107004634 (107.0 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:20:00.816228', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('58', '37bac78e-b4a1-4b0c-9276-e8dcacfd2c40', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'Filesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:21:35.703117', null, '0', '{\"children\": []}', '[]', '{\'name\': \'df -h\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('59', '640a07d9-dd4e-45c3-b725-9cb56358aff4', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:21:05 up 36 days,  2:39,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:22:00.452264', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('60', 'b0803d0e-4312-4b7d-a410-886506619e80', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1400623 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:622112 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452698708 (452.6 MB)  TX bytes:107024581 (107.0 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:22:00.822360', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('61', 'b1fb4d31-8f19-40dd-a85b-8ac249f7d7fa', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:23:05 up 36 days,  2:41,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:24:00.423833', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('62', '2a147dd6-eb09-4d0e-b154-5cac6c064fc2', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1400721 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:622188 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452716758 (452.7 MB)  TX bytes:107039456 (107.0 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:24:00.831714', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('63', 'b7e73732-6003-4281-87a1-cd085fd1c300', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:25:05 up 36 days,  2:43,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:26:00.413339', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('64', '9bde88f0-7241-471d-8eab-9373a9b553f7', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1400814 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:622262 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452734442 (452.7 MB)  TX bytes:107054197 (107.0 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:26:00.772575', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('65', '01555188-51eb-49dd-869a-9a8e8a079924', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'Filesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:26:35.647883', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'df -h\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('66', '1d629c7f-2290-47fb-8d2a-49620f7709a8', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:27:05 up 36 days,  2:45,  1 user,  load average: 0.06, 0.03, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:28:00.419765', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('67', '9271166a-6365-45f6-8237-1ba5123718b7', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1401047 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:622460 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452769172 (452.7 MB)  TX bytes:107091317 (107.0 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:28:00.797073', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('68', 'c5c780ea-6028-4163-b0a8-b12dd8cbf88c', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:29:05 up 36 days,  2:47,  1 user,  load average: 0.01, 0.02, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:30:00.439036', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('69', 'c3bfd2f4-9326-4712-9f09-f44442408007', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1401146 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:622536 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452787049 (452.7 MB)  TX bytes:107106216 (107.1 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:30:00.793151', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('70', '7921199c-03d9-4d01-b206-52ddbab0bd70', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'Filesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:31:35.715894', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'df -h\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('71', 'cad3d2c8-b665-41ea-ac17-a7812065e3d7', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:31:05 up 36 days,  2:49,  1 user,  load average: 0.02, 0.02, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:32:00.421498', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'uptime\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('72', 'e9f8ebda-71f3-40f6-b125-181ba4631d9b', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1401288 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:622635 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452811433 (452.8 MB)  TX bytes:107125874 (107.1 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:32:00.848190', null, '0', '{\"children\": []}', '[]', '{\'name\': \'test1.sh\', \'host\': \'LinuxServer1\'}', 'setup.tasks.script');
INSERT INTO `celery_results_taskresult` VALUES ('73', 'd65b6081-ca38-44ac-9346-3c9476859b44', 'SUCCESS', 'application/json', 'utf-8', '\"(b\' 17:33:05 up 36 days,  2:51,  1 user,  load average: 0.00, 0.01, 0.05\\\\n\', b\'\')\"', '2018-08-28 09:34:00.470676', null, '0', '{\"children\": []}', '[]', '{\'name\': \'uptime\', \'host\': \'LinuxServer1\'}', 'setup.tasks.command');
INSERT INTO `celery_results_taskresult` VALUES ('74', '0d178e77-6eab-44c3-9f05-9f2818918c17', 'SUCCESS', 'application/json', 'utf-8', '\"(b\'eth0      Link encap:Ethernet  HWaddr 00:50:56:bc:c4:83  \\\\n          inet addr:192.168.1.234  Bcast:192.168.1.255  Mask:255.255.255.0\\\\n          inet6 addr: fe80::250:56ff:febc:c483/64 Scope:Link\\\\n          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1\\\\n          RX packets:1401408 errors:0 dropped:304 overruns:0 frame:0\\\\n          TX packets:622716 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:1000 \\\\n          RX bytes:452831685 (452.8 MB)  TX bytes:107141302 (107.1 MB)\\\\n\\\\nlo        Link encap:Local Loopback  \\\\n          inet addr:127.0.0.1  Mask:255.0.0.0\\\\n          inet6 addr: ::1/128 Scope:Host\\\\n          UP LOOPBACK RUNNING  MTU:65536  Metric:1\\\\n          RX packets:44534 errors:0 dropped:0 overruns:0 frame:0\\\\n          TX packets:44534 errors:0 dropped:0 overruns:0 carrier:0\\\\n          collisions:0 txqueuelen:0 \\\\n          RX bytes:221856284 (221.8 MB)  TX bytes:221856284 (221.8 MB)\\\\n\\\\nFilesystem      Size  Used Avail Use% Mounted on\\\\n/dev/sda1        95G  6.9G   83G   8% /\\\\nnone            4.0K     0  4.0K   0% /sys/fs/cgroup\\\\nudev            2.0G  4.0K  2.0G   1% /dev\\\\ntmpfs           394M  1.5M  393M   1% /run\\\\nnone            5.0M     0  5.0M   0% /run/lock\\\\nnone            2.0G  144K  2.0G   1% /run/shm\\\\nnone            100M   28K  100M   1% /run/user\\\\nchenqiufei\\\\n\', b\'df: \\\\xe2\\\\x80\\\\x98/run/user/112/gvfs\\\\xe2\\\\x80\\\\x99: Permission denied\\\\n\')\"', '2018-08-28 09:34:00.857354', null, '0', '{\"children\": []}', '[]', '{\'host\': \'LinuxServer1\', \'name\': \'test1.sh\'}', 'setup.tasks.script');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_assets_userprofile_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_assets_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2018-08-23 11:49:19.067165', '1', '420521738@qq.com', '2', '[{\"changed\": {\"fields\": [\"token\"]}}]', '24', '1');
INSERT INTO `django_admin_log` VALUES ('2', '2018-08-23 11:54:19.762593', '1', '广州租车业务', '1', '[{\"added\": {}}]', '10', '1');
INSERT INTO `django_admin_log` VALUES ('3', '2018-08-23 11:54:55.415182', '1', '广州金山大厦机房', '1', '[{\"added\": {}}]', '7', '1');
INSERT INTO `django_admin_log` VALUES ('4', '2018-08-23 11:55:00.319947', '1', '<id:1 name:LinuxServer1>', '1', '[{\"added\": {}}]', '21', '1');
INSERT INTO `django_admin_log` VALUES ('5', '2018-08-23 11:55:54.477779', '2', '中山租车业务', '1', '[{\"added\": {}}]', '10', '1');
INSERT INTO `django_admin_log` VALUES ('6', '2018-08-23 11:56:17.647514', '2', '中山联通机房', '1', '[{\"added\": {}}]', '7', '1');
INSERT INTO `django_admin_log` VALUES ('7', '2018-08-23 11:56:21.060819', '2', '<id:2 name:LinuxServer2>', '1', '[{\"added\": {}}]', '21', '1');
INSERT INTO `django_admin_log` VALUES ('8', '2018-08-23 14:06:39.575023', '3', '<id:3 name:CentosServer1>', '1', '[{\"added\": {}}]', '21', '1');
INSERT INTO `django_admin_log` VALUES ('9', '2018-08-23 14:09:40.269610', '4', '<id:4 name:WindowsServer1>', '1', '[{\"added\": {}}]', '21', '1');
INSERT INTO `django_admin_log` VALUES ('10', '2018-08-23 14:58:03.396371', '3', '<id:3 name:CentosServer1>', '2', '[{\"added\": {\"name\": \"\\u7f51\\u5361\", \"object\": \"3:00:50:56:bc:b9:05\"}}]', '21', '1');
INSERT INTO `django_admin_log` VALUES ('11', '2018-08-23 15:32:09.008034', '3', '<id:3 name:CentosServer1>', '2', '[{\"added\": {\"name\": \"\\u7f51\\u5361\", \"object\": \"3:00:50:56:bc:b9:05\"}}]', '21', '1');
INSERT INTO `django_admin_log` VALUES ('12', '2018-08-28 09:57:48.769813', '4', 'every 3 minutes', '1', '[{\"added\": {}}]', '32', '1');
INSERT INTO `django_admin_log` VALUES ('13', '2018-08-28 09:58:10.120241', '6', '*/2 * * * * (m/h/d/dM/MY)', '1', '[{\"added\": {}}]', '31', '1');
INSERT INTO `django_admin_log` VALUES ('14', '2018-08-28 09:59:54.166111', '11', 'my_task: */2 * * * * (m/h/d/dM/MY)', '1', '[{\"added\": {}}]', '33', '1');
INSERT INTO `django_admin_log` VALUES ('15', '2018-08-28 10:42:26.319777', '8', '*/2 * * * * (m/h/d/dM/MY)', '1', '[{\"added\": {}}]', '31', '1');
INSERT INTO `django_admin_log` VALUES ('16', '2018-08-28 10:42:57.784975', '13', 'my_task: */2 * * * * (m/h/d/dM/MY)', '1', '[{\"added\": {}}]', '33', '1');
INSERT INTO `django_admin_log` VALUES ('17', '2018-08-28 10:58:44.353191', '13', 'my_task: */2 * * * * (m/h/d/dM/MY)', '3', '', '33', '1');
INSERT INTO `django_admin_log` VALUES ('18', '2018-08-28 10:58:44.358989', '12', 'celery.backend_cleanup: 0 4 * * * (m/h/d/dM/MY)', '3', '', '33', '1');
INSERT INTO `django_admin_log` VALUES ('19', '2018-08-28 10:58:55.247659', '8', '*/2 * * * * (m/h/d/dM/MY)', '3', '', '31', '1');
INSERT INTO `django_admin_log` VALUES ('20', '2018-08-28 10:58:55.252027', '7', '0 4 * * * (m/h/d/dM/MY)', '3', '', '31', '1');
INSERT INTO `django_admin_log` VALUES ('21', '2018-08-28 11:26:37.405352', '1', '*/2 * * * * (m/h/d/dM/MY)', '1', '[{\"added\": {}}]', '31', '1');
INSERT INTO `django_admin_log` VALUES ('22', '2018-08-28 11:40:18.187093', '1', 'celery.backend_cleanup: 0 4 * * * (m/h/d/dM/MY)', '3', '', '33', '1');
INSERT INTO `django_admin_log` VALUES ('23', '2018-08-28 13:49:43.672867', '3', 'my_task: */2 * * * * (m/h/d/dM/MY)', '1', '[{\"added\": {}}]', '33', '1');
INSERT INTO `django_admin_log` VALUES ('24', '2018-08-28 06:25:34.693981', '1', '*/2 * * * * (m/h/d/dM/MY)', '3', '', '31', '1');
INSERT INTO `django_admin_log` VALUES ('25', '2018-08-28 06:25:34.698408', '2', '0 4 * * * (m/h/d/dM/MY)', '3', '', '31', '1');
INSERT INTO `django_admin_log` VALUES ('26', '2018-08-28 06:26:23.151121', '4', '*/2 * * * * (m/h/d/dM/MY)', '1', '[{\"added\": {}}]', '31', '1');
INSERT INTO `django_admin_log` VALUES ('27', '2018-08-28 06:27:26.896807', '5', 'My_command_task: */2 * * * * (m/h/d/dM/MY)', '1', '[{\"added\": {}}]', '33', '1');

-- ----------------------------
-- Table structure for django_celery_beat_crontabschedule
-- ----------------------------
DROP TABLE IF EXISTS `django_celery_beat_crontabschedule`;
CREATE TABLE `django_celery_beat_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(240) NOT NULL,
  `hour` varchar(96) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(124) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_celery_beat_crontabschedule
-- ----------------------------
INSERT INTO `django_celery_beat_crontabschedule` VALUES ('1', '0', '4', '*', '*', '*');
INSERT INTO `django_celery_beat_crontabschedule` VALUES ('2', '*/2', '*', '*', '*', '*');

-- ----------------------------
-- Table structure for django_celery_beat_intervalschedule
-- ----------------------------
DROP TABLE IF EXISTS `django_celery_beat_intervalschedule`;
CREATE TABLE `django_celery_beat_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_celery_beat_intervalschedule
-- ----------------------------
INSERT INTO `django_celery_beat_intervalschedule` VALUES ('1', '5', 'minutes');

-- ----------------------------
-- Table structure for django_celery_beat_periodictask
-- ----------------------------
DROP TABLE IF EXISTS `django_celery_beat_periodictask`;
CREATE TABLE `django_celery_beat_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime(6) DEFAULT NULL,
  `total_run_count` int(10) unsigned NOT NULL,
  `date_changed` datetime(6) NOT NULL,
  `description` longtext NOT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `interval_id` int(11) DEFAULT NULL,
  `solar_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` (`crontab_id`),
  KEY `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` (`interval_id`),
  KEY `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` (`solar_id`),
  CONSTRAINT `django_celery_beat_p_crontab_id_d3cba168_fk_django_ce` FOREIGN KEY (`crontab_id`) REFERENCES `django_celery_beat_crontabschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_interval_id_a8ca27da_fk_django_ce` FOREIGN KEY (`interval_id`) REFERENCES `django_celery_beat_intervalschedule` (`id`),
  CONSTRAINT `django_celery_beat_p_solar_id_a87ce72c_fk_django_ce` FOREIGN KEY (`solar_id`) REFERENCES `django_celery_beat_solarschedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_celery_beat_periodictask
-- ----------------------------
INSERT INTO `django_celery_beat_periodictask` VALUES ('1', 'celery.backend_cleanup', 'celery.backend_cleanup', '[]', '{}', null, null, null, null, '1', null, '0', '2018-08-28 09:00:20.846056', '', '1', null, null);
INSERT INTO `django_celery_beat_periodictask` VALUES ('2', 'command_task', 'setup.tasks.command', '[]', '{\"host\":\"LinuxServer1\",\"name\":\"uptime\"}', null, null, null, '2020-12-12 02:30:00.000000', '1', '2018-08-28 09:32:00.003119', '33', '2018-08-28 09:33:55.268522', '', '2', null, null);
INSERT INTO `django_celery_beat_periodictask` VALUES ('3', 'script_task', 'setup.tasks.script', '[]', '{\"host\":\"LinuxServer1\",\"name\":\"test1.sh\"}', null, null, null, '2020-12-12 02:30:00.000000', '1', '2018-08-28 09:32:00.018525', '29', '2018-08-28 09:33:55.258932', '', '2', null, null);
INSERT INTO `django_celery_beat_periodictask` VALUES ('4', 'command_intervel_task', 'setup.tasks.command', '[]', '{\"host\":\"LinuxServer1\",\"name\":\"df -h\"}', null, null, null, '2020-12-12 02:30:00.000000', '1', '2018-08-28 09:31:35.269173', '10', '2018-08-28 09:33:55.277921', '', null, '1', null);

-- ----------------------------
-- Table structure for django_celery_beat_periodictasks
-- ----------------------------
DROP TABLE IF EXISTS `django_celery_beat_periodictasks`;
CREATE TABLE `django_celery_beat_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_celery_beat_periodictasks
-- ----------------------------
INSERT INTO `django_celery_beat_periodictasks` VALUES ('1', '2018-08-28 09:00:20.842815');

-- ----------------------------
-- Table structure for django_celery_beat_solarschedule
-- ----------------------------
DROP TABLE IF EXISTS `django_celery_beat_solarschedule`;
CREATE TABLE `django_celery_beat_solarschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(24) NOT NULL,
  `latitude` decimal(9,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq` (`event`,`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_celery_beat_solarschedule
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('29', 'appconf', 'appowner');
INSERT INTO `django_content_type` VALUES ('27', 'appconf', 'product');
INSERT INTO `django_content_type` VALUES ('28', 'appconf', 'project');
INSERT INTO `django_content_type` VALUES ('21', 'assets', 'asset');
INSERT INTO `django_content_type` VALUES ('10', 'assets', 'businessunit');
INSERT INTO `django_content_type` VALUES ('13', 'assets', 'cabinet');
INSERT INTO `django_content_type` VALUES ('25', 'assets', 'contract');
INSERT INTO `django_content_type` VALUES ('15', 'assets', 'cpu');
INSERT INTO `django_content_type` VALUES ('9', 'assets', 'disk');
INSERT INTO `django_content_type` VALUES ('16', 'assets', 'eventlog');
INSERT INTO `django_content_type` VALUES ('11', 'assets', 'hostgroup');
INSERT INTO `django_content_type` VALUES ('7', 'assets', 'idc');
INSERT INTO `django_content_type` VALUES ('20', 'assets', 'manufactory');
INSERT INTO `django_content_type` VALUES ('8', 'assets', 'networkdevice');
INSERT INTO `django_content_type` VALUES ('12', 'assets', 'newassetapprovalzone');
INSERT INTO `django_content_type` VALUES ('18', 'assets', 'nic');
INSERT INTO `django_content_type` VALUES ('17', 'assets', 'raidadaptor');
INSERT INTO `django_content_type` VALUES ('14', 'assets', 'ram');
INSERT INTO `django_content_type` VALUES ('22', 'assets', 'securitydevice');
INSERT INTO `django_content_type` VALUES ('19', 'assets', 'server');
INSERT INTO `django_content_type` VALUES ('23', 'assets', 'software');
INSERT INTO `django_content_type` VALUES ('6', 'assets', 'tag');
INSERT INTO `django_content_type` VALUES ('24', 'assets', 'userprofile');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('36', 'celery_results', 'taskresult');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('31', 'django_celery_beat', 'crontabschedule');
INSERT INTO `django_content_type` VALUES ('32', 'django_celery_beat', 'intervalschedule');
INSERT INTO `django_content_type` VALUES ('33', 'django_celery_beat', 'periodictask');
INSERT INTO `django_content_type` VALUES ('34', 'django_celery_beat', 'periodictasks');
INSERT INTO `django_content_type` VALUES ('35', 'django_celery_beat', 'solarschedule');
INSERT INTO `django_content_type` VALUES ('30', 'django_celery_results', 'taskresult');
INSERT INTO `django_content_type` VALUES ('26', 'navi', 'navi');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2018-08-23 11:34:42.374868');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0002_remove_content_type_name', '2018-08-23 11:34:42.455602');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2018-08-23 11:34:42.598756');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0002_alter_permission_name_max_length', '2018-08-23 11:34:42.631725');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0003_alter_user_email_max_length', '2018-08-23 11:34:42.651750');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0004_alter_user_username_opts', '2018-08-23 11:34:42.671399');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0005_alter_user_last_login_null', '2018-08-23 11:34:42.692625');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0006_require_contenttypes_0002', '2018-08-23 11:34:42.697420');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0007_alter_validators_add_error_messages', '2018-08-23 11:34:42.720670');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0008_alter_user_username_max_length', '2018-08-23 11:34:42.741623');
INSERT INTO `django_migrations` VALUES ('11', 'assets', '0001_initial', '2018-08-23 11:34:45.766879');
INSERT INTO `django_migrations` VALUES ('12', 'admin', '0001_initial', '2018-08-23 11:34:45.918448');
INSERT INTO `django_migrations` VALUES ('13', 'admin', '0002_logentry_remove_auto_add', '2018-08-23 11:34:45.966843');
INSERT INTO `django_migrations` VALUES ('14', 'appconf', '0001_initial', '2018-08-23 11:34:46.095329');
INSERT INTO `django_migrations` VALUES ('15', 'appconf', '0002_auto_20180823_1133', '2018-08-23 11:34:46.317234');
INSERT INTO `django_migrations` VALUES ('16', 'navi', '0001_initial', '2018-08-23 11:34:46.344587');
INSERT INTO `django_migrations` VALUES ('17', 'sessions', '0001_initial', '2018-08-23 11:34:46.376975');
INSERT INTO `django_migrations` VALUES ('18', 'appconf', '0003_auto_20180823_1604', '2018-08-23 16:04:20.338188');
INSERT INTO `django_migrations` VALUES ('33', 'celery_results', '0001_initial', '2018-08-28 08:22:39.016646');
INSERT INTO `django_migrations` VALUES ('34', 'celery_results', '0002_add_task_name_args_kwargs', '2018-08-28 08:22:39.104679');
INSERT INTO `django_migrations` VALUES ('35', 'celery_results', '0003_auto_20180828_1622', '2018-08-28 08:22:39.123222');
INSERT INTO `django_migrations` VALUES ('36', 'django_celery_beat', '0001_initial', '2018-08-28 08:22:39.286330');
INSERT INTO `django_migrations` VALUES ('37', 'django_celery_beat', '0002_auto_20161118_0346', '2018-08-28 08:22:39.375722');
INSERT INTO `django_migrations` VALUES ('38', 'django_celery_beat', '0003_auto_20161209_0049', '2018-08-28 08:22:39.421183');
INSERT INTO `django_migrations` VALUES ('39', 'django_celery_beat', '0004_auto_20170221_0000', '2018-08-28 08:22:39.445559');
INSERT INTO `django_migrations` VALUES ('40', 'django_celery_beat', '0005_add_solarschedule_events_choices', '2018-08-28 08:22:39.470930');
INSERT INTO `django_migrations` VALUES ('41', 'django_celery_beat', '0006_auto_20180210_1226', '2018-08-28 08:22:39.576551');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('02taaox51ug25k28n25scey56ebx33jx', 'ODkzODk2M2Y0MmU0OTNkZGRjNWEzNmY4MDhiYTcyYzk5MGNkNzgzNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTIzMTQ5Zjg5OWQ3ZjIyZDU4Zjk4MDhmOThiNWY4ZDQ4MzIwZDM2NCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2018-09-11 11:07:11.812334');
INSERT INTO `django_session` VALUES ('0vzla4t5f02wwclrd4h9ns0tvpm023bf', 'NWQ5Y2M4OWE0YTRmNWRjNDcyMjNlMTdkNzdkN2M2NTk0YjU0Zjk4ODp7Il9zZXNzaW9uX2V4cGlyeSI6MTgwMDAsInZlcmlmeWNvZGUiOiJYM1JEIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI1MjMxNDlmODk5ZDdmMjJkNThmOTgwOGY5OGI1ZjhkNDgzMjBkMzY0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQifQ==', '2018-08-23 16:46:17.270425');
INSERT INTO `django_session` VALUES ('1ubky2cyouzqm078cqlw0jqv5lhz2ylh', 'NGE1YmMzNWM5Zjc3YWI1YzUxNDdlYTdjNzAwNmU5MWNmMGE3Mzc3OTp7InZlcmlmeWNvZGUiOiIxSjlLIiwiX3Nlc3Npb25fZXhwaXJ5IjoxODAwMCwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjUyMzE0OWY4OTlkN2YyMmQ1OGY5ODA4Zjk4YjVmOGQ0ODMyMGQzNjQifQ==', '2018-08-23 22:03:56.803195');
INSERT INTO `django_session` VALUES ('628k4qvffh37lfb9cc9q9hi6mtn6zmmg', 'ODkzODk2M2Y0MmU0OTNkZGRjNWEzNmY4MDhiYTcyYzk5MGNkNzgzNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTIzMTQ5Zjg5OWQ3ZjIyZDU4Zjk4MDhmOThiNWY4ZDQ4MzIwZDM2NCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2018-09-11 14:12:30.348021');
INSERT INTO `django_session` VALUES ('cv165vopuglrafth37id9t7jt5dkg243', 'ZTBkYzIzNzRlMjYyMjdkYzk0MDUzODhjYTFhZGY0ZTc1M2RiM2EyNzp7InZlcmlmeWNvZGUiOiJTQ1lTIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTIzMTQ5Zjg5OWQ3ZjIyZDU4Zjk4MDhmOThiNWY4ZDQ4MzIwZDM2NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfc2Vzc2lvbl9leHBpcnkiOjE4MDAwfQ==', '2018-08-28 11:44:04.460189');
INSERT INTO `django_session` VALUES ('gvd2e3esnsvf71scn9g7tr4o1dd9xjyy', 'ZmQwNjRjYjNkOWY3ODcxYmQ5MWYyYmE1MGUwNzQ5ZTkxZTMyODUwYTp7Il9zZXNzaW9uX2V4cGlyeSI6MTgwMDAsInZlcmlmeWNvZGUiOiJORVpHIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjUyMzE0OWY4OTlkN2YyMmQ1OGY5ODA4Zjk4YjVmOGQ0ODMyMGQzNjQifQ==', '2018-08-24 14:33:22.946164');
INSERT INTO `django_session` VALUES ('im0yz84jrk6b6d3nctufzuc59afwukem', 'NGRmZGQ3N2JkODk5NzcyMDQzMTQ5ZGFjNDNlMTJkNzA1ODU0ZjcwNDp7InZlcmlmeWNvZGUiOiJNU1ZBIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI1MjMxNDlmODk5ZDdmMjJkNThmOTgwOGY5OGI1ZjhkNDgzMjBkMzY0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQifQ==', '2018-09-06 11:48:53.114702');
INSERT INTO `django_session` VALUES ('iv5lagczf8zxfgmnpttq8h1ifc33as0m', 'NjhhZWZiN2M5YTkwNjMxNDE5ZmUyZTczMzAzMjhiZTQ4NjU1MzVlMDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTIzMTQ5Zjg5OWQ3ZjIyZDU4Zjk4MDhmOThiNWY4ZDQ4MzIwZDM2NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=', '2018-09-11 10:41:51.829538');
INSERT INTO `django_session` VALUES ('rauu3l8tsswj7lq19zmwf5ucp984r8ih', 'Njg3MTU5OWMzMjUyYTUwYTVhMGQ0Y2E0YTdkNTg4MDc4MmFjMTBlMjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwidmVyaWZ5Y29kZSI6IkdSVUYiLCJfYXV0aF91c2VyX2hhc2giOiI1MjMxNDlmODk5ZDdmMjJkNThmOTgwOGY5OGI1ZjhkNDgzMjBkMzY0IiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfc2Vzc2lvbl9leHBpcnkiOjE4MDAwfQ==', '2018-08-28 14:43:56.475278');
INSERT INTO `django_session` VALUES ('re4bta2cj8fjxxlt2fnixiqqggvj5dxz', 'YTRiMTI4ZWYzY2YwYmNiMzI1M2NjNmY1N2RhMTRiMDRkMTU3YmJjYTp7Il9hdXRoX3VzZXJfaGFzaCI6IjUyMzE0OWY4OTlkN2YyMmQ1OGY5ODA4Zjk4YjVmOGQ0ODMyMGQzNjQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9zZXNzaW9uX2V4cGlyeSI6MTgwMDAsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwidmVyaWZ5Y29kZSI6IjBQRkcifQ==', '2018-08-27 20:20:53.855068');
INSERT INTO `django_session` VALUES ('vbr71jhbocq65mznc9bqx06oudrban5i', 'YTkyOWUwODM0YjM3OWY2YTc0MjQ4NzZhOWUwOTY0MzBlMzg2ZjgxYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwidmVyaWZ5Y29kZSI6IjdQRkEiLCJfc2Vzc2lvbl9leHBpcnkiOjE4MDAwLCJfYXV0aF91c2VyX2hhc2giOiI1MjMxNDlmODk5ZDdmMjJkNThmOTgwOGY5OGI1ZjhkNDgzMjBkMzY0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQifQ==', '2018-08-27 15:03:49.933574');
INSERT INTO `django_session` VALUES ('xyiz2iwh2qz8tj2z0g7ady4se8wsni89', 'YWVjOTNkZGZhNTBlNzBjYjhiNmM0MzJiYjU0MjRhM2YzOWFhODZkNjp7Il9zZXNzaW9uX2V4cGlyeSI6MTgwMDAsIl9hdXRoX3VzZXJfaGFzaCI6IjUyMzE0OWY4OTlkN2YyMmQ1OGY5ODA4Zjk4YjVmOGQ0ODMyMGQzNjQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsInZlcmlmeWNvZGUiOiI0OFE5IiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==', '2018-08-24 19:33:41.555054');

-- ----------------------------
-- Table structure for navi_navi
-- ----------------------------
DROP TABLE IF EXISTS `navi_navi`;
CREATE TABLE `navi_navi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `url` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of navi_navi
-- ----------------------------
INSERT INTO `navi_navi` VALUES ('1', '星星打车前台', '星星打车首页', 'http://www.xingxingcar.com');
INSERT INTO `navi_navi` VALUES ('2', '星星打车后台', '星星打车后台服务', 'http://crm.xingxingcar.com');
INSERT INTO `navi_navi` VALUES ('3', '金融专驾', '金融专驾首页', 'https://mxjcar.com/');
INSERT INTO `navi_navi` VALUES ('4', '金融专驾后台', '金融专驾后台服务', 'https://hirecar.mxjcar.com');
INSERT INTO `navi_navi` VALUES ('5', 'BI数据分析系统', 'BI数据分析系统后台', 'http://bi.xingxingcar.com/');
