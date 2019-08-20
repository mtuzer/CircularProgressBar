//
//  ViewController.swift
//  CircularProgressBar
//
//  Created by Mert Tuzer on 12.08.2019.
//  Copyright © 2019 Mert Tuzer. All rights reserved.
//

import UIKit

let pi = CGFloat.pi

class ViewController: UIViewController {

    let baseLayer = CAShapeLayer()
    var timer = Timer()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        // add a circular layer
        addTheLayer()
        
        // add a label to show the percentage of the progress
        addLabel()
        
        // add a tap recognizer to start the animation
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate func addTheLayer() {
        let circularPath = UIBezierPath(arcCenter: self.view.center, radius: 80, startAngle: -pi/2, endAngle: 3*pi/2, clockwise: true)
        
        baseLayer.path = circularPath.cgPath
        baseLayer.strokeColor = UIColor.blue.cgColor
        baseLayer.lineWidth = 10
        baseLayer.lineCap = .round
        baseLayer.fillColor = UIColor.clear.cgColor
        baseLayer.strokeEnd = 0
        view.layer.addSublayer(baseLayer)
    }
    
    fileprivate func addLabel() {
        view.addSubview(label)
        label.textAlignment = .center
        label.textColor = .white
        label.font = .italicSystemFont(ofSize: 30)
        label.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        label.center = self.view.center
    }
    
    @objc func handleTap() {
        handleAnimations()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        let value = self.baseLayer.presentation()?.value(forKeyPath: "strokeEnd") as! CGFloat
       
        DispatchQueue.main.async {
            self.label.text = "\( Int(value*100) ) %"
        }
    }
    
    fileprivate func handleAnimations() {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.toValue = 1
        strokeAnimation.duration = 2.5
        strokeAnimation.fillMode = .forwards
        strokeAnimation.autoreverses = true
        strokeAnimation.repeatCount = .infinity
        
        let fillAnimation = CABasicAnimation(keyPath: "fillColor")
        fillAnimation.toValue = UIColor.red.cgColor
        fillAnimation.duration = 2.5
        fillAnimation.fillMode = .forwards
        fillAnimation.autoreverses = true
        fillAnimation.repeatCount = .infinity
        
        baseLayer.add(strokeAnimation, forKey: ".")
        baseLayer.add(fillAnimation, forKey: "..")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}

