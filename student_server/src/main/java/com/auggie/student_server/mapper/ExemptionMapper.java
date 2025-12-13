package com.auggie.student_server.mapper;

import com.auggie.student_server.entity.Exemption;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Auther: auggie
 * @Date: 2025/12/10
 * @Description: ExemptionMapper
 * @Version 1.0.0
 */

@Mapper
@Repository
public interface ExemptionMapper {

    // insert: 学生提交免修申请
    public boolean save(@Param("exemption") Exemption exemption);

    // select: 根据学生ID查询申请记录 (学生端用)
    public List<Exemption> findBySid(@Param("sid") Integer sid);

    // select: 查询所有待审核的申请 (包含学生名和课程名) (管理员端用)
    public List<Exemption> findPending();

    // update: 审核 (通过/驳回)
    // 包含更新 status, audit_reason, audit_by, audit_time
    public boolean updateStatus(@Param("exemption") Exemption exemption);
    
    // delete: 撤销申请 (可选功能)
    public boolean deleteById(@Param("id") Integer id);

    // select: 防止重复提交
    public Exemption findBySidCidTerm(@Param("sid") Integer sid,
                                      @Param("cid") Integer cid,
                                      @Param("term") String term);
}