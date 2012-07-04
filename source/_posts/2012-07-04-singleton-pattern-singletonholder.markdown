---
layout: post
title: "Singleton Pattern: SingletonHolder"
date: 2012-07-04 16:39
comments: true
slug: singleton-pattern-SingletonHolder
status: publish
published: false
comments: true
description: "A better way to define a Singleton in Java"
keywords: "Java, J2EE, Singleton, Pattern, Singleton Pattern, SingletonHolder"
categories:
- java
tags:
---
{% codeblock Singleton.java %}
public class Singleton 
{
        // Private constructor prevents instantiation from other classes
        private Singleton(){}
 
        /**
         * SingletonHolder is loaded on the first execution of Singleton.getInstance() 
         * or the first access to SingletonHolder.INSTANCE, not before.
         */
        private final static class SingletonHolder 
        { 
                private final static Singleton instance = new Singleton();
        }
 
        public static Singleton getInstance() 
        {
                return SingletonHolder.instance;
        }
}
{% endcodeblock %}