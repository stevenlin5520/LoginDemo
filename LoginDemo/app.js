// 封装的登陆逻辑
var loginUtil = require("/utils/login.js")

App({
  onLaunch: function () {
    // 获取用户信息
    wx.getSetting({
      success: res => {
        console.log("wx.getSetting判断授权情况",res)
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称，不会弹框
          wx.getUserInfo({
            success: res => {
              // 将用户信息放入到全局变量
              this.globalData.userInfo = res.userInfo

              // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
              // 所以此处加入 callback 以防止这种情况
              if (this.userInfoReadyCallback) {
                this.userInfoReadyCallback(res)
              }

              // 查看缓存的openid
              // 若没有则重新登录获取；存在的话放入全局变量
              try{
              	let openid = wx.getStorageSync('openid')
              	if(openid != null && openid != ""){
              		console.log("获取到openid、放入globalData中")
              		getApp().globalData.openid = openid

              		// 跳转主页面
              		wx.redirectTo({
              			url: "/main/index/index"
              		})
              	}else{
              		console.log("openid为空，重新登录获取")
              		loginUtil.login()
              	}
              }catch(err){
              	console.log("openid获取异常，重新登录获取")
              	loginUtil.login()
              }

            }
          })
        }
        // else{
        // 	// 跳转授权页面
        // 	wx.redirectTo({
        // 		url: '/global/login/index'
        // 	})
        // }
      }
    })
  },
  globalData: {
    userInfo: null,
    openid: null
  }
})