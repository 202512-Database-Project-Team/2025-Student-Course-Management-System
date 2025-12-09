<template>
  <div class="teacher-home">
    <div class="teacher-banner">
      <div class="txt-area">
        <h1>欢迎登录，{{ teacherName }} 老师</h1>
        <p><i class="el-icon-coffee"></i> 所有的为师者，都是在用生命点亮星空。您辛苦了！</p>
      </div>
      <div class="decoration">
        <i class="el-icon-office-building"></i>
      </div>
    </div>

    <el-row :gutter="20" class="data-row">
      <el-col :span="6">
        <div class="data-card card-1">
          <div class="num">3</div>
          <div class="txt">本学期执教课程</div>
          <i class="bg-icon el-icon-reading"></i>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="data-card card-2">
          <div class="num">128</div>
          <div class="txt">授课学生总数</div>
          <i class="bg-icon el-icon-user"></i>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="data-card card-3">
          <div class="num">12</div>
          <div class="txt">本周待上课时</div>
          <i class="bg-icon el-icon-time"></i>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="data-card card-4">
          <div class="num">1</div>
          <div class="txt">待录入成绩课程</div>
          <i class="bg-icon el-icon-edit-outline"></i>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="20">
      <el-col :span="18">
        <el-card shadow="hover" class="main-card">
          <div slot="header" class="clearfix">
            <span style="font-size: 16px; font-weight: bold;">🎓 常用教学服务</span>
          </div>
          <div class="service-grid">
            <div class="service-item" @click="$router.push('/teacherQueryGradeCourseManage')">
              <div class="s-icon c-blue"><i class="el-icon-edit"></i></div>
              <h3>成绩录入</h3>
              <p>期末/平时成绩登记</p>
            </div>
            <div class="service-item" @click="$router.push('/offerCourse')">
              <div class="s-icon c-purple"><i class="el-icon-circle-plus-outline"></i></div>
              <h3>申请开课</h3>
              <p>新学期课程申报</p>
            </div>
            <div class="service-item" @click="$router.push('/myOfferCourse')">
              <div class="s-icon c-green"><i class="el-icon-collection"></i></div>
              <h3>我的课程</h3>
              <p>查看已开设课程信息</p>
            </div>
            <div class="service-item" @click="$router.push('/updateInfoHome')">
              <div class="s-icon c-orange"><i class="el-icon-setting"></i></div>
              <h3>信息维护</h3>
              <p>个人资料修改</p>
            </div>
          </div>
        </el-card>

        <el-card shadow="hover" class="main-card" style="margin-top: 20px;">
          <div slot="header">
            <span style="font-size: 16px; font-weight: bold;">📝 待办事项</span>
          </div>
          <el-table :data="todoList" style="width: 100%">
            <el-table-column prop="task" label="任务内容"></el-table-column>
            <el-table-column prop="ddl" label="截止日期" width="180"></el-table-column>
            <el-table-column prop="status" label="状态" width="100">
              <template slot-scope="scope">
                 <el-tag type="danger" size="small" v-if="scope.row.urgent">紧急</el-tag>
                 <el-tag type="info" size="small" v-else>普通</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="100">
              <template>
                <el-button type="text" size="small">处理</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>

      <el-col :span="6">
        <el-card shadow="hover" class="side-card">
          <div slot="header">
            <b>📢 教学公告</b>
          </div>
          <div class="notice-item" v-for="n in notices" :key="n.id">
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
      todoList: [
        { task: '《软件工程导论》期末成绩录入', ddl: '2025-06-20', urgent: true },
        { task: '提交下学期教学日历', ddl: '2025-07-01', urgent: false },
        { task: '参与本科生毕业设计答辩', ddl: '2025-06-15', urgent: true },
      ],
      notices: [
        { id:1, title: '关于开展2025年度教学质量评价的通知', date: '2025-06-01' },
        { id:2, title: '数字化教学平台升级维护公告', date: '2025-05-28' },
        { id:3, title: '关于举办青年教师教学竞赛的通知', date: '2025-05-15' },
      ]
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
/* 卡片配色 */
.card-1 { background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%); }
.card-2 { background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%); }
.card-3 { background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%); }
.card-4 { background: linear-gradient(135deg, #fccb90 0%, #d57eeb 100%); }

/* 常用服务 Grid */
.service-grid {
  display: flex;
  justify-content: space-between;
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

.service-item h3 { margin: 0 0 5px 0; font-size: 16px; color: #333; }
.service-item p { margin: 0; font-size: 12px; color: #999; }

/* 侧边公告 */
.notice-item {
  border-bottom: 1px dashed #eee;
  padding: 15px 0;
}
.notice-item:last-child { border-bottom: none; }
.n-title { font-size: 14px; color: #333; margin-bottom: 5px; line-height: 1.4; }
.n-date { font-size: 12px; color: #bbb; }
</style>