"use strict";

import Vue from 'vue';
import axios from "axios";

let config = {
  // 设置后端接口的基础地址，确保前端请求能发到 10086 端口
  baseURL: "http://localhost:10086", 
  timeout: 60 * 1000, 
};

const _axios = axios.create(config);

_axios.interceptors.request.use(
  function(config) { return config; },
  function(error) { return Promise.reject(error); }
);

_axios.interceptors.response.use(
  function(response) { return response; },
  function(error) { return Promise.reject(error); }
);

Plugin.install = function(Vue, options) {
  Vue.axios = _axios;
  window.axios = _axios;
  Object.defineProperties(Vue.prototype, {
    axios: { get() { return _axios; } },
    $axios: { get() { return _axios; } },
    // 【新增】在这里注册 $http，解决 undefined 报错
    $http: { get() { return _axios; } }, 
  });
};

Vue.use(Plugin)
export default Plugin;