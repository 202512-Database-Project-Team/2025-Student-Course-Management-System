<template>
  <div class="notification-detail">
    <el-card shadow="hover">
      <div slot="header">
        <el-page-header @back="goBack" content="通知详情"></el-page-header>
      </div>
      
      <div v-if="currentNotice" class="article">
        <h2 class="title">{{ currentNotice.title }}</h2>
        <div class="meta">
          <el-tag size="small" type="primary">{{ currentNotice.tag }}</el-tag>
          <span class="date"><i class="el-icon-date"></i> {{ currentNotice.fullDate }}</span>
        </div>
        <el-divider></el-divider>
        <div class="content" v-html="currentNotice.content"></div>
      </div>
      
      <el-empty v-else description="未找到相关通知"></el-empty>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "NotificationDetail",
  data() {
    return {
      currentNotice: null,
      // 模拟数据库：包含学生端(1-3)、教师端(101-104)、管理员端(201-203)
      noticeDatabase: {
        // ================= 学生端通知 (已更新为12月) =================
        1: {
          title: '关于2025-2026学年第一学期期末考试安排的通知',
          tag: '教务处',
          fullDate: '2025年12月15日',
          content: `
            <p>各位同学：</p >
            <p>2025-2026学年第一学期期末考试将于<strong>2026年1月5日</strong>正式开始，至1月16日结束。请各位同学注意以下事项：</p >
            <ol>
              <li>请携带学生证和身份证双证进入考场，证件不齐者不得参加考试。</li>
              <li>严禁携带手机、智能手表等电子通讯设备，一经发现按作弊处理。</li>
              <li>具体考场安排及座次表请登录教务系统“我的考试”模块查询。</li>
            </ol>
            <p>祝大家复习顺利，取得优异成绩！</p >
            <p style="text-align: right; margin-top: 20px;">教务处</p >
          `
        },
        2: {
          title: '图书馆关于2026年元旦放假安排的通知',
          tag: '图书馆',
          fullDate: '2025年12月20日',
          content: `
            <p>各位读者：</p >
            <p>根据学校关于2026年元旦放假的通知精神，结合图书馆实际情况，现将节日期间开放时间安排如下：</p >
            <ul>
              <li><strong>2026年1月1日（元旦）：</strong> 全天闭馆</li>
              <li><strong>2026年1月2日起：</strong> 恢复正常开放（8:00 - 22:00）</li>
            </ul>
            <p>闭馆期间电子资源24小时正常服务。请大家互相转告，合理安排学习时间。</p >
            <p style="text-align: right; margin-top: 20px;">校图书馆</p >
          `
        },
        3: {
          title: '关于开展2026年寒假社会实践活动的通知',
          tag: '团委',
          fullDate: '2025年12月10日',
          content: `
            <p>各学院、各位同学：</p >
            <p>为引导广大青年学生在社会课堂中受教育、长才干、作贡献，校团委决定开展2026年寒假社会实践活动。</p >
            <p><strong>活动主题：</strong> 青春力行，奉献社会</p >
            <p><strong>报名时间：</strong> 即日起至2025年12月31日</p >
            <p>请有意向的团队或个人登录“第二课堂”系统进行立项申报，并提交《社会实践安全承诺书》。</p >
            <p style="text-align: right; margin-top: 20px;">校团委</p >
          `
        },

        // ================= 教师端通知 (保持不变) =================
        101: {
          title: '关于2025-2026学年第一学期期末教学工作安排的通知',
          tag: '教务处',
          fullDate: '2025年12月15日',
          content: `<p>期末考试定于2026年1月5日进行，请各位老师做好命题工作。</p >`
        },
        102: {
          title: '2025年度年终科研成果统计与奖励申报启动',
          tag: '科研处',
          fullDate: '2025年12月12日',
          content: `<p>请登录科研系统进行成果登记，截止日期12月31日。</p >`
        },
        103: {
          title: '教务处关于2026年元旦及寒假放假时间的通知',
          tag: '校办',
          fullDate: '2025年12月08日',
          content: `<p>元旦放假1天，寒假自1月19日开始。</p >`
        },
        104: {
          title: '关于开展期末试卷专项检查工作的通知',
          tag: '质评中心',
          fullDate: '2025年12月05日',
          content: `<p>质评中心将于12月20日抽查上学期期末试卷，请各学院做好准备。</p >`
        },

        // ================= 管理员端通知 (保持不变) =================
        201: {
          title: '期末成绩录入截止通知',
          tag: '系统通知',
          fullDate: '2025年12月30日',
          content: `
            <p><strong>系统重要提醒：</strong></p >
            <p>本学期期末成绩录入系统将于<strong>2026年1月20日 24:00</strong>准时关闭。</p >
            <p>请管理员督促各学院教师在此时间节点前完成所有成绩的录入与提交工作。系统关闭后，如需补录成绩，需走线下审批流程并由超级管理员后台解锁。</p >
            <p style="text-align: right; margin-top: 20px;">教务网络管理中心</p >
          `
        },
        202: {
          title: '系统升级维护公告 v2.0',
          tag: '技术部',
          fullDate: '2025年12月28日',
          content: `
            <p>尊敬的用户：</p >
            <p>为了提供更优质的服务，教务系统计划于<strong>2026年1月1日 00:00 - 04:00</strong>进行版本更新维护（v2.0）。</p >
            <p><strong>更新内容：</strong></p >
            <ul>
              <li>优化了选课高并发时的排队机制；</li>
              <li>修复了部分报表导出格式错乱的问题；</li>
              <li>增强了数据库的安全性备份策略。</li>
            </ul>
            <p>维护期间系统将无法访问，请提前做好相关安排。</p >
            <p style="text-align: right; margin-top: 20px;">信息化建设办公室</p >
          `
        },
        203: {
          title: '新学期选课时间安排',
          tag: '教务处',
          fullDate: '2025年12月25日',
          content: `
            <p>2025-2026学年第二学期选课工作即将开始，具体参数配置如下：</p >
            <ul>
              <li><strong>第一轮（预选）：</strong> 2026年1月10日 10:00 - 1月12日 16:00</li>
              <li><strong>第二轮（正选）：</strong> 2026年1月15日 10:00 - 1月17日 16:00</li>
              <li><strong>第三轮（补退选）：</strong> 开学第一周</li>
            </ul>
            <p>请管理员提前在“选课管理”模块检查课程容量及时间冲突设置。</p >
            <p style="text-align: right; margin-top: 20px;">教务处</p >
          `
        }
      }
    };
  },
  created() {
    // 获取路由参数中的 id
    const id = this.$route.params.id;
    this.currentNotice = this.noticeDatabase[id];
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    }
  }
};
</script>

<style scoped>
.notification-detail {
  padding: 20px;
}
.title {
  text-align: center;
  margin-top: 10px;
  font-size: 24px;
  color: #303133;
}
.meta {
  text-align: center;
  margin-top: 15px;
  color: #909399;
}
.date {
  margin-left: 15px;
  font-size: 14px;
}
.content {
  line-height: 1.8;
  font-size: 16px;
  color: #606266;
  padding: 0 20px;
  margin-top: 20px;
}
.content >>> p {
  margin-bottom: 15px;
  text-align: justify;
}
.content >>> ul, .content >>> ol {
  padding-left: 20px;
  margin-bottom: 15px;
}
</style>