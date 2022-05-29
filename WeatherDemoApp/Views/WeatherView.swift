//
//  WeatherView.swift
//  WeatherDemoApp
//
//  Created by Hameed Hussain on 5/28/22.
//

import SwiftUI

struct WeatherView: View {
    //@StateObject var locationManager = LocationManager()
    //@State private var changeUnitType="change"
    //@State var changeUnit = "imperial"
    //@State var unitType = "M"
    //@IBOutlet var buttonText
    var weatherManager = WeatherManager()
    @State var weather:ResponseBody
    @State var weatherImperial:ResponseBody
    @State var minTemp = ""
    @State var maxTemp = ""
    @State var windSpeed = ""
    @State var humidity = ""
    @State var tempNow = ""
    
    var body: some View {
        //var minTemp = ""
        //var maxTemp1=weather.main.temp_max.roundDouble()
        //var humidity = weather.main.humidity.roundDouble()
        //var windSpeed = weather.wind.speed.roundDouble()
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //tempNow = displayTemp(temp:weather)
        
        ZStack(alignment: .leading){
            VStack
            {
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name).bold().font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                
                
                VStack{
                    HStack{
                        VStack(spacing:20){
                            Image(systemName: "sun.max").font(.system(size:40))
                            Text(weather.weather[0].main)
                        }.frame(width:100, alignment: .leading)
                        
                        Text(displayTemp(temp:weather) + "°").font(.system(size:70)).fontWeight(.bold).padding()
                        
                        
                        //VStack{
                            Button(action: {
                                //weather = weather
                                displayTemp(temp:weather)
                                
                                minTemp = weather.main.temp_min.roundDouble()
                                maxTemp = weather.main.temp_max.roundDouble()
                                windSpeed = weather.wind.speed.roundDouble()
                                humidity = weather.main.humidity.roundDouble()
                                //print(minTemp)
                            },
                            label: {
                                Text("C")
                            })
                        
                            Text("|")
                        //}
                        //Adding a Celsius/Farhenheit button to change units
                        VStack{
                            //TextField("Text here", Text=$changeUnit)
                            
                        Button (action: {
                                //weather = weatherImperial
                            displayTemp(temp:weatherImperial)
                            minTemp = weatherImperial.main.temp_min.roundDouble()
                            maxTemp = weatherImperial.main.temp_max.roundDouble()
                            windSpeed = weatherImperial.wind.speed.roundDouble()
                            humidity = weatherImperial.main.humidity.roundDouble()
                            
                        }, label:{
                                Text("F")
                            
                        })
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
            .padding()
            .frame(maxWidth:.infinity, alignment: .leading)
            }
        
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue:0.656, saturation: 0.787,
                          brightness: 0.354))
        .preferredColorScheme(.dark)
    }
    
    func displayTemp(temp:ResponseBody) -> String
    {
        let tempNow = temp.main.feels_like.roundDouble()
        return tempNow
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather:previewWeather, weatherImperial: previewWeather)
    }
}
