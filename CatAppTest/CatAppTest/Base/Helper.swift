//
//  FlagEmojo.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import Foundation

class Helper {

    static  func flagEmoji(for countryCode: String) -> String {
        countryCode.uppercased().unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }
        .map { String($0) }
        .joined()
    }
}
