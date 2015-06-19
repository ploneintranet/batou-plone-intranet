{ config, lib, pkgs, ... }: with config;

{

    flyingcircus.roles.nginx.enable = true;

    # Those packages are only installed as binaries (and includes and libs)
    # to support building software that links to them. They do not indicate
    # that the typical services (e.g. server processes) are installed.
    environment.systemPackages = [
        pkgs.mercurial
        pkgs.openldap
        pkgs.cyrus_sasl
        pkgs.openssl
        pkgs.postgresql
        pkgs.mysql
        pkgs.zlib
        pkgs.libxml2
        pkgs.enchant
        pkgs.libxslt
        pkgs.db
    ];

    # Make an impure environment to support old-style deployments with
    # traditional tools like pip, buildout, etc.
    environment.pathsToLink = [ "/include" ];
 
    environment.shellInit = ''
    # help pip to find libz.so when building lxml
    export LIBRARY_PATH=/var/run/current-system/sw/lib
    # ditto for header files, e.g. sqlite
    export C_INCLUDE_PATH=/var/run/current-system/sw/include:/var/run/current-system/sw/include/sasl
   '';

}
