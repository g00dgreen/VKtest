//
//  MainPresenter.swift
//  VKtest
//
//  Created by Артем Макар on 22.07.24.
//

import Foundation


protocol MainPresenterProtocol {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func getWeatherByIndexPath(index: IndexPath) -> WeatherType
    func onTouched(index: IndexPath)
}

final class MainPresenter {
    weak var view: MainViewController?
    private let model: MainModel
    private var selectedWeather: WeatherType?
    
    
    init(view: MainViewController? = nil, model: MainModel) {
        self.view = view
        self.model = model
    }
}

extension MainPresenter: MainPresenterProtocol {
    func getWeatherByIndexPath(index: IndexPath) -> WeatherType {
        return model.weatherArray[index.row]
    }
    
    func numberOfItemsInSection() -> Int {
        return model.weatherArray.count
    }
    
    func viewDidLoad() {
        selectedWeather = model.selectRandWeather()
        view?.startAnimation(weather: selectedWeather?.name ?? .clear)
    }
    
    func onTouched(index: IndexPath) {
        for i in 0..<model.weatherArray.count {
            model.weatherArray[i].isSelected = false
        }
        model.weatherArray[index.row].isSelected = true
        view?.updateData()
        view?.startAnimation(weather: model.weatherArray[index.row].name)
    }
}
