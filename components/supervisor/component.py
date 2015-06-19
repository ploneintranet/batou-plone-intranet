from batou.lib.supervisor import Supervisor
from batou.lib.logrotate import Logrotate
from batou.lib.nagios import NRPEHost


class Supervisor(Supervisor):

    # Work around a slight annoyance in batou 1.0b12.
    pidfile = 'supervisor.pid'
