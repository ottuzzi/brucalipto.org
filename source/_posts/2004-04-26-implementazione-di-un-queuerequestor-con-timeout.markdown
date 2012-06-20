---
date: '2004-04-26 16:45:10'
layout: post
slug: implementazione-di-un-queuerequestor-con-timeout
status: publish
comments: true
title: Implementazione di un QueueRequestor con timeout.
wordpress_id: '7'
categories:
- java
tags:
- JMS
---

Mi sono trovato nella necessità di dover usare delle code JMS per lo scambio di messaggi tra due applicazioni. L'idea era che a domanda doveva seguire una risposta in maniera sincrona e le API javax.jms mettono a disposizione per lo scopo l'oggetto _javax.jms.QueueRequestor_.


## Il problema

Il problema del QueueRequestor è che non ha un timeout dopo il quale ritorna in qualsiasi caso: se non si ottiene una risposta                         il QueueRequestor non fa procedere l'esecuzione e ciò non è bello.

## La soluzione

Per la soluzione sono stato illuminato da [questo](http://groups.google.com/groups?hl=it&lr=&ie=UTF-8&oe=UTF-8&threadm=3D9D9C2B.A49F993F%40replyinnewsgroup.com&rnum=1&prev=/groups%3Fq%3Dqueuerequestor%2520timeout%2520%26hl%3Dit%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26sa%3DN%26tab%3Dwg)                         post sui newsgroup: qui si afferma che il QueueRequestor è nient'altro che un wrapper di una serie di API pubbliche del package _javax.jms_.
Ecco una classe d'esempio che si interfaccia ad una coda JMS Tibco:

{% codeblock QueueRequestorImpl.java %}
import javax.jms.*;
import java.io.Serializable;
import com.tibco.tibjms.TibjmsQueueConnectionFactory;

public class QueueRequestorImpl
{
	private final static String QUEUE_PATH = "tcp://localhost:7222";
	private final static String QUEUE_NAME = "testQueue";
	private final static long   QUEUE_TIMEOUT = 10000;

	public static Object connect(Serializable request)
	{
		QueueConnection queueConnection = null;
		QueueSession queueSession = null;
		Queue queue = null;
		ObjectMessage objmessage = null;

		TemporaryQueue tempQueue = null;
		QueueSender qSender = null;
		QueueReceiver qReceiver = null;

		try
		{
			QueueConnectionFactory queueConnectionFactory = null;
			queueConnectionFactory = new TibjmsQueueConnectionFactory(QUEUE_PATH);
			queueConnection = queueConnectionFactory.createQueueConnection();
			queueSession = queueConnection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			queue = getQueue(QUEUE_NAME, queueSession);

			tempQueue = queueSession.createTemporaryQueue();
			qReceiver = queueSession.createReceiver(tempQueue);
			qSender = queueSession.createSender(queue);
		}
		catch (Exception e)
		{
			return null;
		}
		finally
		{
			try
			{
				if (qReceiver!=null) qReceiver.close();
				if (qSender!=null) qSender.close();
				if (tempQueue!=null) tempQueue.delete();
				if (queueConnection!=null) queueConnection.close();
			}catch (Exception e){;}
		}
		try
		{
			objmessage = queueSession.createObjectMessage();
			objmessage.setJMSReplyTo(tempQueue);
			queueConnection.start();
			objmessage.setObject(request);

			long elapsedTime = System.currentTimeMillis();
			qSender.send(objmessage);
			Message response = qReceiver.receive(QUEUE_TIMEOUT);
			elapsedTime = System.currentTimeMillis() - elapsedTime;
			System.out.println("QueueRequestorImpl Response Time: " + elapsedTime);

			if (response!=null)
				System.out.println("Message RECEIVED.");
			else
			{
				System.out.println("Message TIMEOUT.");
				return null;
			}

			String sendIDString = objmessage.getJMSMessageID();
			String respIDString = response.getJMSCorrelationID();
			if (!sendIDString.equals(respIDString))
			{
				String msg = "'"+sendIDString+"'!='"+respIDString+"'";
				System.out.println("JMSCorrelationID MISMATCH ("+msg+").");
				return null;
			}

			return response;
		}
		catch (Exception e)
		{
			System.out.println("JMSException '"+e.getMessage()+"'");
			return null;
		}
		finally
		{
			try
			{
				if (qReceiver!=null) qReceiver.close();
				if (qSender!=null) qSender.close();
				if (tempQueue!=null) tempQueue.delete();
				if (queueConnection!=null) queueConnection.close();
			}
			catch (Exception e){;}
		}
	}

	public static Queue getQueue(String name, QueueSession session)
	{
		try
		{
			return session.createQueue(name);
		}
		catch(JMSException e)
		{
			throw new RuntimeException("Session closed");
		}
	}
}
{% endcodeblock %}


## Conclusione

Come si può vedere il problema è facilmente aggirabile, basta solo fare un po' di googling e cercare nei javadoc.
