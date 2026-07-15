//
//  ChatViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 13/7/26.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Message: MessageType {
  var sender: MessageKit.SenderType
  var messageId: String
  var sentDate: Date
  var kind: MessageKit.MessageKind
}

struct Sender: SenderType {
  var senderId: String
  var displayName: String
}

class ChatViewController: MessagesViewController {

  private var messages: [Message] = []
  
  private let selfSender = Sender(senderId: "1", displayName: "Joe Smith")
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .systemGray6
      
      messages.append(
        Message(
        sender: selfSender,
        messageId: "1",
        sentDate: Date(),
        kind: .text("Hello"))
      )
      
      messages.append(
        Message(
        sender: selfSender,
        messageId: "1",
        sentDate: Date(),
        kind: .text("Hello world message. Hello world message. Hello world message Hello world message"))
      )
      
      delegatesAndDataSources()

      DispatchQueue.main.async {
        self.messagesCollectionView.reloadData()
      }
    }
    
  
//  override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    messagesCollectionView.reloadData()
//    messagesCollectionView.scrollToLastItem()
//  }
  private func delegatesAndDataSources() {
    messagesCollectionView.messagesDataSource = self
    messagesCollectionView.messagesLayoutDelegate = self
    messagesCollectionView.messagesDisplayDelegate = self
    
  }
 

}

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
  
  var currentSender: MessageKit.SenderType {
    return selfSender
  }
  
  func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
    
    return messages.count
  }
  
  func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
    
    return messages[indexPath.section]
  }
  
  
  func messageTopLabelHeight(
      for message: MessageType,
      at indexPath: IndexPath,
      in messagesCollectionView: MessagesCollectionView
  ) -> CGFloat {
      return 0
  }
  
}
