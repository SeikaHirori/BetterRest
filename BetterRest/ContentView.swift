//
//  ContentView.swift
//  BetterRest
//
//  Created by Seika Hirori on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp:Date = Date.now
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1


    var body: some View {
        VStack {
                        
            exampleTextDates()
            
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            
            
//            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
//                .labelsHidden()
            selectingDatePicker(wakeUp: $wakeUp)
        }
        .padding()
    }
    
    func exampleDates() {
        let tomorrow = Date.now.addingTimeInterval(86400)
        
        let range = Date.now...tomorrow
    }
    
    func exampleComponents() {
        var components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        
    }
    
}

struct selectingDatePicker: View {
    @Binding var wakeUp:Date
    
    var body: some View {
        VStack{
            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
                .labelsHidden()
        }
    }
}

struct exampleTextDates: View {
    var body: some View {
        VStack {
            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
