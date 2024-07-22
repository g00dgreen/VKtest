//
//  AnimationHelper.swift
//  VKtest
//
//  Created by Артем Макар on 22.07.24.
//

import Foundation
import UIKit

struct AnimationHelper {
    
    var mainView: UIView
    var clouds: [UIImageView] = []
    var sunArray: [UIImageView] = []
    private var currentLayer: CAEmitterLayer?
    
    init(mainView: UIView) {
        self.mainView = mainView
    }
    
    mutating func animateSnow() {
        currentLayer = CAEmitterLayer()
        guard let currentLayer = currentLayer else { return }
        currentLayer.emitterPosition = CGPoint(x: mainView.frame.width / 2, y: -15)
        currentLayer.emitterSize = CGSize(width: mainView.frame.width, height: 0)
        currentLayer.beginTime = CACurrentMediaTime()
        currentLayer.emitterShape = .line
        currentLayer.timeOffset = 0
        
        let snowDrop = CAEmitterCell()
        snowDrop.contents = UIImage(named: "snow")?.cgImage
        snowDrop.emissionRange = .pi/2
        snowDrop.lifetime = 20.0
        snowDrop.birthRate = 30
        snowDrop.scale = 0.005
        snowDrop.scaleRange = 0.005
        snowDrop.velocity = 80
        snowDrop.velocityRange = 20
        snowDrop.spin = -0.5
        snowDrop.spinRange = 1.0
        snowDrop.yAcceleration = 30.0
        snowDrop.xAcceleration = 5.0
        
        let bigSnowDrop = CAEmitterCell()
        bigSnowDrop.contents = UIImage(named: "snow")?.cgImage
        bigSnowDrop.emissionRange = .pi/2
        bigSnowDrop.lifetime = 20.0
        bigSnowDrop.birthRate = 30
        bigSnowDrop.scale = 0.015
        bigSnowDrop.scaleRange = 0.01
        bigSnowDrop.velocity = 40
        bigSnowDrop.velocityRange = 20
        bigSnowDrop.spin = -0.5
        bigSnowDrop.spinRange = 1.0
        bigSnowDrop.yAcceleration = 30.0
        bigSnowDrop.xAcceleration = 5.0
        
        currentLayer.emitterCells = [snowDrop, bigSnowDrop]
        mainView.layer.addSublayer(currentLayer)
    }
    
    mutating func animateRain() {
        currentLayer = CAEmitterLayer()
        guard let currentLayer = currentLayer else { return }
        currentLayer.emitterPosition = CGPoint(x: mainView.frame.width / 2, y: -10)
        currentLayer.emitterSize = CGSize(width: mainView.frame.width, height: 0)
        currentLayer.beginTime = CACurrentMediaTime()
        currentLayer.emitterShape = .line
        currentLayer.timeOffset = 0
        
        let rain = CAEmitterCell()
        rain.contents = UIImage(named: "rain")?.cgImage
        rain.emissionRange = 0
        rain.lifetime = 1
        rain.birthRate = 50
        rain.scale = 0.02
        rain.scaleRange = 0.01
        rain.velocity = 100
        rain.velocityRange = 20
        rain.yAcceleration = 5000
        
        currentLayer.emitterCells = [rain]
        mainView.layer.addSublayer(currentLayer)
    }
    
    mutating func animeteClouds() {
        for _ in 0..<16 {
            let cloudView =  createImageView(named: "cloud")
            cloudView.frame.origin.x = -cloudView.frame.width-50 + CGFloat(Int.random(in: -500...500))
            cloudView.frame.origin.y = mainView.frame.height * 0.25 + CGFloat(Int.random(in: 0...1000))
            mainView.addSubview(cloudView)
            clouds.append(cloudView)
            animateCloud(cloudView, toX: mainView.frame.width + 50)
        }
        
        for _ in 0..<16 {
            let cloudView =  createImageView(named: "cloud")
            cloudView.frame.origin.x = mainView.frame.width+50 + CGFloat(Int.random(in: -500...500))
            cloudView.frame.origin.y = mainView.frame.height * 0.25 + CGFloat(Int.random(in: 0...1000))
            mainView.addSubview(cloudView)
            clouds.append(cloudView)
            animateCloud(cloudView, toX: -mainView.frame.width - 50 )
        }
        
        for _ in 0..<30 {
            let cloudView =  createImageView(named: "cloud")
            cloudView.frame.origin.x = mainView.frame.width+50 + CGFloat(Int.random(in: -500...500))
            cloudView.frame.origin.y = mainView.frame.height * 0.25 + CGFloat(Int.random(in: 0...1000))
            mainView.addSubview(cloudView)
            clouds.append(cloudView)
            animateCloud(cloudView, toX: mainView.frame.width/2 + CGFloat(Int.random(in: -200...200)))
        }
    }
    
    mutating func animateClear() {
        
        for _ in 0...1 {
            let sunView = createImageView(named: "sun")
            sunView.frame = CGRect(x: mainView.frame.origin.x, y: mainView.frame.origin.y, width: 200, height: 200)
            sunView.center.x = mainView.center.x
            sunView.center.y = mainView.center.y
            mainView.addSubview(sunView)
            sunArray.append(sunView)
            
            UIView.animate(withDuration: TimeInterval(6 + Int.random(in: -2...2)), delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse]) {
                sunView.transform = CGAffineTransform(rotationAngle: 180)
            }
        }
    }
    
    mutating func stopAllAnimation() {
        stopAnimateClouds()
        stopAnimateDrops()
        stopAnimeSun()
    }
    
    private func stopAnimeSun() {
        for sun in sunArray {
            UIView.animate(withDuration: 1.0,  animations: {
                sun.center.x = mainView.center.x * 2 + 100
            }, completion: { _ in
                sun.removeFromSuperview()
            })
        }
    }
    
    private func animateCloud(_ cloudView: UIImageView, toX x: CGFloat) {
        UIView.animate(withDuration: TimeInterval(6 + Int.random(in: -2...2)), delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            cloudView.frame.origin.x = x + CGFloat(Int.random(in: -50...50))
        }, completion: nil)
    }
    
    private func stopAnimateClouds(){
        for cloudView in clouds {
            UIView.animate(withDuration: 1.0, delay: 0,  animations: {
                if cloudView.frame.origin.x < mainView.frame.width / 2 {
                    cloudView.frame.origin.x = -cloudView.frame.width - 100
                } else {
                    cloudView.frame.origin.x = mainView.frame.width + 100
                }
            }, completion: { _ in
                cloudView.removeFromSuperview()
            })
        }
    }
    
    private mutating func stopAnimateDrops() {
        guard let currentLayer = currentLayer else { return }
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            currentLayer.removeFromSuperlayer()
        }
        let fadeAnimation = CABasicAnimation(keyPath: "")
        fadeAnimation.fromValue = currentLayer.opacity
        fadeAnimation.toValue = 0.0
        fadeAnimation.duration = 1.0
        currentLayer.add(fadeAnimation, forKey: "")
        CATransaction.commit()
    }
    
    private func createImageView(named: String) -> UIImageView {
        let cloudView = UIImageView(image: UIImage(named: named))
        cloudView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        cloudView.contentMode = .scaleAspectFill
        return cloudView
    }
}
