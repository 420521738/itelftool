/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.240
Source Server Version : 50640
Source Host           : 192.168.1.240:3306
Source Database       : itelftool

Target Server Type    : MYSQL
Target Server Version : 50640
File Encoding         : 65001

Date: 2018-10-17 16:09:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for accounts_permissionlist
-- ----------------------------
DROP TABLE IF EXISTS `accounts_permissionlist`;
CREATE TABLE `accounts_permissionlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for accounts_rolelist
-- ----------------------------
DROP TABLE IF EXISTS `accounts_rolelist`;
CREATE TABLE `accounts_rolelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for accounts_rolelist_permission
-- ----------------------------
DROP TABLE IF EXISTS `accounts_rolelist_permission`;
CREATE TABLE `accounts_rolelist_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolelist_id` int(11) NOT NULL,
  `permissionlist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_rolelist_permis_rolelist_id_permissionli_4a3ad44e_uniq` (`rolelist_id`,`permissionlist_id`),
  KEY `accounts_rolelist_pe_permissionlist_id_40c1a242_fk_accounts_` (`permissionlist_id`),
  CONSTRAINT `accounts_rolelist_pe_permissionlist_id_40c1a242_fk_accounts_` FOREIGN KEY (`permissionlist_id`) REFERENCES `accounts_permissionlist` (`id`),
  CONSTRAINT `accounts_rolelist_pe_rolelist_id_eb971769_fk_accounts_` FOREIGN KEY (`rolelist_id`) REFERENCES `accounts_rolelist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for assets_loginrecord
-- ----------------------------
DROP TABLE IF EXISTS `assets_loginrecord`;
CREATE TABLE `assets_loginrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logintime` datetime(6) NOT NULL,
  `loginsource` char(39) DEFAULT NULL,
  `name_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assets_loginrecord_name_id_244f467c_fk_assets_userprofile_id` (`name_id`),
  CONSTRAINT `assets_loginrecord_name_id_244f467c_fk_assets_userprofile_id` FOREIGN KEY (`name_id`) REFERENCES `assets_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

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
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `assets_userprofile_role_id_e6ea7e79_fk_accounts_rolelist_id` (`role_id`),
  CONSTRAINT `assets_userprofile_role_id_e6ea7e79_fk_accounts_rolelist_id` FOREIGN KEY (`role_id`) REFERENCES `accounts_rolelist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for broken_record_brokenrrecord
-- ----------------------------
DROP TABLE IF EXISTS `broken_record_brokenrrecord`;
CREATE TABLE `broken_record_brokenrrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(1024) NOT NULL,
  `process_description` varchar(1024) NOT NULL,
  `precaution` varchar(1024) DEFAULT NULL,
  `broken_type` varchar(30) NOT NULL,
  `severity_type` varchar(30) NOT NULL,
  `broken_status_type` varchar(30) NOT NULL,
  `broken_department` varchar(30) NOT NULL,
  `occur_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `business_impact_time` varchar(50) NOT NULL,
  `product_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `developer_id` int(11) DEFAULT NULL,
  `maintenance_id` int(11) DEFAULT NULL,
  `update_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `broken_record_broken_product_id_17895c7a_fk_appconf_p` (`product_id`),
  KEY `broken_record_broken_project_id_0c5e5c72_fk_appconf_p` (`project_id`),
  KEY `broken_record_broken_developer_id_c3a0a544_fk_broken_re` (`developer_id`),
  KEY `broken_record_broken_maintenance_id_896980c9_fk_appconf_a` (`maintenance_id`),
  CONSTRAINT `broken_record_broken_developer_id_c3a0a544_fk_broken_re` FOREIGN KEY (`developer_id`) REFERENCES `broken_record_developer` (`id`),
  CONSTRAINT `broken_record_broken_maintenance_id_896980c9_fk_appconf_a` FOREIGN KEY (`maintenance_id`) REFERENCES `appconf_appowner` (`id`),
  CONSTRAINT `broken_record_broken_product_id_17895c7a_fk_appconf_p` FOREIGN KEY (`product_id`) REFERENCES `appconf_product` (`id`),
  CONSTRAINT `broken_record_broken_project_id_0c5e5c72_fk_appconf_p` FOREIGN KEY (`project_id`) REFERENCES `appconf_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for broken_record_developer
-- ----------------------------
DROP TABLE IF EXISTS `broken_record_developer`;
CREATE TABLE `broken_record_developer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `qq` varchar(100) DEFAULT NULL,
  `weChat` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=23891 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

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
-- Table structure for django_celery_beat_periodictasks
-- ----------------------------
DROP TABLE IF EXISTS `django_celery_beat_periodictasks`;
CREATE TABLE `django_celery_beat_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

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
-- Table structure for domain_domainrrecord
-- ----------------------------
DROP TABLE IF EXISTS `domain_domainrrecord`;
CREATE TABLE `domain_domainrrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `ctime` datetime(6) NOT NULL,
  `etime` datetime(6) NOT NULL,
  `ip` char(39) NOT NULL,
  `ip_source` varchar(50) DEFAULT NULL,
  `domain_record_num` varchar(50) DEFAULT NULL,
  `domain_nature` varchar(50) DEFAULT NULL,
  `domain_company` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comment` (`comment`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for fast_excute_fastexcude
-- ----------------------------
DROP TABLE IF EXISTS `fast_excute_fastexcude`;
CREATE TABLE `fast_excute_fastexcude` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `shell` varchar(255) NOT NULL,
  `excude_time` datetime(6) DEFAULT NULL,
  `update_date` datetime(6) NOT NULL,
  `server_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `bar_data` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fast_excute_fastexcu_server_id_270e4950_fk_webshell_` (`server_id`),
  CONSTRAINT `fast_excute_fastexcu_server_id_270e4950_fk_webshell_` FOREIGN KEY (`server_id`) REFERENCES `webshell_webshell` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for fast_excute_fastexcuderecord
-- ----------------------------
DROP TABLE IF EXISTS `fast_excute_fastexcuderecord`;
CREATE TABLE `fast_excute_fastexcuderecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `excudename` varchar(50) NOT NULL,
  `excudeuser` varchar(50) NOT NULL,
  `excude_time` datetime(6) DEFAULT NULL,
  `excudestatus` tinyint(1) NOT NULL,
  `excudeserver` char(39) NOT NULL,
  `excudelog` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

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
-- Table structure for setup_taskrecord
-- ----------------------------
DROP TABLE IF EXISTS `setup_taskrecord`;
CREATE TABLE `setup_taskrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tasktype` varchar(50) NOT NULL,
  `taskuser` varchar(50) NOT NULL,
  `tasktime` datetime(6) NOT NULL,
  `taskstatus` tinyint(1) NOT NULL,
  `taskinfo` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for webshell_webshell
-- ----------------------------
DROP TABLE IF EXISTS `webshell_webshell`;
CREATE TABLE `webshell_webshell` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipaddr` char(39) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `port` int(11) DEFAULT NULL,
  `memo` longtext,
  `product_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ipaddr` (`ipaddr`),
  KEY `webshell_webshell_product_id_cb9a0719_fk_appconf_product_id` (`product_id`),
  KEY `webshell_webshell_project_id_ec120ef6_fk_appconf_project_id` (`project_id`),
  CONSTRAINT `webshell_webshell_product_id_cb9a0719_fk_appconf_product_id` FOREIGN KEY (`product_id`) REFERENCES `appconf_product` (`id`),
  CONSTRAINT `webshell_webshell_project_id_ec120ef6_fk_appconf_project_id` FOREIGN KEY (`project_id`) REFERENCES `appconf_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for zabbix_monitorgraph
-- ----------------------------
DROP TABLE IF EXISTS `zabbix_monitorgraph`;
CREATE TABLE `zabbix_monitorgraph` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(50) NOT NULL,
  `graphids` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `groupname` (`groupname`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
