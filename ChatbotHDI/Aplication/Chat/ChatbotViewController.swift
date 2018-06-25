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
    
    @IBOutlet weak var tableView: UITableView!
    var hasIteraction = false
    
    let chatCells:[ChatDataModel] = [
        ChatDataModel(cellType: .leftBalloon, cellModel:
            ChatCellDataModel(messageText:"Olá, em que posso ajudar ?",messageState:.left,buttonOneText:nil,buttonTwoText: nil)),
        ChatDataModel(cellType: .rightBalloon , cellModel:
            ChatCellDataModel(messageText:"Me f@#&* muito aqui!",messageState:.right,buttonOneText:nil,buttonTwoText: nil)),
        ChatDataModel(cellType: .leftBalloon , cellModel:
            ChatCellDataModel(messageText:"Posso eu, mero mortal saber o que aconteceu com o excelentíssimo senhor fulano siclano beutramo marciano da silva?",messageState:.left,buttonOneText:nil,buttonTwoText: nil)),
        ChatDataModel(cellType: .rightBalloon , cellModel:
            ChatCellDataModel(messageText:nil,messageState:.right,buttonOneText:nil,buttonTwoText: nil))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // change 2 to desired number of seconds
            var model = self.chatCells[self.chatCells.count - 1]
            model.cellModel?.messageText = "Posso eu, mero mortal saber o que aconteceu com o excelentíssimo senhor fulano siclano beutramo marciano da silva?"
            self.tableView.reloadData()
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
        cell.configureCell()
        return cell
    }
    
}
