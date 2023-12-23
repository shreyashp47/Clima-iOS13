//
//  WeatherData.swift
//  Clima
//
//  Created by Shreyash Pattewar on 23/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable{
    let temp: String
}
struct Weather: Decodable{
    let description: String
}
