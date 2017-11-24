
from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.core.paginator import Paginator
from myweb.models import Types,Goods,Users,Orders,Detail
from PIL import Image
import time,json,os




#===============session的购物车案例===============================
# 自定义公共信息加载函数
def loadinfo(request):
    context={}
    context['typelist'] = Types.objects.filter(pid=0)
    return context


# 浏览购物车
def shop(request):
    context = loadinfo(request)
    if 'shoplist' not in request.session:
        request.session['shoplist']={}
    
    return render(request,"myweb/cart.html",context)

# 添加购物车
def addcart(request,sid):
    #shop = {}
    # goods = Goods.objects.get(id=tid)
    # shop = goods.toDict()
    #获取要放入购物车中的商品信息
    goods = Goods.objects.get(id=sid)
    shop = goods.toDict();

    shop['m'] = int(request.POST['m'])
    # 添加一个购买量属性
    #获取要购买的商品信息
    
    # sid = request.POST.get(id=sid)
    # shop['id'] = sid
    # shop['name'] = request.POST.get("name")
    # shop['price'] = float(request.POST.get("price"))
    # shop['m'] = 1 #默认追加一个为1的购买量
    # 从session中获取购物车信息
    shoplist = request.session.get("shoplist",{})

    #判断购物车中是否存在当前购买商品
    if sid in shoplist:
    	shoplist[sid]['m'] += shop['m']
    #若存在，购买量leijia
    else:
        # 将商品shop放入购物车shoplist中
        shoplist[sid] = shop

    # 将购物车shoplist放入session中
    request.session['shoplist'] = shoplist
    # 加载模板
    return render(request,"myweb/cart.html")



def delcart(request,sid):
    # 从session中获取购物车
    shoplist = request.session.get("shoplist",{})
    # 从购物车shoplist中删除一个商品
    del shoplist[sid]
    # 将购物车shoplist放入session中
    request.session['shoplist'] = shoplist
    return render(request,"myweb/cart.html")

def clearcart(request):
    context = loadinfo(request)
    request.session['shoplist'] = {}
    return render(request,"myweb/shopcart.html",context)



def shopcartchange(request):
    #context = loadinfo(request)
    shoplist = request.session['shoplist']
    #获取信息
    shopid = request.GET['sid']
    num = int(request.GET['num'])
    if num<1:
        num = 1
    shoplist[shopid]['m'] = num #更改商品数量
    request.session['shoplist'] = shoplist
    return redirect(reverse('shop'))
    #return render(request,"myweb/cart.html",context)

#===============订单处理=========================

def ordersadd(request):
    ids = request.GET.get('ids','')
    if len(ids) == 0:
        return HttpResponse('请选择要结算的商品!')
    gidlist = ids.split(',')
    #print(gidlist)

    #从购物车获取要结算的所有商品，并放入到orderslist中，并且累计总金额
    shoplist = request.session['shoplist']
    orderslist = {}
    total = 0.0
    for gid in gidlist:
        orderslist[gid] = shoplist[gid]
        total += shoplist[gid]['price']*shoplist[gid]['m']
    #将这些信息放入到sessoin中
    request.session['orderslist'] = orderslist
    request.session['total'] = total

    return render(request,'myweb/orders.html')


def ordersconfirm(request):
    return render(request,'myweb/ordersconfirm.html')


def ordersinsert(request):
    #执行订单信息添加操作
    try:
        od = Orders()
        # print(request.session['vipusers']['id'])
        a = request.session['vipusers']['id']
        od.uid = request.session['vipusers']['id']
        od.linkman = request.POST.get('linkman')
        od.address = request.POST.get('address')
        od.code = request.POST.get('code')
        od.phone = request.POST.get('phone')
        od.addtime = time.time()
        od.total = request.session['total']
        od.status = 0
        od.save()

        #执行订单详情添加操作
        orderslist = request.session['orderslist']
        shoplist = request.session['shoplist']
        for shop in orderslist.values():
            del shoplist[str(shop['id'])]
            ov = Detail()
            ov.orderid = od.id
            ov.goodsid = shop['id']
            ov.name = shop['goods']
            ov.price = shop['price']
            ov.num = shop['m']
            ov.save()
        del request.session['orderslist']
        del request.session['total']
        request.session['shoplist'] = shoplist
        return HttpResponse("订单添加成功! 订单号:"+str(od.id)) 
    except:
        return HttpResponse("订单添加失败!")    


