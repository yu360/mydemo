from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.core.paginator import Paginator
from myadmin.models import Types,Goods
from PIL import Image
import time,json,os

#=============后台商品类别信息管理=======================

#浏览商品类别信息
def typeindex(request):
     # 执行数据查询，并放置到模板中
    lists = Types.objects.extra(select = {'_has':'concat(path,id)'}).order_by('_has')
    # 遍历查询结果，为每个结果对象追加一个pname属性，目的用于缩进标题
    for ob in lists:
        ob.pname ='. . . '*(ob.path.count(',')-1)
        # print(list[0].__dict__)
    context = {"typeslist":lists}
    return render(request,'myadmin/types/index.html',context)
#商品类别信息添加表单
def typeadd(request,tid):
    #判断并获取当前父类别信息
    if int(tid) != 0:
        tob = Types.objects.get(id=tid)
        context = {'pid':tid,'path':tob.path+str(tid)+',','pname':tob.name}
    else:
        context = {'pid':0,'path':'0,','pname':'根类别'}
    return render(request,'myadmin/types/add.html',context)

#执行商品类别信息添加    
def typeinsert(request):
    try:
        ob = Types()
        ob.name = request.POST['name']
        ob.pid = request.POST['pid']
        ob.path = request.POST['path']
        ob.save()
        context = {'info':'添加成功！'}
    except:
         context = {'info':'添加失败！'}

    return render(request,"myadmin/info.html",context)
# 执行商品类别信息删除
def typedel(request,tid):
    try:
        #判断此类别下是否与商品和子类别信息，若没有才可删除
        ob = Types.objects.get(id=tid)
        #ob.delete()
        context = {'info':'删除成功！'}
    except:
        context = {'info':'删除失败！'}
    return render(request,"myadmin/info.html",context)


# 打开商品类别信息编辑表单
def typeedit(request,tid):
    try:
        ob = Types.objects.get(id=tid)
        context = {'type':ob}
        return render(request,"myadmin/types/edit.html",context)
    except:
        context = {'info':'没有找到要修改的信息！'}
    return render(request,"myadmin/info.html",context)


# 执行商品类别信息编辑
def typeupdate(request,tid):
   
    try:
        ob = Types.objects.get(id=tid)
        ob.name = request.POST['name']
        ob.save()
        context = {'info':'修改成功！'}
    except:
        context = {'info':'修改失败！'}
    return render(request,"myadmin/info.html",context)


#==================后台商品信息管理=======================

# 浏览商品信息
def goodsindex(request,pIndex):
     # 执行数据查询，
    
    pIndex = int(pIndex) #处理页号为整型
    list = Goods.objects.filter()
    #获取并判断是否添加name条件搜索
    where = [] #定义一个用于维持搜索条件的变量列表
    name = request.GET.get("goods",'')
    if name != '':
        list = list.filter(goods__contains=name)
        where.append('goods='+name)

    # 通过信息创建分页对象
    p = Paginator(list, 4)
    
    #判断页号，防止越界
    if pIndex > p.num_pages:
        pIndex = p.num_pages
    if pIndex < 1:
        pIndex = 1

    # 获取指定pIndex页的数据
    list1 = p.page(pIndex)
    plist = p.page_range
    # 将结果放置模板中

    for ob in list1:
        ty = Types.objects.get(id=ob.typeid)
        ob.typename = ty.name
    context = {"goodslist":list1,'plist':plist,'pIndex':pIndex,'where':where}

    return render(request,'myadmin/goods/index.html',context)



# 商品信息添加表单
def goodsadd(request):

    # 获取商品的类别信息
    list = Types.objects.extra(select = {'_has':'concat(path,id)'}).order_by('_has')
    context = {"typelist":list}
    return render(request,'myadmin/goods/add.html',context)


#执行商品类别信息添加 
def goodsinsert(request):
    try:
        # 判断并执行图片上传，缩放等处理
        myfile = request.FILES.get("pic", None)
        if not myfile:
            return HttpResponse("没有上传文件信息！")
        # 以时间戳命名一个新图片名称
        filename= str(time.time())+"."+myfile.name.split('.').pop()
        destination = open(os.path.join("./static/goods/",filename),'wb+')
        for chunk in myfile.chunks():      # 分块写入文件  
            destination.write(chunk)  
        destination.close()

        # 执行图片缩放
        im = Image.open("./static/goods/"+filename)
        # 缩放到375*375:
        im.thumbnail((375, 375))
        # 把缩放后的图像用jpeg格式保存:
        im.save("./static/goods/"+filename, None)
        # 缩放到220*220:
        im.thumbnail((220, 220))
        # 把缩放后的图像用jpeg格式保存:
        im.save("./static/goods/m_"+filename, None)
        # 缩放到220*220:
        im.thumbnail((100, 100))
        # 把缩放后的图像用jpeg格式保存:
        im.save("./static/goods/s_"+filename, None)

        # 获取商品信息并执行添加
        ob = Goods()
        ob.goods = request.POST['goods']
        ob.typeid = request.POST['typeid']
        ob.company = request.POST['company']
        ob.price = request.POST['price']
        ob.store = request.POST['store']
        ob.descr = request.POST['descr']
        ob.picname = filename
        ob.state = 1
        ob.addtime = time.time()
        ob.save()
        context = {'info':'添加成功！'}
    except:
        context = {'info':'添加失败！'}

    return render(request,"myadmin/info.html",context)

# 执行商品信息删除
def goodsdel(request,gid):
    try:
        # 获取被删除商品信的息量，先删除对应的图片
        ob = Goods.objects.get(id=gid)
        #执行图片删除
        os.remove("./static/goods/"+ob.picname)   
        os.remove("./static/goods/m_"+ob.picname)   
        os.remove("./static/goods/s_"+ob.picname)
        #执行商品信息的删除 
        ob.delete()
        context = {'info':'删除成功！'}
    except:
        context = {'info':'删除失败！'}
    return render(request,"myadmin/info.html",context)


# 打开商品类别信息编辑表单
def goodsedit(request,gid):
    try:
        # 获取要编辑的信息
        ob = Goods.objects.get(id=gid)
        # 获取商品的类别信息
        list = Types.objects.extra(select = {'_has':'concat(path,id)'}).order_by('_has')
        # 放置信息加载模板
        context = {"typelist":list,'goods':ob}
        return render(request,"myadmin/goods/edit.html",context)
    except:
        context = {'info':'没有找到要修改的信息！'}
    return render(request,"myadmin/info.html",context)


# 执行商品类别信息编辑
def goodsupdate(request,gid):
    try:
        b = False
        oldpicname = request.POST['oldpicname']
        if None != request.FILES.get("pic"):
            myfile = request.FILES.get("pic", None)
            if not myfile:
                return HttpResponse("没有上传文件信息！")
            # 以时间戳命名一个新图片名称
            filename = str(time.time())+"."+myfile.name.split('.').pop()
            destination = open(os.path.join("./static/goods/",filename),'wb+')
            for chunk in myfile.chunks():      # 分块写入文件  
                destination.write(chunk)  
            destination.close()
            # 执行图片缩放
            im = Image.open("./static/goods/"+filename)
            # 缩放到375*375:
            im.thumbnail((375, 375))
            # 把缩放后的图像用jpeg格式保存:
            im.save("./static/goods/"+filename, 'jpeg')
            # 缩放到220*220:
            im.thumbnail((220, 220))
            # 把缩放后的图像用jpeg格式保存:
            im.save("./static/goods/m_"+filename, 'jpeg')
            # 缩放到220*220:
            im.thumbnail((100, 100))
            # 把缩放后的图像用jpeg格式保存:
            im.save("./static/goods/s_"+filename, 'jpeg')
            b = True
            picname = filename
        else:
            picname = oldpicname
        ob = Goods.objects.get(id=gid)
        ob.goods = request.POST['goods']
        ob.typeid = request.POST['typeid']
        ob.company = request.POST['company']
        ob.price = request.POST['price']
        ob.store = request.POST['store']
        ob.descr = request.POST['descr']
        ob.picname = picname
        ob.state = request.POST['state']
        ob.save()
        context = {'info':'修改成功！'}
        if b:
            os.remove("./static/goods/m_"+oldpicname) #执行老图片删除  
            os.remove("./static/goods/s_"+oldpicname) #执行老图片删除  
            os.remove("./static/goods/"+oldpicname) #执行老图片删除  
    except:
        context = {'info':'修改失败！'}
        if b:
            os.remove("./static/goods/m_"+picname) #执行新图片删除  
            os.remove("./static/goods/s_"+picname) #执行新图片删除  
            os.remove("./static/goods/"+picname) #执行新图片删除  
    return render(request,"myadmin/info.html",context)




