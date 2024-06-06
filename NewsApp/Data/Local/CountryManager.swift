//
//  CountryManager.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

//
//  CountryManager.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation

struct Country: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let flag: String
}

class CountryManager {
    static let shared = CountryManager()

    private init() {}

    func getAllCountries() -> [Country] {
        /// THE API Doesn't have an endpoint to get all supported countries so we are using the countries in the Locale instead
        var countries = [Country]()
        let locale = Locale.current
        for code in Locale.isoRegionCodes {
            if let name = locale.localizedString(forRegionCode: code) {
                let flag = self.flag(from: code)
                let country = Country(code: code, name: name, flag: flag)
                countries.append(country)
            }
        }
        return countries.sorted { $0.name < $1.name }
    }

    private func flag(from countryCode: String) -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in countryCode.unicodeScalars {
            if let scalar = UnicodeScalar(base + v.value) {
                s.unicodeScalars.append(scalar)
            }
        }
        return String(s)
    }
}
