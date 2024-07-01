//
//  WeatherManager.swift
//  WeatherWise
//
//  Created by 吴魏 on 7/1/24.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    // OpenWeather API:  8a9abfe58555646b565853c6d9899bd0
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=8a9abfe58555646b565853c6d9899bd0&units=metric") else{ fatalError("Oops! Something went wrong...")}
            
        
        let urlRequest = URLRequest(url: url)
        
        let (data, res) = try await URLSession.shared.data(for: urlRequest)
        
        guard (res as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodeData
    }
}


struct ResponseBody: Decodable {
    var coord: CoordinateResponse
    var weather:[WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    
    struct CoordinateResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    
}

extension ResponseBody.MainResponse {
    var feelslike: Double {return feels_like}
    var tempMin: Double {return temp_min}
    var tempMax: Double {return temp_max}
}

