from batou.component import Component, Attribute
from batou.lib.buildout import Buildout
from batou.lib.file import File
from batou.lib.supervisor import Program
from batou.utils import Address
from batou.lib import git


class Plone(Component):

    listen = Attribute(Address, '{{component.host.fqdn}}:8080')

    def configure(self):
        self.provide('plone:address', self.listen)

        self += File(
            '~/.ssh/config',
            content="""\
Host bitbucket.org
    UserKnownHOstsFile /dev/null
    StrictHostKeyChecking no
Host github.com
    UserKnownHOstsFile /dev/null
    StrictHostKeyChecking no

""")

        self += git.Clone(
            'https://github.com/ploneintranet/ploneintranet.git',
            target='ploneintranet',
            revision='099c7e80a16e0250b81b95646ba3e24c932d9b29')

        self += Buildout(
            python='2.7',
            version='2.3.1',
            setuptools='17.1.1')

        self += Program(
            'plone',
            command='bin/instance',
            args='console')
