---
date: '2005-02-14 09:12:54'
layout: post
slug: log4j-tutorial
status: publish
comments: true
title: Log4j tutorial
wordpress_id: '19'
categories:
- java
tags:
- Tutorial
---

[Log4j](http://logging.apache.org/log4j/index.html) is a powerful Java API for logging and its worst defect is documentation: yes the javadoc are available but if you are looking for a simple setup or for a first time setup things become difficult. Here is the "tutorial" I wish I had at the time I started using log4j.

## What is log4j?

As you can read in [log4j homepage](http://logging.apache.org/log4j/docs/):
{% blockquote %}
With log4j it is possible to enable logging at runtime without modifying the application binary. The log4j package is designed so that these statements can remain in shipped code without incurring a heavy performance cost. Logging behavior can be controlled by editing a configuration file, without touching the application binary.
{% endblockquote %}

So log4j is a Java API that let you insert in your code logging facilities that you can control using a specific configuration file: this way, for example, you can turn debugging info on or off simply touching the config file without looking throughout all your code looking for debug statements.
From a user perspective log4j is mainly composed by two objects: _loggers_ and _appenders_.  Let us have a look about these objects.

## Logger

Here is the definitions from `org.apache.log4j.Logger` javadoc:

{% blockquote %}
This is the central class in the log4j package. Most logging operations, except configuration, are done through this class.
{% endblockquote %}

As you understand the logger is the programmer's best friend: using the methods of Logger you really do logging.
There are mainly two ways you can get a Logger (both using static methods):

{% codeblock lang:java %}
Logger log = Logger.getLogger("myLogger");
{% endcodeblock %}

Loggers are hierarchically organized starting from the _root logger_ that is the parent of all loggers. If you want to get an instance of the _root logger_ you must use:

{% codeblock lang:java %}
Logger rootLog = Logger.getRootLogger();
{% endcodeblock %}

If you think that using

{% codeblock lang:java %}
Logger log = Logger.getLogger("root");
{% endcodeblock %}

is a good idea you are wrong: with these instructions you get a Logger called _root_ that is the son of the real _root logger_.

Loggers give you different levels of logging:

* `DEBUG`: for simple debug informations.
* `INFO`: when you have to log something informative.
* `WARN`: when something not so normal is happening in your code.
* `ERROR`: use this to log error conditions in your code.
* `FATAL`: guess what?


[Here](http://www.brucalipto.org/files/Log4j_01.zip) you can find a simple java class that show you a Logger instantiation and usage.

## Appender

The _appender_ is somewhat hidden to programmer's view: usually you will never use directly an _appender_ (eg: you will never instantiate it) but it is used by the logger. Simply put the _appender_ is the object that does the dirty work of outputting your own logs: you use a ConsoleAppender if you want your logs to appear on the console, you use a FileAppender if you want to write your logs on the disk etc. etc. You can have more than one _appender_ for each _logger_ so you can have output distributed on more places. Last but not least you can set a threshold for every appender making it possible to have different level of 'debug information' in different places.

## It is configuration time!

An example is better than many words:

{% codeblock %}
# Here is the definition of the rootLogger:
# it has to output all logs (DEBUG is the lowest level)
# it has to output using both 'console' and 'file' appender
log4j.rootLogger=DEBUG, console, file
# The appender called 'console' is of type ConsoleAppender
# This appender shows you all info for better debugging
# Its output is formatted using the inserted ConversionPattern
log4j.appender.console=org.apache.log4j.ConsoleAppender
log4j.appender.console.Threshold=DEBUG
log4j.appender.console.layout=org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern=%d %5p %c (%F:%L) - %m%n
# The appender called 'file' is of type FileAppender
# This appender shows you only messages ABOVE the INFO level
# It writes in file 'test.log' located in the directory
# stored in 'user.home' system property.
# Its output is formatted using the inserted ConversionPattern
log4j.appender.file=org.apache.log4j.FileAppender
log4j.appender.file.Threshold=INFO
log4j.appender.file.File=${user.home}/test.log
log4j.appender.file.layout=org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern=%d %5p %c (%F:%L) - %m%n
{% endcodeblock %}

[Here](http://www.brucalipto.org/files/Log4j_02.zip) you can find a simple archive containing a sources, executables and configuration files you can look at to better understand what I was saying.

See on 'Appendix A' about conversion patterns.

See on 'Appendix B' about variable expansion.

Now that you have a configuration file you have to tell log4j to use it and you have two possibilities: put it in the classpath calling it log4j.properties or use `org.apache.log4j.PropertyConfigurator` to load it through the `configure()` method as you can find in the archive.

## Appendix A

Conversion pattern are listed in the javadoc of `org.apache.log4j.PatternLayout` and reported here for simplicity:

<table class="log4j">
	<tr>
		<td><strong>c</strong></td>
		<td>Used to output the category of the logging event. The category conversion specifier can be optionally followed by _precision specifier_, that is a decimal constant in brackets. If a precision specifier is given, then only the corresponding number of right most components of the category name will be printed. By default the category name is printed in full.For example, for the category name "a.b.c" the pattern **%c{2}** will output "b.c".</td>
	</tr>
	<tr>
		<td><strong>C</strong></td>
		<td>Used to output the fully qualified class name of the caller issuing the logging request. This conversion specifier can be optionally followed by _precision specifier_, that is a decimal constant in brackets.If a precision specifier is given, then only the corresponding number of right most components of the class name will be printed. By default the class name is output in fully qualified form.For example, for the class name "org.apache.xyz.SomeClass", the pattern **%C{1}** will output "SomeClass".**WARNING** Generating the caller class information is slow. Thus, it's use should be avoided unless execution speed is not an issue.</td>
	</tr>
	<tr>
		<td><strong>d</strong></td>
		<td>Used to output the date of the logging event. The date conversion specifier may be followed by a _date format specifier_ enclosed between braces. For example, **%d{HH:mm:ss,SSS}** or  **%d{dd MMM yyyy HH:mm:ss,SSS}**.  If no date format specifier is given then ISO8601 format is assumed.The date format specifier admits the same syntax as the time pattern string of the [`SimpleDateFormat`](http://java.sun.com/j2se/1.3/docs/api/java/text/SimpleDateFormat.html). Although part of the standard JDK, the performance of `SimpleDateFormat` is quite poor.For better results it is recommended to use the log4j date formatters. These can be specified using one of the strings "ABSOLUTE", "DATE" and "ISO8601" for specifying [`AbsoluteTimeDateFormat`](http://logging.apache.org/log4j/docs/api/org/apache/log4j/helpers/AbsoluteTimeDateFormat.html), [`DateTimeDateFormat`](http://logging.apache.org/log4j/docs/api/org/apache/log4j/helpers/DateTimeDateFormat.html) and respectively [`ISO8601DateFormat`](http://logging.apache.org/log4j/docs/api/org/apache/log4j/helpers/ISO8601DateFormat.html). For example, **%d{ISO8601}** or  **%d{ABSOLUTE}**.These dedicated date formatters perform significantly better than [`SimpleDateFormat`](http://java.sun.com/j2se/1.3/docs/api/java/text/SimpleDateFormat.html).</td>
	</tr>
	<tr>
		<td><strong>F</strong></td>
		<td>Used to output the file name where the logging request was issued.**WARNING** Generating caller location information is extremely slow. It's use should be avoided unless execution speed is not an issue.</td>
	</tr>
	<tr>
		<td><strong>l</strong></td>
		<td>Used to output location information of the caller which generated the logging event.The location information depends on the JVM implementation but usually consists of the fully qualified name of the calling method followed by the callers source the file name and line number between parentheses.The location information can be very useful. However, it's generation is _extremely_ slow. It's use should be avoided unless execution speed is not an issue.</td>
	</tr>
	<tr>
		<td><strong>L</strong></td>
		<td>Used to output the line number from where the logging request was issued.**WARNING** Generating caller location information is extremely slow. It's use should be avoided unless execution speed is not an issue.</td>
	</tr>
	<tr>
		<td><strong>m</strong></td>
		<td>Used to output the application supplied message associated with the logging event.</td>
	</tr>
	<tr>
		<td><strong>M</strong></td>
		<td>Used to output the method name where the logging request was issued.**WARNING** Generating caller location information is extremely slow. It's use should be avoided unless execution speed is not an issue.</td>
	</tr>
	<tr>
		<td><strong>n</strong></td>
		<td>Outputs the platform dependent line separator character or characters.This conversion character offers practically the same performance as using non-portable line separator strings such as "\n", or "\r\n". Thus, it is the preferred way of specifying a line separator.</td>
	</tr>
	<tr>
		<td><strong>p</strong></td>
		<td>Used to output the priority of the logging event.</td>
	</tr>
	<tr>
		<td><strong>r</strong></td>
		<td>Used to output the number of milliseconds elapsed since the start of the application until the creation of the logging event.</td>
	</tr>
	<tr>
		<td><strong>t</strong></td>
		<td>Used to output the name of the thread that generated the logging event.</td>
	</tr>
	<tr>
		<td><strong>x</strong></td>
		<td>Used to output the NDC (nested diagnostic context) associated with the thread that generated the logging event.</td>
	</tr>
	<tr>
		<td><strong>X</strong></td>
		<td>Used to output the MDC (mapped diagnostic context) associated with the thread that generated the logging event. The **X** conversion character _must_ be followed by the key for the map placed between braces, as in **%X{clientNumber}** where `clientNumber` is the key. The value in the MDC corresponding to the key will be output.See [`MDC`](http://logging.apache.org/log4j/docs/api/org/apache/log4j/MDC.html) class for more details.</td>
	</tr>
	<tr>
		<td><strong>%</strong></td>
		<td>The sequence %% outputs a single percent sign.</td>
	</tr>
</table>

## Appendix B

Here is what the `org.apache.log4j.PropertyConfigurator` says about variable expansion:

{% blockquote %}
All option values admit variable substitution. The syntax of variable substitution is similar to that of Unix shells. The string between an opening "${" and closing "}" is interpreted as a key. The value of the substituted variable can be defined as a system property or in the configuration file itself. The value of the key is first searched in the system properties, and if not found there, it is then searched in the configuration file being parsed. The corresponding value replaces the ${variableName} sequence. For example, if java.home system property is set to /home/xyz, then every occurrence of the sequence ${java.home} will be interpreted as /home/xyz.
{% endblockquote %}

One of the nicest feature of `org.apache.log4j.PropertyConfigurator` I found is that you can use it to dinamically configure/reconfigure log4j. As stated in the javadoc the `configure()` method of this class can get a `java.util.Properties` as parameter: you can simply load a properties file that looks like the final result you want and then you can manipulate it runtime (as `java.util.Properties`) and pass it to `PropertyConfigurator`. With this method you can do whatever you want on log4j: create loggers/appenders runtime, change log level etc. etc.
