//
//  CurrentWeather.swift
//  Meteo
//
//  Created by Perfect Aduh on 24/09/2016.
//  Copyright © 2016 PAK Consulting. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    
    private var _date: String!
    private var _cityName: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        
        let dateFomatter = DateFormatter()
        dateFomatter.dateStyle = .long
        dateFomatter.timeStyle = .none
        let currentDate = dateFomatter.string(from: Date())
        self._date = "Today: \(currentDate)"
        
        return _date
    }
   
    var cityName: String{
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double{
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        
        
        return _currentTemp
    }
    
    
    func downloadCurrentWeather(completed: @escaping DownloadCompleted){
        
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let name = dict["name"] as? String{
                  self._cityName = name
                   
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main
                       
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    if let temp = main["temp"] as? Double{
                        
                        let kelvinToCelcius = round(temp - 273.15)
                        
                          self._currentTemp = kelvinToCelcius
                      
                    }
                  
                }
        
            }
            completed()
        }
        
    }
    
}
