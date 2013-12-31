---
layout: post
title: "How to create a portable JDK 1.7 on windows"
date: 2013-12-27 14:48
comments: true
status: publish
description: "A simple way to create a portable version of Oracle Java 1.7"
keywords: "Java, Oracle, Oracle Java, Portable Java, JDK"
categories:
- java
tags:
- Tutorial
- tips&amp;tricks
---
{% img left /images/2012/07/java_logo.gif Java logo %}As a Java developer sometimes I need a version of Java Development Kit (JDK) that is not the one installed on my PC. Oracle Java installer on Windows does too many things that I cannot control (like changing the JVM used by browsers to run applets). As of this writing Java 7 is at version `u45` and you can download it from [here](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html "Java SE Development Kit 7 - Downloads").
Open the downloaded file with 7-zip (in my case was `jdk-7u45-windows-i586.exe`) and then open the tools.zip you find inside. Extract everything to a convenient path like `C:\jdk-1.7u45`.
Now it is shell time so open a DOS console (Start->Run...->cmd) and type:

{% codeblock Create a portable JDK 1.7 lang:sh %}
> cd C:\jdk-1.7u45
> for /r %x in (*.pack) do C:\jdk-1.7u45\bin\unpack200 "%x" "%x.jar"
{% endcodeblock %}

Now you are almost done but you need to rename some files: 

{% codeblock Look for all files that ends with .pack.jar lang:sh %}
> dir /B /S *.pack.jar
C:\jdk-1.7u45\jre\lib\charsets.pack.jar
C:\jdk-1.7u45\jre\lib\deploy.pack.jar
C:\jdk-1.7u45\jre\lib\javaws.pack.jar
C:\jdk-1.7u45\jre\lib\jfxrt.pack.jar
C:\jdk-1.7u45\jre\lib\jsse.pack.jar
C:\jdk-1.7u45\jre\lib\plugin.pack.jar
C:\jdk-1.7u45\jre\lib\rt.pack.jar
C:\jdk-1.7u45\jre\lib\ext\localedata.pack.jar
C:\jdk-1.7u45\lib\tools.pack.jar
{% endcodeblock %}

Rename all these files removing the .pack part (eg.: rename `charsets.pack.jar` to `charsets.jar`):

{% codeblock Rename all files that ends with .pack.jar lang:sh %}
> ren C:\jdk-1.7u45\jre\lib\charsets.pack.jar charsets.jar
> ren C:\jdk-1.7u45\jre\lib\deploy.pack.jar deploy.jar
> ren C:\jdk-1.7u45\jre\lib\javaws.pack.jar javaws.jar
> ren C:\jdk-1.7u45\jre\lib\jfxrt.pack.jar jfxrt.jar
> ren C:\jdk-1.7u45\jre\lib\jsse.pack.jar jsse.jar
> ren C:\jdk-1.7u45\jre\lib\plugin.pack.jar plugin.jar
> ren C:\jdk-1.7u45\jre\lib\rt.pack.jar rt.jar
> ren C:\jdk-1.7u45\jre\lib\ext\localedata.pack.jar localedata.jar
> ren C:\jdk-1.7u45\lib\tools.pack.jar tools.jar
{% endcodeblock %}

Finally test you new portable JDK 1.7:
{% codeblock Test portable JDK 1.7 lang:sh %}
> .\bin\java -version
java version "1.7.0_45"
Java(TM) SE Runtime Environment (build 1.7.0_45-b18)
Java HotSpot(TM) Client VM (build 24.45-b08, mixed mode)
{% endcodeblock %}

I hope this tutorial can help you... if you find errors please report them to me and I will correct as soon as possible.