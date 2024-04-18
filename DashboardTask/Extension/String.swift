//
//  String.swift
//  DashboardTask
//
//  Created by Mohammad Haris Sofi on 17/04/24.
//

import Foundation
extension String {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}

