# 笔记

本分支由Python2 Django1迁移过来

## 快速开始

    pipenv install
    pipenv shell
    # python manage.py makemigrations sale purchase invent hr selfhelp workflow organ basedata syscfg
    python manage.py migrate

    # 使用mysql的话，在这里执行 `install/SQL/mis.sql` 语句

    # 创建管理员或者修改管理员密码
    # python manage.py changepassword admin
    python manage.py createsuperuser

    python manage.py runserver

