DROP TABLE IF EXISTS `apply_exemption`;
CREATE TABLE `apply_exemption` (
                                   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `sid` int(11) NOT NULL COMMENT '关联学生表s.sid',
                                   `cid` int(11) NOT NULL COMMENT '关联课程表c.cid',
                                   `term` varchar(30) NOT NULL COMMENT '申请学期 (如: 22-春季学期)',
                                   `reason` varchar(255) DEFAULT NULL COMMENT '申请理由',
                                   `status` int(1) DEFAULT 0 COMMENT '0:待审核, 1:已通过, 2:已驳回',
                                   `audit_reason` varchar(255) DEFAULT NULL COMMENT '审核意见',
                                   `audit_by` int(11) DEFAULT NULL COMMENT '审核人(教师ID)',
                                   `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
                                   `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
                                   PRIMARY KEY (`id`),
                                   KEY `idx_sid` (`sid`),
                                   KEY `idx_cid` (`cid`),
                                   CONSTRAINT `fk_apply_sid` FOREIGN KEY (`sid`) REFERENCES `s` (`sid`) ON DELETE CASCADE,
                                   CONSTRAINT `fk_apply_cid` FOREIGN KEY (`cid`) REFERENCES `c` (`cid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生免修免考申请表';