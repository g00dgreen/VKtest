//
//  MainModel.swift
//  VKtest
//
//  Created by Артем Макар on 22.07.24.
//

import Foundation

protocol MainModelProtocol {
    func selectRandWeather() -> WeatherType
    func resetSelectedWeather()
}

final class MainModel {
    var weatherArray: [WeatherType] = [WeatherType(id: 1, name: .clear, localizedName: NSLocalizedString("clear", comment: "clear")),
                                       WeatherType(id: 2, name: .cloudy, localizedName: NSLocalizedString("cloudy", comment: "cloudy")),
                                       WeatherType(id: 4, name: .rain, localizedName: NSLocalizedString("rain", comment: "rain")),
                                       WeatherType(id: 5, name: .snow, localizedName: NSLocalizedString("snow", comment: "snow"))]
}


extension MainModel: MainModelProtocol {
    
    func resetSelectedWeather() {
        for i in 0..<weatherArray.count {
            weatherArray[i].isSelected = false
        }
    }

    func selectRandWeather() -> WeatherType {
        let randIndex = Int.random(in: 0..<weatherArray.count)
        weatherArray[randIndex].isSelected = true
        return weatherArray[randIndex]
    }
}
