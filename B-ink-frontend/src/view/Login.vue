<template>
  <div class='login'>
    <div class="login_content">
      <el-input class="input" placeholder="用户名" v-model="username"></el-input>
      <el-input class="input" type="password" placeholder="密码" v-model="password"></el-input>
      <el-button class="btn login_btn" type="primary" @click="login">登录</el-button>
      <el-button class="btn sign_btn" @click="sign">注册</el-button>
    </div>
  </div>
</template>

<script type="text/ecmascript-6">
  import Application from '../js/app'
  const Login = 0;
  const Sign = 1;
  export default {
    name: 'Login',
    data () {
      return {
        username: '',
        password: '',
      }
    },
    methods: {
      login: function () {
        web3.eth.getAccounts(function (error, accounts) {
          let account = accounts[0];

          Application.contracts.Adoption.deployed().then(function (instance) {
            let apotionInstance = instance;
            return apotionInstance.adopt(1, {from: account});
          }).then(function (result) {
            return Application.markAdopted();
          }).catch(function (err) {
            console.log(err.message);
          });
        });
      },
      sign: function () {
        web3.eth.getAccounts((err, accounts) => {
          let account = accounts[0];
          Application.contracts.Adoption.deployed().then((instance) => {
            let apotionInstance = instance;
            return apotionInstance.createUser(account, this.password, this.username, {from: account});
          }).then((result) => {
            this.$router.push('/Evaluation')
          }).catch(function (err) {
            console.log(err.message);
          });
        })
      }
    }
  }
</script>

<style lang="stylus">
  .login
    padding-top 50%
    .btn, .input
      display block
      margin 20px auto
      width: 60%
</style>
