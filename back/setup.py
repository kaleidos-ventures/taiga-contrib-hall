#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from setuptools import setup, find_packages

setup(
    name = 'taiga-contrib-hall',
    version = ":versiontools:taiga_contrib_hall:",
    description = "The Taiga plugin for hall integration",
    long_description = "",
    keywords = 'taiga, hall, integration',
    author = 'Jesús Espino García',
    author_email = 'jesus.espino@kaleidos.net',
    url = 'https://github.com/taigaio/taiga-contrib-hall',
    license = 'AGPL',
    include_package_data = True,
    packages = find_packages(),
    install_requires=[
        'django == 1.7.8',
    ],
    setup_requires = [
        'versiontools >= 1.8',
    ],
    classifiers = [
        "Programming Language :: Python",
        'Development Status :: 4 - Beta',
        'Framework :: Django',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU Affero General Public License v3',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Topic :: Internet :: WWW/HTTP',
    ]
)
