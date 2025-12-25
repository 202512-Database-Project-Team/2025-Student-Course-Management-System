<template>
  <div class="exemption-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>免修申请中心</span>
      </div>

      <el-tabs v-model="activeTab" type="card" @tab-click="handleTabClick">
        
        <el-tab-pane label="我要申请" name="apply">
          <el-alert
            title="申请提示：请确保您已获得相关证书或证明，审核通过后将自动获得80分。"
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
              <el-input v-model="form.term" disabled></el-input>
            </el-form-item>

            <el-form-item label="申请理由" prop="reason">
              <el-input 
                type="textarea" 
                v-model="form.reason" 
                rows="4" 
                placeholder="请详细描述申请理由，例如：已获得ACM竞赛金奖、已修读过同类课程等...">
              </el-input>
            </el-form-item>

            <el-form-item label="证明材料" prop="proof">
              <el-upload
                class="upload-demo"
                action="http://localhost:10086/upload"
                :on-success="handleUploadSuccess"
                :on-error="handleUploadError"
                :before-upload="beforeUpload"
                :limit="1"
                :file-list="fileList"
                accept=".jpg,.jpeg,.png,.pdf">
                <el-button size="small" type="primary" icon="el-icon-upload2">点击上传证明材料</el-button>
                <div slot="tip" class="el-upload__tip">支持 jpg/png/pdf 文件，大小不超过 10MB</div>
              </el-upload>
              <el-input v-model="form.proof" style="display:none"></el-input>
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
export default {
  name: "StudentExemption",
  data() {
    return {
      activeTab: 'apply',
      loading: false,
      tableLoading: false,
      sid: sessionStorage.getItem('userid'), // 获取当前登录学生ID
      
      // 表单数据
      form: {
        cid: '',
        term: '2025-Spring', // 默认学期，建议后期改为动态获取
        reason: '',
        proof: ''
      },
      fileList: [],
      
      // 列表数据
      courseList: [],
      historyList: [],
      
      // 验证规则
      rules: {
        cid: [{ required: true, message: '请选择课程', trigger: 'change' }],
        reason: [{ required: true, message: '请输入申请理由', trigger: 'blur' }],
        proof: [{ required: true, message: '请上传证明材料', trigger: 'change' }]
      }
    };
  },
  created() {
    this.fetchCourseList();
    if (this.activeTab === 'history') {
      this.fetchHistory();
    }
  },
  methods: {
    // 1. 获取所有课程 (用于下拉选择)
    fetchCourseList() {
      // 假设后端有 /course/findAll 接口，如果没有请改为你项目中的实际查询课程接口
      this.$http.get('/course/findAll').then(res => {
        if (res.data) {
          this.courseList = res.data;
        }
      }).catch(err => {
        console.error("获取课程列表失败", err);
        // 如果失败，可以用假数据测试
        // this.courseList = [{cid: 1, cname: '测试课程 (后端未连接)'}];
      });
    },

    // 2. 获取申请历史
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

    // 3. 上传成功回调
    handleUploadSuccess(res, file) {
      // 根据后端 UploadController，直接返回的是 URL 字符串
      console.log('上传结果:', res);
      if (res) {
        this.form.proof = res;
        this.$message.success('证明材料上传成功');
        // 手动触发校验清除错误提示
        this.$refs.applyForm.clearValidate('proof');
      } else {
        this.$message.error('上传失败：未返回有效URL');
      }
    },

    handleUploadError(err) {
      console.error(err);
      this.$message.error('上传出错，请检查网络或文件大小');
    },

    beforeUpload(file) {
      const isLt10M = file.size / 1024 / 1024 < 10;
      if (!isLt10M) {
        this.$message.error('上传文件大小不能超过 10MB!');
      }
      return isLt10M;
    },

    // 4. 提交申请
    submitApplication() {
      this.$refs.applyForm.validate((valid) => {
        if (valid) {
          this.loading = true;
          const payload = {
            sid: parseInt(this.sid),
            cid: this.form.cid,
            term: this.form.term,
            reason: this.form.reason,
            proof: this.form.proof
          };

          this.$http.post('/exemption/add', payload).then(res => {
            this.loading = false;
            if (res.data === true) {
              this.$message.success('申请提交成功！');
              this.resetForm();
              this.activeTab = 'history';
              this.fetchHistory();
            } else {
              this.$message.warning('提交失败：您可能已经申请过该课程，请勿重复提交。');
            }
          }).catch(err => {
            this.loading = false;
            this.$message.error('系统错误，请稍后再试');
          });
        } else {
          return false;
        }
      });
    },

    resetForm() {
      this.$refs.applyForm.resetFields();
      this.fileList = [];
      this.form.proof = '';
    },

    handleTabClick(tab) {
      if (tab.name === 'history') {
        this.fetchHistory();
      }
    },
    
    // 简单的日期格式化
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
</style>