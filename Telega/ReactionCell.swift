//
//  ReactionCell.swift
//  Telega
//
//  Created by Vladimir Fibe on 28.06.2022.
//

import UIKit
import SnapKit

class ReactionCell: UICollectionViewCell {
  static let identifier = "ReactionCell"
  static let height = 30.0
  
  let labelText: UILabel = {
    $0.font = .systemFont(ofSize: 12)
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(UILabel())

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    layer.cornerRadius = Self.height / 2
    layer.masksToBounds = true
    layer.borderColor = UIColor.white.cgColor
    layer.borderWidth = 1.0
    backgroundColor = .lightGray.withAlphaComponent(0.1)
      contentView.addSubview(labelText)
    labelText.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
  
  func configure(with reaction: String) {
    labelText.text = reaction
  }
}

