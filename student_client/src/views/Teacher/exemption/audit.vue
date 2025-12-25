<template>
  <div class="audit-container">
    <div class="header">
      <h2>免修申请审核</h2>
      <el-button type="primary" icon="el-icon-refresh" size="small" @click="fetchPending">刷新列表</el-button>
    </div>

    <el-table :data="pendingList" border style="width: 100%; margin-top: 20px">
      <el-table-column prop="id" label="ID" width="60"></el-table-column>
      <el-table-column prop="sname" label="学生姓名" width="120"></el-table-column>
      <el-table-column prop="cname" label="申请课程" width="180"></el-table-column>
      <el-table-column prop="term" label="学期" width="150"></el-table-column>
      <el-table-column prop="reason" label="申请理由"></el-table-column>
      
      <el-table-column label="证明材料" width="100">
        <template slot-scope="scope">
           <el-popover placement="right" title="证明预览" trigger="hover">
              <el-image style="width: 200px; height: 200px" :src="scope.row.proof" fit="contain"></el-image>
              <el-button slot="reference" type="text" size="small">预览</el-button>
           </el-popover>
           <el-link :href="scope.row.proof" target="_blank" style="margin-left: 10px"><i class="el-icon-link"></i></el-link>
        </template>
      </el-table-column>

      <el-table-column prop="createTime" label="提交时间" width="160"></el-table-column>

      <el-table-column label="操作" width="200" fixed="right">
        <template slot-scope="scope">
          <el-button size="mini" type="success" @click="handleAudit(scope.row, 1)">通过</el-button>
          <el-button size="mini" type="danger" @click="handleAudit(scope.row, 2)">驳回</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog title="审核确认" :visible.sync="dialogVisible" width="30%">
      <span>您选择了：<b :style="{color: currentStatus===1?'green':'red'}">{{ currentStatus===1?'通过':'驳回' }}</b></span>
      <p style="margin-top: 10px">请输入审核意见：</p >
      <el-input
        type="textarea"
        :rows="2"
        placeholder="请输入内容"
        v-model="auditReason">
      </el-input>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitAudit">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      pendingList: [],
      tid: sessionStorage.getItem('userid'), // 获取当前教师ID
      dialogVisible: false,
      currentStatus: 0,
      currentRow: null,
      auditReason: ''
    };
  },
  created() {
    this.fetchPending();
  },
  methods: {
    // 1. 获取待审核列表
    fetchPending() {
      // 这里的 tid 是可选的，如果后端实现了只看自己课程的逻辑，可以加上 ?tid=${this.tid}
      this.$http.get('/exemption/findPending').then(res => {
        this.pendingList = res.data;
      });
    },

    // 2. 点击通过或驳回
    handleAudit(row, status) {
      this.currentRow = row;
      this.currentStatus = status;
      this.auditReason = status === 1 ? '情况属实，予以通过' : '材料不全，请补充'; // 默认文案
      this.dialogVisible = true;
    },

    // 3. 提交审核
    submitAudit() {
      const payload = {
        id: this.currentRow.id,
        status: this.currentStatus,
        auditReason: this.auditReason,
        auditBy: parseInt(this.tid),
        // 必须回传以下三个字段，用于后端自动录入成绩
        sid: this.currentRow.sid,
        cid: this.currentRow.cid,
        term: this.currentRow.term
      };

      this.$http.post('/exemption/audit', payload).then(res => {
        if (res.data === true) {
          this.$message.success('审核完成');
          this.dialogVisible = false;
          this.fetchPending(); // 刷新列表
        } else {
          this.$message.error('操作失败，请重试');
        }
      });
    }
  }
};
</script>

<style scoped>
.audit-container {
  padding: 20px;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>