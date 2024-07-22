//
//  MainViewController.swift
//  VKtest
//
//  Created by Артем Макар on 22.07.24.
//

import UIKit

class MainViewController: UIViewController {
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        animationHelper = AnimationHelper(mainView: self.view)
        view.addSubview(collectionView)
        setupConstraints()
        
    }
    
    func updateData() {
        collectionView.reloadData()
    }
    
    private var animationHelper: AnimationHelper?
    private let presenter: MainPresenter
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.backgroundColor = .clear
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
}

extension MainViewController {
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.configure(with: presenter.getWeatherByIndexPath(index: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.onTouched(index: indexPath)
    }
    
}

extension MainViewController {
    func startAnimation(weather: WeatherValue) {
        animationHelper?.stopAllAnimation()
        switch weather {
        case .clear:
            UIView.animate(withDuration: 1, delay: 0) {
                self.view.backgroundColor = .skyBlue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.animationHelper?.animateClear()
            }
        case .cloudy:
            UIView.animate(withDuration: 1, delay: 0) {
                self.view.backgroundColor = .lightGray
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.animationHelper?.animeteClouds()
            }
        case .rain:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.animationHelper?.animateRain()
            }
            UIView.animate(withDuration: 1, delay: 0) {
                self.view.backgroundColor = .darkGray
            }
        case .snow:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.animationHelper?.animateSnow()
            }
            UIView.animate(withDuration: 1, delay: 0) {
                self.view.backgroundColor = .darkGray
            }
        }
    }
}

