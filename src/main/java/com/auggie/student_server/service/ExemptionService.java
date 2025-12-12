package com.auggie.student_server.service;

import com.auggie.student_server.entity.Exemption;
import com.auggie.student_server.mapper.ExemptionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    /**
     * 学生提交免修申请
     */
    public boolean save(Exemption exemption) {
        // 这里可以加逻辑，比如检查该学生是否已经申请过这门课，避免重复
        // 为了简单，目前直接保存
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
     * 审核操作 (通过 或 驳回)
     */
    public boolean audit(Exemption exemption) {
        // 打印一下，方便调试
        System.out.println("正在审核免修申请 ID: " + exemption.getId() + " 状态变为: " + exemption.getStatus());
        return exemptionMapper.updateStatus(exemption);
    }
}