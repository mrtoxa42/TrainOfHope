extends Node



#Kaydedilen değişkenler
var data = {}
var gamedata = {coin = 100}
var traindata = {turret = 7,vagon = 7}
var playerdata = {}

#Tutulan sahne değişkenleri
var train
var player
var joystick 


#Ana Değişkenler
var gamestarted = false
var levelin = false
var selflevel
var nowlevel = 1



# Oyun içi değişkenler
var playerhp 
var trainhp


var trainboundary
var currentenemy




