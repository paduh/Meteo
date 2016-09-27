//
//  Location.swift
//  Meteo
//
//  Created by Perfect Aduh on 27/09/2016.
//  Copyright © 2016 PAK Consulting. All rights reserved.
//

import CoreLocation

class Location{
    
    static var sharedInstance = Location()
    
    private init() {}
    
    var longitude: Double!
    var latitude: Double!
    
}
