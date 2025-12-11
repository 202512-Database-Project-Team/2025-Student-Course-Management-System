<template>
  <div class="teacher-home">
    <div class="teacher-banner">
      <div class="txt-area">
        <h1>欢迎登录，{{ teacherName }} 老师</h1>
        <p><i class="el-icon-coffee"></i> 所有的为师者，都是在用生命点亮星空。您辛苦了！</p >
      </div>
      <div class="decoration">
        <i class="el-icon-office-building"></i>
      </div>
    </div>

    <el-row :gutter="20" class="data-row">
      <el-col :span="8" v-for="(item, index) in statCards" :key="index">
        <div class="data-card" :class="'card-' + (index + 1)">
          <div class="num">{{ item.value }}</div>
          <div class="txt">{{ item.label }}</div>
          <i class="bg-icon" :class="item.icon"></i>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="content-row">
      <el-col :span="18" class="equal-height-col">
        <el-card shadow="hover" class="main-card">
          <div slot="header" class="clearfix">
            <span style="font-size: 16px; font-weight: bold;">🎓 常用教学服务</span>
          </div>
          <div class="service-grid">
            <div class="service-item" @click="$router.push('/teacherQueryGradeCourseManage')">
              <div class="s-icon c-blue"><i class="el-icon-edit"></i></div>
              <h3>成绩录入</h3>
              <p>期末/平时成绩登记</p >
            </div>
            <div class="service-item" @click="$router.push('/offerCourse')">
              <div class="s-icon c-purple"><i class="el-icon-circle-plus-outline"></i></div>
              <h3>申请开课</h3>
              <p>新学期课程申报</p >
            </div>
            <div class="service-item" @click="$router.push('/myOfferCourse')">
              <div class="s-icon c-green"><i class="el-icon-collection"></i></div>
              <h3>我的课程</h3>
              <p>查看已开设课程信息</p >
            </div>
            <div class="service-item" @click="$router.push('/updateInfoHome')">
              <div class="s-icon c-orange"><i class="el-icon-setting"></i></div>
              <h3>信息维护</h3>
              <p>个人资料修改</p >
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :span="6" class="equal-height-col">
        <el-card shadow="hover" class="side-card">
          <div slot="header">
            <b>📢 教学公告</b>
          </div>
          <div class="notice-item" v-for="n in notices" :key="n.id" @click="viewNotice(n.id)">
            <div class="n-title">{{ n.title }}</div>
            <div class="n-date">{{ n.date }}</div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "teacherHome",
  data() {
    return {
      teacherName: sessionStorage.getItem('name') || '教师',
      // 统计卡片数据
      statCards: [
        { label: '本学期执教课程', value: '-', icon: 'el-icon-reading' },
        { label: '授课学生总数', value: '-', icon: 'el-icon-user' },
        { label: '待录入成绩课程', value: '-', icon: 'el-icon-edit-outline' },
      ],
      notices: [
        { id: 101, title: '关于2025-2026学年第一学期期末教学工作安排的通知', date: '2025-12-15' },
        { id: 102, title: '2025年度年终科研成果统计与奖励申报启动', date: '2025-12-12' },
        { id: 103, title: '教务处关于2026年元旦及寒假放假时间的通知', date: '2025-12-08' },
        { id: 104, title: '关于开展期末试卷专项检查工作的通知', date: '2025-12-05' },
      ]
    }
  },
  
  created() {
    this.fetchTeacherData();
  },

  methods: {
    viewNotice(id) {
      this.$router.push(`/notification/${id}`);
    },

    fetchTeacherData() {
      const tid = sessionStorage.getItem('tid');
      const term = sessionStorage.getItem('currentTerm');
      const that = this;

      if (!tid || !term) return;

      // 1. 获取本学期执教课程数量
      axios.get(`http://localhost:10086/courseTeacher/findMyCourse/${tid}/${term}`)
        .then(function (resp) {
          if (resp.data) {
            that.statCards[0].value = resp.data.length.toString();
          }
        })
        .catch(err => console.error("获取课程失败", err));

      // 2. 获取授课学生总数 & 计算待录入成绩课程
      const searchForm = {
        tid: tid,
        term: term,
        sid: null,
        sname: null,
        sFuzzy: true,
        tname: null,
        tFuzzy: true,
        cid: null,
        cname: null,
        cFuzzy: true,
        lowBound: null,
        highBound: null
      };

      axios.post("http://localhost:10086/SCT/findBySearch", searchForm)
        .then(function (resp) {
          const sctList = resp.data;
          if (sctList) {
            // 更新授课学生总数
            that.statCards[1].value = sctList.length.toString();

            // 计算待录入成绩课程
            const pendingCourses = new Set();
            sctList.forEach(record => {
              const grade = record.grade;
              if (grade === 0 || grade === null || grade === '' || grade === undefined) {
                pendingCourses.add(record.cid);
              }
            });

            that.statCards[2].value = pendingCourses.size.toString();
          }
        })
        .catch(err => console.error("获取成绩记录失败", err));
    }
  }
}
</script>

<style scoped>
.teacher-home { padding: 10px; }

/* Banner */
.teacher-banner {
  background: linear-gradient(to right, #6a11cb 0%, #2575fc 100%);
  border-radius: 12px;
  color: white;
  padding: 40px;
  margin-bottom: 25px;
  position: relative;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(37, 117, 252, 0.3);
}
.txt-area h1 { margin: 0 0 10px 0; font-size: 26px; }
.txt-area p { opacity: 0.8; margin: 0; font-size: 15px; }
.decoration i {
  position: absolute;
  right: 20px;
  bottom: -20px;
  font-size: 150px;
  opacity: 0.15;
  transform: rotate(-15deg);
}

/* 顶部数据卡片 */
.data-row { margin-bottom: 25px; }
.data-card {
  height: 120px;
  border-radius: 12px;
  color: white;
  padding: 25px;
  position: relative;
  overflow: hidden;
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
  transition: transform 0.3s;
  cursor: default;
}
.data-card:hover { transform: translateY(-5px); }
.data-card .num { font-size: 32px; font-weight: bold; }
.data-card .txt { font-size: 13px; opacity: 0.9; margin-top: 5px; }
.data-card .bg-icon {
  position: absolute;
  right: 15px;
  bottom: 10px;
  font-size: 50px;
  opacity: 0.2;
}
.card-1 { background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%); }
.card-2 { background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%); }
.card-3 { background: linear-gradient(135deg, #fccb90 0%, #d57eeb 100%); }

/* 布局调整：核心样式 */
.content-row {
  display: flex;
  align-items: stretch; /* 关键：子元素高度拉伸 */
  flex-wrap: wrap;
}
.equal-height-col {
  display: flex;
  flex-direction: column;
}
.main-card, .side-card {
  flex: 1; /* 撑满列的高度 */
  display: flex;
  flex-direction: column;
  border-radius: 12px;
  border: none;
}
/* 确保卡片内容区域也能撑开 */
.main-card ::v-deep .el-card__body, 
.side-card ::v-deep .el-card__body {
  flex: 1;
  display: flex;
  flex-direction: column;
}

/* 常用服务 Grid - 垂直居中对齐 */
.service-grid {
  flex: 1; /* 占满剩余空间 */
  display: flex;
  justify-content: space-between;
  align-items: center; /* 垂直居中 */
  text-align: center;
  padding: 10px 0;
}
.service-item {
  flex: 1;
  padding: 20px;
  border-radius: 8px;
  cursor: pointer;
  transition: background 0.3s;
}
.service-item:hover { background: #f5f7fa; }
.s-icon {
  width: 50px;
  height: 50px;
  margin: 0 auto 15px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}
.s-icon.c-blue { background: #e6f7ff; color: #1890ff; }
.s-icon.c-purple { background: #f9f0ff; color: #722ed1; }
.s-icon.c-green { background: #f6ffed; color: #52c41a; }
.s-icon.c-orange { background: #fff7e6; color: #fa8c16; }

/* 侧边公告 */
.notice-item {
  border-bottom: 1px dashed #eee;
  padding: 15px 10px;
  cursor: pointer;
  border-radius: 4px;
  transition: background-color 0.2s;
}
.notice-item:hover {
  background-color: #f5f7fa;
}
.notice-item:last-child { border-bottom: none; }
.n-title { font-size: 14px; color: #333; margin-bottom: 5px; line-height: 1.4; }
.n-date { font-size: 12px; color: #bbb; }
</style>