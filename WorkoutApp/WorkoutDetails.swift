
import SwiftUI

struct WorkoutDetail: View {
    @State var workout: Workout
    @State private var sets: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text(workout.name)
                .font(.largeTitle)
                .padding()
            
            TextField("Enter number of sets", text: $sets)
                .keyboardType(.numberPad)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                .padding([.leading, .trailing])
            
            Button("End Workout") {
                workout.sets = Int(sets) ?? 0
                // Here, you would save the workout data to your database
                NetworkManager.shared.addWorkout(workout: workout) { success, error in
                        if success {
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            alertMessage = "Failed to add workout"
                            showAlert = true
                        }
                    }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }
        .padding()
    }
}

struct WorkoutDetail_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetail(workout: Workout(name: "Pushups", sets: 0))
    }
}

