//
//  WeatherValue.swift
//  VKtest
//
//  Created by Артем Макар on 22.07.24.
//

import Foundation

enum WeatherValue: String {
    case clear
    case cloudy
    case rain
    case snow
}

struct WeatherType {
    let id: Int
    let name: WeatherValue
    var isSelected: Bool = false
    var localizedName: String
}
