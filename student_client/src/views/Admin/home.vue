<template>
  <div class="admin-home">
    <div class="welcome-banner">
      <div class="banner-content">
        <h2>早安，管理员</h2>
        <p>今天是 {{ today }}，祝你工作愉快！系统运行状态良好。</p >
      </div>
      <div class="banner-img">
        <i class="el-icon-data-line"></i>
      </div>
    </div>

    <el-row :gutter="20" class="stat-row">
      <el-col :span="6" v-for="(item, index) in statCards" :key="index">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-icon" :style="{ background: item.color }">
            <i :class="item.icon"></i>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ item.value }}</div>
            <div class="stat-label">{{ item.label }}</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="content-row">
      <el-col :span="16" class="equal-height-col">
        <el-card class="chart-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span><i class="el-icon-pie-chart"></i> 快速操作</span>
          </div>
          
          <div class="operation-container">
            <div class="quick-actions-grid">
              <div class="action-item blue" @click="$router.push('/addStudent')">
                <div class="icon-wrapper"><i class="el-icon-plus"></i></div>
                <span class="label">添加学生</span>
              </div>
              <div class="action-item green" @click="$router.push('/addTeacher')">
                <div class="icon-wrapper"><i class="el-icon-user-solid"></i></div>
                <span class="label">添加教师</span>
              </div>
              <div class="action-item orange" @click="$router.push('/addCourse')">
                <div class="icon-wrapper"><i class="el-icon-notebook-1"></i></div>
                <span class="label">添加课程</span>
              </div>
              <div class="action-item purple" @click="$router.push('/studentList')">
                <div class="icon-wrapper"><i class="el-icon-search"></i></div>
                <span class="label">学生查询</span>
              </div>
            </div>

            <div class="system-desc">
              <p><i class="el-icon-info"></i> 提示：点击上方按钮可快速跳转至对应管理页面，更多功能请查看左侧菜单。</p >
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :span="8" class="equal-height-col">
        <el-card class="chart-card" shadow="hover">
          <div slot="header">
            <span><i class="el-icon-bell"></i> 系统公告</span>
          </div>
          <ul class="notice-list">
            <li v-for="item in notices" :key="item.id" @click="viewNotice(item.id)" class="clickable">
              <span class="tag" :class="item.typeClass">{{ item.type }}</span>
              <span class="text">{{ item.title }}</span>
            </li>
          </ul>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "adminHome",
  data() {
    return {
      today: new Date().toLocaleDateString(),
      statCards: [
        { label: '学生总数', value: '-', icon: 'el-icon-user', color: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)' },
        { label: '教师总数', value: '-', icon: 'el-icon-s-custom', color: 'linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%)' },
        { label: '课程数量', value: '-', icon: 'el-icon-reading', color: 'linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%)' },
        { label: '今日访问', value: '-', icon: 'el-icon-data-analysis', color: 'linear-gradient(135deg, #fccb90 0%, #d57eeb 100%)' },
      ],
      notices: [
        { id: 201, title: '期末成绩录入截止通知', type: '紧急', typeClass: 'urgent' },
        { id: 202, title: '系统升级维护公告 v2.0', type: '通知', typeClass: 'normal' },
        { id: 203, title: '新学期选课时间安排', type: '通知', typeClass: 'normal' },
      ]
    }
  },
  created() {
    this.fetchData();
  },
  methods: {
    viewNotice(id) {
      this.$router.push(`/notification/${id}`);
    },
    fetchData() {
      const that = this;

      axios.get('http://localhost:10086/student/getLength').then(function (resp) {
        if (resp.data !== undefined) {
          that.statCards[0].value = resp.data.toLocaleString();
        }
      }).catch(err => console.error("获取学生数失败", err));

      axios.post('http://localhost:10086/teacher/findBySearch', {}).then(function (resp) {
        if (resp.data) {
          that.statCards[1].value = resp.data.length.toLocaleString();
        }
      }).catch(err => console.error("获取教师数失败", err));

      axios.post('http://localhost:10086/course/findBySearch', {}).then(function (resp) {
        if (resp.data) {
          that.statCards[2].value = resp.data.length.toLocaleString();
        }
      }).catch(err => console.error("获取课程数失败", err));

      const dateStr = new Date().toDateString();
      let seed = 0;
      for (let i = 0; i < dateStr.length; i++) {
        seed += dateStr.charCodeAt(i);
      }
      const visits = 200 + (seed % 300); 
      that.statCards[3].value = visits.toLocaleString();
    }
  }
}
</script>

<style scoped>
.admin-home {
  padding: 10px;
}

/* 欢迎 Banner */
.welcome-banner {
  background: white;
  border-radius: 16px;
  padding: 30px 40px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  box-shadow: 0 5px 20px rgba(0,0,0,0.05);
  position: relative;
  overflow: hidden;
}
.welcome-banner::after {
  content: '';
  position: absolute;
  right: -50px;
  top: -50px;
  width: 200px;
  height: 200px;
  background: rgba(102, 126, 234, 0.1);
  border-radius: 50%;
}

.banner-content h2 {
  font-size: 24px;
  color: #303133;
  margin-bottom: 10px;
}
.banner-content p {
  color: #909399;
}
.banner-img i {
  font-size: 60px;
  color: #667eea;
  opacity: 0.8;
}

/* 统计卡片 */
.stat-row {
  margin-bottom: 25px;
}
.stat-card {
  border: none;
  border-radius: 12px;
  cursor: pointer;
}
.el-card__body {
  display: flex;
  align-items: center;
}
::v-deep .el-card__body {
  display: flex;
  align-items: center;
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 20px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}
.stat-icon i {
  font-size: 30px;
  color: white;
}
.stat-value {
  font-size: 24px;
  font-weight: bold;
  color: #303133;
  margin-bottom: 5px;
}
.stat-label {
  font-size: 14px;
  color: #909399;
}

/* 核心布局调整：等高对齐 */
.content-row {
  display: flex;
  align-items: stretch;
  flex-wrap: wrap;
}
.equal-height-col {
  display: flex;
  flex-direction: column;
}
.chart-card {
  flex: 1; /* 关键：撑满列的高度 */
  display: flex;
  flex-direction: column;
  border-radius: 12px;
  border: none;
}
::v-deep .chart-card .el-card__body {
  flex: 1; /* 关键：撑满卡片主体 */
  display: flex;
  flex-direction: column;
  padding: 20px;
}

/* 快速操作区域样式优化 */
.operation-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  justify-content: space-between; /* 上下分布 */
}

.quick-actions-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr); /* 4列等宽 */
  gap: 20px;
  margin-bottom: 20px;
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 25px 10px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s;
  background-color: #f8f9fa;
  border: 1px solid #eee;
}
.action-item:hover {
  transform: translateY(-5px);
  box-shadow: 0 5px 15px rgba(0,0,0,0.05);
}
.icon-wrapper {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  color: white;
  margin-bottom: 10px;
}
.action-item .label {
  font-size: 14px;
  font-weight: 600;
  color: #555;
}

/* 按钮颜色主题 */
.action-item.blue .icon-wrapper { background: linear-gradient(135deg, #409EFF, #79bbff); }
.action-item.green .icon-wrapper { background: linear-gradient(135deg, #67C23A, #95d475); }
.action-item.orange .icon-wrapper { background: linear-gradient(135deg, #E6A23C, #f3d19e); }
.action-item.purple .icon-wrapper { background: linear-gradient(135deg, #909399, #b1b3b8); }

/* 提示模块 */
.system-desc {
  background: #ecf5ff;
  border-left: 5px solid #409EFF;
  padding: 12px 15px;
  border-radius: 4px;
  color: #409EFF;
  font-size: 13px;
  margin-top: auto; /* 自动推到最底部 */
}

/* 公告列表 */
.notice-list {
  list-style: none;
  padding: 0;
  margin: 0;
}
.notice-list li {
  display: flex;
  align-items: center;
  padding: 15px 10px;
  border-bottom: 1px solid #f0f2f5;
  transition: background-color 0.3s;
  border-radius: 4px;
}
.notice-list li.clickable { cursor: pointer; }
.notice-list li.clickable:hover { background-color: #f5f7fa; }
.notice-list li:last-child { border-bottom: none; }

.tag {
  padding: 2px 8px;
  border-radius: 4px;
  font-size: 12px;
  margin-right: 10px;
  color: white;
  min-width: 40px;
  text-align: center;
}
.tag.urgent { background-color: #ff7875; }
.tag.normal { background-color: #69c0ff; }
.text { color: #606266; font-size: 14px; }
</style>