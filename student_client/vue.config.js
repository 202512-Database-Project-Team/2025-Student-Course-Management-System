// vue.config.js
module.exports = {
  // 确保前端运行在 8081（可选）
  devServer: {
    port: 8086,
    proxy: {
      // 方式一：直接代理 /upload（推荐，最小改动）
      '/upload': {
        target: 'http://localhost:10086',
        changeOrigin: true,
        // 不重写路径，因为后端就是 /upload
      },

      // 👇 如果你还有其他 API，也可以批量代理（比如所有 /api 开头的）
      // '/api': {
      //   target: 'http://localhost:10086',
      //   changeOrigin: true,
      //   pathRewrite: {
      //     '^/api': ''
      //   }
      // }
    }
  },

  // 兼容 Vue 2 项目
  transpileDependencies: ['element-ui']
}