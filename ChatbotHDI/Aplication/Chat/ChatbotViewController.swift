//
//  ChatbotViewController.swift
//  ChatbotHDI
//
//  Created by Lucas César  Nogueira Fonseca on 21/06/2018.
//  Copyright © 2018 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

enum ChatTableViewCells {
    case messageBalloonCell
}

class ChatbotViewController: UIViewController {
    
    var height: CGFloat?
    
    @IBOutlet weak var tableView: UITableView!
    var hasIteraction = false
    
    var chatCells:[ChatDataModel] = [
        ChatDataModel(cellType: .leftBalloon, cellModel:
            ChatCellDataModel(messageText:"Olá, em que posso ajudar ?",messageState:.left,buttonOneText:nil,buttonTwoText: nil,shouldLoad:false)),
        ChatDataModel(cellType: .rightBalloon , cellModel:
            ChatCellDataModel(messageText:"Me f@#&* muito aqui!",messageState:.right,buttonOneText:nil,buttonTwoText: nil,shouldLoad:false)),
        ChatDataModel(cellType: .leftBalloon , cellModel:
            ChatCellDataModel(messageText:"Posso eu, mero mortal saber o que aconteceu com o excelentíssimo senhor fulano siclano beutramo marciano da silva?",messageState:.left,buttonOneText:nil,buttonTwoText: nil,shouldLoad:false)),
        ChatDataModel(cellType: .leftBalloon , cellModel:
            ChatCellDataModel(messageText:nil,messageState:.left,buttonOneText:nil,buttonTwoText: nil,shouldLoad:true))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // change 2 to desired number of seconds
            //Remember of make a func for this
            var model = self.chatCells[self.chatCells.count - 1]
            model.cellModel?.messageText = "Posso eu, mero mortal "
            model.cellModel?.shouldLoad = false
            self.chatCells[self.chatCells.count - 1] = model
           self.height = 100
            self.tableView.reloadData()
            self.height = nil
        }
    }
}

extension ChatbotViewController: UITableViewDelegate {
    
}

extension ChatbotViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = chatCells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:model.cellType?.rawValue ?? "MessageBalloonCell") as! GenericChatTableViewCell
        cell.cellModel = model.cellModel
        cell.delegate = self
        
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == chatCells.count - 1 {
            
            return height ?? UITableViewAutomaticDimension
        } else {
            return UITableViewAutomaticDimension
        }
    }
}

extension ChatbotViewController:ChatCellDelegate {
    func didChangeHeight() {
        let lastSectionIndex = self.tableView.numberOfSections - 1 // last section
        let lastRowIndex = self.tableView.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        let indexPath = IndexPath(row: lastRowIndex, section: lastSectionIndex)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.tableView.scrollToLastCell(animated : true)
    }
}

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
    
    func scrollToLastCell(animated : Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
