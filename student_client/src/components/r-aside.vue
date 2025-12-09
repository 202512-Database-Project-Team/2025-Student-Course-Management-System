<template>
  <el-aside width="240px" class="custom-aside">
    <el-menu
      :default-active="$route.path"
      class="el-menu-vertical-demo"
      router
      text-color="#555"
      active-text-color="#409EFF"
      :unique-opened="true">
      
      <div v-for="(item, i) in navList" :key="i">
        <el-menu-item v-if="!item.children" :index="item.name">
          <i class="el-icon-menu"></i>
          <span slot="title">{{ item.navItem }}</span>
        </el-menu-item>

        <el-submenu v-else :index="item.name">
          <template slot="title">
            <i :class="item.icon || 'el-icon-location'"></i>
            <span>{{ item.navItem }}</span>
          </template>
          <el-menu-item 
            v-for="(subItem, j) in item.children" 
            :key="j" 
            :index="subItem.name">
            {{ subItem.navItem }}
          </el-menu-item>
        </el-submenu>
      </div>
    </el-menu>
  </el-aside>
</template>

<script>
export default {
  name: "r-aside",
  data() {
    return {
      navList: [], // 保持原逻辑不变
    }
  },
  mounted() {
    // 保持原逻辑，从 SessionStorage 获取菜单
    const type = sessionStorage.getItem('type')
    if (type === 'student') {
      this.navList = [
        {name: '/student/studentHome', navItem: '首页', icon: 'el-icon-s-home'},
        {name: '/student/selectCourse', navItem: '选课管理', icon: 'el-icon-collection', children: [
            {name: '/studentSelectCourse', navItem: '学生选课'},
            {name: '/querySelectedCourse', navItem: '课表查询'}
          ]},
        {name: '/student/courseGrade', navItem: '成绩查询', icon: 'el-icon-medal-1', children: [
            {name: '/queryCourseGrade', navItem: '我的成绩'}
          ]},
        {name: '/student/updateInfo', navItem: '个人信息', icon: 'el-icon-user', children: [
            {name: '/updateInfoHome', navItem: '信息维护'}
          ]}
      ]
    } else if (type === 'teacher') {
       this.navList = [
        {name: '/teacher/teacherHome', navItem: '首页', icon: 'el-icon-s-home'},
        {name: '/teacher/courseManage', navItem: '授课管理', icon: 'el-icon-reading', children: [
            {name: '/myOfferCourse', navItem: '我开设的课程'},
            {name: '/offerCourse', navItem: '申请开课'}
          ]},
        {name: '/teacher/gradeCourseManage', navItem: '成绩管理', icon: 'el-icon-edit-outline', children: [
            {name: '/teacherQueryGradeCourseManage', navItem: '录入成绩'}
          ]},
        {name: '/teacher/updateInfo', navItem: '个人信息', icon: 'el-icon-user', children: [
            {name: '/updateInfoHome', navItem: '信息维护'}
          ]}
      ]
    } else if (type === 'admin') {
      this.navList = [
        {name: '/admin/adminHome', navItem: '首页', icon: 'el-icon-s-home'},
        {name: '/admin/studentManage', navItem: '学生管理', icon: 'el-icon-user-solid', children: [
            {name: '/studentList', navItem: '学生列表'},
            {name: '/addStudent', navItem: '添加学生'}
          ]},
        {name: '/admin/teacherManage', navItem: '教师管理', icon: 'el-icon-s-custom', children: [
            {name: '/queryTeacher', navItem: '教师列表'},
            {name: '/addTeacher', navItem: '添加教师'}
          ]},
        {name: '/admin/courseManage', navItem: '课程管理', icon: 'el-icon-notebook-2', children: [
            {name: '/courseList', navItem: '课程列表'},
            {name: '/addCourse', navItem: '添加课程'}
          ]},
        {name: '/admin/gradeCourseManage', navItem: '排课管理', icon: 'el-icon-date', children: [
            {name: '/queryCourseTeacher', navItem: '开课列表'}
          ]}
      ]
    }
  }
}
</script>

<style scoped>
/* 侧边栏样式重构 */
.custom-aside {
  height: 100%;
  transition: width 0.3s;
  overflow-x: hidden;
}

.el-menu {
  border-right: none !important; /* 去掉右侧那条难看的线 */
  padding-top: 20px;
}

/* 菜单项样式 */
.el-menu-item, .el-submenu__title {
  height: 50px;
  line-height: 50px;
  margin: 4px 10px; /* 四周留白，形成悬浮感 */
  border-radius: 8px; /* 菜单项圆角 */
  font-weight: 500;
}

.el-menu-item:hover, .el-submenu__title:hover {
  background-color: #f0f7ff !important;
  color: #409EFF !important;
}

/* 选中项高亮样式：左侧竖条风格 -> 改为全背景淡蓝风格 */
.el-menu-item.is-active {
  background: #e6f7ff !important;
  color: #1890ff !important;
  font-weight: bold;
  position: relative;
}

/* 选中项左边的小蓝条 */
.el-menu-item.is-active::before {
  content: "";
  position: absolute;
  left: 0;
  top: 10%;
  height: 80%;
  width: 4px;
  background-color: #1890ff;
  border-radius: 0 4px 4px 0;
}
</style>