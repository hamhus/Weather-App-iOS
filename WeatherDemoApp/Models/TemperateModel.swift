//
//  TemperateModel.swift
//  WeatherDemoApp
//
//  Created by Hameed Hussain on 5/29/22.
//

import Foundation

class TempModel
{
    
    var minTemp:String=""
//    var maxTemp:String=""
//    var windSpeed:String=""
//    var humidity:String=""
//    var tempNow:String=""
    
    init(weather:ResponseBody)
    {
        minTemp = weather.main.feels_like.roundDouble()
    }
    
}
