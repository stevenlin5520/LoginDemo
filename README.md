# LoginDemo  微信小程序登录模块，包含小程序客户端和后台API服务器

#### 基本思想：<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 由于openid几乎是不变的（同一个appID下），于是就采用openid来请求数据，然后自己自己研究了一套登陆逻辑，不采用session请求，每次传输请求带一个openid过去操作吧，这样就简单多了。
##

#### 以下为该项目的流程图<br/>
![Alt](https://img-blog.csdnimg.cn/20190120213430739.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMzNzk5MzY2,size_16,color_FFFFFF,t_70)
##

#### 实现步骤<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、用户第一次登录，先通过wx.getSetting判断小程序是否授权过，此时是没有授权过的，于是进入授权页面调用登录API  wx.login获取到一个code，将此code连同用户信息userInfo一并发到开发者服务器。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、开发者服务器获取到code之后，连同appID、appSecret通过网络请求微信服务器的code2session接口，获取到openid和session_key。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、将步骤2的openid拿到数据库中查找是否有该用户数据，没有的话就将信息插入到数据库。我在此把openid、session_key（虽然没用到这个数据，还是先预留着，万一下次需要用到呢）、userInfo整理存入数据库，然后返回一个openid给小程序；如果数据库中有该条信息，则返回一个openid给小程序。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、小程序获取到服务器返回的openid后，保存到本地缓存中，并放入全局变量，跳转到用户主界面。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5、小程序第二次登录，通过wx.getSetting，可以查到此时是用户授权过的，然后就同步获取缓存中的openid。若获取失败和没有找到openid的话，就再次调用wx.login登录获取openid，之后步骤也和2、3一样；若获取到了openid，就把他放到全局变量中，直接跳转主页面，不再请求开发者服务器。
##

#### 详情参考CSDN博客<br/>
[微信小程序之登录模块的实现](https://blog.csdn.net/qq_33799366/article/details/86566634)
