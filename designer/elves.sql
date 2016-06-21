/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.1.52 : Database - elves_new
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`elves_new` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `elves_new`;

/*Table structure for table `auth_key` */

DROP TABLE IF EXISTS `auth_key`;

CREATE TABLE `auth_key` (
  `auth_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'authID',
  `auth_key` varchar(16) NOT NULL COMMENT '秘钥',
  `key_name` varchar(32) DEFAULT NULL COMMENT '密钥名称',
  PRIMARY KEY (`auth_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `auth_relation` */

DROP TABLE IF EXISTS `auth_relation`;

CREATE TABLE `auth_relation` (
  `auth_key` varchar(16) NOT NULL COMMENT '秘钥',
  `agent_ip` varchar(15) NOT NULL COMMENT 'AgentIP',
  `module` varchar(32) NOT NULL COMMENT '指令',
  PRIMARY KEY (`auth_key`,`agent_ip`,`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `base_agent` */

DROP TABLE IF EXISTS `base_agent`;

CREATE TABLE `base_agent` (
  `agent_ip` varchar(15) NOT NULL COMMENT 'AgentIP',
  `agent_name` varchar(32) DEFAULT NULL COMMENT 'Agent名称',
  PRIMARY KEY (`agent_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `base_module` */

DROP TABLE IF EXISTS `base_module`;

CREATE TABLE `base_module` (
  `module` varchar(32) NOT NULL COMMENT '指令',
  `module_name` varchar(32) DEFAULT NULL COMMENT '模块名',
  `module_version` varchar(10) DEFAULT NULL COMMENT '模块版本',
  `charp` tinyint(1) DEFAULT '0' COMMENT 'Csharp支持',
  `py` tinyint(1) DEFAULT '0' COMMENT 'Csharp支持',
  PRIMARY KEY (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `log_cron_exec` */

DROP TABLE IF EXISTS `log_cron_exec`;

CREATE TABLE `log_cron_exec` (
  `code` int(11) NOT NULL AUTO_INCREMENT COMMENT 'code',
  `log_id` varchar(19) DEFAULT NULL COMMENT '消息ID',
  `mode` varchar(4) DEFAULT NULL COMMENT '模式',
  `agent_ip` varchar(15) DEFAULT NULL COMMENT 'AgentIP',
  `module` varchar(32) DEFAULT NULL COMMENT '模块',
  `func` varchar(32) DEFAULT NULL COMMENT '方法',
  `param` text COMMENT '参数',
  `starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `agent_sync_flag` tinyint(1) DEFAULT NULL COMMENT '发送agent同步消息状态(1:成功,0:异常)',
  `agent_sync_error` varchar(255) DEFAULT NULL COMMENT '同步agent消息异常信息',
  `agent_sync_costtime` int(11) DEFAULT NULL COMMENT '发送agent同步消息耗时',
  `agent_callback_time` datetime DEFAULT NULL COMMENT 'agent回调时间',
  `worker_message` text COMMENT 'worker执行结果',
  `worker_costtime` int(11) DEFAULT NULL COMMENT 'worker执行时间',
  `module_sync_flag` tinyint(1) DEFAULT NULL COMMENT '发送module同步消息状态(1:成功,0:异常)',
  `module_sync_error` varchar(255) DEFAULT NULL COMMENT '同步module消息异常信息',
  `module_sync_costtime` int(11) DEFAULT NULL COMMENT '发送module同步消息耗时',
  `module_callback_time` datetime DEFAULT NULL COMMENT 'module回调时间',
  `processor_message` text COMMENT 'processor执行结果',
  `processor_costtime` int(11) DEFAULT NULL COMMENT 'processor执行时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `result_flag` tinyint(1) DEFAULT '2' COMMENT '执行状态(0:失败，1:成功，2:执行中)',
  PRIMARY KEY (`code`),
  UNIQUE KEY `log_id` (`log_id`),
  KEY `client_id` (`agent_ip`,`func`),
  KEY `starttime` (`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `log_interface_operate` */

DROP TABLE IF EXISTS `log_interface_operate`;

CREATE TABLE `log_interface_operate` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `interface_name` varchar(32) DEFAULT NULL COMMENT '接口名称',
  `auth_key` varchar(16) DEFAULT NULL COMMENT '秘钥',
  `agent_ip` varchar(15) DEFAULT NULL COMMENT 'AgentIP',
  `params` text COMMENT '参数',
  `result` text COMMENT '返回值',
  PRIMARY KEY (`code`),
  KEY `interface_name` (`interface_name`),
  KEY `auth_key` (`auth_key`),
  KEY `agent_ip` (`agent_ip`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Table structure for table `log_queue_exec` */

DROP TABLE IF EXISTS `log_queue_exec`;

CREATE TABLE `log_queue_exec` (
  `code` int(11) NOT NULL AUTO_INCREMENT COMMENT 'code',
  `log_id` varchar(19) DEFAULT NULL COMMENT '消息ID',
  `mode` varchar(4) DEFAULT NULL COMMENT '模式',
  `agent_ip` varchar(15) DEFAULT NULL COMMENT 'AgentIP',
  `module` varchar(32) DEFAULT NULL COMMENT '模块',
  `func` varchar(32) DEFAULT NULL COMMENT '方法',
  `param` text COMMENT '参数',
  `starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `agent_sync_flag` tinyint(1) DEFAULT NULL COMMENT '发送agent同步消息状态(1:成功,0:异常)',
  `agent_sync_error` varchar(255) DEFAULT NULL COMMENT '同步agent消息异常信息',
  `agent_sync_costtime` int(11) DEFAULT NULL COMMENT '发送agent同步消息耗时',
  `agent_callback_time` datetime DEFAULT NULL COMMENT 'agent回调时间',
  `worker_message` text COMMENT 'worker执行结果',
  `worker_costtime` int(11) DEFAULT NULL COMMENT 'worker执行时间',
  `module_sync_flag` tinyint(1) DEFAULT NULL COMMENT '发送module同步消息状态(1:成功,0:异常)',
  `module_sync_error` varchar(255) DEFAULT NULL COMMENT '同步module消息异常信息',
  `module_sync_costtime` int(11) DEFAULT NULL COMMENT '发送module同步消息耗时',
  `module_callback_time` datetime DEFAULT NULL COMMENT 'module回调时间',
  `processor_message` text COMMENT 'processor执行结果',
  `processor_costtime` int(11) DEFAULT NULL COMMENT 'processor执行时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `result_flag` tinyint(1) DEFAULT '2' COMMENT '执行状态(0:失败，1:成功，2:执行中)',
  PRIMARY KEY (`code`),
  UNIQUE KEY `log_id` (`log_id`),
  KEY `client_id` (`agent_ip`,`func`),
  KEY `starttime` (`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `log_rt_exec` */

DROP TABLE IF EXISTS `log_rt_exec`;

CREATE TABLE `log_rt_exec` (
  `code` int(11) NOT NULL AUTO_INCREMENT COMMENT 'code',
  `log_id` varchar(19) DEFAULT NULL COMMENT '消息ID',
  `mode` varchar(4) DEFAULT NULL COMMENT '模式',
  `agent_ip` varchar(15) DEFAULT NULL COMMENT 'AgentIP',
  `module` varchar(32) DEFAULT NULL COMMENT '模块',
  `func` varchar(32) DEFAULT NULL COMMENT '方法',
  `param` text COMMENT '参数',
  `starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `agent_sync_flag` tinyint(1) DEFAULT NULL COMMENT '发送agent同步消息状态(1:成功,0:异常)',
  `agent_sync_error` varchar(255) DEFAULT NULL COMMENT '同步agent消息异常信息',
  `agent_sync_costtime` int(11) DEFAULT NULL COMMENT '发送agent同步消息耗时',
  `agent_callback_time` datetime DEFAULT NULL COMMENT 'agent回调时间',
  `worker_message` text COMMENT 'worker执行结果',
  `worker_costtime` int(11) DEFAULT NULL COMMENT 'worker执行时间',
  `module_sync_flag` tinyint(1) DEFAULT NULL COMMENT '发送module同步消息状态(1:成功,0:异常)',
  `module_sync_error` varchar(255) DEFAULT NULL COMMENT '同步module消息异常信息',
  `module_sync_costtime` int(11) DEFAULT NULL COMMENT '发送module同步消息耗时',
  `module_callback_time` datetime DEFAULT NULL COMMENT 'module回调时间',
  `processor_message` text COMMENT 'processor执行结果',
  `processor_costtime` int(11) DEFAULT NULL COMMENT 'processor执行时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `result_flag` tinyint(1) DEFAULT '2' COMMENT '执行状态(0:失败，1:成功，2:执行中)',
  PRIMARY KEY (`code`),
  UNIQUE KEY `log_id` (`log_id`),
  KEY `client_id` (`agent_ip`,`func`),
  KEY `starttime` (`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `task_cron` */

DROP TABLE IF EXISTS `task_cron`;

CREATE TABLE `task_cron` (
  `code` int(11) NOT NULL AUTO_INCREMENT COMMENT 'code',
  `id` varchar(19) DEFAULT NULL COMMENT '计划ID',
  `mode` varchar(4) DEFAULT NULL COMMENT '模式',
  `agent_ip` varchar(15) DEFAULT NULL COMMENT '客户端IP',
  `module` varchar(32) DEFAULT NULL COMMENT '模块',
  `func` varchar(32) DEFAULT NULL COMMENT '方法',
  `param` text COMMENT '参数',
  `rule` varchar(155) DEFAULT NULL COMMENT '规则',
  `flag` tinyint(4) DEFAULT NULL COMMENT '状态(1:正常,0:暂停)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`code`),
  UNIQUE KEY `id` (`id`),
  KEY `client_ip` (`agent_ip`,`func`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `task_queue` */

DROP TABLE IF EXISTS `task_queue`;

CREATE TABLE `task_queue` (
  `code` int(11) NOT NULL AUTO_INCREMENT COMMENT 'code',
  `id` varchar(19) DEFAULT NULL COMMENT '队列ID',
  `agent_ip` varchar(15) DEFAULT NULL COMMENT 'AgentIP',
  `module` varchar(32) DEFAULT NULL COMMENT '模块',
  `func` varchar(32) DEFAULT NULL COMMENT '指令',
  `param` text COMMENT '参数',
  `depend_tq_id` varchar(16) DEFAULT NULL COMMENT '依赖',
  `flag` char(1) DEFAULT NULL COMMENT '状态(p:等待,q:已入队,s:已停止)',
  `call_id` varchar(16) DEFAULT NULL COMMENT '调用ID(自动生成)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`code`),
  UNIQUE KEY `tq_id` (`id`),
  KEY `client_id` (`func`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `task_self` */

DROP TABLE IF EXISTS `task_self`;

CREATE TABLE `task_self` (
  `code` int(11) NOT NULL AUTO_INCREMENT COMMENT 'code',
  `ts_id` varchar(19) DEFAULT NULL COMMENT '计划ID',
  `agent_ip` varchar(15) DEFAULT NULL COMMENT '客户端IP',
  `instruct` varchar(32) DEFAULT NULL COMMENT '指令',
  `param` text COMMENT '参数',
  `rule` varchar(155) DEFAULT NULL COMMENT '规则',
  `flag` tinyint(4) DEFAULT NULL COMMENT '状态(1:正常,0:暂停)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`code`),
  UNIQUE KEY `ts_id` (`ts_id`),
  KEY `client_ip` (`agent_ip`,`instruct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Procedure structure for procedure `lock_queue` */

/*!50003 DROP PROCEDURE IF EXISTS  `lock_queue` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`mysql`@`%` PROCEDURE `lock_queue`(IN T VARCHAR(16) )
BEGIN
		CREATE TEMPORARY TABLE locktmp (
			 `tq_id` VARCHAR(16) DEFAULT NULL COMMENT '队列ID'
			) ENGINE=MEMORY DEFAULT CHARSET=utf8;
			INSERT INTO locktmp 
			SELECT `tq_id` FROM `task_queue` WHERE call_id IS NULL AND (depend_tq_id IS NULL OR depend_tq_id = '')
					UNION ALL
					(
						SELECT c.tq_id
						FROM(
						SELECT a.*,b.log_id,b.`result_flag` FROM `task_queue` a
						LEFT JOIN `log_queue_exec` b 
						ON a.depend_tq_id = b.log_id
						WHERE a.call_id IS NULL AND a.depend_tq_id IS NOT NULL) c
						WHERE  c.result_flag=1 OR c.result_flag=0
					);
					
			UPDATE `task_queue` SET call_id =T WHERE tq_id IN( SELECT * FROM locktmp );
			DROP TEMPORARY TABLE locktmp;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
