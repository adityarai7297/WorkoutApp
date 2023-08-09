// NetworkManager.swift

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://your-backend-server.com" // Replace with your backend server's URL
    
    func addWorkout(workout: Workout, completion: @escaping (Bool, Error?) -> Void) {
        let endpoint = "\(baseURL)/addWorkout"
        guard let url = URL(string: endpoint) else {
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(workout)
            request.httpBody = jsonData
        } catch {
            completion(false, error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                completion(false, error)
                return
            }
            
            completion(true, nil)
        }.resume()
    }
}
