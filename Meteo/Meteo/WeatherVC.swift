//
//  WeatherVC.swift
//  Meteo
//
//  Created by Perfect Aduh on 23/09/2016.
//  Copyright © 2016 PAK Consulting. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var waertherTypeImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forcast: Forcast!
    var forcasts = [Forcast]()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    
        tableView.dataSource = self
        tableView.delegate = self
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell{
            
            let forcast = forcasts[indexPath.row]
            cell.configureCell(forcast: forcast)
            return cell
        }
            return WeatherCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return forcasts.count
    }
    
    func downloadForcastWeather(completed:  @escaping DownloadCompleted){
        let forcastURL = URL(string: FORCAST_URL)!
        Alamofire.request(forcastURL).responseJSON{ response in
                let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    
                    for obj in list{
                        let forcast = Forcast(weatherDict: obj)
                        self.forcasts.append(forcast)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather = CurrentWeather()
            currentWeather.downloadCurrentWeather {
                self.updateUI()
            }
            self.downloadForcastWeather {
            }
            
            print(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        }else {locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    func updateUI(){
        currentDate.text = currentWeather.date
        currentTemp.text = "\(currentWeather.currentTemp)℃"
        cityName.text = currentWeather.cityName
        weatherType.text = currentWeather.weatherType
        waertherTypeImg.image = UIImage(named: currentWeather.weatherType)
    }
}

