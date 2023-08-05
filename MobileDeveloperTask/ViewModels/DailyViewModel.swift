//
//  DailyViewModel.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 08.08.2023.
//

import Foundation

class DailyViewModel: ObservableObject {
    @Published var daily: Daily?
    
    func getDaily() async throws -> Daily {
        let endpoint = "https://api.nasa.gov/planetary/apod?api_key=zJyBH3jhtKmwTTvxa83aJV7gBioOq00jjHqfjNbG"
        
        guard let url = URL(string: endpoint) else { throw DailyError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw DailyError.invalidResponse }
        
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" 
            
            var decodedDaily = try decoder.decode(Daily.self, from: data)
            
            
            if let dateStr = decodedDaily.date, let date = dateFormatter.date(from: dateStr) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let formattedDate = dateFormatter.string(from: date)
                decodedDaily.date = formattedDate
            }
            
            return decodedDaily
        } catch {
            throw DailyError.invalidData
        }
    }
}
