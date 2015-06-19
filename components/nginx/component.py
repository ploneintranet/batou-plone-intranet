from batou.component import Component, platform, Attribute
from batou.lib.file import File
from batou.utils import Address


class Nginx(Component):
    """Configures the nginx frontend.
    """

    frontend_address = Attribute(Address, '{{component.host.fqdn}}:80')

    def configure(self):
        self.plone_backend = self.require_one('plone:address')

        self += File(
            '/etc/nginx/local/plone.conf',
            source='plone.conf')


@platform('vagrant', Nginx)
class SystemNginx(Component):

    def verify(self):
        self.parent.assert_no_subcomponent_changes()

    def update(self):
        self.cmd('sudo nixos-rebuild switch')
