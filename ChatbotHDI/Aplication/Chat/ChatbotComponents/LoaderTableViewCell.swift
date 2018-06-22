//
//  LoaderTableViewCell.swift
//  ChatbotHDI
//
//  Created by Lucas César  Nogueira Fonseca on 22/06/2018.
//  Copyright © 2018 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

class LoaderTableViewCell: GenericChatTableViewCell {
    
    
    @IBOutlet weak var circleThreeCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleTwoCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleOneCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleOne: UIView!
    
    @IBOutlet weak var circleThree: UIView!
    @IBOutlet weak var circleTwo: UIView!
    
    private var shouldAnimate = true
    private let deslocation:CGFloat = 4
    private let duration = 0.2
    
    override func configureCell() {
        startAnimation()
    }
    
   private func loaderAnimation() {
        if  shouldAnimate {
            UIView.animate(withDuration: duration,delay: duration,animations: {
                self.circleOneCenterConstraint.constant = self.deslocation
                self.layoutIfNeeded()
            }) { completion in
                if completion {
                    UIView.animate(withDuration:self.duration, animations: {
                        self.circleOneCenterConstraint.constant = -self.deslocation
                        self.circleTwoCenterConstraint.constant = self.deslocation
                        self.layoutIfNeeded()
                    }) { completion in
                        if completion {
                            UIView.animate(withDuration: self.duration, animations: {
                                self.circleOneCenterConstraint.constant = 0
                                self.circleTwoCenterConstraint.constant = -self.deslocation
                                self.circleThreeCenterConstraint.constant = self.deslocation
                                self.layoutIfNeeded()
                            }) { completion in
                                if completion {
                                    UIView.animate(withDuration: self.duration, animations: {
                                         self.circleTwoCenterConstraint.constant = 0
                                        self.circleThreeCenterConstraint.constant = -self.deslocation
                                        self.layoutIfNeeded()
                                    }) { completion in
                                        if completion {
                                            UIView.animate(withDuration: self.duration, animations: {
                                                self.circleThreeCenterConstraint.constant = 0
                                                self.layoutIfNeeded()
                                            }) { completion in
                                                if completion {
                                                    self.loaderAnimation()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func startAnimation() {
        shouldAnimate = true
        loaderAnimation()
    }
    
    func stopAnimation() {
        shouldAnimate = false
    }
}
