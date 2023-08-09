
import SwiftUI

struct WorkoutDetail: View {
    @State var workout: Workout
    @State private var sets: String = ""
    
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
                // For simplicity, I'm omitting database-related code
                // After saving, navigate back to the previous screen.
                // In SwiftUI, this can be done using an environment object for navigation.
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct WorkoutDetail_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetail(workout: Workout(name: "Pushups", sets: 0))
    }
}

