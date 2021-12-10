//
//  TrainTimeApp.swift
//  TrainTime
//
//  Created by Jonas Frey on 09.12.21.
//

import SwiftUI

struct TrainTimeApp: View {
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        f.locale = .current
        return f
    }()
    
    @State private var departure = Date()
    
    // MARK: Persistent Data
    @AppStorage(.walkTimeMetro) private var walkTimeMetro = 0
    @AppStorage(.departureMetro) private var departureMetro = 0
    @AppStorage(.metroTripDuration) private var metroTripDuration = 0
    @AppStorage(.walkTimeTrain) private var walkTimeTrain = 0
    
    private var leaveHouseTime: Date {
        reachMetroTime.addingTimeInterval(.init(-60 * walkTimeMetro))
    }
    private var reachMetroTime: Date {
        departureMetroTime
    }
    @State private var departureMetroTime: Date = Date()
    private var reachTrainStationTime: Date {
        departureMetroTime.addingTimeInterval(.init(60 * metroTripDuration))
    }
    private var reachTrainTime: Date {
        reachTrainStationTime.addingTimeInterval(.init(60 * walkTimeTrain))
    }
    
    private func calculateTimes() {
        print("Calculating times")
        // Try to arrive exactly at the requested arrival time
        // i.e. the latest departure we could take
        var time = departure.addingTimeInterval(.init(-60 * (walkTimeTrain + metroTripDuration)))
        
        // Correct the metro departure to match the intervals
        let mins = Calendar.current.component(.minute, from: time)
        print(departureMetro)
        // If the metro e.g. departs every 10 minutes at __:_4 and our latest departure % 10 is bigger than that,
        // we have to take the one earlier
        if ((mins % 10) > departureMetro) {
            let diff = mins % 10 - departureMetro
            // We need to arrive `diff` minutes earlier
            time = time.addingTimeInterval(.init(-60 * diff))
        } else if (mins % 10 < departureMetro) {
            // We arrive earlier than the metro, but the metro still departs at the given intervals
            // We need to take the earlier metro, because we cannot wait for the metro. That would make us miss the train,
            // since `time` is already the latest metro departure we can afford
            let diff = departureMetro - mins % 10
            time = time.addingTimeInterval(.init(60 * (diff - 10)))
        } else {
            print("Time matches")
        }
        
        departureMetroTime = time
    }
    
    private func valueChanged(_ value: Any) {
        print("Calculating times from value changed")
        calculateTimes()
    }
    
    private func onAppear() {
        departure = Date()
        calculateTimes()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Form {
                    DatePicker("Departure Train", selection: $departure, displayedComponents: .hourAndMinute)
                        .onChange(of: departure, perform: valueChanged)
                    
                    Stepper(value: $walkTimeMetro, in: 0...60) {
                        HStack {
                            Text("Walking Time Metro")
                            Spacer()
                            Text("\(walkTimeMetro)")
                        }
                    }
                    .onChange(of: walkTimeMetro, perform: valueChanged)
                    
                    Picker("Departure Metro", selection: $departureMetro) {
                        ForEach(0..<10) { i in
                            Text("__:_\(i)")
                                .tag(i)
                        }
                    }
                    .onChange(of: departureMetro, perform: valueChanged)
                    
                    Stepper(value: $metroTripDuration, in: 0...60) {
                        HStack {
                            Text("Metro Trip Duration")
                            Spacer()
                            Text("\(metroTripDuration)")
                        }
                    }
                    .onChange(of: metroTripDuration, perform: valueChanged)
                    
                    Stepper(value: $walkTimeTrain, in: 0...60) {
                        HStack {
                            Text("Walking Time Train")
                            Spacer()
                            Text("\(walkTimeTrain)")
                        }
                    }
                    .onChange(of: walkTimeTrain, perform: valueChanged)
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Spacer()
                        Text("Results")
                            .font(.title)
                        Spacer()
                    }
                    Text("Leave the house at ") + Text(formatter.string(from: leaveHouseTime)).bold()
                    Text("Walk \(walkTimeMetro) minutes to the metro")
                    Text("Arrive at the metro station at ") + Text(formatter.string(from: reachMetroTime)).bold()
                    Text("Metro departs at \(formatter.string(from: departureMetroTime))")
                    Text("Arrive at the train station at ") + Text(formatter.string(from: reachTrainStationTime)).bold()
                    Text("Walk \(walkTimeTrain) minutes to the train")
                    Text("Arrive at the train at ") + Text(formatter.string(from: reachTrainTime)).bold()
                    Text("The train leaves at ") + Text(formatter.string(from: departure)).bold()
                }
                .padding()
            }
            .navigationTitle("Train Time")
        }
        .onAppear(perform: onAppear)
    }
}

struct TrainTimeApp_Previews: PreviewProvider {
    
    static var previewStorage: UserDefaults {
        let u = UserDefaults()
        u.set(4, forKey: .departureMetro)
        u.set(10, forKey: .walkTimeMetro)
        u.set(10, forKey: .walkTimeTrain)
        u.set(10, forKey: .metroTripDuration)
        return u
    }
    
    static var previews: some View {
        TrainTimeApp()
            .defaultAppStorage(previewStorage)
    }
}
