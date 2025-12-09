# 🚀 StudentManageSystem 项目介绍

![GitHub License](https://img.shields.io/github/license/ruanjiancheng/StudentManageSystem)   
**一个基于前后端分离的学生成绩管理系统**，采用 Vue + Spring Boot + MyBatis 开发，支持多角色（管理员、教师、学生）管理与动态数据交互。

## 🌐 技术架构

| 前端技术栈       | 后端技术栈          |
|------------------|---------------------|
| Vue 2.x (ES6/7)  | Spring Boot 2.6.3   |
| Vuex / Vue Router| MyBatis             |
| Axios / Element UI| Maven             |
| sessionStorage   | MySQL               |

## 🛠️ 快速部署指南

### 方法一：Docker 一键启动 🔥
```bash
docker-compose up
```

### 方法二：手动部署
1. **导入数据库**
   ```bash
   mysql -u root -p studentms < studentms.sql
   ```
2. **启动前端**
   ```bash
   cd student_client
   npm install && npm run serve
   ```
3. **启动后端**
   - 方式 A：修改 `application.yml` 配置数据库与端口（默认 `10086`）
   - 方式 B：直接运行 JAR（需数据库用户 `root` 密码为 `123`）
   ```bash
   java -jar student-server.jar
   ```

## 🖼️ 项目截图

### 1. 登录界面
![登录界面](README.assets/image-20220211152715838.png)

### 2. 动态搜索与表格
![动态搜索](README.assets/image-20220211153012483.png)

### 3. 教师端成绩管理
![成绩编辑](README.assets/image-20220211153257252.png)

---

## 📦 数据库设计
<img src="README.assets/image-20220211163057648.png" alt="ER图" width="300" />

---

## 🤗 支持作者 ☕️
<div style="display: flex; gap: 20px;">
  <img src="README.assets/微信图片_20250617161919_13.jpg" alt="微信收款码" style="width: 200px; border-radius: 8px;" />
  <img src="README.assets/微信图片_20250617161950_15.jpg" alt="支付宝收款码" style="width: 200px; border-radius: 8px;" />
</div>

---

## ⚠️ 已知问题与优化建议

| 问题描述                          | 解决方向                          |
|-----------------------------------|-----------------------------------|
| 组件复用率低导致代码冗余          | 提取公共组件，优化逻辑封装        |
| 频繁请求接口影响性能              | 集成 MyBatis 二级缓存             |
| 学生端查询功能未更新              | 复用教师端逻辑重构查询模块        |
| API 地址未全局封装                | 使用 Axios 实例配置基础 URL       |

---

## 📈 项目星标历史
[![Star History](https://api.star-history.com/svg?repos=ruanjiancheng/StudentManageSystem&type=linear)](https://star-history.com/#ruanjiancheng/StudentManageSystem&linear) 
