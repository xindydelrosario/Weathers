

import SwiftUI


struct AddCityScreen: View {
    
    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .celsius
    @AppStorage("isDarkMode") private var isDark = false
    @EnvironmentObject var store: Store
    @ObservedObject var networkManager = NetworkManager()
    @State var myWeather: ForecastViewModel!
    @State var isEditing = false
    @State private var showCancelButton: Bool = false
    @StateObject private var addCityVM = WeatherViewModel()
    @StateObject var locationManager = LocationManager()
    
    var webService = WebService()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background-image")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        // MARK: - Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("Search for a city",
                                      text: $addCityVM.city,
                                      onEditingChanged: { isEditing in self.showCancelButton = true },
                                      onCommit: {addCityVM.getCity { myWeather in store.addWeather(myWeather)}
                            })
                            .foregroundColor(Color("TextColor"))
                            
                            Button(action: {
                                self.addCityVM.city = ""
                            }) {
                                Image(systemName: "xmark.circle.fill").opacity(addCityVM.city == "" ? 0 : 1)
                            }
                        }
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(Color("TextColor"))
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                        
                        if showCancelButton  {
                            Button("Cancel") {
                                UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                                self.addCityVM.city = ""
                                self.showCancelButton = false
                            }
                            .foregroundColor(Color(.systemBlue))
                        }
                    }
                    .padding(.horizontal)
                    .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
                    
                    List {
                        // MARK: - Current Location
                        if networkManager.isConnected {
                            if let location = locationManager.location {
                                if let myWeather = myWeather {
                                    NavigationLink(destination: DetailCards(city: myWeather.cityName)) {
                                        CurrentCustomCell(myWeather: myWeather)
                                    }
                                } else {
                                    LoadingView()
                                        .task {
                                            do {
                                                myWeather = try await webService.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                                
                                                //Save or Update stored data
                                                if store.currentW.isEmpty {
                                                    store.addCurrent(myWeather)
                                                } else {
                                                    store.updateCurrent(myWeather)
                                                }
                                            } catch {
                                                print("Error getting weather: \(error)")
                                            }
                                        }
                                }
                            } else {
                                LoadingView()
                                    .onAppear(perform: locationManager.requestLocation)
                            }
                        } else {
                            ForEach(store.currentW, id: \.cityName) { myWeather in
                                NavigationLink(destination: DetailCards(city: myWeather.cityName )) {
                                    CurrentCustomCell(myWeather: myWeather)
                                }
                            }
                        }
                        
                        // MARK: - Added Cities
                        ForEach(store.weatherList, id: \.cityName) { myWeather in
                            NavigationLink(destination: DetailCards(city: myWeather.cityName)) {
                                SearchedCustomCell(myWeather: myWeather)
                            }
                        }
                        .onDelete(perform: store.deleteWeather)
                        //                    }//end of if else
                    }//ScrollView
                    .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
                }//Vstack
                
            }//zstack
 
            .navigationBarTitle("AddCity")
            .foregroundColor(Color("TextColor"))
        }//NvigationView
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

struct FavoriteListScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddCityScreen()
            .environmentObject(Store())
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
