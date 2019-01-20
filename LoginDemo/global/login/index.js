// 封装的登录模块
let loginUtil = require("../../utils/login.js")

Page({

  /**
   * 页面的初始数据
   */
  data: {
    //判断小程序的API，回调，参数，组件等是否在当前版本可用
    canIUse: wx.canIUse("button.open-type=getUserInfo")
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    
  },


  // 用户授权
  bindGetUserInfo: (res) => {
    console.log("bindGetUserInfo获取权限",res)
    if(res.detail.userInfo){
      // 成功获取到权限，将用户信息存入全局变量
      console.log("bindGetUserInfo获取用户信息成功！")

      getApp().globalData.userInfo = res.detail.userInfo
      
      // 登录
      loginUtil.login()

    }else{
      console.log("bindGetUserInfo获取用户信息失败!")

      wx.showToast({
        title: '您想正常使用，请先授权哦!',
        icon: 'none', // "success", "loading", "none"
        duration: 2000,
        mask: false
      })
    }
  }
})