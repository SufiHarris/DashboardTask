//
//  WebServices.swift
//  DashboardTask
//
//  Created by Mohammad Haris Sofi on 17/04/24.
//
import SwiftUI
import Foundation
import Combine

enum ServiceError: Error {
    case networkError(String)
    case noData
    case invalidResponse(Int)
}
enum NetworkingError : LocalizedError {
    case badUrlResponse(url : URLRequest)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badUrlResponse(url: let url ) : return "[404] bad url response : \(url)"
        case .unknown : return "[202] unknown error"
        }
    }
}

class Service {
    static func download (url : URLRequest) -> AnyPublisher<Data, any Error>{
      return URLSession.shared.dataTaskPublisher(for: url)
           // .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap( { try handleUrlResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    static func handleUrlResponse (output : URLSession.DataTaskPublisher.Output , url : URLRequest) throws -> Data {
        guard let response = output.response as? HTTPURLResponse ,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badUrlResponse(url: url)
        }
        return output.data
    }
    static func handleCompletion (completion : Subscribers.Completion<Publishers.Decode<AnyPublisher<Data, Error>, DBModel, JSONDecoder>.Failure> ) {
        switch completion {
        case .finished :
            break
        
        case .failure(let error) :
            print(error.localizedDescription)
        }
    }
}

