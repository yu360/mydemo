from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.core.paginator import Paginator
from myadmin.models import Users
import time,json
#后台首页
def index(request):
    
    return render(request,"myadmin/index.html")

# ==============后台会员管理======================
# 浏览会员
def usersindex(request,pIndex):
    pIndex = int(pIndex) #处理页号为整型
    print(pIndex,'=======')
    lists = Users.objects.filter()
    #获取并判断是否添加name条件搜索
    where = [] #定义一个用于维持搜索条件的变量列表
    name = request.GET.get("username",'')
    if name != '':
        lists = lists.filter(username__contains=name)
        where.append('username='+name)
    # 通过信息创建分页对象
    p = Paginator(lists, 5)
    
    #判断页号，防止越界
    if pIndex > p.num_pages:
        pIndex = p.num_pages
    if pIndex < 1:
        pIndex = 1

    # 获取指定pIndex页的数据
    list2 = p.page(pIndex)
    plist = p.page_range
    # 将结果放置模板中
    context = {"userslist":list2,'plist':plist, 'pIndex':pIndex,"where":where}
    return render(request,"myadmin/users/index.html",context)


def usersadd(request):
    return render(request,'myadmin/users/add.html')

def usersinsert(request):
    
    try:
        ob = Users()
        ob.username = request.POST['username']
        ob.name = request.POST['name']
        #获取密码并md5
        import hashlib
        m = hashlib.md5() 
        m.update(bytes(request.POST['password'],encoding="utf8"))
        ob.password = m.hexdigest()
        ob.sex = request.POST['sex']
        ob.address = request.POST['address']
        ob.code = request.POST['code']
        ob.phone = request.POST['phone']
        ob.email = request.POST['email']
        ob.state = 1
        ob.addtime = time.time()
        ob.save()
        context = {'info':'添加成功！'}
    except:
        context = {'info':'添加失败！'}

    return render(request,"myadmin/info.html",context)

# 执行会员信息删除

def usersdel(request,uid):
    try:
        ob = Users.objects.get(id=uid)
        ob.delete()
        context = {'info':'删除成功！'}
    except:
        context = {'info':'删除失败！'}
    return render(request,"myadmin/info.html",context)

def usersedit(request,uid):

    ob = Users.objects.get(id=uid)
    context = {'user':ob}
    return render(request,"myadmin/users/edit.html",context)


# 执行会员信息编辑
def usersupdate(request,uid):
    try:
        ob = Users.objects.get(id=uid)
        ob.name = request.POST['name']
        ob.sex = request.POST['sex']
        ob.address = request.POST['address']
        ob.code = request.POST['code']
        ob.phone = request.POST['phone']
        ob.email = request.POST['email']
        ob.state = request.POST['state']
        ob.save()
        context = {'info':'修改成功！'}
    except:
        context = {'info':'修改失败！'}
    return render(request,"myadmin/info.html",context)

#==============管理员登录退出操作==============================


def login(request):
    return render(request,"myadmin/login.html")

def dologin(request):
    #获取登录信息
    uname = request.POST.get('username','')
    upass = request.POST.get('password','')
    
    try:
        #从数据库中获取登录信息
        user = Users.objects.get(username=uname)
        if user.state == 0:
            # 验证密码
            import hashlib
            m = hashlib.md5() 
            m.update(bytes(upass,encoding="utf8"))
            if user.password == m.hexdigest():
                #此处表示登录成功，将登录成功后的信息放入到session中
                request.session['adminuser'] = user.name
                return redirect(reverse('myadmin_index'))
            else:
                context = {'info':'登录密码错误！'}
        else:
            context = {'info':'登录者不是后台管理员！'}
    except:
        context = {'info':'登录账号错误！'}
    
    return render(request,"myadmin/login.html",context)

def logout(request):
    del request.session['adminuser']
    return redirect(reverse('myadmin_login'))



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
    #str1 = 'ABCD123EFGHIJK456LMNOPQRS789TUVWXYZ0'
    str1 = '0123456789'
    #随机选取4个值作为验证码
    rand_str = ''
    for i in range(0, 4):
        rand_str += str1[random.randrange(0, len(str1))]
    #构造字体对象，ubuntu的字体路径为“/usr/share/fonts/truetype/freefont”
    font = ImageFont.truetype('static/STXIHEI.TTF', 21)
    #font = ImageFont.load_default().font
    #构造字体颜色
    fontcolor = (255, random.randrange(0, 255), random.randrange(0, 255))
    #绘制4个字
    draw.text((5, -2), rand_str[0], font=font, fill=fontcolor)
    draw.text((25, -2), rand_str[1], font=font, fill=fontcolor)
    draw.text((50, -2), rand_str[2], font=font, fill=fontcolor)
    draw.text((75, -2), rand_str[3], font=font, fill=fontcolor)
    #释放画笔
    del draw
    #存入session，用于做进一步验证
    #request.session['verifycode'] = rand_str
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




