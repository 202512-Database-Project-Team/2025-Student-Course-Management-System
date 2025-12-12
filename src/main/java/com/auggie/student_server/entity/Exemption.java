package com.auggie.student_server.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

/**
 * @Auther: auggie
 * @Date: 2025/12/10
 * @Description: Exemption (免修申请实体类)
 * @Version 1.0.0
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("Exemption")
public class Exemption {
    // === 数据库原表字段 ===
    private Integer id;
    private Integer sid;
    private Integer cid;
    private String term;
    private String reason;
    /**
     * 审核状态: 0-待审核, 1-已通过, 2-已驳回
     */
    private Integer status;
    private String auditReason; // 审核意见
    private Integer auditBy;    // 审核人ID (教师ID)
    private String createTime;  // 申请时间
    private String auditTime;   // 审核时间

    // === 业务扩展字段 (数据库表中不存在，用于前端展示) ===
    private String sname;       // 学生姓名 (用于列表展示)
    private String cname;       // 课程名称 (用于列表展示)
    private String tname;       // 审核教师姓名 (可选)
}