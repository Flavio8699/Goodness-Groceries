//
//  PopupManager.swift
//  GoodnessGroceries
//
//  Created by Flavio Matias on 30/03/2021.
//  Copyright © 2021 Flavio Matias. All rights reserved.
//

import Foundation

class PopupManager: ObservableObject {
    
    @Published var showPopup: Bool = false
    @Published var currentPopup: PopupType? = nil {
        didSet {
            self.showPopup = true
        }
    }
    
}

enum PopupType {
    case error(PopupErrorType)
    case message(title: String, message: String)
    case indicator(indicator: Indicator)
}

enum PopupErrorType: Error {
    case network, general
}
