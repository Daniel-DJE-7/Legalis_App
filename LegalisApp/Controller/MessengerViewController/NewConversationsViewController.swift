//
//  NewConversationsViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 13/7/26.
//

import UIKit

class NewConversationsViewController: UIViewController {
  
  private let searchBar: UISearchBar = {
    let sB = UISearchBar()
    sB.placeholder = "Buscar contacto"
    return sB
  }()
  
  private let contactsTableView: UITableView = {
    let table = UITableView()
    table.isHidden = true
    table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    return table
  }()
  
  private let notResultsLabel: UILabel = {
    let label = UILabel()
    label.isHidden = true
    label.text = "No hay resultados"
    label.font = UIFont(name: "Inter-Regular_Medium", size: 21)
    return label
  }()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      searchBar.delegate = self
      view.backgroundColor = .systemGray6
      
      
      setUpNavigationBar()
      searchBar.becomeFirstResponder()
      
    }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    contactsTableView.frame = view.bounds
  }
    
  private func setUpNavigationBar() {
    navigationItem.titleView = searchBar
    //Back Btn
    let backBtnIcon = UIImage(named: "closeSymbol")
    
    let backBtn = UIBarButtonItem(image: backBtnIcon,
                                  style: .plain,
                                  target: self,
                                  action: #selector(backBtnTapped))
   
    backBtn.tintColor = UIColor(
      red: 0,
      green: 0.1063321754,
      blue: 0.2393084168,
      alpha: 1)
   
    navigationItem.rightBarButtonItem = backBtn
  }

  @objc func backBtnTapped() {
    navigationController?.dismiss(animated: true)
    
  }
  

}

extension NewConversationsViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    
    
  }
  
  
}
