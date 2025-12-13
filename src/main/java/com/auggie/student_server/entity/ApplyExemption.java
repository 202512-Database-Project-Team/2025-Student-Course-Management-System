package com.auggie.student_server.entity;

import lombok.Data;
// 如果没用lombok，请手动生成Getter/Setter/toString

@Data
public class ApplyExemption {
    // === 1. 数据库存在的字段 (必须严格对应) ===
    private Integer id;
    private Integer sid;
    private Integer cid;
    private String term;
    private String reason;
    private Integer status;      // 0:待审核, 1:通过, 2:驳回
    private String auditReason;  // 对应数据库 audit_reason (MyBatis会自动转驼峰)
    private Integer auditBy;     // 对应数据库 audit_by
    private String createTime;   // 时间用String接收最方便，也可以用Date
    private String auditTime;

    // === 2. 数据库没有，但前端需要的字段 (用于展示) ===
    // 我们会在Mapper里通过 SQL JOIN 把这两个值查出来填进去
    private String sname; // 学生姓名
    private String cname; // 课程名称
    private String auditorName; // 审核人姓名 (可选)
}