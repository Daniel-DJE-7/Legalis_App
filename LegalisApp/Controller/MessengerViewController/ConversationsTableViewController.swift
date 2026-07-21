//
//  ChatsCollectionViewController.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 10/6/26.
//

import UIKit


class ConversationsTableViewController: UIViewController {

  fileprivate let searchBarController = UISearchController(searchResultsController: nil)
  
  private let conversationsTableView: UITableView = {
    let table = UITableView()
    table.isHidden = true
    table.showsVerticalScrollIndicator = false
    table.register(ConversationsTableViewCell.self, forCellReuseIdentifier: ConversationsTableViewCell.identifier)
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()
  
  private let noConversationsLabel: UILabel = {
    let label = UILabel()
    label.text = "No hay ninguna conversación"
    label.textColor = .gray
    label.textAlignment = .center
    label.font = UIFont(name: "Inter-Regular_Medium", size: 21)
    label.isHidden = true
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray6
    setUpNavBar()
    setUpSearchBar()
    view.addSubview(conversationsTableView)
    view.addSubview(noConversationsLabel)
    setUpConstraints()
    setUpTableViewDelegatesAndDataSources()
    
    fetchConversations()
  }

  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      conversationsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
      conversationsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      conversationsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      conversationsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 24)
    ])
  }
  private func setUpTableViewDelegatesAndDataSources() {
    conversationsTableView.delegate = self
    conversationsTableView.dataSource = self
  }
  
  private func fetchConversations() {
    conversationsTableView.isHidden = false
  }
  
  //MARK: - Configuration of NAVBAR
  func setUpNavBar() {
      //MARK: - LOGO LEFT VIEW
      let logoImageNav = UIImageView(image: UIImage(named: "logoHorizontal"))
      logoImageNav.contentMode = .scaleAspectFit
      logoImageNav.translatesAutoresizingMaskIntoConstraints = false
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoImageNav)
      
      //MARK: - Bell btn
      let rightBellBtn = UIButton(type: .system)
      rightBellBtn.setImage(UIImage(named: "bellBlue"), for: .normal)
      rightBellBtn.imageView?.contentMode = .scaleAspectFit
      rightBellBtn.addTarget(self, action: #selector(onBellButtonTapped), for: .touchUpInside)
      rightBellBtn.translatesAutoresizingMaskIntoConstraints = false
      
      let bellBarBtn = UIBarButtonItem(customView: rightBellBtn)
     
      //MARK: - NEW CHAT btn
      let newChatIcon = UIButton(type: .system)
      newChatIcon.setImage(UIImage(named: "newChatIcon"), for: .normal)
      newChatIcon.imageView?.contentMode = .scaleAspectFit
      newChatIcon.addTarget(self, action: #selector((onNewChatBtnTapped)), for: .touchUpInside)
      newChatIcon.translatesAutoresizingMaskIntoConstraints = false
      
      let newChatBtn = UIBarButtonItem(customView: newChatIcon)
      
      navigationItem.rightBarButtonItems = [
        bellBarBtn,
        newChatBtn
      ]
      
      NSLayoutConstraint.activate([
        logoImageNav.widthAnchor.constraint(equalToConstant: 120),
        logoImageNav.heightAnchor.constraint(equalToConstant: 40),
        
        rightBellBtn.widthAnchor.constraint(equalToConstant: 32),
        rightBellBtn.heightAnchor.constraint(equalToConstant: 32),
        
        newChatIcon.widthAnchor.constraint(equalToConstant: 32),
        newChatIcon.heightAnchor.constraint(equalToConstant: 32)
      ])
    }

  @objc private func onBellButtonTapped() {
    print("btn is working")
  }
  
  @objc private func onNewChatBtnTapped() {
    let vc = NewConversationsViewController()
    let navVC = UINavigationController(rootViewController: vc)
    present(navVC, animated: true)
  }

}

extension ConversationsTableViewController: UISearchBarDelegate {
  
  func setUpSearchBar() {
    definesPresentationContext = true
    navigationItem.searchController = searchBarController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchBarController.searchBar.placeholder = "Buscar"
  
    searchBarController.searchBar.searchTextField.clearButtonMode = .whileEditing
    searchBarController.obscuresBackgroundDuringPresentation = false
    searchBarController.searchBar.delegate = self
  }
}

extension ConversationsTableViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ConversationsTableViewCell.identifier, for: indexPath) as? ConversationsTableViewCell else {
      return UITableViewCell()
    }
    
    cell.layer.cornerRadius = 12
    cell.layer.borderColor = #colorLiteral(red: 0.7682896852, green: 0.7757481933, blue: 0.817332685, alpha: 1)
    cell.backgroundColor = .white
    cell.layer.borderWidth = 2
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let vc = ChatViewController()
    vc.title = "Nombre de usuario"
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  
  
}
