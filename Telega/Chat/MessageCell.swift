//
//  MessageCell.swift
//  Telega
//
//  Created by Vladimir Fibe on 04.07.2022.
//

import UIKit
import SnapKit

class MessageCell: UICollectionViewCell {
  static var reuseIdentifier: String = "MessageCell"
  let title: UILabel = {
    $0.font = .commissioner12()
    $0.textColor = .black
    return $0
  }(UILabel())

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.layer.cornerRadius = 16
    contentView.clipsToBounds = true
    contentView.backgroundColor = #colorLiteral(red: 0.9623864293, green: 0.9687970281, blue: 0.9719694257, alpha: 1)
    contentView.addSubview(title)
    setupConstraints()
  }
  
  func setupConstraints() {
    title.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(9)
      $0.leading.trailing.equalToSuperview().inset(12)
      
    }
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with reaction: Reaction) {
    title.text = reaction.title
  }
}
