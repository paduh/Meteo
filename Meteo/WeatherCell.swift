//
//  WeatherCell.swift
//  Meteo
//
//  Created by Perfect Aduh on 25/09/2016.
//  Copyright © 2016 PAK Consulting. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var forcastImg: UIImageView!
    @IBOutlet weak var forcastDay: UILabel!
    @IBOutlet weak var forcastWeatherType: UILabel!
    @IBOutlet weak var forcastHighTemp: UILabel!
    @IBOutlet weak var forcastLowTemp: UILabel!

    func configureCell(forcast: Forcast){
        
        forcastDay.text = forcast.date
        forcastWeatherType.text = forcast.forcastWeatherType
        forcastLowTemp.text = "\(forcast.lowTemp)"
        forcastHighTemp.text = "\(forcast.highTemp)"
        forcastImg.image = UIImage(named: forcast.forcastWeatherType)
    }
}


