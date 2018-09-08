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
#app {
  font-family: 'PingFang SC', 'Microsoft YaHei', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  height: 100%;
}

@font-face {
  font-family: 'iconfont';  /* project id 828897 */
  src: url('//at.alicdn.com/t/font_828897_8j574fzfqgr.eot');
  src: url('//at.alicdn.com/t/font_828897_8j574fzfqgr.eot?#iefix') format('embedded-opentype'),
  url('//at.alicdn.com/t/font_828897_8j574fzfqgr.woff') format('woff'),
  url('//at.alicdn.com/t/font_828897_8j574fzfqgr.ttf') format('truetype'),
  url('//at.alicdn.com/t/font_828897_8j574fzfqgr.svg#iconfont') format('svg');
}

.el-message-box__wrapper {
  padding: 50% 20px 0 20px;
}
.el-message-box {
  width: 100%;
}
</style>
