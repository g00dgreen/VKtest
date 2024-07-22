//
//  CollectionViewCell.swift
//  VKtest
//
//  Created by Артем Макар on 22.07.24.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private let name: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with weather: WeatherType) {
        name.text = weather.localizedName
        contentView.backgroundColor = weather.isSelected ? .green : .clear
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
    }
}

//MARK: - Layout
extension CollectionViewCell {
    private func setupViews() {
        contentView.layer.cornerRadius = 20
        contentView.addSubview(name)
    }
    
    private func setupConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([            
            name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

