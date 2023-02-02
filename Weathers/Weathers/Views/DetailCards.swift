

import SwiftUI

struct DetailCards: View {
    
    @EnvironmentObject var store: Store
    @State var myWeather: ForecastViewModel!
    let city: String
    
    var body: some View {
        ZStack {
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    
                    VStack {
                        NavView()
                            .padding(.top)
                            .padding(.horizontal)
                            .edgesIgnoringSafeArea(.bottom)
                        Spacer()
                        
                        HStack {
                            
                            TabView {
                                ForEach(store.currentW, id: \.cityName) { myWeather in
                                    WeatherForecast(myWeather: myWeather)
                                }
                                
                                ForEach(store.weatherList, id: \.cityName) { myWeather in
                                    WeatherForecast(myWeather: myWeather)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                            .tabViewStyle(PageTabViewStyle())
                        }//HSTACK
                    }//VSTACK
                }//SCROLLVIEW
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct DetailCards_Previews: PreviewProvider {
    static var previews: some View {
        DetailCards(city: "")
    }
}
