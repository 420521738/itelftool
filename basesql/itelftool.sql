/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.240
Source Server Version : 50640
Source Host           : 192.168.1.240:3306
Source Database       : itelftool

Target Server Type    : MYSQL
Target Server Version : 50640
File Encoding         : 65001

Date: 2018-08-23 16:56:13
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
INSERT INTO `assets_asset` VALUES ('1', 'server', 'LinuxServer1', 'VMware-42 3c 7d ba 4a 67 31 72-c2 15 fb 3c 12 86 23 14', null, null, null, null, '0', '', '2018-08-23 11:55:00.314118', '2018-08-23 11:57:06.151592', '1', '1', null, '1', '1');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
INSERT INTO `assets_userprofile` VALUES ('1', 'pbkdf2_sha256$36000$pOI098jq1qdH$TUwHA0IstEpstbI7+QDCyJJyDttbj6OrgiYPsLEiqoc=', '2018-08-23 11:48:53.109583', '0', '420521738@qq.com', '1', '1', '陈秋飞', '420token', null, null, null, '', '2018-08-23 11:38:09.473073', '2018-08-23 11:38:09.000000', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

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
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

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
INSERT INTO `django_session` VALUES ('0vzla4t5f02wwclrd4h9ns0tvpm023bf', 'NWQ5Y2M4OWE0YTRmNWRjNDcyMjNlMTdkNzdkN2M2NTk0YjU0Zjk4ODp7Il9zZXNzaW9uX2V4cGlyeSI6MTgwMDAsInZlcmlmeWNvZGUiOiJYM1JEIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI1MjMxNDlmODk5ZDdmMjJkNThmOTgwOGY5OGI1ZjhkNDgzMjBkMzY0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQifQ==', '2018-08-23 16:46:17.270425');
INSERT INTO `django_session` VALUES ('im0yz84jrk6b6d3nctufzuc59afwukem', 'NGRmZGQ3N2JkODk5NzcyMDQzMTQ5ZGFjNDNlMTJkNzA1ODU0ZjcwNDp7InZlcmlmeWNvZGUiOiJNU1ZBIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiI1MjMxNDlmODk5ZDdmMjJkNThmOTgwOGY5OGI1ZjhkNDgzMjBkMzY0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQifQ==', '2018-09-06 11:48:53.114702');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of navi_navi
-- ----------------------------
INSERT INTO `navi_navi` VALUES ('1', '星星打车前台', '星星打车首页', 'http://www.xingxingcar.com');
INSERT INTO `navi_navi` VALUES ('2', '星星打车后台', '星星打车后台服务', 'http://crm.xingxingcar.com');
INSERT INTO `navi_navi` VALUES ('3', '金融专驾', '金融专驾首页', 'https://mxjcar.com/');
INSERT INTO `navi_navi` VALUES ('4', '金融专驾后台', '金融专驾后台服务', 'https://hirecar.mxjcar.com');
INSERT INTO `navi_navi` VALUES ('5', 'BI数据分析系统', 'BI数据分析系统后台', 'http://bi.xingxingcar.com/');
