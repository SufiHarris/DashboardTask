//
//  GetDbData.swift
//  DashboardTask
//
//  Created by Mohammad Haris Sofi on 17/04/24.
//

import Foundation
import Combine

class GetDbData : ObservableObject {
    @Published var DbData : DBModel?
    private let bearerToken : String = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"
    var dataCancellables = Set<AnyCancellable>()
    
    init() {
        getDBData()
    }
    
    func getDBData() {
        guard let getWardUrl = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew" )else {
            fatalError("URL for appointments is incorrect")
        }
        var request = URLRequest(url: getWardUrl)
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: DBModel.self, decoder: JSONDecoder())
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Handle successful completion
                    break
                case .failure(let error):
                    // Handle failure
                    print(error)
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: {[weak self] value in
                // Handle received value
                print(value)
                self?.DbData = value
            })
            .store(in: &dataCancellables) // Make sure to hold cancellables in your class or struct
    }
    
}
