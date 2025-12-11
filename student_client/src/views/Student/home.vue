<template>
  <div class="student-home">
    <div class="welcome-banner">
      <div class="banner-text">
        <h2>Hi, {{ studentName }} 同学 </h2>
        <p>新的一天，继续加油！</p >
      </div>
      <div class="banner-img">
        < img :src="https://cdn-icons-png.flaticon.com/512/3426/3426653.png" alt="study"/>
      </div>
    </div>

    <el-row :gutter="20" class="stat-row">
      <el-col :span="8" v-for="(item, index) in statCards" :key="index">
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

    <el-row :gutter="20" class="content-row">
      <el-col :span="16" class="equal-height-col">
        <el-card class="dashboard-card fit-height" shadow="hover">
          <div slot="header" class="card-header">
            <span><i class="el-icon-menu"></i> 学习中心</span>
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
        </el-card>
      </el-col>

      <el-col :span="8" class="equal-height-col">
        <el-card class="dashboard-card fit-height" shadow="hover">
          <div slot="header" class="card-header">
            <span><i class="el-icon-bell"></i> 最新通知</span>
          </div>
          <ul class="notification-list">
            <li v-for="(notice, i) in notifications" :key="i" @click="viewNotice(notice.id)" class="clickable-notice">
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
      statCards: [
        { label: '已选课程', value: '-', icon: 'el-icon-reading', color: '#409EFF', bg: '#ecf5ff' },
        { label: '已修学分', value: '-', icon: 'el-icon-collection', color: '#67C23A', bg: '#f0f9eb' },
        { label: '加权成绩', value: '-', icon: 'el-icon-data-line', color: '#E6A23C', bg: '#fdf6ec' },
      ],
      notifications: [
        { id: 1, day: '15', month: 'DEC', title: '2025-2026学年秋季期末考试安排的通知', tag: '教务处' },
        { id: 2, day: '20', month: 'DEC', title: '图书馆关于2026年元旦放假安排的通知', tag: '图书馆' },
        { id: 3, day: '10', month: 'DEC', title: '关于开展2026年寒假社会实践活动的通知', tag: '团委' },
      ]
    }
  },
  
  created() {
    this.fetchAcademicData();
  },

  methods: {
    viewNotice(id) {
      this.$router.push(`/notification/${id}`);
    },
    
    fetchAcademicData() {
      const sid = sessionStorage.getItem('sid');
      const term = sessionStorage.getItem('currentTerm');
      
      if (!sid || !term) return;

      const that = this;
      axios.get(`http://localhost:10086/SCT/findBySid/${sid}/${term}`).then(function (resp) {
        const courseList = resp.data;
        
        if (courseList) {
          const courseCount = courseList.length;
          
          let totalCredits = 0; // 所有已选课程的学分总和
          let weightedSum = 0;  // 加权总分 (成绩 * 学分)
          let validCredits = 0; // 参与加权计算的学分总和 (即已出成绩的课程)
          
          courseList.forEach(course => {
            const credit = parseFloat(course.ccredit) || 0;
            const grade = parseFloat(course.grade) || 0;
            
            // 只要选了课，就算入总学分（用于显示"已修学分"）
            totalCredits += credit;
            
            // 只有成绩不为0（已打分）的课程，才计入加权计算
            if (grade !== 0) {
              weightedSum += credit * grade;
              validCredits += credit;
            }
          });

          let weightedAverage = 0;
          // 分母使用 validCredits 而不是 totalCredits
          if (validCredits > 0) {
            weightedAverage = (weightedSum / validCredits).toFixed(2);
          }

          that.statCards[0].value = courseCount.toString();
          that.statCards[1].value = totalCredits.toString();
          that.statCards[2].value = weightedAverage.toString();
        }
      }).catch(err => {
        console.error("获取首页数据失败:", err);
        that.$message.error("无法加载学业统计数据");
      });
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
}
.stat-card ::v-deep .el-card__body {
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

/* 布局调整 */
.content-row {
  display: flex;
  align-items: stretch;
  flex-wrap: wrap;
}
.equal-height-col {
  display: flex;
  flex-direction: column;
}

.dashboard-card {
  border-radius: 12px;
  border: none;
  display: flex;
  flex-direction: column;
  flex: 1;
}

.dashboard-card ::v-deep .el-card__body {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 0 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.quick-actions {
  flex: 1;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
}

.action-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
  padding: 20px 0;
  border-radius: 8px;
}
.action-item:hover { 
  transform: translateY(-3px); 
  background: #f5f7fa; 
}
.icon-box {
  width: 60px;
  height: 60px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 26px;
  color: white;
  margin-bottom: 12px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}
.icon-box.blue { background: linear-gradient(135deg, #409EFF, #79bbff); }
.icon-box.green { background: linear-gradient(135deg, #67C23A, #95d475); }
.icon-box.purple { background: linear-gradient(135deg, #a0cfff, #b37feb); }
.icon-box.orange { background: linear-gradient(135deg, #E6A23C, #f3d19e); }

/* 通知列表 */
.notification-list {
  list-style: none;
  padding: 15px 0;
  margin: 0;
}
.notification-list li {
  display: flex;
  margin-bottom: 25px;
  align-items: flex-start;
}
.notification-list li:last-child {
  margin-bottom: 0;
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

.clickable-notice {
  cursor: pointer;
  transition: background-color 0.3s;
  padding: 5px;
  border-radius: 4px;
}
.clickable-notice:hover {
  background-color: #f5f7fa;
}
</style>