---
date: '2009-08-11 15:10:09'
layout: post
slug: how-to-clone-a-schema-in-mysql
status: publish
comments: true
title: How to clone a schema in MySQL
wordpress_id: '192'
categories:
- linux
tags:
- RHEL5
- Tutorial
---

{% img left /images/2008/10/logo_mysql_sun.gif MySQL logo %} Today I needed to clone a schema in MySQL: simply I upgraded my monitoring software [Zabbix](http://www.zabbix.com/) and thus I needed to "upgrade" also the DB schema where Zabbix saves data. As this is a destructive operation I wanted to have the zabbix schema cloned. But how do you clone a schema in MySQL?

The first thing to do is to create the new schema (or database in MySQL world) and grant all privileges to a user (even an existing one):

{% codeblock Creating a new schema lang:sql %}
create database zabbix16;
grant all privileges on zabbix16.* to zabbix@"%";
{% endcodeblock %}

At this point we can use the mysqldump program to dump data directly in the mysql program:

{% codeblock lang:sh %}
$ mysqldump --add-drop-table --complete-insert \
  -uzabbix -pPWD zabbix | mysql -uzabbix -pPWD zabbix16
{% endcodeblock %}

After some time, when mysqldump finishes, you will see the zabbix16 schema as an exact copy of the original one!
