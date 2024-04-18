//
//  DashboardModel.swift
//  DashboardTask
//
//  Created by Mohammad Haris Sofi on 17/04/24.
//

import Foundation
import SwiftUI
import Combine

class DashboardViewModel : ObservableObject {
    @Published var dbData: DBModel?
    var cancellables  = Set<AnyCancellable>()
    private let getDbData  = GetDbData()
    private var cancellabels = Set<AnyCancellable>()
    @State var isLoading : Bool = true
    init() {
       getDBData()
    }
    
    func getDBData() {
        getDbData.$DbData
            .sink {[weak self] (value) in
                self?.dbData = value
                self?.isLoading = false
            }
            .store(in: &cancellabels)
    }
}

