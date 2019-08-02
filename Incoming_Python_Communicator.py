#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 30 14:48:55 2019

@author: anhpham
"""
import serial
import time
 
arduinoData = serial.Serial('/dev/cu.usbmodem143301',9600)
 
 
f = open("/Users/anhpham/Documents/XCode/Incoming!/Incoming!/Incoming.txt", "r")
 
while True:
 
    #This is the delay of 1 sec. Change this according to your needs.
    
    c = f.read(1)
    if (not c):
        break
    
 
    arduinoData.write(c.encode('utf-8'))
 
    print ("Character sent:", c)
    time.sleep(1)
 
f.close()
 
arduinoData.close()
 
 
 
#a = True
 
#while (a):
 
#    g = input("Enter the input : ")
 
#    if(g == '0'):
 
#        a = False
 
#        arduinoData.close()
 
#    else:
 
#        arduinoData.write(g.encode('utf-8'))
 