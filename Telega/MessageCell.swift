//
//  MessageCell.swift
//  Telega
//
//  Created by Vladimir Fibe on 04.07.2022.
//

import UIKit

class MessageCell: UICollectionViewCell, SelfConfiguringMessage {
  static var reuseIdentifier: String = "MessageCell"
  let title = UILabel()
  let label = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    title.translatesAutoresizingMaskIntoConstraints = false
    label.layer.cornerRadius = 16
    label.clipsToBounds = true
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = .systemGray6
    contentView.addSubview(label)
    label.addSubview(title)
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: contentView.topAnchor),
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: label.topAnchor, constant: 10),
      title.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 10),
      title.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: -10),
      title.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -10)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with reaction: Reaction) {
    title.text = reaction.title
  }
}
