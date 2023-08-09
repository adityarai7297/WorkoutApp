//
//  ContentView.swift
//  WorkoutApp
//
//  Created by Aditya Rai on 8/8/23.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: WorkoutDetail(workout: Workout(name: "Pushups", sets: 0))) {
                    Text("Pushups")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Select Workout")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
