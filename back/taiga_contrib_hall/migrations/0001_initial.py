# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('projects', '0015_auto_20141230_1212'),
    ]

    operations = [
        migrations.CreateModel(
            name='HallHook',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, verbose_name='ID', serialize=False)),
                ('url', models.URLField(verbose_name='URL')),
                ('project', models.ForeignKey(to='projects.Project', related_name='hallhooks')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
    ]
