<template>
  <el-container class="main-container">
    <el-header><r-header></r-header></el-header>
    <el-container>
      <r-aside></r-aside>
      <el-main>
        <transition name="fade-transform" mode="out-in">
          <router-view></router-view>
        </transition>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import RAside from "@/components/r-aside";
import RHeader from "@/components/r-header";
export default { name: "index", components: {RHeader, RAside} }
</script>

<style scoped>
.main-container { height: 100%; width: 100%; }
.el-header { padding: 0; z-index: 1000; }
/* 核心修改：背景色设为透明，让 App.vue 的全局背景透出来 */
.el-main { 
  background-color: transparent; 
  height: 100%; 
  padding: 20px; 
  overflow-x: hidden; 
}
</style>