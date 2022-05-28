//
//  WeatherView.swift
//  WeatherDemoApp
//
//  Created by Hameed Hussain on 5/28/22.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var locationManager = LocationManager()
    @State private var changeUnit = ""
    var weatherManager = WeatherManager()
    var weather:ResponseBody
    var body: some View {
        var minTemp=weather.main.temp_min.roundDouble()
        var maxTemp=weather.main.temp_max.roundDouble()
        var humidity = weather.main.humidity.roundDouble()
        var windSpeed = weather.wind.speed.roundDouble()
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        ZStack(alignment: .leading){
            VStack
            {
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name).bold().font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                
                Spacer()
                
                VStack{
                    HStack{
                        VStack(spacing:20){
                            Image(systemName: "sun.max").font(.system(size:40))
                            Text(weather.weather[0].main)
                        }.frame(width:100, alignment: .leading)
                        
                        Text(weather.main.feels_like.roundDouble() + "°").font(.system(size:70)).fontWeight(.bold).padding()
                        
                        //Adding a Celsius/Farhenheit button to change units
                        VStack{
                            Button(action:{
                                title.text="C"
                            })
                            {
                                Text = "Unit changed"
                            }
                            .label:{
                                Text("C").font(.system(size:30)).fontWeight(.bold)
                            }
                            if(self.changeUnit)
                            {
                                Text("Unit Changed")
                                var weather:ResponseBody? = weather
                                if let location = locationManager.location{
                                    if let weather = weather
                                    {
                                        //Text("Weather data fetched")
                                        WeatherView(weather: weather)
                                    }
                                    else{
                                LoadingView()
                                    .task{
                                        do{
                                            weather = try await
                                            weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude, unit:"imperial")
                                        }
                                        catch{
                                            print("Error getting weather \(error)")
                                        }
                                    }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer().frame(height:80)
                    
                    AsyncImage(url:URL(string:"https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")){image in image.resizable().aspectRatio(contentMode: .fit).frame(width:350)
                        
                    }placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth:.infinity)
            }
            .padding()
            .frame(maxWidth:.infinity, alignment: .leading)
            
            VStack{
                Spacer()
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Weather now").bold().padding(.bottom)
                    HStack{
                        WeatherRow(logo: "thermometer", name: "Min temp", value: minTemp + "°")
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: maxTemp + "°")
                        
                    }
                    HStack{
                        WeatherRow(logo: "wind", name: "Wind speed", value: windSpeed + "m/s")
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: humidity + "°")
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue:0.656, saturation: 0.787,
                                       brightness: 0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue:0.656, saturation: 0.787,
                          brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather:previewWeather)
    }
}
