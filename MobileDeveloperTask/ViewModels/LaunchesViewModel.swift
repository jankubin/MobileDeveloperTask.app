//
//  LaunchesViewModel.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 04.08.2023.
//

import Foundation

class LaunchesViewModel: ObservableObject{
    @Published var spaceXLaunch: [Response] = []
    
    func fetch() {
        guard let url = URL(string: "https://api.spacexdata.com/v5/launches") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let spaceXLaunch = try decoder.decode([Response].self, from: data)
                DispatchQueue.main.async {
                    self.spaceXLaunch = spaceXLaunch
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
   
}
