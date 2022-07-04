//
//  MessageHeaderView.swift
//  Telega
//
//  Created by Vladimir Fibe on 04.07.2022.
//

import UIKit

class MessageHeaderView: UICollectionReusableView {
   static let reuseIdentifier = "MessageHeader"
  let content = UILabel()
  override init(frame: CGRect) {
    super.init(frame: frame)
    let separator = UIView(frame: .zero)
    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.backgroundColor = .quaternaryLabel
    content.numberOfLines = 0
    
    
    let stackView = UIStackView(arrangedSubviews: [separator, content])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    addSubview(stackView)
    NSLayoutConstraint.activate([
      separator.heightAnchor.constraint(equalToConstant: 1),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
