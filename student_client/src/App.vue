<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
/* --- 1. 全局重置与新背景 --- */
body, html {
  margin: 0;
  padding: 0;
  height: 100%;
  width: 100%;
  font-family: 'Helvetica Neue', Helvetica, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', '微软雅黑', Arial, sans-serif;
  
  /* --- 核心修改：更有质感的微光背景 --- */
  background-color: #f2f4f7; /* 基础底色 */
  background-image: 
    radial-gradient(circle at 50% 3%, rgba(210, 225, 255, 0.6) 0%, rgba(242, 244, 247, 0) 50%),
    linear-gradient(180deg, rgba(255, 255, 255, 0.4) 0%, rgba(242, 244, 247, 0) 100%);
  background-attachment: fixed; /* 背景固定，不随滚动条移动 */
  background-size: cover;
  
  -webkit-font-smoothing: antialiased;
}

#app {
  height: 100%;
  width: 100%;
}

/* --- 2. 滚动条美化 (保持不变) --- */
::-webkit-scrollbar { width: 8px; height: 8px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: #dcdfe6; border-radius: 4px; transition: background 0.3s; }
::-webkit-scrollbar-thumb:hover { background: #b4bccc; }

/* --- 3. 动画效果 (保持不变) --- */
.fade-transform-enter-active, .fade-transform-leave-active { transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94); }
.fade-transform-enter { opacity: 0; transform: translateX(30px); }
.fade-transform-leave-to { opacity: 0; transform: translateX(-30px); }
.el-button:active { transform: scale(0.96) !important; }

/* --- 4. 组件全局样式 (保持不变) --- */
.home_container { height: 100vh !important; width: 100%; }
.el-container { height: 100%; }
.el-header { padding: 0 !important; background-color: rgba(255, 255, 255, 0.95); /* 头部稍微透明一点点 */ backdrop-filter: blur(10px); z-index: 1000; width: 100%; }
.el-aside { background-color: #fff; height: 100%; overflow-x: hidden; box-shadow: 2px 0 8px rgba(0,0,0,0.05); z-index: 999; }
.el-card { border: none !important; border-radius: 12px !important; box-shadow: 0 4px 20px 0 rgba(0, 0, 0, 0.05) !important; transition: all 0.3s; background-color: rgba(255, 255, 255, 0.9) !important; /* 卡片微透明 */ }
.el-card:hover { transform: translateY(-3px); box-shadow: 0 8px 25px 0 rgba(0, 0, 0, 0.1) !important; }
.el-table { border-radius: 8px; background-color: transparent !important; }
.el-table tr, .el-table th { background-color: transparent !important; } /* 表格透明化适配新背景 */
.el-button { border-radius: 6px !important; transition: all 0.2s; }
</style>