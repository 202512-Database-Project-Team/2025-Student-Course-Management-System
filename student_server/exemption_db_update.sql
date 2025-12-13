-- 2025-12-13 新增免修申请功能表
DROP TABLE IF EXISTS `apply_exemption`;
CREATE TABLE `apply_exemption` (
                                   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `sid` int(11) NOT NULL COMMENT '学生ID',
                                   `cid` int(11) NOT NULL COMMENT '课程ID',
                                   `term` varchar(30) NOT NULL COMMENT '学期',
                                   `reason` varchar(255) DEFAULT NULL COMMENT '申请理由',
                                   `proof` varchar(255) DEFAULT NULL COMMENT '证明材料URL',
                                   `status` int(1) DEFAULT 0 COMMENT '0:待审核, 1:已通过, 2:已驳回',
                                   `audit_reason` varchar(255) DEFAULT NULL COMMENT '审核意见',
                                   `audit_by` int(11) DEFAULT NULL COMMENT '审核人ID',
                                   `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                                   `audit_time` datetime DEFAULT NULL,
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;