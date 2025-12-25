import Vue from 'vue';
import VueRouter from 'vue-router';
import login from '../views/login/index';
import admin from '../views/Admin/index';
import adminHome from '../views/Admin/home';
import studentManage from '../views/Admin/studentManage/index'
import addStudent from "@/views/Admin/studentManage/addStudent";
import studentList from "@/views/Admin/studentManage/studentList";
import editorStudent from "@/views/Admin/studentManage/editorStudent";
import teacherManage from "@/views/Admin/teacherManage/index"
import addTeacher from "@/views/Admin/teacherManage/addTeacher";
import editorTeacher from "@/views/Admin/teacherManage/editorTeacher";
import courseManage from "@/views/Admin/courseManage/index";
import addCourse from "@/views/Admin/courseManage/addCourse";
import teacher from "@/views/Teacher/index";
import queryStudent from "@/views/Admin/studentManage/queryStudent";
import queryTeacher from "@/views/Admin/teacherManage/queryTeacher";
import student from "@/views/Student/index";
import editorCourse from "@/views/Admin/courseManage/editorCourse";
import courseList from "@/views/Admin/courseManage/courseList";
import queryCourse from "@/views/Admin/courseManage/queryCourse";
import offerCourse from "@/views/Teacher/offerCourse";
import teacherHome from "@/views/Teacher/home";
import setCourse from "@/views/Teacher/setCourse";
import studentHome from "@/views/Student/home";
import myOfferCourse from "@/views/Teacher/myOfferCourse";
import CourseTeacherManage from "@/views/Admin/selectCourseManage/index";
import queryCourseTeacher from "@/views/Admin/selectCourseManage/queryCourseTeacher";
import studentSelectCourseManage from "@/views/Student/selectCourse/index";
import selectCourse from "@/views/Student/selectCourse/selectCourse";
import querySelectedCourse from "@/views/Student/selectCourse/querySelectedCourse";
import studentCourseGrade from "@/views/Student/courseGrade/index";
import queryCourseGrade from "@/views/Student/courseGrade/queryCourseGrade";
import queryGradeCourse from "@/views/Admin/gradeCourseManage/queryGradeCourse";
import editorGradeCourse from "@/views/Admin/gradeCourseManage/editorGradeCourse";
import teacherGradeCourseManage from "@/views/Teacher/teacherGradeCourseManage/index";
import teacherQueryGradeCourse from "@/views/Teacher/teacherGradeCourseManage/teacherQueryGradeCourse";
import teacherGradeCourseList from "@/views/Teacher/teacherGradeCourseManage/teacherGradeCourseList";
import teacherEditorGradeCourse from "@/views/Teacher/teacherGradeCourseManage/teacherEditorGradeCourse";
import updateInfo from "@/components/updateInfo";
import NotificationDetail from '@/views/Student/NotificationDetail';

// 🟢 新增：引入免修相关的组件
import StudentExemption from "@/views/Student/exemption/index";
import TeacherExemptionAudit from "@/views/Teacher/exemption/audit";

Vue.use(VueRouter)

const routes = [
  {
    // 随便定义的首页
    path: '/',
    name: 'index',
    component: login,
    redirect: '/login'
  },
  {
    // 登陆页
    path: '/login',
    name: 'login',
    component: login
  },
  {
    // admin 的路由
    path: '/admin',
    name: 'admin',
    redirect: '/adminHome',
    component: admin,
    meta: {requireAuth: true},
    children: [
      {
        path: '/adminHome',
        name: 'Hi! admin',
        component: adminHome,
        meta: {requireAuth: true},
        children: [
          {
            path: '/adminHome',
            name: 'admin 主页',
            component: adminHome,
            meta: {requireAuth: true},
          }
        ]
      },
      {
        path: '/studentManage',
        name: '学生管理',
        component: studentManage,
        meta: {requireAuth: true},
        children: [
          {
            path: '/addStudent',
            name: '添加学生',
            component: addStudent,
            meta: {requireAuth: true}
          },
          {
            path: '/studentList',
            name: '学生列表',
            component: studentList,
            meta: {requireAuth: true},
          },
          {
            path: '/editorStudent',
            name: '编辑学生',
            component: editorStudent,
            meta: {requireAuth: true}
          },
          {
            path: '/queryStudent',
            name: '搜索',
            component: queryStudent,
            meta: {requireAuth: true},
            children: [
              {
                path: '/queryStudent/studentList',
                component: studentList,
                meta: {requireAuth: true}
              }
            ]
          }
        ]
      },
      {
        path: '/teacherManage',
        name: '教师管理',
        component: teacherManage,
        meta: {requireAuth: true},
        children: [
          {
            path: '/addTeacher',
            name: '添加教师',
            component: addTeacher,
            meta: {requireAuth: true}
          },
          {
            path: '/queryTeacher',
            name: '教师列表',
            component: queryTeacher,
            meta: {requireAuth: true},
            children: [
            ]
          },
          {
            path: '/editorTeacher',
            name: '编辑教师',
            component: editorTeacher,
            meta: {requireAuth: true}
          },
        ]
      },
      {
        path: '/courseManage',
        name: '课程管理',
        component: courseManage,
        meta: {requireAuth: true},
        children: [
          {
            path: '/addCourse',
            name: '添加课程',
            component: addCourse,
            meta: {requireAuth: true}
          },
          {
            path: '/queryCourse',
            name: '搜索课程',
            component: queryCourse,
            meta: {requireAuth: true},
            children: [
              {
                path: '/courseList',
                name: '课程列表',
                component: courseList,
                meta: {requireAuth: true}
              },
            ]
          },
          {
            path: '/editorCourse',
            name: '编辑课程',
            component: editorCourse,
            meta: {requireAuth: true}
          },
        ]
      },
      {
        path: '/CourseTeacher',
        name: '开课表管理',
        component: CourseTeacherManage,
        meta: {requireAuth: true},
        children: [
          {
            path: '/queryCourseTeacher',
            name: '开课管理',
            component: queryCourseTeacher,
            meta: {requireAuth: true},
          }
        ]
      },
      {
        name: 'admin 学生成绩管理',
        path: "/gradeCourseManage",
        component: studentManage,
        meta: {requireAuth: true},
        children: [
          {
            path: '/queryGradeCourse',
            name: '学生成绩查询',
            component: queryGradeCourse,
            meta: {requireAuth: true},
          },
          {
            path: '/editorGradeCourse',
            name: '编辑',
            component: editorGradeCourse,
            meta: {requireAuth: true}
          }
        ]
      }
    ]
  },
  {
    path: '/teacher',
    name: 'teacher',
    component: teacher,
    redirect: '/teacherHome',
    meta: {requireAuth: true},
    children: [
      {
        path: '/teacherHome',
        name: 'Hi! teacher',
        meta: {requireAuth: true},
        component: teacherHome,
        children: [
          {
            path: '/teacherHome',
            name: '教师主页',
            meta: {requireAuth: true},
            component: teacherHome
          },
        ]
      },
      {
        path: '/updateInfo',
        name: '教师编辑',
        component: updateInfo,
        meta: {requireAuth: true},
        children: [
          {
            path: '/updateInfoHome',
            name: '编辑教师信息',
            component: updateInfo,
            meta: {requireAuth: true}
          }
        ]
      },
      {
        path: '/courseManage',
        name: '课程设置',
        meta: {requireAuth: true},
        component: setCourse,
        children: [
          {
            path: '/myOfferCourse',
            name: '我开设的课程',
            component: myOfferCourse,
            meta: {requireAuth: true}
          },
          {
            path: '/offerCourse',
            name: '开设课程',
            component: offerCourse,
            meta: {requireAuth: true}
          },
        ]
      },
      {
        name: '教师成绩管理',
        path: '/teacherQueryGradeCourseManage',
        component: teacherGradeCourseManage,
        meta: {requireAuth: true},
        children: [
          {
            path: '/teacherQueryGradeCourseManage',
            name: '成绩管理',
            component: teacherQueryGradeCourse,
            meta: {requireAuth: true}
          },
          {
            path: '/teacherEditorGradeCourse',
            name: '编辑成绩',
            component: teacherEditorGradeCourse,
            meta: {requireAuth: true}
          }
        ]
      },
      // 🟢 新增：教师端免修审核路由
      {
        path: '/teacher/exemption-audit',
        name: '免修审核',
        component: TeacherExemptionAudit,
        meta: {requireAuth: true}
      }
    ]
  },
  {
    path: '/student',
    name: 'student',
    component: student,
    redirect: '/studentHome',
    meta: {requireAuth: true},
    children: [
      {
        path: '/student',
        name: 'hi! student',
        component: studentHome,
        meta: {requireAuth: true},
        children: [
          {
            path: '/studentHome',
            name: '学生主页',
            component: studentHome,
            meta: {requireAuth: true},
          }
        ],
      },
      {
          path: '/notification/:id', 
          name: 'notificationDetail',
          component: NotificationDetail,
          meta: {requireAuth: true}
      },
      {
        path: '/updateInfo',
        name: '学生编辑',
        component: updateInfo,
        meta: {requireAuth: true},
        children: [
          {
            path: '/updateInfoHome',
            name: '编辑学生信息',
            component: updateInfo,
            meta: {requireAuth: true}
          }
        ]
      },
      {
        path: '/studentSelectCourseManage',
        name: '选课管理',
        component: studentSelectCourseManage,
        meta: {requireAuth: true},
        children: [
          {
            path: '/studentSelectCourse',
            name: '选课',
            component: selectCourse,
            meta: {requireAuth: true}
          },
          {
            path: '/querySelectedCourse',
            name: '查询课表',
            component: querySelectedCourse,
            meta: {requireAuth: true}
          }
        ]
      },
      {
        path: '/courseGrade',
        name: '学生成绩管理',
        component: studentCourseGrade,
        meta: {requireAuth: true},
        children: [
          {
            path: '/queryCourseGrade',
            name: '成绩查询',
            component: queryCourseGrade,
            meta: {requireAuth: true}
          },
        ]
      },
      // 🟢 新增：学生端免修申请路由
      {
        path: '/student/exemption',
        name: '免修申请',
        component: StudentExemption,
        meta: {requireAuth: true}
      }
    ]
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router

/*
  session 设置：
    1. token
    2. name
    3. type
    4. tid
    5. sid
    5. 系统信息 info
 */
router.beforeEach((to, from, next) => {
  console.log(from.path + ' ====> ' + to.path)
  if (to.meta.requireAuth) { // 判断该路由是否需要登录权限
    if (sessionStorage.getItem("token") === 'true') { // 判断本地是否存在token
      next()
    } else {
      // 未登录,跳转到登陆页面
      next({
        path: '/login',
        query: {redirect: to.fullPath}
      })
    }
  } else {
    // 不需要登陆权限的页面，如果已经登陆，则跳转主页面
    if(sessionStorage.getItem("token") === 'true'){
      console.log('检查拦截器配置，大概率出现漏网之鱼')
      const t = sessionStorage.getItem("type")
      next('/' + t);
    }else{
      next();
    }
  }
});