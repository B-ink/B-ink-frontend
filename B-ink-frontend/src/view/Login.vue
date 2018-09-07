<template>
  <div class='login'>
    <div class="login_content">
      <el-form :model="user" :rules="rules" ref="LoginForm">
        <el-form-item prop="username">
          <el-input class="input" placeholder="用户名" v-model="user.username" autofocus></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input class="input" type="password" placeholder="密码" v-model="user.password"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button class="btn login_btn" type="primary" @click="login">登录</el-button>
        </el-form-item>
        <el-form-item>
          <el-button class="btn sign_btn" @click="sign">注册</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script type="text/ecmascript-6">
  import Application from '../js/app'

  export default {
    name: 'Login',
    data () {
      return {
        user: {
          username: '',
          password: '',
        },
        rules: {
          username: [{required: true, message: '请输入用户名', trigger: 'blur'}, {min: 1}],
          password: [{required: true, message: '请输入密码', trigger: 'blur'}],
        }
      }
    },
    methods: {
      login: function () {
        this.$refs.LoginForm.validate().then(() => {
          try {
            web3.eth.getAccounts((error, accounts) => {
              let account = accounts[0];
              Application.contracts.Adoption.deployed().then(function (instance) {
                let apotionInstance = instance;
                return apotionInstance.findUser.call(account);
              }).then((result) => {
                let [address, username, password] = result;
                if (username === this.user.username && password === this.user.password) {
                  this.$router.push('Evaluation');
                } else {
                  this.$message.error('用户名或密码不正确！')
                }
              }).catch((err) => {
                this.$message.error('ETH帐号不存在，请先注册！')
              });
            });
          } catch (err) {
            this.$message.error('请安装METAMASK插件，设置账户信息后刷新重试')
          }
        }).catch(() => {
        })
      },
      sign: function () {
        this.$refs.LoginForm.validate().then(() => {
          this.$alert('请确保ETH账户未进行过注册（如果Gas Limit为0，说明已经注册过，请拒绝交易，直接登录）！', '提示', {
            confirmButtonText: '确定',
            type: 'info'
          }).then(() => {
          })
          try {
            web3.eth.getAccounts((err, accounts) => {
              let account = accounts[0];
              Application.contracts.Adoption.deployed().then((instance) => {
                return instance.createUser(account, this.user.password, this.user.username, {from: account});
              }).then((result) => {
                this.$router.push('/Evaluation')
              })
            })
          } catch (err) {
            this.$message.error('请安装METAMASK插件，设置账户信息后刷新重试')
          }
        }).catch(() => {
        })
      }
    }
  }
</script>

<style lang="stylus">
  .login
    padding-top 50%
    .login_content
      width: 60%
      margin auto
    .btn, .input
      display block
      width: 100%
</style>
