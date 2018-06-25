//
//  GenericChatTableViewCell.swift
//  ChatbotHDI
//
//  Created by Lucas César  Nogueira Fonseca on 22/06/2018.
//  Copyright © 2018 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

protocol ChatCellDelegate {
    func didChangeHeight()
}

class GenericChatTableViewCell: UITableViewCell {

    var cellModel:ChatCellDataModel?
    
    var delegate:ChatCellDelegate?
    
    func configureCell(animated:Bool? = false) {
        //This is to subClass override
    }
}
