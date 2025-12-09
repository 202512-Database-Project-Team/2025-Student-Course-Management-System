<template>
  <div class="student-home">
    <div class="welcome-banner">
      <div class="banner-text">
        <h2>Hi, {{ studentName }} 同学 👋</h2>
        <p>新的一天，继续加油！距离期末考试还有 <strong>42</strong> 天。</p>
      </div>
      <div class="banner-img">
        <img src="https://cdn-icons-png.flaticon.com/512/3426/3426653.png" alt="study" />
      </div>
    </div>

    <el-row :gutter="20" class="stat-row">
      <el-col :span="6" v-for="(item, index) in statCards" :key="index">
        <el-card shadow="hover" class="stat-card" :style="{ borderLeft: '4px solid ' + item.color }">
          <div class="stat-content">
            <div class="stat-value" :style="{ color: item.color }">{{ item.value }}</div>
            <div class="stat-label">{{ item.label }}</div>
          </div>
          <div class="stat-icon" :style="{ background: item.bg }">
            <i :class="item.icon" :style="{ color: item.color }"></i>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20">
      <el-col :span="16">
        <el-card class="dashboard-card" shadow="hover">
          <div slot="header" class="card-header">
            <span><i class="el-icon-menu"></i> 学习中心</span>
            <el-button type="text">查看全部</el-button>
          </div>
          <div class="quick-actions">
            <div class="action-item" @click="$router.push('/studentSelectCourse')">
              <div class="icon-box blue"><i class="el-icon-notebook-2"></i></div>
              <span>在线选课</span>
            </div>
            <div class="action-item" @click="$router.push('/querySelectedCourse')">
              <div class="icon-box green"><i class="el-icon-date"></i></div>
              <span>我的课表</span>
            </div>
            <div class="action-item" @click="$router.push('/queryCourseGrade')">
              <div class="icon-box purple"><i class="el-icon-trophy"></i></div>
              <span>成绩查询</span>
            </div>
            <div class="action-item" @click="$router.push('/updateInfoHome')">
              <div class="icon-box orange"><i class="el-icon-user"></i></div>
              <span>个人信息</span>
            </div>
          </div>
          
          <div class="today-course">
            <h4>📅 今日课程 (3)</h4>
            <el-table :data="todayCourses" style="width: 100%" :show-header="false" size="small">
              <el-table-column prop="time" width="120"></el-table-column>
              <el-table-column prop="name"></el-table-column>
              <el-table-column prop="room" align="right"></el-table-column>
              <el-table-column width="80" align="right">
                <template slot-scope="scope">
                  <el-tag size="mini" :type="scope.row.status === '进行中' ? 'success' : 'info'">{{ scope.row.status }}</el-tag>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </el-card>
      </el-col>

      <el-col :span="8">
        <el-card class="dashboard-card" shadow="hover">
          <div slot="header" class="card-header">
            <span><i class="el-icon-bell"></i> 最新通知</span>
          </div>
          <ul class="notification-list">
            <li v-for="(notice, i) in notifications" :key="i">
              <div class="notice-date">
                <span class="day">{{ notice.day }}</span>
                <span class="month">{{ notice.month }}</span>
              </div>
              <div class="notice-content">
                <div class="notice-title">{{ notice.title }}</div>
                <div class="notice-tag">{{ notice.tag }}</div>
              </div>
            </li>
          </ul>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "studentHome",
  data() {
    return {
      studentName: sessionStorage.getItem('name') || '同学',
      // 模拟数据
      statCards: [
        { label: '已选课程', value: '6', icon: 'el-icon-reading', color: '#409EFF', bg: '#ecf5ff' },
        { label: '已修学分', value: '24.5', icon: 'el-icon-collection', color: '#67C23A', bg: '#f0f9eb' },
        { label: '平均绩点', value: '3.82', icon: 'el-icon-data-line', color: '#E6A23C', bg: '#fdf6ec' },
        { label: '缺勤次数', value: '0', icon: 'el-icon-warning-outline', color: '#F56C6C', bg: '#fef0f0' },
      ],
      todayCourses: [
        { time: '08:00 - 09:35', name: '高等数学 (上)', room: '教学楼 A101', status: '已结束' },
        { time: '10:00 - 11:35', name: 'Java 程序设计', room: '计算机机房 302', status: '进行中' },
        { time: '14:00 - 15:35', name: '大学英语 IV', room: '外语楼 C205', status: '未开始' },
      ],
      notifications: [
        { day: '15', month: 'JUN', title: '关于2025年春季学期期末考试安排的通知', tag: '教务处' },
        { day: '12', month: 'JUN', title: '图书馆端午节闭馆通知', tag: '图书馆' },
        { day: '08', month: 'JUN', title: '第十届“互联网+”大学生创新创业大赛报名', tag: '团委' },
      ]
    }
  }
}
</script>

<style scoped>
.student-home {
  padding: 10px;
}

/* Banner 样式 */
.welcome-banner {
  background: linear-gradient(120deg, #84fab0 0%, #8fd3f4 100%);
  border-radius: 16px;
  padding: 30px 50px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  color: #fff;
  box-shadow: 0 8px 20px rgba(132, 250, 176, 0.3);
}

.banner-text h2 {
  font-size: 28px;
  margin-bottom: 10px;
  text-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.banner-text p {
  font-size: 16px;
  opacity: 0.9;
}
.banner-img img {
  height: 120px;
  filter: drop-shadow(0 5px 15px rgba(0,0,0,0.1));
}

/* 统计卡片 */
.stat-row { margin-bottom: 25px; }
.stat-card {
  border: none;
  border-radius: 12px;
  height: 100px;
  display: flex;
  align-items: center;
  /* El-card body 修正 */
}
/* 深度选择器修正 el-card 内部 padding */
::v-deep .el-card__body {
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px !important;
}

.stat-value {
  font-size: 28px;
  font-weight: 700;
  line-height: 1.2;
}
.stat-label {
  font-size: 13px;
  color: #909399;
  margin-top: 5px;
}
.stat-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}

/* 功能区 */
.dashboard-card {
  border-radius: 12px;
  border: none;
  margin-bottom: 20px;
}
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}
.quick-actions {
  display: flex;
  justify-content: space-around;
  margin-bottom: 30px;
  padding: 10px 0;
}
.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  transition: transform 0.2s;
}
.action-item:hover { transform: translateY(-3px); }
.icon-box {
  width: 60px;
  height: 60px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 26px;
  color: white;
  margin-bottom: 10px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}
.icon-box.blue { background: linear-gradient(135deg, #409EFF, #79bbff); }
.icon-box.green { background: linear-gradient(135deg, #67C23A, #95d475); }
.icon-box.purple { background: linear-gradient(135deg, #a0cfff, #b37feb); } /* 紫色调整 */
.icon-box.orange { background: linear-gradient(135deg, #E6A23C, #f3d19e); }

.today-course h4 {
  margin: 0 0 15px 0;
  color: #606266;
  font-size: 15px;
}

/* 通知列表 */
.notification-list {
  list-style: none;
  padding: 0;
  margin: 0;
}
.notification-list li {
  display: flex;
  margin-bottom: 20px;
  align-items: flex-start;
}
.notice-date {
  background: #f4f4f5;
  border-radius: 8px;
  padding: 5px 10px;
  text-align: center;
  margin-right: 15px;
  min-width: 50px;
}
.notice-date .day { display: block; font-size: 18px; font-weight: bold; color: #303133; }
.notice-date .month { display: block; font-size: 10px; color: #909399; text-transform: uppercase; }
.notice-content { flex: 1; }
.notice-title { font-size: 14px; color: #303133; margin-bottom: 5px; line-height: 1.4; }
.notice-tag { font-size: 12px; color: #909399; }
</style>