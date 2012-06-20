---
date: '2008-10-03 14:29:15'
layout: post
slug: how-to-install-a-mysql-cluster
status: publish
comments: true
title: 'How to install a MySQL cluster on a single UNIX/Linux server '
wordpress_id: '99'
categories:
- linux
tags:
- Tutorial
- CentOS
---

{% img left /images/2008/10/logo_mysql_sun.gif MySQL logo %}In this tutorial I will show you how to install a MySQL cluster on a single node: obviously you will not gain any hardware redundancy with this setup but it is useful if you need to create a test installation as it was for me. You can find many tutorials about this topic but they are quite old and MySQL Cluster changed a lot in last years.

**What is a MySQL cluster?**

Let's start explaining the architecture of a MySQL cluster with an image taken from [dev.mysql.com](http://dev.mysql.com/doc/refman/5.1/en/mysql-cluster-overview.html):


[![MySQL cluster architecture](/images/2008/10/cluster-components-1.png)](/images/2008/10/cluster-components-1.png)



As you may see the MySQL cluster is an aggregation of many components:
* one management server;
* many MySQL daemons that acts as "frontend";
* many data nodes that store the real data.

This tutorial will guide you in the creation of a cluster with:
* one management node;
* two MySQL daemons;
* two data nodes.

Obviously you can expand this configuration simply adding the components you need. As stated at the beginning of this tutorial you can create all this setup on a single server (well you need 3 IPs on the server) or, and that would be very easy, you can split the MySQL cluster components on many servers.

**What do I need?**

For this setup you need:
* the archive of MySQL cluster 6.2 (6.2.15 was used in this tutorial) compiled for your system/architecture you can download from [dev.mysql.com](http://dev.mysql.com/downloads/cluster/6.2.html) (please note that this tutorial was created for a Solaris10/SPARC installation so your archive name could be different from mine);
* an unprivileged user;
* 3 IPs on the same server;
* at least 2GB of free disk space;
* quite some time to follow this tutorial ;)


**Definitions**

As it is a complex installation I define the following variables in the BASH shell:


{% codeblock lang:sh %}
export MYSQL_HOME=[PUT HERE THE BASE DIRECTORY FOR THE INSTALLATION]
export MGMT_HOME=$MYSQL_HOME/[PUT HERE THE DIRECTORY NAME FOR THE MGMT NODE]
export NODE1_HOME=$MYSQL_HOME/[PUT HERE THE DIRECTORY NAME FOR THE FIRST NODE]
export NODE2_HOME=$MYSQL_HOME/[PUT HERE THE DIRECTORY NAME FOR THE SECOND NODE]

export MGMT_BIN=$MGMT_HOME/bin
export NODE1_BIN=$NODE1_HOME/bin
export NODE2_BIN=$NODE2_HOME/bin

export MGMT_VAR=$MGMT_HOME/var
export NODE1_VAR=$NODE1_HOME/var
export NODE2_VAR=$NODE2_HOME/var

export MGMT_DATADIR=$MGMT_VAR/lib/mysql-cluster
export NODE1_DATADIR=$NODE1_VAR/lib/mysql-cluster
export NODE2_DATADIR=$NODE2_VAR/lib/mysql-cluster
export NODE1_NDBD_DATADIR=$NODE1_VAR/lib/mysql-cluster1
export NODE2_NDBD_DATADIR=$NODE2_VAR/lib/mysql-cluster1

export MGMT_ETC=$MGMT_HOME/etc
export NODE1_ETC=$NODE1_HOME/etc
export NODE2_ETC=$NODE2_HOME/etc
{% endcodeblock %}

**Installing MySQL in proper directories**

Let's start to create the needed directories and install MySQL from the downloaded archive:


{% codeblock First we need to create the main directories lang:sh %}
$ mkdir -p $MGMT_HOME
$ mkdir -p $MGMT_NODE1
$ mkdir -p $MGMT_NODE2
{% endcodeblock %}

{% codeblock Now we extract the content of downloaded archive into main directories lang:sh %}
$ gzcat mysql-cluster-gpl-6.2.15-[YOUR_ARCHITECTURE_HERE].tar.gz | tar -xf -
$ mv mysql-cluster-gpl-6.2.15-[YOUR_ARCHITECTURE_HERE] $MGMT_HOME
$ gzcat mysql-cluster-gpl-6.2.15-[YOUR_ARCHITECTURE_HERE].tar.gz | tar -xf -
$ mv mysql-cluster-gpl-6.2.15-[YOUR_ARCHITECTURE_HERE] $NODE1_HOME
$ gzcat mysql-cluster-gpl-6.2.15-[YOUR_ARCHITECTURE_HERE].tar.gz | tar -xf -
$ mv mysql-cluster-gpl-6.2.15-[YOUR_ARCHITECTURE_HERE] $NODE2_HOME
{% endcodeblock %}


{% codeblock And now some other useful directories lang:sh %}
$ mkdir -p $NODE1_DATADIR
$ mkdir -p $NODE1_NDBD_DATADIR
$ mkdir -p $NODE1_VAR/log
$ mkdir -p $NODE1_VAR/run
$ mkdir -p $NODE2_DATADIR
$ mkdir -p $NODE2_NDBD_DATADIR
$ mkdir -p $NODE2_VAR/log
$ mkdir -p $NODE2_VAR/run
{% endcodeblock %}

**Configuration files**

In this section we are going to create the configuration files for the three main components of the architecture: the management server and two MySQLd server (the first one is a master server).


{% codeblock This is the configuration of the mgmt node %}
#Put this content in a file called **$MGMT_ETC/config.ini**
[NDB_MGMD]
Id=1
Hostname=[PUT HERE THE IPADDRESS OF MGMT NODE]
PortNumber=1186
Datadir=[PUT HERE THE VALUE OF MGMT_DATADIR]
[NDBD]
Id=2
Hostname=[PUT HERE THE IPADDRESS OF NODE1]
Datadir=[PUT HERE THE VALUE OF NODE1_DATADIR]
[NDBD]
Id=3
Hostname=[PUT HERE THE IPADDRESS OF NODE2]
Datadir=[PUT HERE THE VALUE OF NODE2_DATADIR]
[MYSQLD]
[MYSQLD]
{% endcodeblock %}



{% codeblock This is the configuration of node1 %}
#Put this content in a file called **my.cnf.master** in **$NODE1_ETC**
[MYSQLD]
user=mysql #the user running MySQL
basedir=[PUT HERE THE VALUE OF NODE1_HOME]
datadir=[PUT HERE THE VALUE OF NODE1_DATADIR]
pid-file = [PUT HERE THE VALUE OF NODE1_VAR]/run/mysqld.pid
socket = [PUT HERE THE VALUE OF NODE1_VAR]/run/mysqld.sock
log-error = [PUT HERE THE VALUE OF NODE1_VAR]/log/mysqld.err
bind-address = [PUT HERE THE IPADDRESS OF NODE 1]
ndb-cluster-connection-pool=1
ndbcluster
ndb-connectstring="[PUT HERE THE IPADDRESS OF MGMT NODE]"
ndb-force-send=1
ndb-use-exact-count=0
ndb-extra-logging=1
ndb-autoincrement-prefetch-sz=256
engine-condition-pushdown=1
#REPLICATION SPECIFIC - GENERAL
#server-id must be unique across all mysql servers participating in replication.
server-id=4
#REPLICATION SPECIFIC - MASTER
log-bin
{% endcodeblock %}

{% codeblock This is the configuration of node2 %}
**#Put this content in a file called **my.cnf** in **$NODE2_ETC
**[MYSQLD]
user=mysql #the user running MySQL
basedir=[PUT HERE THE VALUE OF NODE2_HOME]
datadir=[PUT HERE THE VALUE OF NODE2_DATADIR]
pid-file = [PUT HERE THE VALUE OF NODE2_VAR]/run/mysqld.pid
socket = [PUT HERE THE VALUE OF NODE2_VAR]/run/mysqld.sock
log-error = [PUT HERE THE VALUE OF NODE2_VAR]/log/mysqld.err
bind-address = [PUT HERE THE IPADDRESS OF NODE 2]
ndb-cluster-connection-pool=1
ndbcluster
ndb-connectstring="[PUT HERE THE IPADDRESS OF MGMT NODE]"
ndb-force-send=1
ndb-use-exact-count=0
ndb-extra-logging=1
ndb-autoincrement-prefetch-sz=256
engine-condition-pushdown=1
#server-id must be unique across all mysql servers participating in replication.
server-id=5
{% endcodeblock %}

**MySQLd servers initialization**

The two MySQLd servers need to have their DB initialized (they need to know at least who users are and who can connect from). For this purpose we use the install_db script:

{% codeblock Initialize DBs lang:sh %}
$ $NODE1_HOME/scripts/mysql_install_db --force --datadir=$NODE1_DATADIR --basedir=$NODE1_HOME
$ $NODE2_HOME/scripts/mysql_install_db --force --datadir=$NODE2_DATADIR --basedir=$NODE2_HOME
{% endcodeblock %}

**Starting nodes**

It is now the time to start the management node:

{% codeblock lang:sh %}
$ $MGMT_BIN/ndb_mgmd -f $MGMT_ETC/config.ini #The mgmt should start
$ less $MGMT_VAR/lib/mysql-cluster/ndb_1_cluster.log #Check the log for errors
{% endcodeblock %}

Now we need to start the data nodes:


{% codeblock lang:sh %}
$ cd $NODE1_NDBD_DATADIR
$ $NODE1_BIN/ndbd --initial -c [MGMT_IP_ADDRESS] --bind-address=[FIRST_NODE_IP_ADDRESS]
$ cd $NODE2_NDBD_DATADIR
$ $NODE2_BIN/ndbd --initial -c [MGMT_IP_ADDRESS] --bind-address=[SECOND_NODE_IP_ADDRESS]
{% endcodeblock %}

Please note the --initial parameter used as argument to the ndbd command: this is needed only for the very first run... **omit it next time**!

Now the first check: we ask the MGMT console the cluster status:

{% codeblock lang:sh %}
$ $MGMT_BIN/ndb_mgm -c [MGMT_IP_ADDRESS] -e show
Connected to Management Server at: 10.145.2.3:1186
Cluster Configuration
---------------------
[ndbd(NDB)]     2 node(s)
id=2    @10.145.2.33  (mysql-5.1.23 ndb-6.2.15, Nodegroup: 0, Master)
id=3    @10.145.2.34  (mysql-5.1.23 ndb-6.2.15, Nodegroup: 0)
[ndb_mgmd(MGM)] 1 node(s)
id=1    @10.145.2.3  (mysql-5.1.23 ndb-6.2.15)
[mysqld(API)]   2 node(s)
id=4 (not connected, accepting connect from any host)
id=5 (not connected, accepting connect from any host)
{% endcodeblock %}

You should see something similar with your IPs: note that we actually see the two datanodes just started and the mgmt node.
At the end we need to start the two MySQLd that acts as frontend:

{% codeblock lang:sh %}
$ $NODE1_BIN/mysqld --defaults-file=$NODE1_/my.cnf.master &
$ $NODE2_BIN/mysqld --defaults-file=$NODE2_ETC/my.cnf &
{% endcodeblock %}

and executing the query of the mgmt cluster console we should now see all nodes:


{% codeblock lang:sh %}
$ $MGMT_BIN/ndb_mgm -c [MGMT_IP_ADDRESS] -e show
Connected to Management Server at: 10.145.2.3:1186
Cluster Configuration
---------------------
[ndbd(NDB)]     2 node(s)
id=2    @10.145.2.33  (mysql-5.1.23 ndb-6.2.15, Nodegroup: 0, Master)
id=3    @10.145.2.34  (mysql-5.1.23 ndb-6.2.15, Nodegroup: 0)
[ndb_mgmd(MGM)] 1 node(s)
id=1    @10.145.2.3  (mysql-5.1.23 ndb-6.2.15)
[mysqld(API)]   2 node(s)
id=4    @10.145.2.3  (mysql-5.1.23 ndb-6.2.15)
id=5    @10.145.2.3  (mysql-5.1.23 ndb-6.2.15)
{% endcodeblock %}

If you see something different then probably you have a problem: please look at log files that you can find in `$NODE1_VAR/log` or `$NODE2_VAR/log`. If you provide as much information as possible I'll try to help you out.

**Trying the toy**

Now, if the management console says everything is OK, we need to test our shiny new MySQL cluster:


{% codeblock lang:sh %}
$ $NODE1_BIN/mysql -u root -h [FIRST_NODE_IP_ADDRESS] test
mysql> show engines; #check you can see ndbcluster!!!
mysql> CREATE TABLE animals (grp ENUM('fish','mammal','bird') NOT NULL,  id MEDIUMINT NOT NULL AUTO_INCREMENT,  name CHAR(30) NOT NULL,  PRIMARY KEY (grp,id) ) engine=ndbcluster;
mysql> INSERT INTO animals (grp,name) VALUES  ('mammal','dog'),('mammal','cat'),  ('bird','penguin'),('fish','lax'), ('mammal','whale'), ('bird','ostrich');
mysql> select * from animals;
+--------+----+---------+
| grp    | id | name    |
+--------+----+---------+
| mammal |  2 | cat     |
| bird   |  6 | ostrich |
| fish   |  4 | lax     |
| bird   |  3 | penguin |
| mammal |  1 | dog     |
| mammal |  5 | whale   |
+--------+----+---------+
6 rows in set (0.00 sec)
{% endcodeblock %}

and now check the second MySQLd node:


{% codeblock lang:sh %}
# $NODE2_BIN/mysql -u root -h [SECOND_NODE_IP_ADDRESS] test
mysql> show engines; #check you can see ndbcluster!!!
mysql> select * from animals;
+--------+----+---------+
| grp    | id | name    |
+--------+----+---------+
| mammal |  2 | cat     |
| bird   |  6 | ostrich |
| fish   |  4 | lax     |
| bird   |  3 | penguin |
| mammal |  1 | dog     |
| mammal |  5 | whale   |
+--------+----+---------+
6 rows in set (0.00 sec)
{% endcodeblock %}

That's it... if something on your side does not work please leave here a note providing as much information as possible and I'll try to help you!
