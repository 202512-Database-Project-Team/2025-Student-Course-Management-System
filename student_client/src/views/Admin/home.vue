<template>
  <div class="admin-home">
    <div class="welcome-banner">
      <div class="banner-content">
        <h2>早安，管理员</h2>
        <p>今天是 {{ today }}，祝你工作愉快！系统运行状态良好。</p>
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

    <el-row :gutter="20">
      <el-col :span="16">
        <el-card class="chart-card">
          <div slot="header" class="clearfix">
            <span><i class="el-icon-pie-chart"></i> 快速操作</span>
          </div>
          <div class="quick-actions">
            <el-button type="primary" icon="el-icon-plus" plain @click="$router.push('/addStudent')">添加学生</el-button>
            <el-button type="success" icon="el-icon-user-solid" plain @click="$router.push('/addTeacher')">添加教师</el-button>
            <el-button type="warning" icon="el-icon-notebook-1" plain @click="$router.push('/addCourse')">添加课程</el-button>
            <el-button type="info" icon="el-icon-search" plain @click="$router.push('/studentList')">学生查询</el-button>
          </div>
          <div class="system-desc">
            <p>💡 提示：点击左侧菜单栏可进行详细的教务管理操作。</p>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="chart-card">
          <div slot="header">
            <span><i class="el-icon-bell"></i> 系统公告</span>
          </div>
          <ul class="notice-list">
            <li>
              <span class="tag urgent">紧急</span>
              <span class="text">期末成绩录入截止通知</span>
            </li>
            <li>
              <span class="tag normal">通知</span>
              <span class="text">系统升级维护公告 v2.0</span>
            </li>
            <li>
              <span class="tag normal">通知</span>
              <span class="text">新学期选课时间安排</span>
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
      // 模拟的统计数据
      statCards: [
        { label: '学生总数', value: '2,450', icon: 'el-icon-user', color: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)' },
        { label: '教师总数', value: '186', icon: 'el-icon-s-custom', color: 'linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%)' },
        { label: '课程数量', value: '85', icon: 'el-icon-reading', color: 'linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%)' },
        { label: '今日访问', value: '532', icon: 'el-icon-data-analysis', color: 'linear-gradient(135deg, #fccb90 0%, #d57eeb 100%)' },
      ]
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

/* 快捷操作 */
.quick-actions {
  display: flex;
  gap: 15px;
  margin-bottom: 20px;
}
.system-desc {
  background: #f4f4f5;
  padding: 15px;
  border-radius: 8px;
  color: #909399;
  font-size: 13px;
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
  padding: 12px 0;
  border-bottom: 1px solid #f0f2f5;
}
.notice-list li:last-child {
  border-bottom: none;
}
.tag {
  padding: 2px 8px;
  border-radius: 4px;
  font-size: 12px;
  margin-right: 10px;
  color: white;
}
.tag.urgent { background-color: #ff7875; }
.tag.normal { background-color: #69c0ff; }
.text { color: #606266; font-size: 14px; }
</style>