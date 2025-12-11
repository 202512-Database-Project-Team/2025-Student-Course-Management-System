<template>
  <div class="login-wrapper">
    <div class="login-container">
      <div class="login-header-text">
        <div class="logo-icon">
          <i class="el-icon-s-custom"></i>
        </div>
        <h1 class="system-title">大学生选课管理系统</h1>
        <p class="system-subtitle">Student Course Management System</p >
      </div>

      <div class="login-box">
        <el-card class="login-card" shadow="hover">
          <div slot="header" class="card-header">
            <span>用户登录</span>
          </div>
          <el-form :model="ruleForm" :rules="rules" ref="ruleForm" class="login-form">
            <el-form-item prop="id">
              <el-input
                  v-model.number="ruleForm.id"
                  prefix-icon="el-icon-user"
                  placeholder="请输入学号/工号/ID">
              </el-input>
            </el-form-item>

            <el-form-item prop="password">
              <el-input
                  v-model="ruleForm.password"
                  placeholder="请输入密码"
                  show-password
                  prefix-icon="el-icon-lock">
              </el-input>
            </el-form-item>

            <el-form-item prop="type">
              <el-radio-group v-model="ruleForm.type" class="role-radio-group">
                <el-radio label="student">学生</el-radio>
                <el-radio label="teacher">教师</el-radio>
                <el-radio label="admin">管理员</el-radio>
              </el-radio-group>
            </el-form-item>

            <el-form-item>
              <el-button type="primary" class="login-button" @click="submitForm('ruleForm')">登录</el-button>
              <div class="login-options">
                <el-button type="text" size="small" @click="resetForm('ruleForm')">重置</el-button>
                <el-divider direction="vertical"></el-divider>
                <el-button type="text" size="small" class="test-btn" @click="test('ruleForm')">忘记密码？</el-button>
              </div>
            </el-form-item>

          </el-form>
        </el-card>
      </div>
      <div class="login-footer">
        © 2025 大学生选课管理系统 | All Rights Reserved
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      ruleForm: {
        id: null,
        password: null,
        type: null,
      },
      rules: {
        id: [
          { required: true, message: '请输入用户 id', trigger: 'blur' },
          { type: 'number', message: '请输入数字', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ],
        type: [
          { required: true, message: '请选择', trigger: 'change' }
        ],
      }
    };
  },
  methods: {
    submitForm(formName) {
      const that = this
      this.$refs[formName].validate((valid) => {
        if (valid) {
          let check = false
          let name = null

          axios.get('http://localhost:10086/info/getCurrentTerm').then(function (resp) {
            sessionStorage.setItem("currentTerm", resp.data)
          })

          axios.get('http://localhost:10086/info/getForbidCourseSelection').then(function (resp) {
            sessionStorage.setItem("ForbidCourseSelection", resp.data)
          })

          if (that.ruleForm.type === 'admin' || that.ruleForm.type === 'teacher') {
            let form = {tid: that.ruleForm.id, password: that.ruleForm.password}
            console.log(form)
            axios.post("http://localhost:10086/teacher/login", form).then(function (resp) {
              console.log("教师登陆验证信息：" + resp.data)
              check = resp.data
              if (check === true) {
                axios.get("http://localhost:10086/teacher/findById/" + that.ruleForm.id).then(function (resp) {
                  console.log("登陆页正在获取用户信息" + resp.data)
                  name = resp.data.tname

                  sessionStorage.setItem("token", 'true')
                  sessionStorage.setItem("type", that.ruleForm.type)
                  sessionStorage.setItem("name", name)
                  sessionStorage.setItem("tid", resp.data.tid)

                  console.log('name: ' + name + ' ' + that.ruleForm.type + ' ' + resp.data.tid)

                  if (that.ruleForm.type === 'admin' && name === 'admin') {
                    that.$message({
                      showClose: true,
                      message: '登陆成功，欢迎 ' + name + '!',
                      type: 'success'
                    });
                    that.$router.push('/admin')
                  }
                  else if(that.ruleForm.type === 'teacher' && name !== 'admin') {
                    that.$message({
                      showClose: true,
                      message: '登陆成功，欢迎 ' + name + '!',
                      type: 'success'
                    });
                    that.$router.push('/teacher')
                  }
                  else {
                    that.$message({
                      showClose: true,
                      message: 'admin 登陆失败，检查登陆类型',
                      type: 'error'
                    });
                  }
                })
              }
              else {
                that.$message({
                  showClose: true,
                  message: '登陆失败，检查账号密码',
                  type: 'error'
                });
              }
            })
          }
          else if (that.ruleForm.type === 'student') {
            let form = {sid: that.ruleForm.id, password: that.ruleForm.password}
            axios.post("http://localhost:10086/student/login", form).then(function (resp) {
              console.log("学生登陆验证信息：" + resp.data)
              check = resp.data
              if (check === true) {
                axios.get("http://localhost:10086/student/findById/" + that.ruleForm.id).then(function (resp) {
                  console.log("登陆页正在获取用户信息" + resp.data)
                  name = resp.data.sname

                  sessionStorage.setItem("token", 'true')
                  sessionStorage.setItem("type", that.ruleForm.type)
                  sessionStorage.setItem("name", name)
                  sessionStorage.setItem("sid", resp.data.sid)

                  that.$message({
                    showClose: true,
                    message: '登陆成功，欢迎 ' + name + '!',
                    type: 'success'
                  });

                  console.log('正在跳转：' + '/' + that.ruleForm.type)

                  // 3. 路由跳转
                  that.$router.push({
                    path: '/' + that.ruleForm.type,
                    query: {}
                  })
                })
              }
              else {
                that.$message({
                  showClose: true,
                  message: '账号密码错误，请联系管理员',
                  type: 'error'
                });
              }
            })
          }
          else {
            console.log("! error type")
          }
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    test(forName) {
      console.log(this.ruleForm)
    }
  }
}
</script>

<style scoped>
/* 外层包裹器：负责全屏背景和 Flex 居中 */
.login-wrapper {
  height: 100vh;
  width: 100%;
  /* 背景图片：使用了一个通用的图书馆/校园风格图片，叠加了深色渐变遮罩以突出前景 */
background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('~@/assets/bg.png');  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  display: flex;
  justify-content: center;
  align-items: center;
}

/* 内容容器：包含标题、登录框、页脚，垂直排列 */
.login-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  z-index: 1;
}

/* 头部文字区域样式 */
.login-header-text {
  text-align: center;
  margin-bottom: 30px;
  color: #ffffff;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
}

.logo-icon {
  font-size: 40px;
  margin-bottom: 10px;
}

.system-title {
  margin: 0;
  font-size: 34px;
  font-weight: bold;
  letter-spacing: 2px;
  font-family: "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "微软雅黑", Arial, sans-serif;
}

.system-subtitle {
  margin: 10px 0 0 0;
  font-size: 14px;
  font-weight: 300;
  letter-spacing: 1px;
  opacity: 0.8;
}

/* 登录框容器：限定宽度，防止过宽 */
.login-box {
  width: 420px;
}

/* Element Card 样式覆盖 */
.login-card {
  border: none;
  border-radius: 8px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  background: rgba(255, 255, 255, 0.96); /* 轻微透明，增加质感 */
}

.card-header {
  text-align: center;
  font-size: 18px;
  color: #333;
  font-weight: 500;
}

.login-form {
  padding: 10px 10px 0 10px;
}

/* 输入框样式微调 */
.el-input__inner {
  height: 42px; /* 稍微加高输入框 */
}

/* 身份单选框组居中 */
.role-radio-group {
  width: 100%;
  display: flex;
  justify-content: space-around;
  margin-bottom: 10px;
}

/* 登录按钮样式 */
.login-button {
  width: 100%;
  font-size: 16px;
  letter-spacing: 2px;
  padding: 12px 0;
  background: #409EFF; /* Element UI 主色调 */
  border-color: #409EFF;
  transition: background-color 0.3s ease;
}
.login-button:hover {
  background: #66b1ff;
  border-color: #66b1ff;
}

/* 底部辅助链接区域 */
.login-options {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 10px;
}

.test-btn {
  color: #909399;
}

/* 页脚版权样式 */
.login-footer {
  margin-top: 30px;
  color: rgba(255, 255, 255, 0.7);
  font-size: 12px;
  text-align: center;
}
</style>