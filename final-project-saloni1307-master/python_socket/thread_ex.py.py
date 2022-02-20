#!/usr/bin/python

import threading
import time
import pygame
from pygame.locals import *
import obd
import serial
import string
import socket
import json
import re
#import pynmea2
#import RPi GPIO as gpio

ser = serial.Serial('/dev/ttyACM0', 4800, timeout=1)  # Open Serial port
running = True

global value

value = 0
value2 = 99
i = 1

global gps_conn

pygame.init()

screen = pygame.display.set_mode((480,200))

headerFont = pygame.font.SysFont("Sans", 60)
digitFont = pygame.font.SysFont("Sans", 50)

white = (255,255,255)
black = (0,0,0)
grey = (112, 128, 144)

run = True

move_ahead = True

class obdThread (threading.Thread):
   def __init__(self):
      threading.Thread.__init__(self)
   def run(self):
      global value, value2
      value = 0
      value2 = 99
      move_ahead = True
      print ("Starting OBD Thread")
      while 1:
        if(value <= 199):
          if(move_ahead == True):
            value+=1
            if(value == 199):
              move_ahead = True
        elif(move_ahead == False):
          value-=1
          if(value == 0):
            move_ahead = True
           
        if (value%10) == 0:
          value2-=1
        if(value2 == 0):
          value2 = 99
              
        data = ("Speed-%d Fuel Percent-%d\r\n" %(value, value2))
        conn.send(data.encode())
        #print("Sending OBD data")
        time.sleep(1)
          
      print ("Exiting OBD Thread")

class gpsThread (threading.Thread):
   def __init__(self):
      threading.Thread.__init__(self)
   def run(self):
      print ("Starting GPS Thread")
      while 1:
          try:
              while True:
                  data_chunk = readString_socket()
                  #data_chunk = readString()
                  if "$GPGGA" in data_chunk:
                   lines = data_chunk.split("$GPGGA")
                   for line in lines:
                     if(len(line) != 0):
                       if(line[0] != '$'):
                         gpgga_content_words = line.split(",")
                         lat = gpgga_content_words[2]
                         lon = gpgga_content_words[4]
                         #print("lat : " + lat + ", lon : " + lon)
                         printGGA(gpgga_content_words)
                    
                    
                  
          except KeyboardInterrupt:
              print('Exiting GPS')
              server_gps.close()
              gps_conn.close()
              server_socket.close()
              conn.close()
              
          time.sleep(1)
      print ("Exiting GPS Thread")
   
def draw_hud():
           screen.fill(grey)
           pygame.draw.circle(screen, black, (int(circle1_x), int(circle_y)), int(circle_rad), 5)
           pygame.draw.circle(screen, black, (int(circle2_x), int(circle_y)), int(circle_rad), 5)
           pygame.draw.circle(screen, black, (int(circle3_x), int(circle_y)), int(circle_rad), 5)
           speed_text = headerFont.render("SPEED", True, black)
           rpm_text = headerFont.render("RPM", True, black)
           load_text = headerFont.render("LOAD", True, black)
           speed_text_loc = speed_text.get_rect(center=(speed_text_x, speed_text_y))
           rpm_text_loc = rpm_text.get_rect(center=(rpm_text_x, rpm_text_y))
           load_text_loc = load_text.get_rect(center=(load_text_x, load_text_y))
           screen.blit(speed_text, speed_text_loc)
           screen.blit(rpm_text, rpm_text_loc)
           screen.blit(load_text, load_text_loc)
           
def readString():
    while 1:
        line = ser.readline().decode("utf-8")  # Read the entire string
        return line
        
def readString_socket():
    global gps_conn
    while 1:
        line = gps_conn.recv(1024).decode()  # Read the entire string
        return line


def getTime(string, format, returnFormat):
    return time.strftime(returnFormat,
                         time.strptime(string, format))  # Convert date and time to a nice printable format


def getLatLng(latString, lngString):
    lat = latString[:2].lstrip('0') + "." + "%.7s" % str(float(latString[2:]) * 1.0 / 60.0).lstrip("0.")
    lng = lngString[:3].lstrip('0') + "." + "%.7s" % str(float(lngString[3:]) * 1.0 / 60.0).lstrip("0.")
    return lat, lng
    

def convertToCoordinates(value):
    degrees = int(float(value))
    submin = abs( (float(value) - int(float(value)) ) * 60)
    minutes = int(submin)
    subseconds = abs((submin-int(submin)) * 60)
    notation = str(degrees) + u"\u00b0" + str(minutes) + "\'" +\
               str(subseconds)[0:1] + "\""
    return notation


def printGGA(lines):
    #print("========================================GGA========================================")
    # print(lines, '\n')
    latlng = getLatLng(lines[2], lines[4])
    global latitude
    latitude = convertToCoordinates(latlng[0])
    global longitude 
    longitude = convertToCoordinates(latlng[1])
    #print("Lat,Long: ", latlng[0], lines[3], ", ", latlng[1], lines[5], sep='')
    print("Latitude: ", latitude, lines[3], "      Longitude: ", longitude, lines[5], "      Altitude: ", lines[9], lines[10], sep=" ")
    print(" ")
    data = ("Latitude-%s %s Longitude-%s %s Altitude-%s %s\r\n" %(latitude, lines[3], longitude, lines[5], lines[9], lines[10] ))
    conn.send(data.encode())
    image = pygame.image.load("/etc/project/map/map.jpg").convert()

    sprite = pygame.sprite.Sprite()
    sprite.image = image
    sprite.rect = (0, 0, 0, 0)
    
    lat_text = headerFont.render("LAT:", True, black)
    long_text = headerFont.render("LONG:", True, black)
    alt_text = headerFont.render("ALT:", True, black)
    sprite.image.blit(lat_text, (100, 40))
    sprite.image.blit(long_text, (100, 100))
    sprite.image.blit(alt_text, (100, 150))
    LatDisplay = digitFont.render(str(latitude + lines[3]), 3, black)
    LongDisplay = digitFont.render(str(longitude + lines[5]), 3, black)
    AltDisplay = digitFont.render(str(lines[9] + lines[10]), 3, black)
              
    sprite.image.blit(LatDisplay, (220, 40))
    sprite.image.blit(LongDisplay, (250, 100))
    sprite.image.blit(AltDisplay, (200, 150))
    
    group = pygame.sprite.Group()
    group.add(sprite)
    group.draw(screen)
    
    pygame.display.flip()
    return


def checksum(line):
    checkString = line.partition("*")
    checksum = 0
    for c in checkString[0]:
        checksum ^= ord(c)

    try:  # Just to make sure
        inputChecksum = int(checkString[2].rstrip(), 16);
    except:
        print("Error in string")
        return False

    if checksum == inputChecksum:
        return True
    else:
        print("=====================================================================================")
        print("===================================Checksum error!===================================")
        print("=====================================================================================")
        print(hex(checksum), "!=", hex(inputChecksum))
        return False

if __name__ == '__main__':

    try:
     global gps_conn
     host = input("Enter server ip address: ")
     #host = "192.168.1.8"
     port = 5000  # initiate port no above 1024
     port_gps = 5050
 
     server_socket = socket.socket()  # get instance
     server_gps = socket.socket()
     
     # look closely. The bind() function takes tuple as argument
     server_socket.bind((host, port))  # bind host address and port together
     server_gps.bind((host, port_gps))
     #("Bind with client")
 
     # configure how many client the server can listen simultaneously
     server_socket.listen(2)
     server_gps.listen(2)
     conn, address = server_socket.accept()  # accept new connection
     print("Connection from: " + str(address))
     
     gps_conn, address_gps = server_gps.accept()
     print("Connection from: " + str(address_gps))
     # Create new threads
     thread1 = obdThread()
     thread2 = gpsThread()
 
     # Start new Threads
     thread1.start()
     thread2.start()
    except KeyboardInterrupt:
     print('Exiting Process')
     server_gps.close()
     gps_conn.close()
     server_socket.close()
     conn.close()
     

