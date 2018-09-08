<template>
  <div id="city">
    <el-select v-model="value7" placeholder="你的房产在哪个城市？" @change="setCity">
      <el-option-group
        v-for="group in options3"
        :key="group.label"
        :label="group.label">
        <el-option
          v-for="item in group.options"
          :key="item.value"
          :label="item.label"
          :value="item.value">
        </el-option>
      </el-option-group>
    </el-select>
  </div>
</template>

<script type="text/ecmascript-6">
  export default {
    name: 'CitySelector',
    methods: {
      setCity: function () {
        this.$emit('changeCity', this.value7)
      }
    },
    data () {
      return {
        options3: [{
          label: '热门城市',
          options: [{
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
          }]
        }, {
          label: '城市名',
          options: [{
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
          }]
        }],
        value7: ''
      }
    }
  }
</script>

<style lang="stylus">
  #city
    margin 0px
    .el-input__inner
      width: 270px
      box-shadow: 0 14px 24px rgba(50, 48, 58, .25) !important
</style>
