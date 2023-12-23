//
//  WeatherManager.swift
//  Clima
//
//  Created by Shreyash Pattewar on 23/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=6b615da85e89041952546345f8e70af5&units=metric"
    
    
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
                    
                    return
                }
                if let safeData = data {
                    let dataString = String(data: safeData,encoding: .utf8)
                    print(dataString!)
                    parseJSON(weatherData: safeData)
                    
                    
                }
            }
            task.resume()
        }}
    
    
    func parseJSON(weatherData: Data){
        
        let decoder = JSONDecoder()
        do{ 
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decoderData.main.temp)
        }catch {
            print(error)
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
