


import SwiftUI

struct NavView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var store: Store
    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .celsius
    @AppStorage("isDarkMode") private var isDark = false
    
    var body: some View {
        HStack {
            
            
            Button {
                withAnimation(.easeIn) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Image(systemName: "plus.app")
                    .font(.title2)
                    .foregroundColor(Color("TextColor"))
            }
             Spacer()
            
            Menu {
                Button {
                    isDark.toggle()
                } label: {
                    Label {
                        Text("Theme: ")
                    } icon: {
                        Image(systemName: isDark ? "moon" : "sun.max")
                    }
                }
                
                Divider()
                //Temperatue Unit
                Picker(selection: $selectedUnit, label: Text("")) {
                    ForEach(TemperatureUnit.allCases, id: \.self) {
                        Text("\($0.displayText)" as String)
                    }
                }
                .pickerStyle(.automatic)//adapt menu style
                
                Divider()
            } label: {
                Image(systemName: "gearshape")
                    .font(.title2)
            }//End of Menu
            //Update value when user select a unit
            .onChange(of: selectedUnit) { newValue in
                store.selectedUnit = selectedUnit
            }
        
        }
        .foregroundColor(Color("TextColor"))
        
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
