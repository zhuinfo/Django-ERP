# Django-ERP
Django-ERP是一款基于Django开发的ERP管理软件，包含常用的销售管理、采购管理、库存管理、组织管理等，支持按项目归集费用，支持工作流审批，支持采购单、报价单的批量导入。

Forked from <a href="https://github.com/zhuinfo/Django-ERP">zhuinfo Django-ERP</a> 感谢他的付出。

# 安装指南
请先确保您已安装了Python 2.7,并已配置好了数据库，本文档会略过这部分内容（理论上Django是可以支持MYSql、PGSQL、SQLite、Oracle等主流数据库的，但是建议不要嘬，用自己熟悉的数据库，因为数据是无价的。）
验证方法请通过python --version查看版本，以及数据库 确认用户名和密码是否登录正常

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
>
