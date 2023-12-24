//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
   
   
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager =  CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}


//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
 
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }
        else {textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if  let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate


extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        print(weather.temperatureString)
        
        DispatchQueue.main.sync {
            
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
                
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            
        }
        
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}


//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lang = location.coordinate.longitude
        
            print(String(lat) + " " + String(lang))
            weatherManager.fetchWeatherWithLatLang(lat: (lat), lang: (lang))
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
