/*
Navicat MySQL Data Transfer

Source Server         : LocalMySQL
Source Server Version : 50640
Source Host           : localhost:3306
Source Database       : itelftool

Target Server Type    : MYSQL
Target Server Version : 50640
File Encoding         : 65001

Date: 2018-08-07 20:14:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for assets_asset
-- ----------------------------
DROP TABLE IF EXISTS `assets_asset`;
CREATE TABLE `assets_asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `sn` varchar(128) COLLATE utf8_bin NOT NULL,
  `management_ip` char(39) COLLATE utf8_bin DEFAULT NULL,
  `trade_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `price` double DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `memo` longtext COLLATE utf8_bin,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_asset
-- ----------------------------
INSERT INTO `assets_asset` VALUES ('1', 'server', 'WindowsServer1', '00426-OEM-8992662-00006', null, null, null, null, '0', '', '2018-08-07 19:54:50.653488', '2018-08-07 19:57:24.292276', '1', '1', null, '1', '1');
INSERT INTO `assets_asset` VALUES ('2', 'server', 'LinuxServer1', 'VMware-42 3c 7d ba 4a 67 31 72-c2 15 fb 3c 12 86 23 14', null, null, null, null, '0', '', '2018-08-07 20:01:03.515814', '2018-08-07 20:01:44.037132', '1', '2', null, '1', '2');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_asset_tags
-- ----------------------------

-- ----------------------------
-- Table structure for assets_businessunit
-- ----------------------------
DROP TABLE IF EXISTS `assets_businessunit`;
CREATE TABLE `assets_businessunit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `memo` varchar(64) COLLATE utf8_bin NOT NULL,
  `parent_unit_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `assets_businessunit_parent_unit_id_b9c536a6_fk_assets_bu` (`parent_unit_id`),
  CONSTRAINT `assets_businessunit_parent_unit_id_b9c536a6_fk_assets_bu` FOREIGN KEY (`parent_unit_id`) REFERENCES `assets_businessunit` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_businessunit
-- ----------------------------
INSERT INTO `assets_businessunit` VALUES ('1', '员工电脑1线', '', null);
INSERT INTO `assets_businessunit` VALUES ('2', '员工电脑2线', '', null);

-- ----------------------------
-- Table structure for assets_contract
-- ----------------------------
DROP TABLE IF EXISTS `assets_contract`;
CREATE TABLE `assets_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) COLLATE utf8_bin NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `memo` longtext COLLATE utf8_bin,
  `price` int(11) NOT NULL,
  `detail` longtext COLLATE utf8_bin,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `license_num` int(11) NOT NULL,
  `create_date` date NOT NULL,
  `update_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn` (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_contract
-- ----------------------------

-- ----------------------------
-- Table structure for assets_cpu
-- ----------------------------
DROP TABLE IF EXISTS `assets_cpu`;
CREATE TABLE `assets_cpu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpu_model` varchar(128) COLLATE utf8_bin NOT NULL,
  `cpu_count` smallint(6) NOT NULL,
  `cpu_core_count` smallint(6) NOT NULL,
  `memo` longtext COLLATE utf8_bin,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`),
  CONSTRAINT `assets_cpu_asset_id_6ead6ace_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_cpu
-- ----------------------------
INSERT INTO `assets_cpu` VALUES ('1', 'Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz', '1', '2', null, '2018-08-07 19:56:43.703954', null, '1');
INSERT INTO `assets_cpu` VALUES ('2', 'Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz', '4', '8', null, '2018-08-07 20:01:09.356148', null, '2');

-- ----------------------------
-- Table structure for assets_disk
-- ----------------------------
DROP TABLE IF EXISTS `assets_disk`;
CREATE TABLE `assets_disk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `slot` varchar(64) COLLATE utf8_bin NOT NULL,
  `manufactory` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `model` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `capacity` double NOT NULL,
  `iface_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `memo` longtext COLLATE utf8_bin,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_disk_asset_id_slot_8f76b712_uniq` (`asset_id`,`slot`),
  CONSTRAINT `assets_disk_asset_id_b8cd1d73_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_disk
-- ----------------------------
INSERT INTO `assets_disk` VALUES ('2', '           74I3CCQUT', '0', '(标准磁盘驱动器)', 'TOSHIBA MQ01ACF050 SCSI Disk Device', '465.76', 'SCSI', null, '2018-08-07 19:57:23.995259', null, '1');
INSERT INTO `assets_disk` VALUES ('3', 'unknown', 'unknown', 'unknown', 'unknown', '107.4', 'unknown', null, '2018-08-07 20:01:09.492156', null, '2');

-- ----------------------------
-- Table structure for assets_eventlog
-- ----------------------------
DROP TABLE IF EXISTS `assets_eventlog`;
CREATE TABLE `assets_eventlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `event_type` smallint(6) NOT NULL,
  `component` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `detail` longtext COLLATE utf8_bin NOT NULL,
  `date` datetime(6) NOT NULL,
  `memo` longtext COLLATE utf8_bin,
  `asset_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assets_eventlog_asset_id_150968b8_fk_assets_asset_id` (`asset_id`),
  KEY `assets_eventlog_user_id_3e5400a8_fk_assets_userprofile_id` (`user_id`),
  CONSTRAINT `assets_eventlog_asset_id_150968b8_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`),
  CONSTRAINT `assets_eventlog_user_id_3e5400a8_fk_assets_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_eventlog
-- ----------------------------
INSERT INTO `assets_eventlog` VALUES ('1', 'HardwareChanges', '1', '1:slot:0 capacity:465.76', 0x41737365745B3C69643A31206E616D653A57696E646F7773536572766572313E5D202D2D3E20636F6D706F6E656E745B313A736C6F743A302063617061636974793A3436352E37365D202D2D3E206973206C61636B696E672066726F6D207265706F7274696E6720736F7572636520646174612C20617373756D6520697420686173206265656E2072656D6F766564206F72207265706C616365642C77696C6C20616C736F2064656C6574652069742066726F6D204442, '2018-08-07 19:57:23.848250', null, '1', '1');
INSERT INTO `assets_eventlog` VALUES ('2', 'NewComponentAdded', '2', 'Disk', 0x41737365745B3C69643A31206E616D653A57696E646F7773536572766572313E5D202D2D3E20636F6D706F6E656E745B4469736B5D20686173206A75737465642061646465642061206E6577206974656D205B7B276361706163697479273A203436352E37362C202761737365745F6964273A20312C20276D6F64656C273A2027544F5348494241204D5130314143463035302053435349204469736B20446576696365272C2027736C6F74273A20302C202769666163655F74797065273A202753435349272C20276D616E75666163746F7279273A202728E6A087E58786E7A381E79B98E9A9B1E58AA8E599A829272C2027736E273A20272020202020202020202020373449334343515554277D5D, '2018-08-07 19:57:24.040261', null, '1', '1');
INSERT INTO `assets_eventlog` VALUES ('3', 'FieldChanged', '1', 'WindowsServer1 sn:00426-OEM-8992662-00006', 0x41737365745B3C69643A31206E616D653A57696E646F7773536572766572313E5D202D2D3E20636F6D706F6E656E745B57696E646F77735365727665723120736E3A30303432362D4F454D2D383939323636322D30303030365D202D2D3E206669656C645B6F735F72656C656173655D20686173206368616E6765642066726F6D205B372036346269742020362E312E37363031205D20746F205B372036346269742020362E312E373630315D, '2018-08-07 19:57:24.384281', null, '1', '1');

-- ----------------------------
-- Table structure for assets_idc
-- ----------------------------
DROP TABLE IF EXISTS `assets_idc`;
CREATE TABLE `assets_idc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `memo` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_idc
-- ----------------------------
INSERT INTO `assets_idc` VALUES ('1', '广州金山大厦机房', null);

-- ----------------------------
-- Table structure for assets_manufactory
-- ----------------------------
DROP TABLE IF EXISTS `assets_manufactory`;
CREATE TABLE `assets_manufactory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manufactory` varchar(64) COLLATE utf8_bin NOT NULL,
  `support_num` varchar(30) COLLATE utf8_bin NOT NULL,
  `memo` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `manufactory` (`manufactory`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_manufactory
-- ----------------------------
INSERT INTO `assets_manufactory` VALUES ('1', 'LENOVO', '', '');
INSERT INTO `assets_manufactory` VALUES ('2', 'VMware, Inc.', '', '');

-- ----------------------------
-- Table structure for assets_networkdevice
-- ----------------------------
DROP TABLE IF EXISTS `assets_networkdevice`;
CREATE TABLE `assets_networkdevice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_asset_type` smallint(6) NOT NULL,
  `vlan_ip` char(39) COLLATE utf8_bin DEFAULT NULL,
  `intranet_ip` char(39) COLLATE utf8_bin DEFAULT NULL,
  `model` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `port_num` smallint(6) DEFAULT NULL,
  `device_detail` longtext COLLATE utf8_bin,
  `asset_id` int(11) NOT NULL,
  `firmware_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`),
  KEY `assets_networkdevice_firmware_id_15f668d8_fk_assets_software_id` (`firmware_id`),
  CONSTRAINT `assets_networkdevice_asset_id_23e1a954_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`),
  CONSTRAINT `assets_networkdevice_firmware_id_15f668d8_fk_assets_software_id` FOREIGN KEY (`firmware_id`) REFERENCES `assets_software` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_networkdevice
-- ----------------------------

-- ----------------------------
-- Table structure for assets_newassetapprovalzone
-- ----------------------------
DROP TABLE IF EXISTS `assets_newassetapprovalzone`;
CREATE TABLE `assets_newassetapprovalzone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) COLLATE utf8_bin NOT NULL,
  `asset_type` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `manufactory` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `model` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `ram_size` int(11) DEFAULT NULL,
  `cpu_model` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `cpu_count` int(11) DEFAULT NULL,
  `cpu_core_count` int(11) DEFAULT NULL,
  `os_distribution` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `os_type` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `os_release` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `data` longtext COLLATE utf8_bin NOT NULL,
  `date` datetime(6) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `approved_date` datetime(6) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn` (`sn`),
  KEY `assets_newassetappro_approved_by_id_360d43f1_fk_assets_us` (`approved_by_id`),
  CONSTRAINT `assets_newassetappro_approved_by_id_360d43f1_fk_assets_us` FOREIGN KEY (`approved_by_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_newassetapprovalzone
-- ----------------------------

-- ----------------------------
-- Table structure for assets_nic
-- ----------------------------
DROP TABLE IF EXISTS `assets_nic`;
CREATE TABLE `assets_nic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `sn` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `model` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `macaddress` varchar(64) COLLATE utf8_bin NOT NULL,
  `ipaddress` char(39) COLLATE utf8_bin DEFAULT NULL,
  `netmask` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `bonding` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `memo` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `macaddress` (`macaddress`),
  UNIQUE KEY `assets_nic_asset_id_macaddress_c408aecf_uniq` (`asset_id`,`macaddress`),
  CONSTRAINT `assets_nic_asset_id_de9d6d3a_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_nic
-- ----------------------------
INSERT INTO `assets_nic` VALUES ('1', '9', null, '[00000009] Bluetooth 设备(个人区域网)', '28:B2:BD:51:79:A2', null, '', null, null, '2018-08-07 19:56:44.043973', null, '1');
INSERT INTO `assets_nic` VALUES ('2', '11', null, '[00000011] Intel(R) Wireless-N 7260', '28:B2:BD:51:79:9E', null, '', null, null, '2018-08-07 19:56:44.199982', null, '1');
INSERT INTO `assets_nic` VALUES ('3', '12', null, '[00000012] Intel(R) Ethernet Connection I217-LM', '28:D2:44:B4:CA:14', '192.168.7.199', '[\'255.255.255.0\', \'64\']', null, null, '2018-08-07 19:56:44.323989', null, '1');
INSERT INTO `assets_nic` VALUES ('4', '13', null, '[00000013] Fortinet virtual adapter', '00:09:0F:FE:00:01', null, '', null, null, '2018-08-07 19:56:44.416995', null, '1');
INSERT INTO `assets_nic` VALUES ('5', 'eth0', null, 'unknown', '00:50:56:bc:c4:83', '192.168.1.234', '255.255.255.0', '0', null, '2018-08-07 20:01:09.611163', null, '2');

-- ----------------------------
-- Table structure for assets_raidadaptor
-- ----------------------------
DROP TABLE IF EXISTS `assets_raidadaptor`;
CREATE TABLE `assets_raidadaptor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `slot` varchar(64) COLLATE utf8_bin NOT NULL,
  `model` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `memo` longtext COLLATE utf8_bin,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_raidadaptor_asset_id_slot_1ebcc4e2_uniq` (`asset_id`,`slot`),
  CONSTRAINT `assets_raidadaptor_asset_id_6838cc4e_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_raidadaptor
-- ----------------------------

-- ----------------------------
-- Table structure for assets_ram
-- ----------------------------
DROP TABLE IF EXISTS `assets_ram`;
CREATE TABLE `assets_ram` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `model` varchar(128) COLLATE utf8_bin NOT NULL,
  `slot` varchar(64) COLLATE utf8_bin NOT NULL,
  `capacity` int(11) NOT NULL,
  `memo` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_ram_asset_id_slot_0336f41b_uniq` (`asset_id`,`slot`),
  CONSTRAINT `assets_ram_asset_id_e5b50d00_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_ram
-- ----------------------------
INSERT INTO `assets_ram` VALUES ('1', '227AF8D0', 'Physical Memory', 'ChannelA-DIMM0', '4096', null, '2018-08-07 19:56:44.454997', null, '1');
INSERT INTO `assets_ram` VALUES ('2', '43731542', 'Physical Memory', 'ChannelB-DIMM0', '4096', null, '2018-08-07 19:56:44.494999', null, '1');
INSERT INTO `assets_ram` VALUES ('3', 'Not Specified', 'DRAM', 'RAM slot #0', '4096', null, '2018-08-07 20:01:09.668166', null, '2');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `created_by` varchar(32) COLLATE utf8_bin NOT NULL,
  `model` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `raid_type` varchar(512) COLLATE utf8_bin DEFAULT NULL,
  `os_type` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `os_distribution` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `os_release` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `asset_id` int(11) NOT NULL,
  `hosted_on_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`),
  KEY `assets_server_hosted_on_id_1f2367ea_fk_assets_server_id` (`hosted_on_id`),
  CONSTRAINT `assets_server_asset_id_e68204e6_fk_assets_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `assets_asset` (`id`),
  CONSTRAINT `assets_server_hosted_on_id_1f2367ea_fk_assets_server_id` FOREIGN KEY (`hosted_on_id`) REFERENCES `assets_server` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_server
-- ----------------------------
INSERT INTO `assets_server` VALUES ('1', '0', 'auto', '20ANCTO1WW', null, 'Windows', 'Microsoft', '7 64bit  6.1.7601', '1', null);
INSERT INTO `assets_server` VALUES ('2', '0', 'auto', 'VMware Virtual Platform', null, 'linux', 'Ubuntu', 'Ubuntu 14.04 LTS', '2', null);

-- ----------------------------
-- Table structure for assets_software
-- ----------------------------
DROP TABLE IF EXISTS `assets_software`;
CREATE TABLE `assets_software` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_asset_type` smallint(6) NOT NULL,
  `license_num` int(11) NOT NULL,
  `version` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `version` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_software
-- ----------------------------

-- ----------------------------
-- Table structure for assets_tag
-- ----------------------------
DROP TABLE IF EXISTS `assets_tag`;
CREATE TABLE `assets_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_bin NOT NULL,
  `create_date` date NOT NULL,
  `creator_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `assets_tag_creator_id_cc19142e_fk_assets_userprofile_id` (`creator_id`),
  CONSTRAINT `assets_tag_creator_id_cc19142e_fk_assets_userprofile_id` FOREIGN KEY (`creator_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_tag
-- ----------------------------

-- ----------------------------
-- Table structure for assets_userprofile
-- ----------------------------
DROP TABLE IF EXISTS `assets_userprofile`;
CREATE TABLE `assets_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_bin NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `name` varchar(32) COLLATE utf8_bin NOT NULL,
  `token` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `department` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `tel` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `mobile` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `memo` longtext COLLATE utf8_bin,
  `date_joined` datetime(6) NOT NULL,
  `valid_begin_time` datetime(6) NOT NULL,
  `valid_end_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_userprofile
-- ----------------------------
INSERT INTO `assets_userprofile` VALUES ('1', 'pbkdf2_sha256$36000$qjJVaSudZE3E$LYjaYuhFNtEF6zmBEIB0su6uwePEv6GLhtFaXK/H3mY=', '2018-08-07 20:02:14.246860', '0', '420521738@qq.com', '1', '1', '陈秋飞', '420token', null, null, null, '', '2018-08-07 19:47:22.153835', '2018-08-07 19:47:22.000000', null);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of assets_userprofile_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
INSERT INTO `auth_permission` VALUES ('16', 'Can add 网卡', '6', 'add_nic');
INSERT INTO `auth_permission` VALUES ('17', 'Can change 网卡', '6', 'change_nic');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete 网卡', '6', 'delete_nic');
INSERT INTO `auth_permission` VALUES ('19', 'Can add security device', '7', 'add_securitydevice');
INSERT INTO `auth_permission` VALUES ('20', 'Can change security device', '7', 'change_securitydevice');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete security device', '7', 'delete_securitydevice');
INSERT INTO `auth_permission` VALUES ('22', 'Can add 硬盘', '8', 'add_disk');
INSERT INTO `auth_permission` VALUES ('23', 'Can change 硬盘', '8', 'change_disk');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete 硬盘', '8', 'delete_disk');
INSERT INTO `auth_permission` VALUES ('25', 'Can add raid adaptor', '9', 'add_raidadaptor');
INSERT INTO `auth_permission` VALUES ('26', 'Can change raid adaptor', '9', 'change_raidadaptor');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete raid adaptor', '9', 'delete_raidadaptor');
INSERT INTO `auth_permission` VALUES ('28', 'Can add 事件纪录', '10', 'add_eventlog');
INSERT INTO `auth_permission` VALUES ('29', 'Can change 事件纪录', '10', 'change_eventlog');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete 事件纪录', '10', 'delete_eventlog');
INSERT INTO `auth_permission` VALUES ('31', 'Can add tag', '11', 'add_tag');
INSERT INTO `auth_permission` VALUES ('32', 'Can change tag', '11', 'change_tag');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete tag', '11', 'delete_tag');
INSERT INTO `auth_permission` VALUES ('34', 'Can add 网络设备', '12', 'add_networkdevice');
INSERT INTO `auth_permission` VALUES ('35', 'Can change 网络设备', '12', 'change_networkdevice');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete 网络设备', '12', 'delete_networkdevice');
INSERT INTO `auth_permission` VALUES ('37', 'Can add 合同', '13', 'add_contract');
INSERT INTO `auth_permission` VALUES ('38', 'Can change 合同', '13', 'change_contract');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete 合同', '13', 'delete_contract');
INSERT INTO `auth_permission` VALUES ('40', 'Can add CPU部件', '14', 'add_cpu');
INSERT INTO `auth_permission` VALUES ('41', 'Can change CPU部件', '14', 'change_cpu');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete CPU部件', '14', 'delete_cpu');
INSERT INTO `auth_permission` VALUES ('43', 'Can add 软件/系统', '15', 'add_software');
INSERT INTO `auth_permission` VALUES ('44', 'Can change 软件/系统', '15', 'change_software');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete 软件/系统', '15', 'delete_software');
INSERT INTO `auth_permission` VALUES ('46', 'Can add 新上线待批准资产', '16', 'add_newassetapprovalzone');
INSERT INTO `auth_permission` VALUES ('47', 'Can change 新上线待批准资产', '16', 'change_newassetapprovalzone');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete 新上线待批准资产', '16', 'delete_newassetapprovalzone');
INSERT INTO `auth_permission` VALUES ('49', 'Can add 机房', '17', 'add_idc');
INSERT INTO `auth_permission` VALUES ('50', 'Can change 机房', '17', 'change_idc');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete 机房', '17', 'delete_idc');
INSERT INTO `auth_permission` VALUES ('52', 'Can add 用户信息', '18', 'add_userprofile');
INSERT INTO `auth_permission` VALUES ('53', 'Can change 用户信息', '18', 'change_userprofile');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete 用户信息', '18', 'delete_userprofile');
INSERT INTO `auth_permission` VALUES ('55', 'Can add 厂商', '19', 'add_manufactory');
INSERT INTO `auth_permission` VALUES ('56', 'Can change 厂商', '19', 'change_manufactory');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete 厂商', '19', 'delete_manufactory');
INSERT INTO `auth_permission` VALUES ('58', 'Can add 服务器', '20', 'add_server');
INSERT INTO `auth_permission` VALUES ('59', 'Can change 服务器', '20', 'change_server');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete 服务器', '20', 'delete_server');
INSERT INTO `auth_permission` VALUES ('61', 'Can add 资产总表', '21', 'add_asset');
INSERT INTO `auth_permission` VALUES ('62', 'Can change 资产总表', '21', 'change_asset');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete 资产总表', '21', 'delete_asset');
INSERT INTO `auth_permission` VALUES ('64', 'Can add RAM', '22', 'add_ram');
INSERT INTO `auth_permission` VALUES ('65', 'Can change RAM', '22', 'change_ram');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete RAM', '22', 'delete_ram');
INSERT INTO `auth_permission` VALUES ('67', 'Can add 业务线', '23', 'add_businessunit');
INSERT INTO `auth_permission` VALUES ('68', 'Can change 业务线', '23', 'change_businessunit');
INSERT INTO `auth_permission` VALUES ('69', 'Can delete 业务线', '23', 'delete_businessunit');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8_bin,
  `object_repr` varchar(200) COLLATE utf8_bin NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_assets_userprofile_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_assets_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2018-08-07 19:53:17.626167', 0x31, '420521738@qq.com', '2', 0x5B7B226368616E676564223A207B226669656C6473223A205B22746F6B656E225D7D7D5D, '18', '1');
INSERT INTO `django_admin_log` VALUES ('2', '2018-08-07 19:54:10.217175', 0x31, '广州金山大厦机房', '1', 0x5B7B226164646564223A207B7D7D5D, '17', '1');
INSERT INTO `django_admin_log` VALUES ('3', '2018-08-07 19:54:36.107656', 0x31, '员工电脑', '1', 0x5B7B226164646564223A207B7D7D5D, '23', '1');
INSERT INTO `django_admin_log` VALUES ('4', '2018-08-07 19:54:46.305239', 0x31, '员工电脑1线', '2', 0x5B7B226368616E676564223A207B226669656C6473223A205B226E616D65225D7D7D5D, '23', '1');
INSERT INTO `django_admin_log` VALUES ('5', '2018-08-07 19:54:50.655488', 0x31, '<id:1 name:WindowsServer1>', '1', 0x5B7B226164646564223A207B7D7D5D, '21', '1');
INSERT INTO `django_admin_log` VALUES ('6', '2018-08-07 20:00:56.483412', 0x32, '员工电脑2线', '1', 0x5B7B226164646564223A207B7D7D5D, '23', '1');
INSERT INTO `django_admin_log` VALUES ('7', '2018-08-07 20:01:03.518815', 0x32, '<id:2 name:LinuxServer1>', '1', 0x5B7B226164646564223A207B7D7D5D, '21', '1');

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8_bin NOT NULL,
  `model` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('21', 'assets', 'asset');
INSERT INTO `django_content_type` VALUES ('23', 'assets', 'businessunit');
INSERT INTO `django_content_type` VALUES ('13', 'assets', 'contract');
INSERT INTO `django_content_type` VALUES ('14', 'assets', 'cpu');
INSERT INTO `django_content_type` VALUES ('8', 'assets', 'disk');
INSERT INTO `django_content_type` VALUES ('10', 'assets', 'eventlog');
INSERT INTO `django_content_type` VALUES ('17', 'assets', 'idc');
INSERT INTO `django_content_type` VALUES ('19', 'assets', 'manufactory');
INSERT INTO `django_content_type` VALUES ('12', 'assets', 'networkdevice');
INSERT INTO `django_content_type` VALUES ('16', 'assets', 'newassetapprovalzone');
INSERT INTO `django_content_type` VALUES ('6', 'assets', 'nic');
INSERT INTO `django_content_type` VALUES ('9', 'assets', 'raidadaptor');
INSERT INTO `django_content_type` VALUES ('22', 'assets', 'ram');
INSERT INTO `django_content_type` VALUES ('7', 'assets', 'securitydevice');
INSERT INTO `django_content_type` VALUES ('20', 'assets', 'server');
INSERT INTO `django_content_type` VALUES ('15', 'assets', 'software');
INSERT INTO `django_content_type` VALUES ('11', 'assets', 'tag');
INSERT INTO `django_content_type` VALUES ('18', 'assets', 'userprofile');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2018-08-07 19:45:41.121056');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0002_remove_content_type_name', '2018-08-07 19:45:42.374128');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2018-08-07 19:45:46.730377');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0002_alter_permission_name_max_length', '2018-08-07 19:45:47.632429');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0003_alter_user_email_max_length', '2018-08-07 19:45:47.693432');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0004_alter_user_username_opts', '2018-08-07 19:45:47.749436');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0005_alter_user_last_login_null', '2018-08-07 19:45:47.817439');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0006_require_contenttypes_0002', '2018-08-07 19:45:48.236463');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0007_alter_validators_add_error_messages', '2018-08-07 19:45:48.289466');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0008_alter_user_username_max_length', '2018-08-07 19:45:48.339469');
INSERT INTO `django_migrations` VALUES ('11', 'assets', '0001_initial', '2018-08-07 19:46:27.361701');
INSERT INTO `django_migrations` VALUES ('12', 'admin', '0001_initial', '2018-08-07 19:46:30.045855');
INSERT INTO `django_migrations` VALUES ('13', 'admin', '0002_logentry_remove_auto_add', '2018-08-07 19:46:30.119859');
INSERT INTO `django_migrations` VALUES ('14', 'sessions', '0001_initial', '2018-08-07 19:46:31.103915');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8_bin NOT NULL,
  `session_data` longtext COLLATE utf8_bin NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('sije46wz1v1u33dz7hv70vq0r5ezsavs', 0x596D55324D6D4D77593256684D6A4D354D4746694E7A49314E4455784F4449334D7A6C685A4749794F474D324D5445325A575A6D597A7037496C39686458526F5833567A5A584A666147467A61434936496D59334D6D45314E6A63354F4749785A5467344F54466A5A6A59304D44686D4E5759325A474E6B5A445A6A4F4455784D47466D4D4467694C434A6659585630614639316332567958324A685932746C626D51694F694A6B616D46755A3238755932397564484A70596935686458526F4C6D4A685932746C626D527A4C6B31765A475673516D466A613256755A434973496E5A6C636D6C6D65574E765A4755694F694A4355466F3449697769583246316447686664584E6C636C39705A434936496A45694C434A666332567A63326C76626C396C65484270636E6B694F6A45344D44417766513D3D, '2018-08-08 01:02:14.279862');
