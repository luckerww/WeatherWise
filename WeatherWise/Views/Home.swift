//
//  Home.swift
//  WeatherWise
//
//  Created by 吴魏 on 7/1/24.
//

import SwiftUI

struct Home: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack{
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: previewWeather)
                } else {
                    ProgressView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            }
                            catch {
                                print("Oops! Something went wrong!")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    ProgressView()
                } else {
                    Welcome()
                        .environmentObject(locationManager)
            }
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(LinearGradient(colors: [Color("light"), Color("dark")], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}



#Preview {
   ContentView()
}
