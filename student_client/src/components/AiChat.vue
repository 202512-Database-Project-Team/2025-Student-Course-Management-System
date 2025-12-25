<template>
  <div class="ai-chat-wrapper">
    <div 
      class="chat-float-btn" 
      :class="{ 'is-active': showChat }" 
      @click="toggleChat"
      title="打开 AI 助手"
    >
      <transition name="rotate-icon">
        <span v-if="!showChat" class="btn-icon">💬</span>
        <span v-else class="btn-icon">✕</span>
      </transition>
    </div>

    <transition name="panel-slide">
      <div v-if="showChat" class="chat-panel">
        <div class="chat-header">
          <div class="header-left">
            <div class="ai-avatar">
              <span>🤖</span>
            </div>
            <div class="ai-info">
              <span class="ai-name">AI 智能助手</span>
              <span class="ai-status">
                <span class="status-dot"></span> 在线中
              </span>
            </div>
          </div>
          <button class="close-btn" @click="toggleChat" title="关闭">
            <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>

        <div class="chat-body">
          <iframe
            :src="iframeSrc"
            class="chat-iframe"
            frameborder="0"
            allow="microphone"
            title="AI Assistant"
          ></iframe>
          </div>
      </div>
    </transition>
  </div>
</template>

<script>
export default {
  name: "AiChat",
  data() {
    return {
      showChat: false,
      iframeSrc:
        "https://1419482254471355.appflow.aliyunnest.com/webhook/home/b271bff12d8121795fc79a58ca8b6ab074a433b5018bfa15439ec33e4c759ce597930fc745188965f0/index",
    };
  },
  methods: {
    toggleChat() {
      this.showChat = !this.showChat;
    },
  },
};
</script>

<style scoped>
/* --- 悬浮球样式 --- */
.chat-float-btn {
  position: fixed;
  right: 24px;
  bottom: 30px;
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #409eff, #2b85e4);
  color: #fff;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
  box-shadow: 0 8px 20px rgba(64, 158, 255, 0.4);
  cursor: pointer;
  z-index: 10000;
  transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  user-select: none;
}

.chat-float-btn:hover {
  transform: scale(1.1);
  box-shadow: 0 12px 24px rgba(64, 158, 255, 0.5);
}

.chat-float-btn.is-active {
  background: #f56c6c; /* 打开时变成红色关闭按钮风格，或者保持蓝色看个人喜好 */
  box-shadow: 0 8px 20px rgba(245, 108, 108, 0.4);
  transform: rotate(90deg);
}

/* 图标切换动画 */
.rotate-icon-enter-active, .rotate-icon-leave-active {
  transition: opacity 0.2s, transform 0.2s;
  position: absolute;
}
.rotate-icon-enter-from, .rotate-icon-leave-to {
  opacity: 0;
  transform: scale(0.5);
}

/* --- 聊天面板主体 (核心美化部分) --- */
.chat-panel {
  position: fixed;
  right: 30px;
  bottom: 100px;
  width: 380px;
  height: 620px;
  background: #ffffff;
  border-radius: 16px;
  box-shadow: 0 16px 48px rgba(0, 0, 0, 0.18);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  z-index: 9999;
  border: 1px solid rgba(0, 0, 0, 0.05);
  transform-origin: bottom right;
}

/* 1. 头部样式 */
.chat-header {
  height: 64px;
  background: linear-gradient(to right, #f8f9fa, #ffffff);
  border-bottom: 1px solid #ebeef5;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
  flex-shrink: 0;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.ai-avatar {
  width: 36px;
  height: 36px;
  background: #eecfff;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  border: 2px solid #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.ai-info {
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.ai-name {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  line-height: 1.2;
}

.ai-status {
  font-size: 12px;
  color: #67c23a;
  display: flex;
  align-items: center;
  gap: 4px;
  margin-top: 2px;
}

.status-dot {
  width: 6px;
  height: 6px;
  background-color: #67c23a;
  border-radius: 50%;
  display: inline-block;
}

.close-btn {
  border: none;
  background: transparent;
  color: #909399;
  cursor: pointer;
  padding: 8px;
  border-radius: 8px;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  justify-content: center;
}

.close-btn:hover {
  background-color: #f0f2f5;
  color: #606266;
}

/* 2. iframe 区域 */
.chat-body {
  flex: 1;
  background-color: #fff;
  position: relative;
  /* 防止 iframe 撑开滚动条 */
  overflow: hidden; 
}

.chat-iframe {
  width: 100%;
  height: 100%;
  display: block;
}

/* --- 面板进出动画 --- */
.panel-slide-enter-active,
.panel-slide-leave-active {
  transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.panel-slide-enter-from,
.panel-slide-leave-to {
  opacity: 0;
  transform: translateY(20px) scale(0.95);
}

/* --- 移动端适配 --- */
@media (max-width: 480px) {
  .chat-panel {
    width: 90vw; /* 宽度占满屏幕90% */
    right: 5vw;
    bottom: 100px;
    height: 70vh; /* 高度占屏幕70% */
  }
}
</style>