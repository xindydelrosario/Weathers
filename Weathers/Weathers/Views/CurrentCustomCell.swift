


import SwiftUI

struct CurrentCustomCell: View {
    
    @EnvironmentObject var store: Store
    let myWeather: ForecastViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {

                Text(myWeather.cityName)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                Spacer()
                Text("\(myWeather.dailyDates[0].DATE())")
                    .font(.system(size: 15))
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    Image(myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text("\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        .font(.title3)
                }
                Spacer()
                Text(myWeather.description.capitalized)
                    .font(.system(size: 15))
            }
        }//Hstack
        .padding()
    }
}

struct CurrentWeatherList_Previews: PreviewProvider {
    static var previews: some View {
        AddCityScreen()
    }
}

struct SearchedCustomCell: View {

    @EnvironmentObject var store: Store
    let myWeather: ForecastViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(myWeather.cityName)
                        .font(.title3)
                        .fontWeight(.bold)

                    Text(" ")
                        .font(.system(size: 13))
                }
                Spacer()
                Text("\(myWeather.dailyDates[0].DATE())")
                    .font(.system(size: 15))
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    Image(myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)

                    Text("\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        .font(.title3)
                }
                Spacer()
                Text(myWeather.description.capitalized)
                    .font(.system(size: 15))
            }
        }//Hstack
        .padding()
    }
}
