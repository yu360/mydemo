from django.conf.urls import url

from . import views,viewsorder

urlpatterns = [
    #网站前台
    url(r'^$', views.index, name="index"),

    url(r'^list$', views.lists, name="list"),

    url(r'^detail/(?P<gid>[0-9]+)$', views.detail, name="detail"),
    
    #前台会员

    url(r'^users$', views.usersindex, name="userslogin"),

    url(r'^dologin$', views.dologin, name="myweb_dologin"),

    url(r'^usersadd$', views.usersadd, name="myweb_usersadd"),

    url(r'^usersinsert$', views.usersinsert, name="myweb_usersinsert"),
    
    url(r'^logout$', views.logout, name="myweb_logout"),
    url(r'^verifycode',views.verifycode,name='myweb_verifycode'),#验证码
    # #购物车

    # session购物车案例
    url(r'^shop$',viewsorder.shop,name="shop"), #浏览商品

    url(r'^addcart/(?P<sid>[0-9]+)$',viewsorder.addcart,name="addcart"), #添加购物车

    url(r'^delcart/(?P<sid>[0-9]+)$',viewsorder.delcart,name="delcart"), #删除一个商品
    url(r'^clearcart$',viewsorder.clearcart,name="clearcart"), #清空购物车
    url(r'^shopcartchange$', viewsorder.shopcartchange,name='shopcartchange'), #更改购物车中商品数量

    #订单处理

    url(r'^ordersadd$',viewsorder.ordersadd,name="ordersadd"), #订单的表单页
    url(r'^ordersconfirm$',viewsorder.ordersconfirm,name="ordersconfirm"), #订单的确认页
    url(r'^ordersinsert$',viewsorder.ordersinsert,name="ordersinsert"), #订单的执行页

    #个人中心路由
    url(r'^ordersshow$', views.ordersshow, name="ordersshow"),#查看我的订单
    url(r'^vipusers$',views.vipusers,name='vipusers'),#个人中心页
    url(r'^modify$',views.modify,name='modify'),#修改个人信息
    url(r'^usersupdate$', views.usersupdate, name="usersupdate"),


]
