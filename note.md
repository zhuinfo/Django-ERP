# 笔记

本分支由Python2 Django1迁移过来

## 快速开始

    pipenv install --pypi-mirror https://mirrors.aliyun.com/pypi/simple/
    pipenv shell
    # python manage.py makemigrations sale purchase invent hr selfhelp workflow organ basedata syscfg
    python manage.py migrate

    # 使用mysql的话，在这里执行 `install/SQL/mis.sql` 语句
    > mysql -u root -p root mis < Install/SQL/mis.sql

    # 创建管理员或者修改管理员密码
    # python manage.py changepassword admin
    python manage.py createsuperuser

    python manage.py runserver


## Ubuntu下部署

如果安装 mysqlclient 时报错，需要先安装下面扩展包

    sudo apt-get install -y build-essential libssl-dev libffi-dev libxml2 libxml2-dev libxslt1-dev zlib1g-dev
    sudo apt-get install -y libmysqlclient-dev python3-dev
