# coding=utf-8

import os
import re

from distutils.core import setup
from distutils.command.build import build
from distutils.extension import Extension
from Cython.Build import cythonize


def parse_version_from_changelog():
    try:
        deb_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'debian/changelog')
        with open(deb_path, 'r') as changelog:
            regmatch = re.match(r'hhmarisa \((.*)\).*', changelog.readline())
            return regmatch.groups()[0]
    except (IOError, AttributeError):
        return 'unknown_version'


version = parse_version_from_changelog()

setup(
    name='hhmarisa',
    version=version,
    description='Simple marisa reader',
    packages=['hhmarisa'],
    ext_modules = cythonize([Extension("hhmarisa", ["hhmarisa/hhmarisa.pyx"], libraries=["marisa"])]),
)

