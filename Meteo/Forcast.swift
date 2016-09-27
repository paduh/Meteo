//
//  Forcast.swift
//  Meteo
//
//  Created by Perfect Aduh on 25/09/2016.
//  Copyright © 2016 PAK Consulting. All rights reserved.
//

import Foundation

class Forcast{
    
    private var _date: String!
    private var _forcastWeatherType: String!
    private var _lowTemp: Double!
    private var _highTemp: Double!
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        
        return _date
    }
    
    var forcastWeatherType: String{
        if _forcastWeatherType == nil{
            _forcastWeatherType = ""
        }
        return _forcastWeatherType
    }
    
    var lowTemp: Double{
        if _lowTemp == nil{
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    var highTemp: Double{
        if _highTemp == nil{
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let date = weatherDict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            
            self._date = unixConvertedDate.dayOfTheWeek()
            
        }
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double{
                let kelvinToCelius = round(min -  273.15)
                self._lowTemp = kelvinToCelius
                
            }
            if let max  = temp["max"] as? Double{
                let kelvinToCelcius = round(max - 273.15)
                self._highTemp = kelvinToCelcius
                
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                self._forcastWeatherType = main
            }
        }
    }
}

extension Date{
    
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}

