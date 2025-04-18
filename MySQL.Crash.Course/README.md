### MySQL必知必会 示例代码

#### Ubuntu20.04上安装mysql8.0+版本

```
$ sudo apt-get update  #更新源
$ sudo apt-get install mysql-server #安装
```

安装完成后，可以通过下面的命令来查看时候安装成功：

```
$ systemctl status mysql
```

#### 设置root用户密码

```
$ sudo mysql
mysql> use mysql;
mysql> flush privileges;
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '你的密码';
mysql> flush privileges;
```

设置后可以通过下面命令来验证:

```
$ mysql -uroot -p'你的密码'
mysql>
```

#### 查看mysql版本信息

```
$ mysqladmin -u root -p'你的密码' version
```

#### 增加用户并授权

```
$ mysql -uroot -p'你的密码'
mysql> create user hexu;
mysql> ALTER USER 'hexu' IDENTIFIED WITH mysql_native_password BY '123456';
mysql> grant all on *.* to hexu;
```

#### 远程登陆

远程登陆命令如下:
```
$ mysql -h 10.0.0.14 -P 3306 -u hexu -p123456
```
如果提示ERROR 2003 (HY000): Can't connect to MySQL server on '10.0.0.14:3306' (111)
说明需要配置远程登陆

首先配置（取消）访问IP地址限制

在 /etc/mysql/mysql.conf.d/mysqld.cnf 里，在 bind-address= 127.0.0.1 这一句前加 # 将它注释掉，然后重启MySQL即可。

```
bind-address= 127.0.0.1
=>
# bind-address= 127.0.0.1
```

注意需要重启MySQL。

```
$ service mysql restart
```

然后授权远程用户登录

```
# 在服务器上进入MySQL控制台
$ mysql -u root -p
# 对于mySQL 8.0及以后版本，使用下面的命令进行授权（ %表示任意地址，也可以指定IP）
mysql> use mysql;
mysql> update user set user.Host='%' where user.User='hexu';
mysql> flush privileges;
```

![封面](cover.jpg)


