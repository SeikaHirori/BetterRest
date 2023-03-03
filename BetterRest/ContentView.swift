//
//  ContentView.swift
//  BetterRest
//
//  Created by Seika Hirori on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp:Date = Date.now
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
        .padding()
    }
    
    func exampleDates() {
        let tomorrow = Date.now.addingTimeInterval(86400)
        
        let range = Date.now...tomorrow
    }
    
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
