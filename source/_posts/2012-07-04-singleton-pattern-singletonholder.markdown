---
layout: post
title: "Singleton Pattern: SingletonHolder"
date: 2012-07-04 16:39
comments: true
slug: singleton-pattern-SingletonHolder
status: publish
comments: true
description: "A better way to define a Singleton in Java"
keywords: "Java, J2EE, Singleton, Pattern, Singleton Pattern, SingletonHolder"
categories:
- java
tags:
- tips&amp;tricks
---
Writing a singleton is not that hard but writing it the right way may not be all that trivial. I wrote hundreds 
singletons in my developer life and yesterday I found, thanks to a 
[Wikipedia post](http://en.wikipedia.org/wiki/Singleton_pattern#The_solution_of_Bill_Pugh "Singleton Pattern: the solution of Bill Pugh"),
what I think is the perfect solution. The solution is not mine but I report it here for future reference:

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

In this implementation the singleton instance is thread safe and unique as this is warranted by using final and static keywords. 
Moreover the singleton instantiation is as lazy as possible: the singleton instance will be created if and only 
if you call the getInstance() method and not whenever you simply reference the Singleton class (like accessing a constant).