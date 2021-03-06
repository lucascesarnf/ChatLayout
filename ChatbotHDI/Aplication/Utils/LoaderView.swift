//
//  LoaderView.swift
//  ChatbotHDI
//
//  Created by Lucas César  Nogueira Fonseca on 22/06/2018.
//  Copyright © 2018 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    
    enum AnimationState:Int {
        case one = 1
        case two
        case three
        case four
        case five
        case six
        
        var nextState:AnimationState {
            switch self {
            case .one:
                return .two
            case .two:
                return .three
            case .three:
                return .four
            case .four:
                return .five
            case .five:
                return .six
            case .six:
                return .one
                
            }
        }
    }
    
    @IBOutlet weak var circleThreeCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleTwoCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleOneCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleOne: UIView!
    
    @IBOutlet weak var circleThree: UIView!
    @IBOutlet weak var circleTwo: UIView!
    private var currentState:AnimationState = .one
    
    private var shouldAnimate = true
    private let deslocation:CGFloat = 4
    private let duration = 0.2
    
    private func loaderAnimation() {
        if  shouldAnimate {
            switch currentState {
            case .one:
                self.circleOneCenterConstraint.constant = self.deslocation
            case .two:
                self.circleOneCenterConstraint.constant = -self.deslocation
                self.circleTwoCenterConstraint.constant = self.deslocation
            case .three:
                self.circleOneCenterConstraint.constant = 0
                self.circleTwoCenterConstraint.constant = -self.deslocation
                self.circleThreeCenterConstraint.constant = self.deslocation
            case .four:
                self.circleTwoCenterConstraint.constant = 0
                self.circleThreeCenterConstraint.constant = -self.deslocation
            case .five:
                self.circleThreeCenterConstraint.constant = 0
            case .six:
                segueToNextStateAnimation()
            }
            if currentState != .six {
                UIView.animate(withDuration: self.duration,delay: currentState == .one ? duration : 0, animations: {
                    self.layoutIfNeeded()
                }) { completion in
                    if completion {
                        self.segueToNextStateAnimation()
                    }
                }
            }
        }
    }
    
    private func segueToNextStateAnimation() {
        //This is to take sure that the recursive calls will be executed on main thread
        DispatchQueue.main.async(execute: { () -> Void in
            self.currentState = self.currentState.nextState
            self.loaderAnimation()
        })
    }
    
    func startAnimation() {
        shouldAnimate = true
        loaderAnimation()
    }
    
    func stopAnimation() {
        shouldAnimate = false
    }
}
