<template>
  <div class="header-wrapper">
    
    <div class="header-left">
      <div class="logo-box">
        <i class="el-icon-reading logo-icon"></i>
      </div>
      <span class="system-title">学生成绩管理系统</span>
    </div>
    
    <div class="header-right">
      <div class="term-info">
        <i class="el-icon-date icon"></i>
        <span>{{ currentTerm }} 学期</span>
      </div>
      
      <el-divider direction="vertical" class="custom-divider"></el-divider>
      
      <el-dropdown trigger="click" class="user-dropdown">
        <span class="el-dropdown-link user-name">
           <el-avatar size="small" :style="{backgroundColor: '#764ba2', fontSize: '14px'}"> 
             {{ name ? name.substring(0,1) : 'U' }} 
           </el-avatar>
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
  justify-content: space-between;
  padding: 0 20px; /* 稍微减小内边距以适应小屏幕 */
  box-sizing: border-box;
  background: #fff;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

/* 左侧样式 */
.header-left {
  display: flex;
  align-items: center;
  /* 移除 gap，使用 margin 兼容旧浏览器 */
}

.logo-box {
  width: 36px;
  height: 36px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 12px; /* 替代 gap */
  flex-shrink: 0; /* 防止Logo被压缩 */
}

.logo-icon {
  font-size: 20px;
  color: white;
}

.system-title {
  font-size: 18px; /* 稍微调小一点字体，增强兼容性 */
  font-weight: 700;
  color: #2c3e50;
  white-space: nowrap; /* 防止标题换行 */
}

/* 右侧样式 */
.header-right {
  display: flex;
  align-items: center;
  flex-shrink: 0; /* 关键：防止右侧被挤压 */
}

/* 修改部分：新的学期样式 */
.term-info {
  display: flex;
  align-items: center;
  font-size: 14px;
  color: #606266;
  white-space: nowrap; /* 关键：强制不换行 */
  margin-right: 15px; /* 与分割线的距离 */
}

.term-info .icon {
  margin-right: 6px;
  font-size: 16px;
  color: #909399;
}

.custom-divider {
  margin: 0 15px 0 0; /* 调整分割线边距 */
  height: 20px;
}

.user-name {
  display: flex;
  align-items: center;
  cursor: pointer;
  padding: 4px 0; /* 去掉左右padding，避免hover背景块在窄屏出问题 */
  transition: opacity 0.3s;
  white-space: nowrap; /* 防止用户名换行 */
}

.user-name:hover {
  opacity: 0.8; /* 简单的 hover 效果 */
}

.name-text {
  margin-left: 8px;
  font-weight: 600;
  color: #333;
  font-size: 14px;
  max-width: 100px; /* 限制名字最大宽度 */
  overflow: hidden;
  text-overflow: ellipsis; /* 名字太长显示省略号 */
}
</style>