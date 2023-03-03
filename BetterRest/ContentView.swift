//
//  ContentView.swift
//  BetterRest
//
//  Created by Seika Hirori on 3/2/23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp:Date = Date.now
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1


    var body: some View {
        VStack{
            code_part_2(wakeUp: $wakeUp, sleepAmount: $sleepAmount, coffeeAmount: $coffeeAmount)
        }
    }
}


struct code_part_2: View {
    @Binding var wakeUp: Date
    @Binding var sleepAmount: Double
    @Binding var coffeeAmount: Int
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 5) {
                VStack {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .padding()
                
                VStack {
                Text("Desired amount of sleep")
                    .font(.headline)
                
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                .padding()
                
                VStack{
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper(coffeeAmount == 1 ? "1 cup": "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }
                .padding()
                // more to come
            }
            .padding()
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
    }
}
    
    func calculateBedTime() {
        
        // section 2.2
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            // more code soon
            let components: DateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            
            let sleepTime = wakeUp - prediction.actualSleep
            
        } catch {
            // something went wrong :'[
        }
        
        
    }
    
}

struct selectingDatePicker: View {
    @Binding var wakeUp:Date // RFER #1
    
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

struct examplesPart_One:View {
    @Binding var wakeUp:Date
    @Binding var sleepAmount:Double
    
    var body: some View {
        VStack {
                                    
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            
//            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
//                .labelsHidden()
            selectingDatePicker(wakeUp: $wakeUp) // RFER #1
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
