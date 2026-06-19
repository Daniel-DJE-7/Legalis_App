//
//  WelcomeView.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 29/4/26.
//

import UIKit
import AVFoundation

protocol welcomeViewDelegate: AnyObject {
  func clientSignUp()
  func lawyerSignUp()
}

class WelcomeView: UIView {
  
  var welcomePlayerLayer: AVPlayerLayer?
  
  weak var delegate: welcomeViewDelegate?
  
  //MARK: - UI HEADER LOGO ElEMENT
  private let imageLogo: UIImageView = {
      let image = UIImageView()
      image.image = UIImage(named: "legalisLogo")
      image.contentMode = .scaleAspectFit
      image.translatesAutoresizingMaskIntoConstraints = false
      image.widthAnchor.constraint(equalToConstant: 140).isActive = true
      image.heightAnchor.constraint(equalToConstant: 140).isActive = true
      return image
  }()
  
  //MARK: - UI WELCOME MESSAGE
  private let welcomeLabel: UILabel = {
      let label = UILabel()
      label.text = "Selecciona tu usuario"
    label.textColor = .systemBackground
      label.font = UIFont(name: "Inter", size: 30)
    label.font = .systemFont(ofSize: 30, weight: .heavy)
      label.textAlignment = .center
      label.numberOfLines = 0
      return label
  }()
  
  private let message: UILabel = {
      let label = UILabel()
      label.text = "Para ofrecerte la mejor experiencia legal personalizada."
      label.textColor = .systemBackground
      label.font = .systemFont(ofSize: 15, weight: .regular)
      label.font = UIFont(name: "Inter", size: 15)
      label.textAlignment = .left
      label.numberOfLines = 0
      return label
  }()
  
  lazy var lawyerButton: UIButton = {
      var config = UIButton.Configuration.filled()
    
      config.title = "Abogado"
      
    //transformamos el titulo en tamaño 17 con semibold
      config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
        var outgoing = incoming
        outgoing.font = .systemFont(ofSize: 17, weight: .semibold)
            return outgoing
          }
      
      config.image = UIImage(named: "work_work_symbol")
      config.imagePlacement = .leading
      config.imagePadding = 30
      config.baseForegroundColor = .white
      config.baseBackgroundColor = UIColor.systemGray.withAlphaComponent(0.9)

    //subtitulo del boton
      var subtitle = AttributedString("Quiero gestionar mis casos")
      let size: CGFloat = 13
          subtitle.foregroundColor = .white
          subtitle.font = UIFont(name: "Inter", size: size)
          subtitle.font = .systemFont(ofSize: size, weight: .regular)
    //agregamos el subtitulo al boton
      config.attributedSubtitle = subtitle
    
    //configuramos constraints dentro del boton
      config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 12)
    
    //creamos el boton
      let button = UIButton(configuration: config)
      button.translatesAutoresizingMaskIntoConstraints = false
      
          // agregamos la flecha como subvista
          let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
          arrow.tintColor = .lightGray
          arrow.translatesAutoresizingMaskIntoConstraints = false
          //agreamos como subvista la flecha al boton
          button.addSubview(arrow)
          
          NSLayoutConstraint.activate([
              arrow.centerYAnchor.constraint(equalTo: button.centerYAnchor),
              arrow.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12)
          ])
          
          button.contentHorizontalAlignment = .leading
          button.addTarget(self, action: #selector(lawyersSignUp), for: .touchUpInside)
      return button
  }()
  
  lazy var clientButton: UIButton = {
    var config = UIButton.Configuration.filled()
    
      config.title = "Cliente"
      
    //transformamos el titulo en tamaño 17 con semibold
      config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
        var outgoing = incoming
        outgoing.font = .systemFont(ofSize: 17, weight: .semibold)
            return outgoing
          }
      
      config.image = UIImage(systemName: "person")
      config.imagePlacement = .leading
      config.imagePadding = 30
      config.baseForegroundColor = .white
      //config.baseBackgroundColor = UIColor.systemGray.withAlphaComponent(0.8)
      config.baseBackgroundColor = #colorLiteral(red: 0.07146114336, green: 0.1429360474, blue: 0.2692385255, alpha: 1)

    //subtitulo del boton
      var subtitle = AttributedString("Busco asesoría profesional")
      let size: CGFloat = 13
          subtitle.foregroundColor = .systemGray3
          subtitle.font = UIFont(name: "Inter", size: size)
          subtitle.font = .systemFont(ofSize: size, weight: .regular)
    //agregamos el subtitulo al boton
      config.attributedSubtitle = subtitle
    
    //configuramos constraints dentro del boton
      config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 12)
    
    //creamos el boton
      let button = UIButton(configuration: config)
      button.translatesAutoresizingMaskIntoConstraints = false
      
          // agregamos la flecha como subvista
          let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
          arrow.tintColor = .lightGray
          arrow.translatesAutoresizingMaskIntoConstraints = false
          //agreamos como subvista la flecha al boton
          button.addSubview(arrow)
          
          NSLayoutConstraint.activate([
              arrow.centerYAnchor.constraint(equalTo: button.centerYAnchor),
              arrow.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12)
          ])
          
          button.contentHorizontalAlignment = .leading
          button.layer.cornerRadius = 10
          button.backgroundColor = #colorLiteral(red: 0.07146114336, green: 0.1429360474, blue: 0.2692385255, alpha: 1)
    
          button.addTarget(self, action: #selector(clientsSingUp), for: .touchUpInside)
      return button
  }()
  
  
  //MARK: - Section footer UI Elements
    let confidentialLabel: UILabel = {
      let label = UILabel()
      label.text = "CONFIDENCIAL"
      label.textColor = .lightGray
      label.font = UIFont(name: "Inter-Regular", size: 11)
      return label
    }()
  
    let secureLabel: UILabel = {
      let label = UILabel()
      label.text = "SEGURO"
      label.textColor = .lightGray
      label.font = UIFont(name: "Inter-Regular", size: 11)
      return label
    }()
  
    let professionalLabel: UILabel = {
      let label = UILabel()
      label.text = "PROFESIONAL"
      label.textColor = .lightGray
      label.font = UIFont(name: "Inter-Regular", size: 11)
      return label
    }()
  
  
    override init(frame: CGRect) {
        super.init(frame: frame)

      backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.1429360474, blue: 0.2692385255, alpha: 1)
      setUpVideoBackground()
      setupUI()
    }
  
  private func setupUI() {

      // MESSAGE
      let messageStack = UIStackView(arrangedSubviews: [
        welcomeLabel,
        message,
      ])
      messageStack.axis = .vertical
      messageStack.alignment = .center
      messageStack.spacing = 3
      
      // BUTTONS
      let buttonsStack = UIStackView(arrangedSubviews: [
          clientButton,
          lawyerButton
      ])
      buttonsStack.axis = .vertical
      buttonsStack.spacing = 18
      buttonsStack.alignment = .center
      
      //FOOTER
      let footerStack = UIStackView(arrangedSubviews: [
        confidentialLabel, secureLabel, professionalLabel
      ])
      footerStack.axis = .horizontal
      footerStack.spacing = 20
      footerStack.alignment = .center
      footerStack.distribution = .equalSpacing
      footerStack.translatesAutoresizingMaskIntoConstraints = false
      
      // GLOBAL
      let globalStack = UIStackView(arrangedSubviews: [
        messageStack,
        buttonsStack
      ])

      globalStack.axis = .vertical
      globalStack.spacing = 40
      globalStack.alignment = .center
      globalStack.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.1)
      
      addSubview(imageLogo)
      addSubview(globalStack)
      addSubview(footerStack)

      globalStack.translatesAutoresizingMaskIntoConstraints = false

      NSLayoutConstraint.activate([
        //logo
        imageLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
        imageLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
        //buttons
        clientButton.widthAnchor.constraint(equalToConstant: 350),
        clientButton.heightAnchor.constraint(equalToConstant: 98),
        lawyerButton.widthAnchor.constraint(equalToConstant: 350),
        lawyerButton.heightAnchor.constraint(equalToConstant: 98),
        //globalStacVIew
        globalStack.centerYAnchor.constraint(equalTo: centerYAnchor),
        globalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        globalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        //footerStackView
        footerStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        footerStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        
      ])
  }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
  
    @objc
    func clientsSingUp() {
      print("Hello client")
      delegate?.clientSignUp()
    }
  
  @objc
  func lawyersSignUp() {
    print("Hello lawyer")
    delegate?.lawyerSignUp()
  }
  
  //MARK: - Welcome video player
  private func setUpVideoBackground() {
    
    guard let path = Bundle.main.path(forResource: "welcomeVideo", ofType: "mp4") else { return }
    let player = AVPlayer(url: URL(fileURLWithPath: path))
    
    let layer = AVPlayerLayer(player: player)
    layer.videoGravity = .resizeAspectFill
    layer.frame = bounds
    //ponemos el video como background
    self.layer.insertSublayer(layer, at: 0)
    self.welcomePlayerLayer = layer
    player.volume = 0
    
    player.play()
  
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    welcomePlayerLayer?.frame = bounds
  }
}


