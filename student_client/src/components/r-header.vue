<template>
  <div class="header-wrapper">
    
    <div class="header-left">
      <div class="logo-box">
        <i class="el-icon-reading logo-icon"></i>
      </div>
      <span class="system-title">学生成绩管理系统</span>
    </div>
    
    <div class="header-right">
      <span class="welcome-text">
        <i class="el-icon-date"></i> {{ currentTerm }} 学期
      </span>
      
      <el-divider direction="vertical"></el-divider>
      
      <el-dropdown trigger="click" class="user-dropdown">
        <span class="el-dropdown-link user-name">
           <el-avatar size="small" :style="{backgroundColor: '#764ba2'}"> {{ name.substring(0,1) }} </el-avatar>
           <span class="name-text">{{ name }}</span>
           <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item icon="el-icon-user">个人中心</el-dropdown-item>
          <el-dropdown-item icon="el-icon-switch-button" @click.native="logout">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>

  </div>
</template>

<script>
export default {
  name: "r-header",
  data() {
    return {
      name: sessionStorage.getItem("name") || '用户',
      currentTerm: sessionStorage.getItem("currentTerm") || '2025-2026-1'
    }
  },
  methods: {
    logout() {
      sessionStorage.clear();
      this.$router.push('/');
      this.$message.success('已安全退出');
    }
  }
}
</script>

<style scoped>
.header-wrapper {
  height: 60px;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between; /* 核心：左右两端对齐 */
  padding: 0 30px; /* 左右留出一些呼吸空间 */
  box-sizing: border-box; /* 确保 padding 不会撑大宽度 */
  background: #fff;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

/* 左侧样式 */
.header-left {
  display: flex;
  align-items: center;
  gap: 15px;
}

.logo-box {
  width: 36px;
  height: 36px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.logo-icon {
  font-size: 20px;
  color: white;
}

.system-title {
  font-size: 20px;
  font-weight: 700;
  color: #2c3e50;
  letter-spacing: 0.5px;
}

/* 右侧样式 */
.header-right {
  display: flex;
  align-items: center;
  gap: 15px;
}

.welcome-text {
  font-size: 14px;
  color: #606266;
  background: #f4f4f5;
  padding: 6px 12px;
  border-radius: 20px;
}

.user-name {
  display: flex;
  align-items: center;
  cursor: pointer;
  padding: 4px 10px;
  border-radius: 4px;
  transition: all 0.3s;
}

.user-name:hover {
  background: #f5f7fa;
}

.name-text {
  margin-left: 8px;
  font-weight: 600;
  color: #333;
  font-size: 15px;
}
</style>