---
layout: post
title: "The Raspberry Diary: Linksys WUSB100 Wireless N USB Adapter"
date: 2012-07-24 12:03
comments: true
status: publish
comments: true
description: "This is my Raspberry diary: how to make Linksys WUSB100 Wireless N USB Adapter work"
keywords: "RaspberryPi, rpi, linux, diary, raspbian"
categories:
- linux
tags:
- RaspberryPi
---
[{% img left /images/2012/07/Raspi_Colour_R_71x86.png Raspberry Pi logo %}](http://www.raspberrypi.org/) Today I want to make my
Cisco Linksys WUSB100 Wireless N USB Adapter work on Raspberry Pi. In 
[ELinux RPi Verified Peripherals](http://elinux.org/RPi_VerifiedPeripherals#Problem_USB_Wifi_Adapters) page this USB Wi-Fi dongle is
listed as problematic and making it to work is quite a challenge. My own USB key is exactly the one listed there with 
idVendor="1737" e idProduct="0078" identified as Linksys (Cisco) WUSB100 ver.2.

## Software installation

As I noted in my [previous post](/linux/the-raspberry-diary-day-1) I'm using [Raspbian](http://www.raspbian.org/), the Linux 
distribution recommended in the [Raspberry Pi](http://www.raspberrypi.org/downloads) official download page. 
For using the Wi-Fi USB key we need at least the software for managing Wi-Fi networks and the firmware for the USB Wi-Fi key: 
specifically the WUSB100 ver.2 is based on the RT-3070 Ralink chipset. This USB key is supported by the `rt2800usb` driver actually 
present in the official Raspberry Pi linux kernel once you provide the firmware binary blob. 
All the following commands must be run as **root**.

So let us install the needed packages:
{% codeblock lang:sh %}
$ apt-get install wireless-tools wpasupplicant firmware-ralink 
{% endcodeblock %}

## Software configuration

Now we have all the needed software but still the Wi-Fi USB will not appear as device `wlan0` 
we need to make it working: it is time of some udev voodoo and finally things should work.

First we need to edit file `/etc/udev/rules.d/network_drivers.rules`
{% codeblock lang:sh %}
$ nano /etc/udev/rules.d/network_drivers.rules
{% endcodeblock %}

and then add as a single line the following:
{% codeblock lang:sh %}
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="1737", ATTR{idProduct}=="0078", RUN+="/sbin/modprobe -qba rt2800usb"
{% endcodeblock %}

Double check you wrote it right, save and close.
Then we need to edit `/etc/modprobe.d/network_drivers.conf`
{% codeblock lang:sh %}
$ nano /etc/modprobe.d/network_drivers.conf
{% endcodeblock %}

and then add the following as a single line:
{% codeblock lang:sh %}
install rt2800usb /sbin/modprobe --ignore-install rt2800usb $CMDLINE_OPTS; /bin/echo "1737 0078" > /sys/bus/usb/drivers/rt2800usb/new_id
{% endcodeblock %}

## Network setup
Finally you need to modify `/etc/network/interfaces` to reflect the new interface addition 
adding something similar to:
{% codeblock A possible interfaces if Wi-Fi is WEP encrypted lang:sh %}
# my wifi device
auto wlan0
iface wlan0 inet dhcp
	wireless-essid [ACCESS_POINT_SSID]
	wireless-mode Managed
	wireless-key [YOUR_SECRET_WEP_PASSWORD]
{% endcodeblock %}

or

{% codeblock A possible interfaces if Wi-Fi is WAP encrypted lang:sh %}
# my wifi device
auto wlan0
iface wlan0 inet dhcp
	wpa-ssid [ACCESS_POINT_SSID]
	wpa-psk [YOUR_SECRET_WPA_PASSWORD] 
{% endcodeblock %}

If you write your password in `/etc/network/interfaces` please keep it permission tight:

{% codeblock lang:sh %}
$ chmod 0600 /etc/network/interfaces
{% endcodeblock %}

## Reboot and final checks

Now reboot and everything should be fine: finally you will see the `wlan0` device 
appearing if you run `ifconfig`:
{% codeblock lang:sh %}
$ ifconfig -a
{% endcodeblock %}

With all these steps my Cisco Linksys WUSB100 Wireless N USB Adapter is working and stable during 
last 8 hours with moderate network traffic: I did not stress test it yet... if I will found something 
unusual I will let you know.

Is this setup working for you? Do you have any problem? Use comments below to leave a feedback 
and I will try to help you!