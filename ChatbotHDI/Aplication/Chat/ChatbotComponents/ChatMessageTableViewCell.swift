//
//  ChatMessageTableViewCell.swift
//  ChatbotHDI
//
//  Created by Lucas César  Nogueira Fonseca on 21/06/2018.
//  Copyright © 2018 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

class ChatMessageTableViewCell: LoaderTableViewCell {
    
    @IBOutlet weak var leadingBalloonConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingBalloonConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageHeightConstraint: NSLayoutConstraint!
    
    private var imageDeslocation:CGFloat = 0
    private var isAlreadyConfigured = false
    private var isLoading = false
    
    private var currentState: BalloonMessageState?
    
    @IBOutlet weak var perfilImage: UIImageView!
    
    override func configureCell(animated:Bool? = false) {
        loaderView.alpha = 0
        if let state = cellModel?.messageState {
            configureBalloonState(state, animated)
        }
    }
    
    private func configureBalloonState(_ state: BalloonMessageState,_ animated:Bool? = false) {
        currentState = state
        
        if isAlreadyConfigured {
            if isLoading {
                    stopLoaderAnimation()
            }
        } else {
            if let shouldLoad = cellModel?.shouldLoad, shouldLoad {
                startLoaderAnimation()
            } else {
                messageLabel.numberOfLines = 0
                messageLabel.text = cellModel?.messageText
                //this 15 constant is to make the margins spaces
                imageDeslocation = perfilImage.frame.width + leadingBalloonConstraint.constant + trailingBalloonConstraint.constant + 15
                let duration:CGFloat
                UIView.animate(withDuration:0.2) {
                    self.setCellBalloonState(state)
                }
            }
        }
        isAlreadyConfigured = true
    }
    
    private func setCellBalloonState(_ state: BalloonMessageState) {
        switch state {
        case .left:
            messageView.backgroundColor = UIColor(displayP3Red: 232/255.0, green: 232/255.0, blue: 232/255.0, alpha: 1)
            let balloonSize = self.frame.width - (messageLabel.intrinsicContentSize.width + leadingBalloonConstraint.constant + trailingBalloonConstraint.constant + imageDeslocation)
            let constant = balloonSize > 30 ? balloonSize : 30
            trailingBalloonConstraint.constant =  constant
            messageLabel.textColor = .black
            
        case .right:
            messageView.backgroundColor = UIColor(displayP3Red: 64/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1)
            let balloonSize = self.frame.width - (messageLabel.intrinsicContentSize.width + leadingBalloonConstraint.constant + trailingBalloonConstraint.constant + imageDeslocation)
            let constant = balloonSize > 30 ? balloonSize : 30
            leadingBalloonConstraint.constant = constant
            messageLabel.textColor = .white
        }
    }
    
    override func startLoaderAnimation() {
        messageView.alpha = 0
        loaderView.alpha = 1
        isLoading = true
        super.startLoaderAnimation()
    }
    
    override func stopLoaderAnimation(completion: ((_ result:Bool) -> Void)? = nil) {
        isLoading = false
        super.stopLoaderAnimation() { finish in
            if finish {
                if let state = self.cellModel?.messageState {
                    self.isAlreadyConfigured = false
                    self.configureBalloonState(state)
                    self.layoutIfNeeded()
                    UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                        self.loaderWidthConstraint.constant = self.messageView.frame.width
                        self.layoutIfNeeded()
                    }) { _ in
                        self.delegate?.didChangeHeight()
                    }
                }
            }
        }
    }
}
