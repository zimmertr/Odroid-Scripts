# Odroid Scripts

## Summary

A collection of my scripts written for my Odroid XU4Qs. 

## LED_Control

`led_control` monitors your CPU usage in real time and will flash the blue LED whenever CPU Usage is above 5%. I wrote this script because I was dissatisfied with the default heartbeat flash of the LED as it isn't really indicitive of activity. It also comes with a Systemd unit so you can enable it on boot.

## HW_Status

`hw_status` is a simple tool to grab the Fan Speed, GPU Temperature, and CPU Temperature by core of the Odroid and update it via the console in real time.

## Configuration

`configuration` isn't really a script, but rather a collection of the commands I ran to bootstrap my Odroids for my reference when reformatting them. This is probably not very useful for you.
