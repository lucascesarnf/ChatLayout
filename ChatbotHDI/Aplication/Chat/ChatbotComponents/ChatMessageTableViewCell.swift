//
//  ChatMessageTableViewCell.swift
//  ChatbotHDI
//
//  Created by Lucas César  Nogueira Fonseca on 21/06/2018.
//  Copyright © 2018 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

protocol ChatMessageCellDelegate {
    func didSetMessage(text: String)
}

class ChatMessageTableViewCell: LoaderTableViewCell {
    
    @IBOutlet weak var leadingBalloonConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingBalloonConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    private var imageDeslocation:CGFloat = 0
    
    private var currentState: BalloonMessageState?
    
    @IBOutlet weak var perfilImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("You Call me")
    }
    
    override func configureCell() {
        loaderView.alpha = 0
        imageDeslocation = perfilImage.frame.width + leadingBalloonConstraint.constant + trailingBalloonConstraint.constant + 15 //this 15 constant is to make the margins spaces
        if let state = cellModel?.messageState, let text = cellModel?.messageText {
            messageLabel.text = text
            setBalloonState(state)
        } else {
            startLoaderAnimation()
        }
    }
    
    func setBalloonState(_ state: BalloonMessageState) {
        currentState = state
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
        super.startLoaderAnimation()
    }
    
    override func stopLoaderAnimation() {
        super.stopLoaderAnimation()
        if let state = cellModel?.messageState {
            setBalloonState(state)
            UIView.animate(withDuration: 0.8, delay: 0.2, animations: {
                self.loaderView.bounds = self.messageView.frame
            }) { completion in
                self.messageView.alpha = 1
                UIView.animate(withDuration: 0.5, animations: {
                    self.loaderView.alpha = 0
                }, completion: nil)
            }
        }
    }
}

extension ChatMessageTableViewCell: ChatMessageCellDelegate {
    func didSetMessage(text: String) {
        cellModel?.messageText = text
        stopLoaderAnimation()
    }
}
