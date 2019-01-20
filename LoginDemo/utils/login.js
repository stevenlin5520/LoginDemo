function login(){
  console.log("登陆请求获取openid")

  // 登录
  wx.login({
    success: res => {
      console.log("wx.login.code", res)
      
      // 加载进度
      wx.showLoading({
        title: '正在请求数据',
        mask: false
      })
      
      // 发送 res.code 到后台换取 openId, sessionKey,返回openid保存
      wx.request({
        url: 'http://192.168.0.240:8080/MiniProgramServer/login/login',
        // url: 'http://231q021j08.imwork.net/SSMDemo/loginCon/login',
        // url: 'https://psfd.handbbc.com/SSMDemo/loginCon/login',
        data: {
          code: res.code,
          // 将用户信息传到服务器保存
          userInfo: getApp().globalData.userInfo
        },
        header: {
          'content-type': 'application/json' // 默认值
        },
        method: 'POST',
        success(res) {
          console.log("成功", res)
          // 获取到openid后将openid存入本地,同时放到全局变量里
          getApp().globalData.openid = res.data.openid

          wx.setStorage({
            key: 'openid',
            data: res.data.openid
          })

          wx.hideLoading()
          // 然后跳转主页面
          wx.redirectTo({
            url: '/main/index/index'
          })
        },
        fail(res){
          console.log("请求失败")
          wx.hideLoading()
          wx.showToast({
            title: '请求失败',
            icon: 'none', // "success", "loading", "none"
            duration: 1500,
            mask: false
          })
        }
      })
      // request请求结束
    }
  })
};

module.exports = {
  login: login
}