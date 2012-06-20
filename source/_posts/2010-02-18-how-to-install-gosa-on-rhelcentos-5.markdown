---
date: '2010-02-18 12:30:43'
layout: post
slug: how-to-install-gosa-on-rhelcentos-5
status: publish
comments: true
title: How to install GOsa on RHEL or CentOS 5
wordpress_id: '210'
categories:
- linux
tags:
- CentOS
- RHEL5
- Tutorial
---

{% img left /images/2010/02/gosa-logo2.png GOsa logo %} As you can read on [GOsa website](https://oss.gonicus.de/labs/gosa/): "GOsa² provides a powerful GPL'ed framework for managing accounts and systems in LDAP databases. Using GOsa² allows system administrators to easily manage users and groups...". The installation on Red Hat Enterprise Linux/CentOS is a bit tricky and here you will find how to install it.

First you need to set SELinux in permissive mode (if you have enabled it) and configure the firewall to let other systems to connect to port 80/443 (HTTP and HTTPs) and 389 (LDAP server port) using the commandline tool

{% codeblock Setting firewall lang:sh %}
$ system-config-securitylevel-tui
{% endcodeblock %}

{% img /images/2010/02/opaplnx44_security_1.png %}

{% img /images/2010/02/opaplnx44_security_2.png %}

Now we need to get some more RPM repos to work:


{% codeblock Adding more rpms repos lang:sh %}
//First the CentOS testing repo
$ cd /etc/yum.repos.d/
$ wget http://dev.centos.org/centos/5/CentOS-Testing.repo
//Then the RPMForge repo
$ rpm -Uhv \
  http://apt.sw.be/redhat/el5/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
//And last the GOsa RPM repo
$ cat >> GOsa.repo << EOF
[GOsa-Repository]
name=GOsa Repository
baseurl=ftp://oss.gonicus.de/pub/gosa/redhat
enabled=0
gpgcheck=0
EOF
{% endcodeblock %}

As we want the system as stable as possible without many packages from externarl repositories please verify that the files CentOS-Testing.repo and rpmforge.repo both contain the line '**enabled=0**'. Now let's check the new repositories for new packages to install and install them:

{% codeblock Installing packages lang:sh %}
$ yum --enablerepo=rpmforge,GOsa-Repository,c5-testing check-update
//Install LDAP
$ yum install openldap openldap-servers
//Install PHP 5.2 from CentOS Testing
$ yum --enablerepo=c5-testing install php-common php-imap \
  php-snmp php-mysql php-mbstring php-pdo
//Install perl-Crypt-SmbHash from RPMForge
$ yum --enablerepo=rpmforge install perl-Crypt-SmbHash
//Install GOsa RPMs
$ yum --enablerepo=GOsa-Repository install gosa-help-en.noarch \
  gosa-plugin-addressbook.noarch gosa-plugin-ldapmanager.noarch \
  gosa-plugin-mail.noarch gosa-plugin-rolemanagement.noarch \
  gosa-plugin-systems.noarch gosa-schema.noarch gosa-plugin-goto
{% endcodeblock %}

Now we need to be sure that Apache HTTPD and LDAP servers start at boot:


{% codeblock Starting services lang:sh %}
$ chkconfig httpd on
$ chkconfig ldap on
$ service httpd start
$ service ldap start
{% endcodeblock %}


At this point, before configuring GOsa, you need to add specific GOsa schemas to your ldap using as reference a part of the beginning of my own /etc/openldap/slapd.conf


{% codeblock LDAP configuration %}
include /etc/openldap/schema/core.schema
include /etc/openldap/schema/cosine.schema
include /etc/openldap/schema/inetorgperson.schema
include /etc/openldap/schema/gosa/rfc2307bis.schema
include /etc/openldap/schema/gosa/gofax.schema
include /etc/openldap/schema/gosa/gofon.schema
include /etc/openldap/schema/gosa/samba.schema
include /etc/openldap/schema/gosa/gosystem.schema
include /etc/openldap/schema/gosa/goto.schema
include /etc/openldap/schema/gosa/samba3.schema
include /etc/openldap/schema/gosa/gosa-samba3.schema
include /etc/openldap/schema/gosa/goserver.schema
include /etc/openldap/schema/gosa/goto-mime.schema
include /etc/openldap/schema/gosa/trust.schema
{% endcodeblock %}

Restart your openldap and finally we can connect to GOsa web interface and configure it pointing your browser at:

{% codeblock %}
http://<hostname>/gosa/
{% endcodeblock %}


Now you should have a fully functional GOsa install on your CentOS5: please let me know if you found error in this tutorial or even if you found it useful.
