//
//  ContentView.swift
//  BetterRest
//
//  Created by Seika Hirori on 3/2/23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp:Date = defaultWakeTime
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1
    
    @State private var alertTitle:String = ""
    @State private var alertMessage:String = ""
    @State private var showingAlert:Bool = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        VStack{
            code_part_2(wakeUp: $wakeUp, sleepAmount: $sleepAmount, coffeeAmount: $coffeeAmount, alertTitle: $alertTitle, alertMessage: $alertMessage, showingAlert: $showingAlert, defaultWakeTime: ContentView.defaultWakeTime)
        }
    }
}


struct code_part_2: View {
    @Binding var wakeUp: Date
    @Binding var sleepAmount: Double
    @Binding var coffeeAmount: Int
    
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    @Binding var showingAlert: Bool
    
    var defaultWakeTime: Date
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.subheadline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.subheadline)
                        .padding(1)
                }
                Section {
                    Stepper(coffeeAmount == 1 ? "1 cup": "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                } header: {
                    Text("Daily coffee intake")
                        .font(.subheadline)
                }
                .padding(1)
    
//                .moddedVStack()
//                .padding()
                // more to come
            }
            .padding()
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
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
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            // something went wrong :'[
            alertTitle = "Error"
        }
        
        showingAlert = true
    }
    
    
}

extension View {
    func moddedVStack() -> some View {
        modifier(ModdedVStack())
    }
}

struct ModdedVStack: ViewModifier {
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            content
//                .font(.headline)
        }
        .padding()
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
