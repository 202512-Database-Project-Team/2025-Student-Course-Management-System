<template>
  <div>
    <el-form >
      <el-form-item label="选择学期">
        <el-select v-model="term" placeholder="请选择学期">
          <el-option v-for="(item, index) in termList" :key="index" :label="item" :value="item"></el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <el-card>
      <el-table
          :data="tableData"
          border
          style="width: 100%">
        <el-table-column
            fixed
            prop="cid"
            label="课号"
            width="150">
        </el-table-column>
        <el-table-column
            prop="cname"
            label="课程号"
            width="150">
        </el-table-column>
        <el-table-column
            prop="tid"
            label="教师号"
            width="150">
        </el-table-column>
        <el-table-column
            prop="tname"
            label="教师名称"
            width="150">
        </el-table-column>
        <el-table-column
            prop="ccredit"
            label="学分"
            width="150">
        </el-table-column>
        <el-table-column
            prop="grade"
            label="成绩"
            width="150">
        </el-table-column>
      </el-table>
      <el-pagination
          background
          layout="prev, pager, next"
          :total="total"
          :page-size="pageSize"
          @current-change="changePage"
      >
      </el-pagination>
    </el-card>
  </div>
</template>

<script>
export default {
  methods: {
    changePage(page) {
      page = page - 1
      const that = this
      let start = page * that.pageSize, end = that.pageSize * (page + 1)
      let length = that.tmpList.length
      let ans = (end < length) ? end : length
      that.tableData = that.tmpList.slice(start, ans)
    },
  },
  data() {
    return {
      tableData: null,
      pageSize: 10,
      total: null,
      tmpList: null,
      // 这里删除了 avg: 0,
      term: sessionStorage.getItem('currentTerm'),
      termList: null
    }
  },
  created() {
    const that = this
    axios.get('http://localhost:10086/SCT/findAllTerm').then(function (resp) {
      that.termList = resp.data
    })
  },
  watch: {
    term: {
      handler(newTerm, oldTerm) {
        const sid = sessionStorage.getItem('sid')
        const that = this
        axios.get('http://localhost:10086/SCT/findBySid/' + sid + '/' + newTerm).then(function (resp) {
          that.tmpList = resp.data
          that.total = resp.data.length
          let start = 0, end = that.pageSize
          let length = that.tmpList.length
          let ans = (end < length) ? end : length
          that.tableData = that.tmpList.slice(start, end)
          // 这里删除了计算平均分(avg)的 for 循环逻辑
        })
      },
      immediate: true
    }
  }
}
</script>