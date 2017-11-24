from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.core.paginator import Paginator
from myweb.models import Types,Goods,Users,Orders,Detail
from PIL import Image, ImageDraw, ImageFont
import time,json,random,os



#网站前台商品展示

#公共信息加载
def loadinfo(request):
    context = {}
    lists = Types.objects.filter(pid=0)
    context['Typelist'] = lists
    return context



#首页
def index(request):
    context = loadinfo(request)
    return render(request,'myweb/index.html',context)

#商品列表
def lists(request):
    context = loadinfo(request)
    lists = Goods.objects.filter()
    #判断添加搜索条件
    tid = int(request.GET.get('tid',0))
    print(request.GET.get('tid'))
    print(tid)
    if tid > 0:
        lists = lists.filter(typeid__in=Types.objects.only('id').filter(pid=tid))
    context['goodslist'] = lists
    return render(request,'myweb/list.html',context)

#商品详情
def detail(request,gid):
    context = loadinfo(request)
    ob = Goods.objects.get(id=gid)
    ob.clicknum +=1
    ob.save()
    context ['goods'] = ob
      
    return render(request,'myweb/detail.html',context)
    
#===============前台会员管理======================

def usersindex(request):
   
    return render(request,"myweb/users/login.html")


def dologin(request):
    verifycode = request.session['verifycode']
    code = request.POST['code']
    if verifycode != code:
        context = {'info':'验证码错误！'}
        return render(request,"myweb/users/login.html",context)
    #获取登录信息
    uname = request.POST.get('username','')
    upass = request.POST.get('password','')
    code = request.POST.get('code','')
  
    #从数据库中获取登录信息
    user = Users.objects.get(username=uname)
    if user.state == 0 or user.state==1:
        # 验证密码
        import hashlib
        m = hashlib.md5() 
        m.update(bytes(upass,encoding="utf8"))
        if user.password == m.hexdigest():
            #此处表示登录成功，将登录成功后的信息放入到session中
            request.session['vipusers'] = user.toDict()
            return redirect(reverse('index'))
        else:
            context = {'info':'登录密码错误！'}
    else:
        context = {'info':'登录者不是后台管理员！'}
 
    return render(request,"myweb/users/login.html",context)
   

def usersadd(request):
    return render(request,"myweb/users/add.html")

def usersinsert(request):
    ob = Users()
    ob.username = request.POST['uname']
    ob.password = request.POST['password']
    #获取密码并md5
    import hashlib
    m = hashlib.md5() 
    m.update(bytes(request.POST['password'],encoding="utf8"))
    ob.password = m.hexdigest()
    ob.username = request.POST['uname']
    ob.state = 1
    ob.addtime = time.time()
    ob.save()
    context = {'info':'注册成功！'}
    return render(request,"myweb/users/login.html",context)

def logout(request):
    # 清除登录的session信息
    del request.session['vipusers']
    # 跳转登录页面（url地址改变）
    return redirect(reverse('index'))

def verifycode(request):
    #引入随机函数模块
    import random
    from PIL import Image, ImageDraw, ImageFont
    #定义变量，用于画面的背景色、宽、高
    #bgcolor = (random.randrange(20, 100), random.randrange(
    #    20, 100),100)
    bgcolor = (242,164,247)
    width = 100
    height = 25
    #创建画面对象
    im = Image.new('RGB', (width, height), bgcolor)
    #创建画笔对象
    draw = ImageDraw.Draw(im)
    #调用画笔的point()函数绘制噪点
    for i in range(0, 100):
        xy = (random.randrange(0, width), random.randrange(0, height))
        fill = (random.randrange(0, 255), 255, random.randrange(0, 255))
        draw.point(xy, fill=fill)
    #定义验证码的备选值
    str1 = '0123456789'
    #随机选取4个值作为验证码
    rand_str = ''
    for i in range(0, 4):
        rand_str += str1[random.randrange(0, len(str1))]
    #构造字体对象，ubuntu的字体路径为“/usr/share/fonts/truetype/freefont”
    font = ImageFont.truetype('static/msyh.ttc', 21)
    # font = ImageFont.load_default().font
    #构造字体颜色
    fontcolor = (255, random.randrange(0, 255), random.randrange(0, 255))
    #绘制4个字
    draw.text((5, 2), rand_str[0], font=font, fill=fontcolor)
    draw.text((25, 2), rand_str[1], font=font, fill=fontcolor)
    draw.text((50, 2), rand_str[2], font=font, fill=fontcolor)
    draw.text((75, 2), rand_str[3], font=font, fill=fontcolor)
    #释放画笔
    del draw
    #存入session，用于做进一步验证
    request.session['verifycode'] = rand_str
    """
    python2的为
    # 内存文件操作
    import cStringIO
    buf = cStringIO.StringIO()
    """
    # 内存文件操作-->此方法为python3的
    import io
    buf = io.BytesIO()
    #将图片保存在内存中，文件类型为png
    im.save(buf, 'png')
    #将内存中的图片数据返回给客户端，MIME类型为图片png
    return HttpResponse(buf.getvalue(), 'image/png')


#我的订单
def ordersshow(request):
    context = loadinfo(request)
    #获取当前用户的所有订单信息
    odlist = Orders.objects.filter(uid=request.session['vipusers']['id'])

    #遍历当前用户的所有订单,添加他的订单详情
    for od in odlist:
        delist = Detail.objects.filter(orderid=od.id)

        for og in delist:
            og.picname = Goods.objects.only('picname').get(id=og.goodsid).picname
        od.detaillist = delist

    #将整理好的订单信息放置到模板遍历中
    context['orderslist'] = odlist
    return render(request,"myweb/ordersshow.html",context)    

#==============个人中心====================

def vipusers(request):
    return render(request,"myweb/vipusers.html")

#修改个人信息
def modify(request):
    return render(request,"myweb/modify.html")

# 执行会员信息编辑
def usersupdate(request):
    try:
        uid = request.session['vipusers']['id']
        # print(uid)
        ob = Users.objects.get(id=uid)
        # print(ob)
        ob.name = request.POST['name']
        ob.sex = request.POST['sex']
        # print(ob.name)
        ob.address = request.POST['address']
        ob.code = request.POST['code']
        ob.phone = request.POST['phone']
        ob.email = request.POST['email']
        # ob.state = request.POST['state']
        ob.save()
        request.session['vipusers'] = ob.toDict()
        print('ok')
        context = {'info':'修改成功！'}
    except:
        context = {'info':'修改失败！'}
    return render(request,"myweb/vipusers.html",context)

