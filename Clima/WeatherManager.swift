//
//  WeatherManager.swift
//  Clima
//
//  Created by Shreyash Pattewar on 23/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weathermanager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager {
    
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=6b615da85e89041952546345f8e70af5&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    
    func performRequest (urlString: String){
        if  let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            //let task1 = session.dataTask(with: url, completionHandler:   handle(data:response:error:)   )
            //task1.resume()
            let task = session.dataTask(with: url) { (data, respose, error) in
                if error != nil
                {    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data: safeData,encoding: .utf8)
                    ///print(dataString!)
                    if  let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                    
                    
                }
            }
            task.resume()
        }}
    
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decoderData.main.temp)
            let  id = decoderData.weather[0].id
            let  description = decoderData.weather[0].id
            let  name = decoderData.name
            let  temp = decoderData.main.temp
            
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather
            
        }catch {
            print(error)
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    //    func handle(data: Data?, response: URLResponse?, error: Error?)
    //    {
    //        if error != nil
    //        {    print(error!)
    //
    //            return
    //        }
    //        if let safeData = data {
    //            let dataString = String(data: safeData,encoding: .utf8)
    //            print(dataString!)
    //
    //        }
    //    }
}
