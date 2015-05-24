/*
 Navicat MySQL Data Transfer

 Source Server         : local
 Source Server Version : 50615
 Source Host           : 127.0.0.1
 Source Database       : scheduler

 Target Server Version : 50615
 File Encoding         : utf-8

 Date: 05/24/2015 13:52:41 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `t_qrt_blob_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_blob_triggers`;
CREATE TABLE `t_qrt_blob_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `t_qrt_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `t_qrt_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_qrt_calendars`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_calendars`;
CREATE TABLE `t_qrt_calendars` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_qrt_cron_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_cron_triggers`;
CREATE TABLE `t_qrt_cron_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(200) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `t_qrt_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `t_qrt_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_qrt_cron_triggers`
-- ----------------------------
BEGIN;
INSERT INTO `t_qrt_cron_triggers` VALUES ('Scheduler', 'aaa', 'DEFAULT', '0/10 * * * * ?', 'Asia/Harbin');
COMMIT;

-- ----------------------------
--  Table structure for `t_qrt_fired_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_fired_triggers`;
CREATE TABLE `t_qrt_fired_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_group` varchar(200) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_qrt_fired_triggers`
-- ----------------------------
BEGIN;
INSERT INTO `t_qrt_fired_triggers` VALUES ('Scheduler', 'NON_CLUSTERED1432438699711', 'aaa', 'DEFAULT', 'NON_CLUSTERED', '1432438760000', '5', 'EXECUTING', 'localtest', 'DEFAULT', '0', '1'), ('Scheduler', 'NON_CLUSTERED1432438699712', 'aaa', 'DEFAULT', 'NON_CLUSTERED', '1432438770000', '5', 'ACQUIRED', null, null, '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `t_qrt_job_details`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_job_details`;
CREATE TABLE `t_qrt_job_details` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_qrt_job_details`
-- ----------------------------
BEGIN;
INSERT INTO `t_qrt_job_details` VALUES ('Scheduler', 'localtest', 'DEFAULT', '', 'eap.scheduling.job.test.local.LocalTestJob', '1', '0', '0', '1', 0xaced0005737200156f72672e71756172747a2e4a6f62446174614d61709fb083e8bfa9b0cb020000787200266f72672e71756172747a2e7574696c732e537472696e674b65794469727479466c61674d61708208e8c3fbc55d280200015a0013616c6c6f77735472616e7369656e74446174617872001d6f72672e71756172747a2e7574696c732e4469727479466c61674d617013e62ead28760ace0200025a000564697274794c00036d617074000f4c6a6176612f7574696c2f4d61703b787000737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000f770800000010000000007800);
COMMIT;

-- ----------------------------
--  Table structure for `t_qrt_locks`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_locks`;
CREATE TABLE `t_qrt_locks` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_qrt_locks`
-- ----------------------------
BEGIN;
INSERT INTO `t_qrt_locks` VALUES ('Scheduler', 'STATE_ACCESS'), ('Scheduler', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
--  Table structure for `t_qrt_paused_trigger_grps`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_paused_trigger_grps`;
CREATE TABLE `t_qrt_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_qrt_scheduler_state`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_scheduler_state`;
CREATE TABLE `t_qrt_scheduler_state` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_qrt_scheduler_state`
-- ----------------------------
BEGIN;
INSERT INTO `t_qrt_scheduler_state` VALUES ('Scheduler', 'NON_CLUSTERED', '1432438762938', '7500');
COMMIT;

-- ----------------------------
--  Table structure for `t_qrt_simple_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_simple_triggers`;
CREATE TABLE `t_qrt_simple_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `t_qrt_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `t_qrt_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_qrt_simprop_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_simprop_triggers`;
CREATE TABLE `t_qrt_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `t_qrt_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `t_qrt_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_qrt_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `t_qrt_triggers`;
CREATE TABLE `t_qrt_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint(13) DEFAULT NULL,
  `prev_fire_time` bigint(13) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) DEFAULT NULL,
  `calendar_name` varchar(200) DEFAULT NULL,
  `misfire_instr` smallint(2) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `t_qrt_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `t_qrt_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_qrt_triggers`
-- ----------------------------
BEGIN;
INSERT INTO `t_qrt_triggers` VALUES ('Scheduler', 'aaa', 'DEFAULT', 'localtest', 'DEFAULT', '', '1432438770000', '1432438760000', '5', 'ACQUIRED', 'CRON', '1286640000000', '0', null, '0', '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
