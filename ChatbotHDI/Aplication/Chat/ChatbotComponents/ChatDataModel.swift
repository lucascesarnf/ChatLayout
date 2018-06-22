//
//  ChatDataModel.swift
//  ChatbotHDI
//
//  Created by Lucas César  Nogueira Fonseca on 21/06/2018.
//  Copyright © 2018 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation


enum BalloonMessageState {
    case left
    case right
}

enum ChatCellType: String {
    case balloon = "MessageBalloonCell"
    case leftBalloon = "LeftMessageBalloonCell"
    case rightBalloon = "RightMessageBalloonCell"
    case loader = "LoaderCell"
    case oneButton = "OneButtonCell"
    case twoButtons = "TwoButtonsCell"
    case search = "SearchCell"
}

struct ChatDataModel {
    var cellType:ChatCellType?
    var cellModel:ChatCellDataModel?
}

struct ChatCellDataModel {
    var messageText:String?
    var messageState: BalloonMessageState?
    var buttonOneText:String?
    var buttonTwoText:String?
}
