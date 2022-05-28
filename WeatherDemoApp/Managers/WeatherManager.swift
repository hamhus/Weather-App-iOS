//
//  WeatherManager.swift
//  WeatherDemoApp
//
//  Created by Hameed Hussain on 5/28/22.
//

import Foundation
import CoreLocation

class WeatherManager
{
    func getCurrentWeather(latitude:CLLocationDegrees, longitude:CLLocationDegrees, unit:String) async throws -> ResponseBody
    {
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("c0d6b7fb19db3109bb97da925d9ea1d8")&units=\(unit)")
        else{fatalError("Missing URL")}
                    
                    let urlRequest = URLRequest(url:url)
                    
                   let(data, response) = try await URLSession.shared.data(for:urlRequest)
                    
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Missing URL")}
        
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodeData
    }
}

struct ResponseBody:Decodable
{
    var coord:CoordinatesResponse
    var weather:[WeatherResponse]
    var base:String
    var main:MainResponse
    var visibility:Double
    var wind:WindResponse
    var clouds:CloudsResponse
    var dt:Double
    var sys:SysResponse
    var timezone:Double
    var id:Double
    var name:String
    var cod:Double
    
    struct CoordinatesResponse:Decodable{
        var lon:Double
        var lat:Double
    }
    
    struct WeatherResponse:Decodable{
        var id:Double
        var main:String
        var description:String
        var icon:String
    }
    struct MainResponse:Decodable
    {
        var temp:Double
        var feels_like:Double
        var temp_min:Double
        var temp_max:Double
        var pressure:Double
        var humidity:Double
    }
    
    struct WindResponse:Decodable
    {
        var speed:Double
        var deg:Double
    }
    
    struct CloudsResponse:Decodable
    {
        var all:Double
    }
    
    struct SysResponse:Decodable
    {
        var type:Double
        var id:Double
        var country:String
        var sunrise:Double
        var sunset:Double
    }
}
