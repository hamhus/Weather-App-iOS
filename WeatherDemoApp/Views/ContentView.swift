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
    
    
    var body: some View {
        
        VStack{
            if let location = locationManager.location{
//Text("Your coordinates are :\(location.longitude),\(location.latitude)")
                if let weather = weather
                {
                    //Text("Weather data fetched")
                    WeatherView(weather: weather)
                }
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
