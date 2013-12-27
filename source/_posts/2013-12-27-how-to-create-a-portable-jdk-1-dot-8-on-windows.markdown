---
layout: post
title: "How to create a portable JDK 1.8 on windows"
date: 2013-12-27 14:49
comments: true
status: publish
description: "A simple way to create a portable version of Oracle Java 1.8"
keywords: "Java, Oracle, Oracle Java, Portable Java, JDK"
categories:
- java
tags:
- Tutorial
- tips&amp;tricks
---
{% img left /images/2012/07/java_logo.gif Java logo %}As a Java developer sometimes I need a version of Java Development Kit (JDK) that is not the one installed on my PC. Oracle Java installer on Windows does too many things that I cannot control (like changing the JVM used by browsers to run applets). As of this writing Java 8 is not yet available for general consumption but you can get an early access release [here](https://jdk8.java.net/download.html "Java 8 Early Access Release download").
Open the downloaded file with 7-zip and then open the tools.zip you find inside. Extract everything to a convenient path like `C:\jdk-1.8-ea`.
Now it is shell time so open a DOS console (Start->Run...->cmd) and type:

{% codeblock Create a portable JDK 1.8 lang:sh %}
> cd C:\jdk-1.8-ea
> for /r %x in (*.pack) do C:\jdk-1.8-ea\bin\unpack200 "%x" "%x.jar"
{% endcodeblock %}

Now you are almost done but you need to rename some files: 

{% codeblock Look for all files that ends with .pack.jar lang:sh %}
> dir /B /S *.pack.jar
C:\jdk-1.8-ea\jre\lib\charsets.pack.jar
C:\jdk-1.8-ea\jre\lib\deploy.pack.jar
C:\jdk-1.8-ea\jre\lib\javaws.pack.jar
C:\jdk-1.8-ea\jre\lib\jsse.pack.jar
C:\jdk-1.8-ea\jre\lib\plugin.pack.jar
C:\jdk-1.8-ea\jre\lib\rt.pack.jar
C:\jdk-1.8-ea\jre\lib\ext\jfxrt.pack.jar
C:\jdk-1.8-ea\jre\lib\ext\localedata.pack.jar
C:\jdk-1.8-ea\lib\tools.pack.jar
{% endcodeblock %}

Rename all these files removing the .pack part (eg.: rename `charsets.pack.jar` to `charsets.jar`):

{% codeblock Rename all files that ends with .pack.jar lang:sh %}
> ren C:\jdk-1.8-ea\jre\lib\charsets.pack.jar charsets.jar
> ren C:\jdk-1.8-ea\jre\lib\deploy.pack.jar deploy.jar
> ren C:\jdk-1.8-ea\jre\lib\javaws.pack.jar javaws.jar
> ren C:\jdk-1.8-ea\jre\lib\jsse.pack.jar jsse.jar
> ren C:\jdk-1.8-ea\jre\lib\plugin.pack.jar plugin.jar
> ren C:\jdk-1.8-ea\jre\lib\rt.pack.jar rt.jar
> ren C:\jdk-1.8-ea\jre\lib\ext\jfxrt.pack.jar jfxrt.jar
> ren C:\jdk-1.8-ea\jre\lib\ext\localedata.pack.jar localedata.jar
> ren C:\jdk-1.8-ea\lib\tools.pack.jar tools.jar
{% endcodeblock %}

Finally test you new portable JDK 1.8:
{% codeblock Test portable JDK 1.8 lang:sh %}
C:\jdk-1.8-ea>.\bin\java -version
java version "1.8.0-ea"
Java(TM) SE Runtime Environment (build 1.8.0-ea-b121)
Java HotSpot(TM) Client VM (build 25.0-b63, mixed mode)
{% endcodeblock %}

I hope this tutorial can help you... if you find errors please report them to me and I will correct as soon as possible.