//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Misha on 2021/11/7.
//

import Foundation

struct WeatherModel{
    let conditionID:    Int
    let cityNAME:   String
    let temperature: Double
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionNAME: String{
        switch conditionID{
        case 200  ... 232: return "cloud.bolt"
        case 300 ... 321: return "cloud.drizzle"
        case 500 ... 532: return "cloud.rain"
        case 600 ... 622: return "cloud.snow"
        case 701 ... 781: return "cloud.fog"
        case 800: return "sun.max"
        case 801 ... 804: return "cloud.bold"
        default:return "cloud"
        }    }
    
    
    
}
