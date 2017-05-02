# Django-ERP
Django-ERP是一款基于Django开发的ERP管理软件，包含常用的销售管理、采购管理、库存管理、组织管理等，支持按项目归集费用，支持工作流审批，支持采购单、报价单的批量导入。

Forked from <a href="https://github.com/zhuinfo/Django-ERP">zhuinfo Django-ERP</a> 感谢他的付出。

# 安装指南

> 我的开发、测试环境是Python2.7的，所以这个文档大多数情况我默认会使用这个条件，有个别测试不到位的可能还需要慢慢完善。

请先确保您已安装了Python 2.7,并已配置好了数据库，本文档会略过这部分内容（理论上Django是可以支持MYSql、PGSQL、SQLite、Oracle等主流数据库的，但是建议不要嘬，用自己熟悉的数据库，因为数据是无价的。）
验证方法请通过python --version查看版本，以及数据库 确认用户名和密码是否登录正常

后续我争取不上requirements.txt，远期目标我个人是希望能做个dock镜像，并让它能慢慢顺着Python3和新版本的django平滑过渡上去。

## 数据库配置

数据库配置项在mis/settings.py文件中
在88-96行为Mysql数据库配置

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',#MYSQL类型数据库，Python会依赖MySQL的驱动器
        'HOST': 'localhost',#数据库主机地址
        'NAME': 'mis',#数据库名称
        'USER': 'root',#数据库用户名（建议不要加入root敢死队）
        'PASSWORD': 'root',#数据库密码
    }
}
```


## 克隆代码
> git clone https://github.com/bg4hkq/Django-ERP.git


## 导入数据库
> mysql -uroot -proot mis < Install/mis.sql

## 运行测试服务器
> python manage.py runserver

## 修改管理员账户密码
```
C:\Django-ERP>python manage.py changepassword admin

You have 3 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth.
Run 'python manage.py migrate' to apply them.
Changing password for user 'admin'
Password:
Password (again):
Password changed successfully for user 'admin'

C:\Django-ERP>
```

# 排错

## MYSQL驱动错误
```
django.core.exceptions.ImproperlyConfigured: Error loading MySQLdb module: No module named MySQLdb
```

出现No module named MySQLdb是django找不到MySQL驱动导致的问题，所以需要先安装一个数据库驱动。

