//
//  WeatherDate.swift
//  WeatherApp
//
//  Created by Misha on 2021/11/4.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: main
    let weather: [weather]
    
}

struct main: Codable{
    let temp: Double
}

struct weather: Codable{
    let id: Int
    //let main: String
    //let description: String
    //let icon: String
}
