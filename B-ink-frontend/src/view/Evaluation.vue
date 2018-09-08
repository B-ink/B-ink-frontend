<template>
  <el-container direction="vertical" style="width: 100%; height: 100%">
    <div style="width: 100%">
      <div id="risk-form" style="width: 100%; height:100%; background-image: url('./static/background.jpg');
              background-position: center; background-repeat: no-repeat;  background-attachment:fixed; background-size: cover;">
        <swiper :options="swiperOption" style="height: 100%; width: 100%">
          <swiper-slide style="height: 100%;">
            <div style="position: relative;width: 100%; height: 100%; text-align: center; margin-bottom: 60px;
            padding-top: 50%;">
              <div @click="goMyInsurance"
                   style="position: absolute; top: 30px; right: 20px; color: white; font-weight: 500; text-shadow: 0 14px 24px rgba(50,48,58,.25);">
                我的保单
                <i class="el-icon-back" style="transform: rotateY(180deg)"></i>
              </div>
              <div style="text-shadow: 0 14px 24px rgba(50,48,58,.25)">
                <span style="font-size: 40px; color: white; font-weight: 700;">B-ink</span>
                <br>
                <span style="font-size: 35px; color: white; font-weight: 700;">房屋租赁保险平台</span>
              </div>
              <div style="text-align: center; margin-top: 30px">
                <CitySelector @changeCity="getCity"></CitySelector>
              </div>
              <svg class="icon" aria-hidden="true" style="position: fixed; bottom: 0px; font-size: 40px; left: 45%;"
                   id="moveIcon">
                <use xlink:href="#icon-xiayi"></use>
              </svg>
            </div>
          </swiper-slide>
          <swiper-slide style="height: 100%">
            <div style="padding: 20px">
              <el-form label-width="80px" label-position="left">
                <div v-show="check1">
                  <div class="title">
                    <svg class="icon" aria-hidden="true" style="fill: white; font-size: 25px; margin-right: 5px">
                      <use xlink:href="#icon-loushui"></use>
                    </svg>
                    浸水评估
                  </div>
                  <el-form-item label="墙面">
                    <el-select v-model="wall" placeholder="请选择" size="medium">
                      <el-option
                        v-for="item in wallOptions"
                        :key="item.value"
                        :label="item.value"
                        :value="item.value">
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="地板">
                    <el-select v-model="floor" placeholder="请选择" size="medium">
                      <el-option
                        v-for="item in floorOptions"
                        :key="item.value"
                        :label="item.value"
                        :value="item.value">
                      </el-option>
                    </el-select>
                  </el-form-item>
                </div>
                <div v-show="check2">
                  <div class="title">
                    <i class="iconfont" style="font-family: iconfont;font-size: 25px; margin-right: 5px">
                      &#xe613;
                    </i>
                    地震评估
                  </div>
                  <el-form-item label="建筑材料">
                    <el-select v-model="stone" placeholder="请选择" size="medium">
                      <el-option
                        v-for="item in materials"
                        :key="item.value"
                        :label="item.value"
                        :value="item.value">
                      </el-option>
                    </el-select>
                  </el-form-item>
                </div>
                <div>
                  <div class="title">
                    <svg class="icon" aria-hidden="true" style="fill: white; font-size: 25px; margin-right: 5px">
                      <use xlink:href="#icon-huozai"></use>
                    </svg>
                    火灾评估
                  </div>
                  <el-form-item label="板材">
                    <el-select v-model="bar" placeholder="请选择" size="medium">
                      <el-option
                        v-for="item in panelOptions"
                        :key="item.value"
                        :label="item.value"
                        :value="item.value">
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="涂料">
                    <el-select v-model="paint" placeholder="请选择" size="medium">
                      <el-option
                        v-for="item in paintOptions"
                        :key="item.value"
                        :label="item.value"
                        :value="item.value">
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="消防设施">
                    <el-radio-group v-model="radio1">
                      <el-radio
                        v-for="item in radioOptions"
                        :key="item.value"
                        :label="item.value"
                        :value="item.value"
                        style="display: block; margin: 5px;">
                      </el-radio>
                    </el-radio-group>
                  </el-form-item>
                </div>
                <el-form-item style="position: absolute; bottom: 40%; width: 100%; right: 10px">
                  <el-button type="plain" style="position:absolute;right:5%" @click="startEvaluation">开始评估</el-button>
                </el-form-item>
              </el-form>
            </div>
          </swiper-slide>
        </swiper>
      </div>
      <x-dialog :show.sync="showDialog" class="dialog-demo" style="padding: 10px; height: 100%;">
        <div style="padding: 0 20px; margin: 20px 0">
          <div class="img-box" style="font-size: 48px; height: 80px; color: #409EFF;">
            {{this.finalPoint}}
          </div>
          <el-input type="number" placeholder="请输入保险金额" style="margin-bottom: 10px" v-model="money"></el-input>
          <div>{{`您的费率是${getFee * 100}%`}}</div>
          <div style="margin-bottom: 15px">{{`保险费是${Number((this.money * getFee).toPrecision(9))}元`}}</div>
          <el-button @click="clickClose">我再想想</el-button>
          <el-button @click="clickConfirm" type="primary" v-if="this.finalPoint <= 400">我要投保</el-button>
        </div>
      </x-dialog>
    </div>
  </el-container>
</template>

<script type="text/ecmascript-6">
  import ElAside from 'element-ui/packages/aside/src/main'
  import ElRow from 'element-ui/packages/row/src/row'
  import ElMain from 'element-ui/packages/main/src/main'
  import CitySelector from '../components/CitySelector.vue'
  import ElHeader from 'element-ui/packages/header/src/main'
  import 'swiper/dist/css/swiper.css'
  import {swiper, swiperSlide} from 'vue-awesome-swiper'
  import {XDialog, Countup} from 'vux'
  import Application from '../js/app'

  export default {
    components: {
      ElHeader,
      ElMain,
      ElRow,
      ElAside,
      CitySelector,
      swiper,
      swiperSlide,
      XDialog,
      Countup
    },
    name: 'Evaluation',
    computed: {
      getFee () {
        if (this.finalPoint < 70) {
          return 0.0005;
        } else if (this.finalPoint <= 120) {
          return 0.00052;
        } else if (this.finalPoint <= 200) {
          return 0.00055;
        } else if (this.finalPoint <= 400) {
          return 0.00058;
        }
      }
    },
    methods: {
      goMyInsurance () {
        this.$router.push('MyInsurance')
      },
      getCity (msg) {
        this.city = msg
      },
      startEvaluation () {
        if (this._validate()) {
          this.showDialog = true
          this.startCount = true
        } else {
          this.$message.error('您还有未填写的项目，请仔细检查，填写完整！');
        }
      },
      clickClose () {
        this.showDialog = false
        this.startCount = false
      },
      _validate () {
        if (this.city === '') {
          console.log('die city')
          return false;
        } else {
          if (this.check1) {
            if (!(this.wall !== '' && this.floor !== '')) {
              console.log('die check1')
              return false;
            }
          }
          if (this.check2) {
            if (this.stone === '') {
              console.log('die check2')
              return false;
            }
          }
          if (this.bar === '' || this.radio1 === '' || this.paint === '') {
            console.log('die check3')
            return false;
          }
          return true;
        }
      },
      clickConfirm () {
        if (this.money === null || this.money === 0) {
          this.$message.error('您还未输入投保金额!')
          return
        }
        this.clickClose();
        web3.eth.getAccounts((err, accounts) => {
          let account = accounts[0];
          Application.contracts.Adoption.deployed().then((instance) => {
            return instance.saveInsurancePart1(this.wall, this.floor, this.bar, this.paint, this.stone, this.radio1, account, {from: account})
          }).then((result) => {
            Application.contracts.Adoption.deployed().then((instance) => {
              return instance.saveInsurancePart2(this.city,
                this.money,
                Number((this.money * this.getFee).toPrecision(9)), {from: account})
            }).then((result) => {
              this.$router.push('MyInsurance')
            })
          })
        })
      }
    },
    watch: {
      city: function (newValue, oldValue) {
        this.rainstormPoint = 0
        this.acidRainPoint = 0
        this.typhoonPoint = 0
        this.stormTidePoint = 0
        this.floodPoint = 0
        this.earthquakePoint = 0
        this.wall = ''
        this.floor = ''
        this.bar = ''
        this.paint = ''
        this.stone = ''
        this.radio1 = ''
        this.finalPoint = 100
        if (newValue === 'Beijing' || newValue === 'Liaoning' || newValue === 'Shandong' || newValue === 'Guangdong' || newValue === 'Guangxi' || newValue === 'Fujian' ||
          newValue === 'Zhejiang' || newValue === 'Taiwan' || newValue === 'Xianggang' || newValue === 'Aomen' || newValue === 'Heilongjiang' || newValue === 'Hebei' ||
          newValue === 'Shanxi1' || newValue === 'Henan' || newValue === 'Jiangxi' || newValue === 'Neimenggu' || newValue === 'Gansu' || newValue === 'Shanxi2' ||
          newValue === 'Hunan') {
          this.rainstormPoint = this.rainstormPoint + 20
        }
        if (newValue === 'Sichuan' || newValue === 'Chongqing' || newValue === 'Guizhou' || newValue === 'Hunan' || newValue === 'Hubei' || newValue === 'Jiangxi' ||
          newValue === 'Fujian' || newValue === 'Guangdong' || newValue === 'Wuhan') {
          this.acidRainPoint = this.acidRainPoint + 20
        }
        if (newValue === 'Guangdong' || newValue === 'Hainan' || newValue === 'Fujian' || newValue === 'Zhejiang' || newValue === 'Taiwan') {
          this.typhoonPoint = this.typhoonPoint + 30
        }
        if (newValue === 'Zhejiang' || newValue === 'Fujian' || newValue === 'Guangdong') {
          this.stormTidePoint = this.stormTidePoint + 30
        }
        if (newValue === 'Neimenggu' || newValue === 'Jilin' || newValue === 'Liaoning' || newValue === 'Hebei' || newValue === 'Henan' || newValue === 'Shandong' ||
          newValue === 'Jiangsu' || newValue === 'Anhui' || newValue === 'Qinghai' || newValue === 'Xizang' || newValue === 'Xinjiang' || newValue === 'Gansu' ||
          newValue === 'Ningxia' || newValue === 'Sichuan' || newValue === 'Yunnan' || newValue === 'Hainan') {
          this.floodPoint = this.floodPoint + 35
        }
        if (this.rainstormPoint + this.typhoonPoint + this.floodPoint > 0) {
          this.check1 = true
        } else {
          this.check1 = false
        }
        if (newValue === 'Hebei' || newValue === 'Henan' || newValue === 'Shandong' || newValue === 'Neimenggu' || newValue === 'Shanxi1' || newValue === 'Shanxi2' ||
          newValue === 'Ningxia' || newValue === 'Neimenggu' || newValue === 'Jiangsu' || newValue === 'Anhui' || newValue === 'Qinghai' || newValue === 'Xizang' ||
          newValue === 'Xinjiang' || newValue === 'Gansu' || newValue === 'Sichuan' || newValue === 'Yunnan' || newValue === 'Hainan') {
          this.check2 = true
          this.earthquakePoint = this.earthquakePoint + 35
        } else {
          this.check2 = false
        }
        this.finalPoint = this.finalPoint + this.floodPoint + this.typhoonPoint + this.rainstormPoint + this.earthquakePoint + this.stormTidePoint + this.acidRainPoint
      },
      wall: function (newValue, oldValue) {
        if (newValue === '乳胶漆墙面') {
          this.finalPoint = this.finalPoint + 20
        } else if (newValue === '壁纸墙面') {
          this.finalPoint = this.finalPoint - 5
        } else if (newValue === '硅藻泥墙面') {
          this.finalPoint = this.finalPoint - 10
        }
        if (oldValue === '乳胶漆墙面') {
          this.finalPoint = this.finalPoint - 20
        } else if (oldValue === '壁纸墙面') {
          this.finalPoint = this.finalPoint + 5
        } else if (oldValue === '硅藻泥墙面') {
          this.finalPoint = this.finalPoint + 10
        }
      },
      floor: function (newValue, oldValue) {
        if (newValue === '木地板') {
          this.finalPoint = this.finalPoint + 10
        } else if (newValue === '瓷砖') {
          this.finalPoint = this.finalPoint - 5
        }
        if (oldValue === '木地板') {
          this.finalPoint = this.finalPoint - 10
        } else if (oldValue === '瓷砖') {
          this.finalPoint = this.finalPoint + 5
        }
      },
      bar: function (newValue, oldValue) {
        if (newValue === '实木板') {
          this.finalPoint = this.finalPoint + 40
        } else if (newValue === '人造板') {
          this.finalPoint = this.finalPoint - 10
        }
        if (oldValue === '实木板') {
          this.finalPoint = this.finalPoint - 40
        } else if (oldValue === '人造板') {
          this.finalPoint = this.finalPoint + 10
        }
      },
      paint: function (newValue, oldValue) {
        if (newValue === '水性漆') {
          this.finalPoint = this.finalPoint - 20
        } else if (newValue === '油性漆') {
          this.finalPoint = this.finalPoint - 5
        }
        if (oldValue === '水性漆') {
          this.finalPoint = this.finalPoint + 20
        } else if (oldValue === '油性漆') {
          this.finalPoint = this.finalPoint + 5
        }
      },
      stone: function (newValue, oldValue) {
        if (newValue === '砖石') {
          this.finalPoint = this.finalPoint + 30
        }
        if (oldValue === '砖石') {
          this.finalPoint = this.finalPoint - 30
        }
      },
      radio1: function (newValue, oldValue) {
        if (newValue === '家中备有灭火器等设备') {
          this.finalPoint = this.finalPoint - 20
        } else if (newValue === '未备有灭火器等设备') {
          this.finalPoint = this.finalPoint + 10
        }
        if (oldValue === '家中备有灭火器等设备') {
          this.finalPoint = this.finalPoint + 20
        } else if (oldValue === '未备有灭火器等设备') {
          this.finalPoint = this.finalPoint - 10
        }
      }
    },
    data () {
      return {
        swiperOption: {
          notNextTick: true,
          autoplay: 3000,
          direction: 'vertical',
          grabCursor: true,
          setWrapperSize: true,
          autoHeight: true,
          mousewheelControl: true,
          observeParents: true,
          on: {
            touchMove: function () {
              var temp = document.getElementById('moveIcon')
              if (Math.abs(this.translate) > (this.height * 1.0) / 2) {
                temp.style.transform = 'rotate(180deg)'
              } else {
                temp.style.transform = ''
              }
            }
          }
        },
        wallOptions: [{value: '乳胶漆墙面'}, {value: '壁纸墙面'}, {value: '硅藻泥墙面'}, {value: '其他'}],
        floorOptions: [{value: '木地板'}, {value: '瓷砖'}, {value: '其他'}],
        panelOptions: [{value: '实木板'}, {value: '人造板'}],
        paintOptions: [{value: '水性漆'}, {value: '油性漆'}],
        materials: [{value: '砖石'}, {value: '钢筋混凝土'}],
        radioOptions: [{value: '家中备有灭火器等设备'}, {value: '楼道中备有灭火器等设备'}, {value: '未备有灭火器等设备'}],
        wall: '',
        floor: '',
        bar: '',
        paint: '',
        stone: '',
        city: '',
        radio1: '',
        check1: true,
        check2: true,
        rainstormPoint: 0,
        acidRainPoint: 0,
        typhoonPoint: 0,
        stormTidePoint: 0,
        floodPoint: 0,
        earthquakePoint: 0,
        finalPoint: 100,
        showDialog: false,
        startCount: false,
        money: null,
      }
    }
  }
</script>

<style lang="stylus">
  @import "~vux/src/styles/close"
  #risk-form
    .el-form-item
      margin-bottom 10px

    .el-input__inner
      box-shadow: 0 14px 24px rgba(50, 48, 58, .25) !important

    .el-form-item__label
      color: white
      font-size 16px
      text-shadow: 0 14px 24px rgba(50, 48, 58, .25)

    .el-radio__label
      color: white
      text-shadow: 0 14px 24px rgba(50, 48, 58, .25)

    .title
      margin 30px 0 15px 0
      font-size 20px
      color white
      font-weight 500
      text-shadow: 0 14px 24px rgba(50, 48, 58, .25)

    .dialog-demo
      .weui-dialog
        border-radius: 8px
      .dialog-title
        //line-height: 30px
        //color: #666
      .img-box
        height: 80%
        overflow: hidden
        font-family: 'Source Sans Pro', Helvetica, Arial, sans-serif
        font-size: 5em
        color: #409EFF
      .vux-close
        margin-top: 2px
        margin-bottom: 2px
</style>
