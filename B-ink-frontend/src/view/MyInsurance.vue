<template>
  <div class='my-insurance' style="position: relative">
    <div @click="goEvaluation"
         style="position: absolute; top: 35px; left: 20px; color: black; font-weight: 500; text-shadow: 0 14px 24px rgba(50,48,58,.25);">
      <i class="el-icon-back"></i>
      去投保
    </div>
    <div style="position: absolute;right: 20px; top: 30px; font-size: 24px;">
      我的保单
    </div>
    <div style="margin-top: 60px">
      <div v-for="(insurance, key) in insurances" :key="key"
           style="position: relative;background-color: #fff;padding: 20px; margin: 20px 0; border-radius: 10px;">
        <div style="border-bottom: 1px dashed rgba(7,17,27,0.1); padding-bottom: 10px;">
          <div class="line"><span class="label">投保时间  </span> {{insurance.time}}</div>
        </div>
        <div style="padding: 10px 0 20px 0; border-bottom: 1px dashed rgba(7,17,27,0.1)">
          <div v-if="insurance.city !== ''" class="line"><span class="label">城市  </span>{{getCity(insurance.city)}}
          </div>
          <div v-if="insurance.wall !== ''" class="line"><span class="label">墙面</span> {{insurance.wall}}</div>
          <div v-if="insurance.floor !== ''" class="line"><span class="label">地板</span> {{insurance.floor}}</div>
          <div v-if="insurance.bar !== ''" class="line"><span class="label">板材</span> {{insurance.bar}}</div>
          <div v-if="insurance.paint !== ''" class="line"><span class="label">涂料</span> {{insurance.paint}}</div>
          <div v-if="insurance.stone !== ''" class="line"><span class="label">建筑材料</span> {{insurance.stone}}</div>
          <div v-if="insurance.radio1 !== ''" class="line"><span class="label">防火设施</span> {{insurance.radio1}}</div>
        </div>
        <div style="text-align: right; padding-top: 20px;">
          <div class="line"><span style="display: inline-block; margin-right: 10px; color: #999">保险额度: ￥{{Number(insurance.money)}}    </span><span
            class="line">保险费: <span style="color: red">￥{{Number(insurance.expense)}}</span></span></div>
        </div>
        <i class="coupon-circle coupon-circle-left"></i>
        <i class="coupon-circle coupon-circle-right"></i>
      </div>
      <div v-if="insurances.length === 0">您还没有保单</div>
    </div>
  </div>
</template>

<script type="text/ecmascript-6">
  import Application from '../js/app'

  export default {
    name: 'MyInsurance',
    created () {
      Application.contracts.Adoption.deployed().then((instance) => {
        Application.contracts.Adoption.deployed().then((instance) => {
          return instance.insurancePart1Len()
        }).then((res) => {
          let insurancePart1Len = Number(res);
          console.log(insurancePart1Len)
          for (let i = 0; i < insurancePart1Len; i++) {
            Application.contracts.Adoption.deployed().then((instance) => {
              Application.contracts.Adoption.deployed().then((instance) => {
                return instance.insurancePart1s(i)
              }).then((res) => {
                console.log(res)
                if (web3.eth.accounts[0] === res[6]) {
                  let [wall, floor, bar, paint, stone, radio1, _address, time] = res;
                  Application.contracts.Adoption.deployed().then((instance) => {
                    Application.contracts.Adoption.deployed().then((instance) => {
                      return instance.insurancePart2s(i)
                    }).then((res) => {
                      let [city, money, expense] = res;
                      this.insurances.push({
                        city,
                        wall,
                        floor,
                        bar,
                        paint,
                        stone,
                        radio1,
                        _address,
                        time: new Date(parseInt(time) * 1000).toLocaleString(),
                        money,
                        expense
                      })
                    })
                  })
                }
              })
            })
          }
        })
      })
    },
    data () {
      return {
        insurances: []
      }
    },
    methods: {
      getCity (pinyin) {
        let cities = [{
          value: 'Shanghai',
          label: '上海'
        }, {
          value: 'Beijing',
          label: '北京'
        }, {
          value: 'Zhejiang',
          label: '浙江'
        }, {
          value: 'ChongQing',
          label: '重庆'
        }, {
          value: 'Liaoning',
          label: '辽宁'
        }, {
          value: 'Jiangsu',
          label: '江苏'
        }, {
          value: 'Xianggang',
          label: '香港'
        }, {
          value: 'Taiwan',
          label: '台湾'
        }, {
          value: 'Aomen',
          label: '澳门'
        },
          {
            value: 'Chengdu',
            label: '成都'
          }, {
            value: 'Shenzhen',
            label: '深圳'
          }, {
            value: 'Guangzhou',
            label: '广州'
          }, {
            value: 'Dalian',
            label: '大连'
          }, {
            value: 'Tianjin',
            label: '天津'
          }, {
            value: 'Hebei',
            label: '河北'
          }, {
            value: 'Henan',
            label: '河南'
          }, {
            value: 'Yunnan',
            label: '云南'
          }, {
            value: 'Heilongjiang',
            label: '黑龙江'
          }, {
            value: 'Hunan',
            label: '湖南'
          }, {
            value: 'Anhui',
            label: '安徽'
          }, {
            value: 'Shandong',
            label: '山东'
          }, {
            value: 'Xinjiang',
            label: '新疆维吾尔'
          }, {
            value: 'Jiangxi',
            label: '江西'
          }, {
            value: 'Hubei',
            label: '湖北'
          }, {
            value: 'Guangxi',
            label: '广西壮族'
          }, {
            value: 'Gansu',
            label: '甘肃'
          }, {
            value: 'Shanxi1',
            label: '山西'
          }, {
            value: 'Neimenggu',
            label: '内蒙古'
          }, {
            value: 'Shanxi2',
            label: '陕西'
          }, {
            value: 'Jilin',
            label: '吉林'
          }, {
            value: 'Fujian',
            label: '福建'
          }, {
            value: 'Guizhou',
            label: '贵州'
          }, {
            value: 'Guangdong',
            label: '广东'
          }, {
            value: 'Qinghai',
            label: '青海'
          }, {
            value: 'Xizang',
            label: '西藏'
          }, {
            value: 'Sichuan',
            label: '四川'
          }, {
            value: 'Ningxia',
            label: '宁夏回族'
          }, {
            value: 'Hainan',
            label: '海南'
          }];
        for (let city of cities) {
          if (city.value === pinyin) {
            return city.label;
          }
        }
      },
      goEvaluation () {
        this.$router.push('Evaluation')
      }
    }
  }
</script>

<style lang="stylus">
  .my-insurance
    background-color #f5f7f9
    padding 20px
    box-sizing border-box
    min-height 100%
    .line
      margin 3px 0
      .label
        color: #999
    .coupon-circle
      display inline-block
      position absolute
      bottom 58px
      width 20px
      height 20px
      background-color #f5f7f9
      border-radius 50%
    .coupon-circle-left
      left -10px
    .coupon-circle-right
      right -10px
</style>
