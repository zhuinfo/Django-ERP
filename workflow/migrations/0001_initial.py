# -*- coding: utf-8 -*-
# Generated by Django 1.11.29 on 2020-06-13 20:58
from __future__ import unicode_literals

import datetime
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('contenttypes', '0002_remove_content_type_name'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('organ', '0001_initial'),
        ('syscfg', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='History',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('pro_time', models.DateTimeField(auto_now_add=True, verbose_name='process time')),
                ('pro_type', models.IntegerField(choices=[(0, 'SUBMIT'), (1, 'AGREE'), (3, 'DENY'), (4, 'TERMINATE')], default=0, verbose_name='process type')),
                ('memo', models.CharField(blank=True, max_length=40, null=True, verbose_name='memo')),
            ],
            options={
                'ordering': ['inst', 'pro_time'],
                'verbose_name': 'workflow history',
                'verbose_name_plural': 'workflow history',
            },
        ),
        migrations.CreateModel(
            name='Instance',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(blank=True, max_length=10, null=True, verbose_name='code')),
                ('object_id', models.PositiveIntegerField(verbose_name=b'object id')),
                ('start_time', models.DateTimeField(auto_now_add=True, verbose_name='start time')),
                ('approved_time', models.DateTimeField(blank=True, null=True, verbose_name='approved time')),
                ('status', models.IntegerField(choices=[(1, 'NEW'), (2, 'IN PROGRESS'), (3, 'DENY'), (4, 'TERMINATED'), (9, 'APPROVED'), (99, 'COMPLETED')], default=1, verbose_name='status')),
            ],
            options={
                'verbose_name': 'workflow instance',
                'verbose_name_plural': 'workflow instance',
            },
        ),
        migrations.CreateModel(
            name='Modal',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(blank=True, max_length=6, null=True, verbose_name='workflow code')),
                ('name', models.CharField(max_length=40, verbose_name='workflow name')),
                ('description', models.TextField(blank=True, null=True, verbose_name='description')),
                ('app_name', models.CharField(blank=True, max_length=60, null=True, verbose_name='app name')),
                ('model_name', models.CharField(blank=True, max_length=60, null=True, verbose_name='model name')),
                ('begin', models.DateField(blank=True, default=datetime.date.today, null=True, verbose_name='begin date')),
                ('end', models.DateField(blank=True, default=datetime.date(9999, 12, 31), null=True, verbose_name='end date')),
                ('content_type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='contenttypes.ContentType', verbose_name='content type')),
            ],
            options={
                'verbose_name': 'workflow model',
                'verbose_name_plural': 'workflow model',
            },
        ),
        migrations.CreateModel(
            name='Node',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(blank=True, max_length=4, null=True, verbose_name='node code')),
                ('name', models.CharField(max_length=80, verbose_name='node name')),
                ('tooltip', models.CharField(blank=True, max_length=120, null=True, verbose_name='tooltip words')),
                ('start', models.BooleanField(default=False, verbose_name='start node')),
                ('stop', models.BooleanField(default=False, verbose_name='stop node')),
                ('can_terminate', models.BooleanField(default=False, verbose_name='can terminate')),
                ('can_deny', models.BooleanField(default=True, verbose_name='can deny')),
                ('can_edit', models.BooleanField(default=False, verbose_name='can edit')),
                ('email_notice', models.BooleanField(default=True, verbose_name='email notice')),
                ('short_message_notice', models.BooleanField(default=False, verbose_name='short message notice')),
                ('approve_node', models.BooleanField(default=False, verbose_name='approve node')),
                ('handler', models.TextField(blank=True, help_text='\u81ea\u5b9a\u4e49SQL\u8bed\u53e5\uff0c\u4f18\u5148\u9ad8\u4e8e\u6307\u5b9a\u7528\u6237\u3001\u5c97\u4f4d\u3001\u89d2\u8272', null=True, verbose_name='handler')),
                ('handler_type', models.IntegerField(choices=[(1, 'designated user'), (2, 'designated position'), (3, 'designated role'), (4, 'submitter')], default=1, verbose_name='handler type')),
                ('next_user_handler', models.CharField(blank=True, max_length=40, null=True, verbose_name='next user handler')),
                ('next_node_handler', models.CharField(blank=True, max_length=40, null=True, verbose_name='next node handler')),
                ('status_field', models.CharField(blank=True, max_length=40, null=True, verbose_name='status field')),
                ('status_value', models.CharField(blank=True, max_length=40, null=True, verbose_name='status value')),
                ('action', models.CharField(blank=True, max_length=40, null=True, verbose_name='execute action')),
                ('departments', models.ManyToManyField(blank=True, to='organ.OrgUnit', verbose_name='designated department')),
                ('modal', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='workflow.Modal', verbose_name='workflow model')),
                ('next', models.ManyToManyField(blank=True, to='workflow.Node', verbose_name='next node')),
                ('positions', models.ManyToManyField(blank=True, to='organ.Position', verbose_name='designated position')),
                ('roles', models.ManyToManyField(blank=True, to='syscfg.Role', verbose_name='designated role')),
                ('users', models.ManyToManyField(blank=True, to=settings.AUTH_USER_MODEL, verbose_name='designated user')),
            ],
            options={
                'verbose_name': 'workflow node',
                'verbose_name_plural': 'workflow node',
            },
        ),
        migrations.CreateModel(
            name='TodoList',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(blank=True, max_length=10, null=True, verbose_name='code')),
                ('app_name', models.CharField(blank=True, max_length=60, null=True, verbose_name='app name')),
                ('model_name', models.CharField(blank=True, max_length=60, null=True, verbose_name='model name')),
                ('arrived_time', models.DateTimeField(auto_now_add=True, verbose_name='arrived time')),
                ('is_read', models.BooleanField(default=False, verbose_name='is read')),
                ('read_time', models.DateTimeField(blank=True, null=True, verbose_name='read time')),
                ('status', models.BooleanField(default=False, verbose_name='is done')),
                ('inst', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='workflow.Instance', verbose_name='workflow instance')),
                ('node', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='workflow.Node', verbose_name='current node')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL, verbose_name='handler')),
            ],
            options={
                'ordering': ['user', '-arrived_time'],
                'verbose_name': 'workflow todo',
                'verbose_name_plural': 'workflow todo',
            },
        ),
        migrations.AddField(
            model_name='instance',
            name='current_nodes',
            field=models.ManyToManyField(blank=True, to='workflow.Node', verbose_name='current node'),
        ),
        migrations.AddField(
            model_name='instance',
            name='modal',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='workflow.Modal', verbose_name='workflow model'),
        ),
        migrations.AddField(
            model_name='instance',
            name='starter',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='starter', to=settings.AUTH_USER_MODEL, verbose_name='start user'),
        ),
        migrations.AddField(
            model_name='history',
            name='inst',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='workflow.Instance', verbose_name='workflow instance'),
        ),
        migrations.AddField(
            model_name='history',
            name='node',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='workflow.Node', verbose_name='workflow node'),
        ),
        migrations.AddField(
            model_name='history',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL, verbose_name='submitter'),
        ),
    ]