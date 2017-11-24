from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.core.paginator import Paginator
from myadmin.models import Types,Goods,Orders,Detail,Users
from PIL import Image
import time,json,os

def index(request,pIndex):
    pIndex = int(pIndex)
    print(pIndex)
    #获取信息对象
    oblist = Orders.objects.filter()
    print()
    where = [] #定义一个用于维持搜索条件的变量列表
    linkman = request.GET.get("linkman",'')
    if linkman != '':
        oblist = oblist.filter(linkman__contains=linkman)
        where.append('linkman='+linkman)
    # 通过信息创建分页对象
    p = Paginator(oblist, 5)

    #判断页号，防止越界
    if pIndex > p.num_pages:
        pIndex = p.num_pages
    if pIndex < 1:
        pIndex = 1
    # 获取指定pIndex页的数据
    oblists = p.page(pIndex)
    plist = p.page_range
    # 将结果放置模板中
    for od in oblist:
        od.name = Users.objects.only('name').get(id=od.uid).name
    contet = {"orderslist":oblist,"list":oblists,'plist':plist,'pIndex':pIndex,"where":where}
    return render(request,'myadmin/order/index.html',contet)

# def index(request):
#     oblist = Orders.objects.filter()
#     for od in oblist:
#         od.name=Users.objects.only('name').get(id=od.uid).name
#     context = {'orderslist':oblist}
#     return render(request,'myadmin/order/index.html',context)

def detail(request,oid):
    ob = Orders.objects.get(id=oid)
    print(ob)
    ob.name = Users.objects.only('name').get(id=ob.uid).name
    #遍历当前用户的所有订单,添加他的订单详情
    delist = Detail.objects.filter(orderid=ob.id)
    #遍历当前用户的所有订单,添加他的订单详情
    for og in delist:
        og.picname = Goods.objects.only('picname').get(id=og.goodsid).picname
    ob.detaillist = delist
    context ={'orders':ob}

    return render(request,'myadmin/order/detail.html',context )
    
def shuohuo(request,oid):
    ob = Orders.objects.get(id=oid)
    ob.status = 1
    ob.save()
    ob.name = Users.objects.only('name').get(id=ob.uid).name
    #遍历当前用户的所有订单,添加他的订单详情
    delist = Detail.objects.filter(orderid=ob.id)
    #遍历当前用户的所有订单,添加他的订单详情
    for og in delist:
        og.picname = Goods.objects.only('picname').get(id=og.goodsid).picname
    ob.detaillist = delist

    context ={'orders':ob}

    return render(request,'myadmin/order/detail.html',context )


def orderswin(request):
    oblist = Orders.objects.filter(status=1)
    for od in oblist:
        oid = od.uid
        od.name=Users.objects.only('name').get(id=oid).name
    context = {'orderslist':oblist,}
    return render(request,'myadmin/order/index.html',context)

def ordersshow(request):
    oblist = Orders.objects.filter(status__in=(1,2,3))

    for od in oblist:
        print(type(od.uid),'=========')
        od.name=Users.objects.only('name').get(id=od.uid).name

    context = {'orderslist':oblist}
    return render(request,'myadmin/order/index.html',context)
	