<template>
  <div class='login'>
    <div class="login_content">
      <el-input class="input" placeholder="用户名"></el-input>
      <el-input class="input" type="password" placeholder="密码"></el-input>
      <el-button class="btn login_btn" type="primary">登录</el-button>
      <el-button class="btn sign_btn">注册</el-button>
    </div>
  </div>
</template>

<script type="text/ecmascript-6">
  export default {
    name: 'Login'
  }
</script>

<style lang="stylus">
  .login
    margin-top 50%
    .btn, .input
      display block
      margin 20px auto
      width: 60%
</style>
