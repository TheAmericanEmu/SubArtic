class_name POI extends Area3D

@export var poi_name:String

signal poi_discovered

var has_been_found:=false

func discover_poi():
	if not has_been_found:
		has_been_found=true
		print(poi_name," Has been found")
		poi_discovered.emit()
