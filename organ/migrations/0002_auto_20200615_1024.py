# Generated by Django 3.0.7 on 2020-06-15 10:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('organ', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='organization',
            name='certificate',
            field=models.FileField(blank=True, null=True, upload_to='organ', verbose_name='organization code certificate'),
        ),
        migrations.AlterField(
            model_name='organization',
            name='license',
            field=models.FileField(blank=True, null=True, upload_to='organ', verbose_name='business license'),
        ),
        migrations.AlterField(
            model_name='position',
            name='document',
            field=models.FileField(blank=True, null=True, upload_to='', verbose_name='reference'),
        ),
        migrations.AlterField(
            model_name='position',
            name='grade',
            field=models.CharField(choices=[], default='01', max_length=2, verbose_name='position grade'),
        ),
        migrations.AlterField(
            model_name='position',
            name='series',
            field=models.CharField(choices=[], default='A', max_length=1, verbose_name='position series'),
        ),
    ]
