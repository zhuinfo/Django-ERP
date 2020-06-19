# Django-ERP笔记

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

## 导出 basedata.ValueListItem

    python manage.py dumpdata --format json basedata.ValueList basedata.ValueListItem > value_list.json

导入

    python manage.py loaddata value_list.json

## 主要模块说明

- 个人自助
    - 工单服务
    - 费用报销
    - 借款申请
    - 活动
- 销售管理
    - 报价单
    - 销售订单
    - 销售回款
- 采购管理
    - 采购单
        - 需要选择合作伙伴（供应商）
    - 采购明细
        - 关联采购单
    - 采购付款
        - 需要关联采购单
    - 发票
- 库存管理
    - 实时库存
    - 领料单
    - 入库单
        - 需要选择仓库
        - 入库单可以关联采购单
    - 库存调整
    - 返库单
        - 物料出库后需要返库，可以创建返库单
    - 期初库存
        - 可以从文件中导入初始数据
- 组织机构
    - 组织机构
    - 组织单元
        - 关联组织机构，给组织机构进行分级
    - 岗位
- 基础数据
    - 项目
    - 职员
    - 合作伙伴
    - 物料
    - 计量单位
        - 用于标识物料的单位
    - 仓库
    - 技术参数
    - 文档
    - 值列表
    - 费用科目
    - 导入
    - 分类
    - 品牌
    - 经济行业
- 系统配置
    - 站点
    - 模块
    - 菜单
    - 角色
- 工作流
    - 工作流模型
    - 工作流节点
    - 工作流实例
    - 待办任务
    - 审批记录
- 认证授权（Django自带）
- 内容类型（Django自带）


## 优化

【基础数据】应用中，可以把【文档】、【值列表】、【导入】模块抽出来放在【系统配置】应用中。
