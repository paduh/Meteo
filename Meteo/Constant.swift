//
//  Constant.swift
//  Meteo
//
//  Created by Perfect Aduh on 24/09/2016.
//  Copyright © 2016 PAK Consulting. All rights reserved.
//

import Foundation

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude)&lon=\(Location.sharedInstance.longitude)&appid=466e8d514785dd9c0cebf4841eb42373"
let FORCAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude)&lon=\(Location.sharedInstance.longitude)&cnt=10&mode=json&appid=466e8d514785dd9c0cebf4841eb42373"

typealias DownloadCompleted = () -> ()
