<template>
  <div>
    <!-- 悬浮球 -->
    <div class="chat-float-btn" @click="toggleChat">
      💬
    </div>

    <!-- 问答窗口（带 iframe） -->
    <transition name="chat-fade">
      <div v-if="showChat" class="chat-panel">
        <div class="chat-panel-header">
          <span>AI 问答小助手</span>
          <button class="chat-panel-close" @click="toggleChat">✕</button>
        </div>
        <div class="chat-panel-body">
          <iframe
            :src="iframeSrc"
            width="100%"
            height="100%"
            frameborder="0"
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
/* 悬浮球样式 */
.chat-float-btn {
  position: fixed;
  right: 24px;
  bottom: 24px;
  width: 56px;
  height: 56px;
  border-radius: 50%;
  background-color: #409eff;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.25);
  cursor: pointer;
  z-index: 9999;
  font-size: 24px;
}

/* 问答面板 */
.chat-panel {
  position: fixed;
  right: 24px;
  bottom: 90px;
  width: 400px;
  height: 560px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
  overflow: hidden;
  z-index: 9998;
  display: flex;
  flex-direction: column;
}

/* 面板头部 */
.chat-panel-header {
  height: 40px;
  background-color: #409eff;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 12px;
  font-size: 14px;
}

.chat-panel-close {
  border: none;
  background: transparent;
  color: #fff;
  cursor: pointer;
  font-size: 16px;
}

/* 面板主体区域（iframe 区域） */
.chat-panel-body {
  flex: 1;
}

/* 出现/消失 动画 */
.chat-fade-enter-active,
.chat-fade-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}
.chat-fade-enter-from,
.chat-fade-leave-to {
  opacity: 0;
  transform: translateY(10px);
}
</style>
