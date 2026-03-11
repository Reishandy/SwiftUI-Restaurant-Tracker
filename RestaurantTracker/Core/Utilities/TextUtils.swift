//
//  URLChecker.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import Foundation

func isValidWebURL(_ string: String) -> Bool {
    guard let url = URL(string: string) else {
        return false
    }
    
    let hasValidScheme = url.scheme == "http" || url.scheme == "https"
    let hasHost = url.host != nil
    
    return hasValidScheme && hasHost
}
