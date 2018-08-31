<template>
  <el-container :direction="vertical" style="height: 100%">
    <el-container>
      <div id="risk-form" style="width: 100%">
        <swiper :options="swiperOption" style="height: 100%; width: 100%">
          <swiper-slide style="height: 100%">
            <el-form>
              <el-form-item label="房屋位置" size="medium">
                <CitySelector></CitySelector>
              </el-form-item>
            </el-form>
            <img id="nextIcon" src="../../static/icon/下移.png" width="40px" style="position: absolute; bottom: 0px">
          </swiper-slide>
          <swiper-slide style="height: 100%">
            <el-form label-width="80px" label-position="left">
              <div class="title"><img src="../../static/icon/漏水.png" width="20px">浸水评估</div>
              <el-form-item label="墙面">
                <el-select v-model="value1" placeholder="请选择">
                  <el-option
                    v-for="item in wallOptions"
                    :key="item.value"
                    :label="item.value"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="地板">
                <el-select v-model="value2" placeholder="请选择">
                  <el-option
                    v-for="item in floorOptions"
                    :key="item.value"
                    :label="item.value"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="板材">
                <el-select v-model="value3" placeholder="请选择">
                  <el-option
                    v-for="item in panelOptions"
                    :key="item.value"
                    :label="item.value"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="涂料">
                <el-select v-model="value4" placeholder="请选择">
                  <el-option
                    v-for="item in paintOptions"
                    :key="item.value"
                    :label="item.value"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-form-item>
              <div class="title"><img src="../../static/icon/地震.png" width="20px">地震评估</div>
              <el-form-item label="建筑材料">
                <el-select v-model="value5" placeholder="请选择">
                  <el-option
                    v-for="item in materials"
                    :key="item.value"
                    :label="item.value"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-form-item>
              <div class="title"><img src="../../static/icon/火灾.png" width="20px">火灾评估</div>
              <el-form-item label="消防设施">
                <el-radio-group v-model="radio1">
                  <el-radio
                    v-for="item in radioOptions"
                    :key="item.value"
                    :label="item.value"
                    :value="item.value"
                    style="display: block; margin: 0;">
                  </el-radio>
                </el-radio-group>
              </el-form-item>
            </el-form>
          </swiper-slide>
        </swiper>
      </div>
    </el-container>
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

  export default {
    components: {
      ElHeader,
      ElMain,
      ElRow,
      ElAside,
      CitySelector,
      swiper,
      swiperSlide
    },
    name: 'Evaluation',
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
          observeParents: true
        },
        wallOptions: [{value: '乳胶漆墙面'}, {value: '壁纸墙面'}, {value: '硅藻泥墙面'}, {value: '其他'}],
        floorOptions: [{value: '木地板'}, {value: '瓷砖'}, {value: '其他'}],
        panelOptions: [{value: '实木板'}, {value: '人造板'}],
        paintOptions: [{value: '水性漆'}, {value: '油性漆'}],
        materials: [{value: '砖石'}, {value: '钢筋混凝土'}],
        radioOptions: [{value: '家中备有灭火器等设备'}, {value: '楼道中备有灭火器等设备'}, {value: '未备有灭火器等设备'}],
        value1: '',
        value2: '',
        value3: '',
        value4: '',
        value5: '',
        radio1: ''
      }
    }
  }
</script>

<style lang="stylus">
  #nextIcon
    position fixed
    left 45%

  #risk-form
    margin 10px

  .el-form-item
    margin-bottom 10px

  .title
    margin 30px 0 15px 0
</style>
