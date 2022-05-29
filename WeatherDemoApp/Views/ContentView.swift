//
//  ContentView.swift
//  WeatherDemoApp
//
//  Created by Hameed Hussain on 5/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather:ResponseBody?
    @State var weatherImperial:ResponseBody?
    
    
    var body: some View {
        
        VStack{
            if let location = locationManager.location{
//Text("Your coordinates are :\(location.longitude),\(location.latitude)")
                
                if let weatherImp=weatherImperial, let weather = weather
                {
                    //Text("Weather data fetched")
                    WeatherView(weather: weather, weatherImperial: weatherImp)
                }
                //let weatherMet = weather
                //let weatherImp = weatherImperial
//                if(let weatherImp = weatherImperial)
//                {
//                    WeatherView(weather: weather, weatherImp: weatherImperial)
//                }
                else
                {
                    LoadingView()
                        .task{
                            do{
                                weather = try await
                                weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude, unit:"metric")
                            }
                            catch{
                                print("Error getting weather \(error)")
                            }
                        }
                        .task{
                            do{
                                weatherImperial = try await
                                weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude, unit:"imperial")
                            }
                            catch{
                                print("Error getting weather \(error)")
                            }
                        }
                }
            }
            else
            {
                if locationManager.isLoading{
                    LoadingView()
                }
                else
                {
                    WelcomeView().environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue:0.656, saturation: 0.787,
                          brightness: 0.354))
        .preferredColorScheme(.dark)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
