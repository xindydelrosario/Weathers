

import SwiftUI

struct WeatherForecast: View {

    let myWeather: ForecastViewModel
    @EnvironmentObject var store: Store

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    Text(myWeather.cityName)
                        .font(.title)
                        .bold()
                    
                    Text(myWeather.dailyDates[0].DATE())
                        .font(.title2)

                    HStack(alignment: .center){
                        Image(myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)

                        Text("\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                            .font(.system(size: 50))
                    }//hstack

                    Text(myWeather.description.capitalized)
                        .font(.title3)

                }//Vstack
                .padding()
                .foregroundColor(Color("TextColor"))

                CustomStackView {
                    Label {
                        Text("Details")
                    } icon: {
                    }

                } contentView: {
                    HStack {
                        VStack(alignment: .leading) {
                            DetailRow(logo: "sunrise.fill", name: "Sunrise",
                                      value: myWeather.sunrise.Time())
                            
                            Spacer()
                            DetailRow(logo: "wind", name: "Wind speed",
                                      value: "\(myWeather.currentWind)m/s")
                            
                            
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            DetailRow(logo: "sunset.fill", name: "Sunset",
                                      value: myWeather.sunset.Time())
                            Spacer()
                            
                            DetailRow(logo: "humidity", name: "Humidity",
                                      value: "\(myWeather.currentHumidity)%")
                            
                        }
                    }
                }


                CustomStackView {
                    Label {
                        Text("5-Day Forecast")
                    }
                icon: {
                    }

                } contentView: {
                    VStack(spacing: 10) {

                        DailyRow(
                                 day: myWeather.dailyDates[1].DATE(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[1])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )

                        Spacer()

                        DailyRow(
                                 day: myWeather.dailyDates[2].DATE(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[2])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )

                        Spacer()

                        DailyRow(
                                 day: myWeather.dailyDates[3].DATE(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[3])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )

                        Spacer()

                        DailyRow(
                                 day: myWeather.dailyDates[4].DATE(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[4])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        Spacer()
                        
                        DailyRow(
                                 day: myWeather.dailyDates[5].DATE(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[5])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                    }//vstack
                }
            }//ScrollView
        }//VStack
        .foregroundColor(Color("TextColor"))
    }
}

struct ForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityScreen()
    }
}
