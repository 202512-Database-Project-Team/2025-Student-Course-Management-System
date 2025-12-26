<template>
  <div class="exemption-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>免修申请中心</span>
      </div>

      <el-tabs v-model="activeTab" type="card" @tab-click="handleTabClick">
        
        <el-tab-pane label="我要申请" name="apply">
          <el-alert
            title="申请提示：请确保您已获得相关证书或证明，审核通过后系统将自动为您录入 80 分。"
            type="info"
            show-icon
            :closable="false"
            style="margin-bottom: 20px;">
          </el-alert>

          <el-form :model="form" ref="applyForm" :rules="rules" label-width="120px" style="max-width: 700px;">
            
            <el-form-item label="选择课程" prop="cid">
              <el-select v-model="form.cid" placeholder="请选择要免修的课程" filterable style="width: 100%">
                <el-option
                  v-for="item in courseList"
                  :key="item.cid"
                  :label="item.cname + ' (' + item.cid + ')'"
                  :value="item.cid">
                </el-option>
              </el-select>
            </el-form-item>

            <el-form-item label="当前学期" prop="term">
              <el-input v-model="form.term" readonly placeholder="系统自动获取"></el-input>
            </el-form-item>

            <el-form-item label="申请理由" prop="reason">
              <el-input 
                type="textarea" 
                v-model="form.reason" 
                rows="4" 
                placeholder="请详细描述申请理由，例如：已获得竞赛金奖、已修读过同类课程等...">
              </el-input>
            </el-form-item>

            <el-form-item label="证明材料" prop="proof">
              <el-upload
                class="upload-demo"
                :action="uploadUrl" 
                :on-success="handleUploadSuccess"
                :on-error="handleUploadError"
                :before-upload="beforeUpload"
                :limit="1"
                :file-list="fileList"
                :on-remove="handleRemove"
                name="file"
                accept=".jpg,.jpeg,.png,.pdf">
                
                <el-button size="small" type="primary" icon="el-icon-upload2">点击上传证明材料</el-button>
                <div slot="tip" class="el-upload__tip">支持 jpg/png/pdf 文件，大小不超过 10MB。必须先上传证明才能提交申请。</div>
              </el-upload>

              <el-input v-model="form.proof" v-show="false"></el-input>
            </el-form-item>

            <el-form-item>
              <el-button type="primary" @click="submitApplication" :loading="loading">提交申请</el-button>
              <el-button @click="resetForm">重置</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>

        <el-tab-pane label="申请记录" name="history">
          <el-table :data="historyList" stripe border style="width: 100%" v-loading="tableLoading">
            <el-table-column type="index" label="序号" width="60" align="center"></el-table-column>
            <el-table-column prop="cname" label="课程名称" min-width="150"></el-table-column>
            <el-table-column prop="term" label="学期" width="140"></el-table-column>
            <el-table-column prop="reason" label="申请理由" show-overflow-tooltip min-width="180"></el-table-column>
            
            <el-table-column label="证明材料" width="100" align="center">
              <template slot-scope="scope">
                <el-link type="primary" :href="scope.row.proof" target="_blank" v-if="scope.row.proof">
                  <i class="el-icon-view"></i> 查看
                </el-link>
                <span v-else>无</span>
              </template>
            </el-table-column>
            
            <el-table-column label="状态" width="100" align="center">
              <template slot-scope="scope">
                <el-tag v-if="scope.row.status === 0" type="warning" size="small">待审核</el-tag>
                <el-tag v-else-if="scope.row.status === 1" type="success" size="small">已通过</el-tag>
                <el-tag v-else-if="scope.row.status === 2" type="danger" size="small">已驳回</el-tag>
              </template>
            </el-table-column>
            
            <el-table-column prop="auditReason" label="审核意见" show-overflow-tooltip min-width="150">
                <template slot-scope="scope">
                  <span v-if="scope.row.auditReason">{{ scope.row.auditReason }}</span>
                  <span v-else style="color: #909399">暂无</span>
                </template>
            </el-table-column>
            
            <el-table-column prop="createTime" label="申请时间" width="160" align="center">
               <template slot-scope="scope">
                  {{ formatDate(scope.row.createTime) }}
               </template>
            </el-table-column>
          </el-table>
        </el-tab-pane>

      </el-tabs>
    </el-card>
  </div>
</template>

<script>
// 如果你没有全局配置 axios，可以在这里 import
// import axios from 'axios';

export default {
  name: "StudentExemption",
  data() {
    return {
      activeTab: 'apply',
      loading: false,
      tableLoading: false,
      // 从 SessionStorage 获取当前用户ID和学期
      sid: sessionStorage.getItem('sid'), 
      currentTerm: sessionStorage.getItem('currentTerm') || '2025-Spring', // 默认值防报错
      
      // 上传接口地址 (根据你的后端端口修改)
      uploadUrl: 'http://localhost:10086/upload',

      form: {
        cid: '',
        term: '', // 在 created 中初始化
        reason: '',
        proof: '' // 重要：存储上传成功后的文件 URL
      },
      fileList: [], // 用于 UI 显示已选文件
      
      courseList: [],
      historyList: [],
      
      rules: {
        cid: [{ required: true, message: '请选择课程', trigger: 'change' }],
        term: [{ required: true, message: '学期信息缺失', trigger: 'blur' }],
        reason: [{ required: true, message: '请输入申请理由', trigger: 'blur' }],
        // 这里的 proof 校验会检查隐藏的 input 框是否有值
        proof: [{ required: true, message: '请务必上传证明材料', trigger: 'change' }]
      }
    };
  },
  created() {
    // 初始化表单的学期字段
    this.form.term = this.currentTerm;
    this.fetchCourseList();
  },
  methods: {
    // 1. 获取课程列表 (用于下拉框)
    fetchCourseList() {
      this.$http.post('/course/findBySearch', {}).then(res => {
        if (res.data) {
          this.courseList = res.data;
        }
      }).catch(err => {
        console.error("获取课程列表失败", err);
      });
    },

    // 2. 文件上传逻辑
    // 上传成功回调：后端返回 URL 字符串 -> 赋值给 form.proof
    handleUploadSuccess(res, file, fileList) {
      if (res) {
        // res 应该是后端返回的 URL 字符串，例如 "http://.../img.jpg"
        this.form.proof = res; 
        this.$message.success('证明材料上传成功');
        // 关键：手动清除校验报错（因为隐藏的 input 值变化了，Vue 可能会延迟反应）
        this.$refs.applyForm.clearValidate('proof');
      } else {
        this.$message.error('上传失败：未返回有效地址');
      }
    },

    // 上传失败回调
    handleUploadError(err, file, fileList) {
      console.error(err);
      this.$message.error('上传服务异常，请检查后端是否启动 (端口 10086)');
    },

    // 上传前校验：限制大小和格式
    beforeUpload(file) {
      const isLt10M = file.size / 1024 / 1024 < 10;
      if (!isLt10M) {
        this.$message.error('上传文件大小不能超过 10MB!');
      }
      return isLt10M;
    },

    // 移除文件时，清空 form.proof
    handleRemove(file, fileList) {
      this.form.proof = '';
      this.fileList = [];
    },

    // 3. 提交整个申请表单
    submitApplication() {
      this.$refs.applyForm.validate((valid) => {
        if (valid) {
          this.loading = true;
          
          const payload = {
            sid: parseInt(this.sid),
            cid: this.form.cid,
            term: this.form.term,
            reason: this.form.reason,
            proof: this.form.proof // 这里发送的是 URL
          };

          this.$http.post('/exemption/add', payload).then(res => {
            this.loading = false;
            // 假设后端返回 true 代表成功
            if (res.data === true) {
              this.$message.success('申请提交成功！');
              this.resetForm();
              // 自动切到历史记录 tab
              this.activeTab = 'history';
              this.fetchHistory();
            } else {
              this.$message.warning('提交失败：您可能重复申请了该课程。');
            }
          }).catch(err => {
            this.loading = false;
            this.$message.error('提交出错，请稍后重试');
          });
        } else {
          // 校验不通过，如果是 proof 字段，会自动显示 "请务必上传证明材料"
          return false;
        }
      });
    },

    // 4. 获取历史记录
    fetchHistory() {
      if (!this.sid) return;
      this.tableLoading = true;
      this.$http.get(`/exemption/findBySid/${this.sid}`).then(res => {
        this.historyList = res.data || [];
        this.tableLoading = false;
      }).catch(err => {
        this.$message.error('获取历史记录失败');
        this.tableLoading = false;
      });
    },

    resetForm() {
      this.$refs.applyForm.resetFields();
      this.fileList = [];
      this.form.proof = '';
      // 重置后记得把学期填回去
      this.form.term = this.currentTerm;
    },

    handleTabClick(tab) {
      if (tab.name === 'history') {
        this.fetchHistory();
      }
    },
    
    formatDate(dateStr) {
      if (!dateStr) return '';
      return dateStr.replace('T', ' ').substring(0, 19);
    }
  }
};
</script>

<style scoped>
.exemption-container {
  padding: 20px;
}
.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}
.el-tag--small {
  font-weight: bold;
}
</style>