//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Misha on 2021/11/3.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate{
    func didUpdWeather(_ weatherManager:WeatherManager, weather : WeatherModel)
    func didFailWithError( error: Error )
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7ad20a99d0866eed8ba0a115c4318272&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWheather(cityName: String){
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
            let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
            performRequest(with: urlString)
        }
    
    func performRequest(with urlString: String){
        //1.Create URL
        if let url = URL(string: urlString){
            //2.Create an URLSession
            let session = URLSession(configuration: .default)
            //3.Give the session Task
            
            let task =  session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if  let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdWeather(self, weather: weather)
                    }
                    
                }
            }
            //4.Start the task
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionID: id, cityNAME: name, temperature: temp )
            
            print(weather.conditionNAME)
            print(weather.temperatureString)
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
}
 
