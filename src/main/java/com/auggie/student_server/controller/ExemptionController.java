package com.auggie.student_server.controller;

import com.auggie.student_server.entity.Exemption;
import com.auggie.student_server.service.ExemptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Auther: auggie
 * @Date: 2025/12/10
 * @Description: ExemptionController (免修接口)
 * @Version 1.0.0
 */

@RestController
@CrossOrigin("*")
@RequestMapping("/exemption")
public class ExemptionController {

    @Autowired
    private ExemptionService exemptionService;

    // 1 学生提交申请接口
    // URL: POST http://localhost:10086/exemption/add
    @PostMapping("/add")
    public boolean add(@RequestBody Exemption exemption) {
        System.out.println("收到免修申请: " + exemption);
        return exemptionService.save(exemption);
    }

    // 2 学生查看历史接口
    // URL: GET http://localhost:10086/exemption/findBySid/1
    @GetMapping("/findBySid/{sid}")
    public List<Exemption> findBySid(@PathVariable Integer sid) {
        return exemptionService.findBySid(sid);
    }

    // 3 教师获取待审核列表接口
    // URL: GET http://localhost:10086/exemption/findPending
    @GetMapping("/findPending")
    public List<Exemption> findPending() {
        return exemptionService.findPending();
    }

    // 4 教师审核接口 (提交审核结果)
    // URL: POST http://localhost:10086/exemption/audit
    // 前端传参: { "id": 1, "status": 1, "auditReason": "同意", "auditBy": 4 }
    @PostMapping("/audit")
    public boolean audit(@RequestBody Exemption exemption) {
        return exemptionService.audit(exemption);
    }
}