


import SwiftUI

struct DailyRow: View {

    var day: String
    var temp: String
    
    var body: some View {
        HStack {
            Today(day: day)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Temp(temp: temp)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }//hstack
    }
}

struct DailyRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyRow(day: "today", temp: "30°C")
    }
}

struct Today: View {
    
    var day: String
    
    var body: some View {
        Text(day)
            .font(.title3)
    }
}


struct Temp: View {
    
    var temp: String
    
    var body: some View {
        Text(temp)
            .font(.title3)
    }
}
