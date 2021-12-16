# Generated by Django 3.0.7 on 2020-06-15 10:24

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('contenttypes', '0002_remove_content_type_name'),
        ('workflow', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='instance',
            name='object_id',
            field=models.PositiveIntegerField(verbose_name='object id'),
        ),
        migrations.AlterField(
            model_name='modal',
            name='content_type',
            field=models.ForeignKey(limit_choices_to={'app_label__in': ['basedata', 'organ']}, on_delete=django.db.models.deletion.CASCADE, to='contenttypes.ContentType', verbose_name='content type'),
        ),
    ]
