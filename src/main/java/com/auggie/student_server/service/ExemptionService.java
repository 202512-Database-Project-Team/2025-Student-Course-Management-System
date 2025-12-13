package com.auggie.student_server.service;

import com.auggie.student_server.entity.Exemption;
import com.auggie.student_server.mapper.ExemptionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.auggie.student_server.mapper.StudentCourseTeacherMapper;
import com.auggie.student_server.entity.StudentCourseTeacher;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Auther: auggie
 * @Date: 2025/12/10
 * @Description: ExemptionService (免修申请业务层)
 * @Version 1.0.0
 */

@Service
public class ExemptionService {

    @Autowired
    private ExemptionMapper exemptionMapper;

    @Autowired
    private StudentCourseTeacherMapper sctMapper;
    /**
     * 学生提交免修申请（含防重）
     */
    public boolean save(Exemption exemption) {
        // 1 检查该生、该学期、该课程是否已经提交过申请
        Exemption existing = exemptionMapper.findBySidCidTerm(
                exemption.getSid(),
                exemption.getCid(),
                exemption.getTerm()
        );

        // 2 有，拦截
        if (existing != null) {
            System.out.println("拦截重复申请：sid=" + exemption.getSid() + ", cid=" + exemption.getCid());
            return false; // 返回失败，前端会收到 false
        }

        // 3. 无，放行，保存
        return exemptionMapper.save(exemption);
    }

    /**
     * 学生查看自己的申请历史
     */
    public List<Exemption> findBySid(Integer sid) {
        return exemptionMapper.findBySid(sid);
    }

    /**
     * 教师/管理员查看所有待审核的申请
     */
    public List<Exemption> findPending() {
        return exemptionMapper.findPending();
    }

    /**
     * 审核操作 (通过 或 驳回) 加事务 通过后自动给80分
     */
    @Transactional
    public boolean audit(Exemption exemption) {
        boolean success = exemptionMapper.updateStatus(exemption);

        if (success && exemption.getStatus() == 1) {
            // 构建成绩对象
            StudentCourseTeacher sct = new StudentCourseTeacher();
            sct.setSid(exemption.getSid());
            sct.setCid(exemption.getCid());
            sct.setTerm(exemption.getTerm());
            sct.setTid(exemption.getAuditBy());
            sct.setGrade(80.0F);                  // 免修固定给 80 分

            // 成绩保存
            try {
                sctMapper.insertWithGrade(sct);
                System.out.println("免修成绩录入成功：80分");
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("录入失败，可能该学生已选修过此课程");
            }
        }
        return success;
    }
}