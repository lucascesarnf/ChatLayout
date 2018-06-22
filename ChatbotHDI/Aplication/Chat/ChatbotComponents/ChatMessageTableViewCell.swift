//
//  ChatMessageTableViewCell.swift
//  ChatbotHDI
//
//  Created by Lucas César  Nogueira Fonseca on 21/06/2018.
//  Copyright © 2018 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

class ChatMessageTableViewCell: GenericChatTableViewCell {
    
    @IBOutlet weak var leadingBalloonConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingBalloonConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    /* ATENTION
    The 'imageDeslocation' variable have to be the sum of the image cell widht and the spaces btween image and text.
    on this case: 40(image widht) + 10(image trailing) + 10 (image leading) + 15(text spaces)
    If you will change the constrainst remember to update this values:
    */
     private var imageDeslocation:CGFloat = 0
    
    private var currentState: BalloonMessageState?
    
    @IBOutlet weak var perfilImage: UIImageView!
    
    override func configureCell() {
        imageDeslocation = perfilImage.frame.width + leadingBalloonConstraint.constant + trailingBalloonConstraint.constant + 15 //this 15 constant is to make the margins spaces
        messageLabel.text = cellModel?.messageText
        if let state = cellModel?.messageState {
            setBalloonState(state)
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
}
