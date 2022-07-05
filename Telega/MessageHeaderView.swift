//
//  MessageHeaderView.swift
//  Telega
//
//  Created by Vladimir Fibe on 04.07.2022.
//

import UIKit
import SnapKit

class MessageHeaderView: UICollectionReusableView {
  static let reuseIdentifier = "MessageHeader"
  
  let nameLabel: UILabel = {
    $0.text = "nastya_shuller"
    $0.font = .commissionerMedium12()
    $0.textAlignment = .left
    $0.textColor = .black
    return $0
  }(UILabel())
  
  let content: UILabel = {
    $0.numberOfLines = 0
    $0.font = .commissioner14()
    return $0
  }(UILabel())
  
  let messageImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.masksToBounds = true
    return $0
  }(UIImageView(image: UIImage(named: "woman")))
  
  lazy var stack: UIStackView = {
    $0.axis = .vertical
    $0.spacing = 5
    return $0
  }(UIStackView(arrangedSubviews: [nameLabel, messageImageView, content]))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  func setupViews() {
    addSubview(stack)
  }
  func setupConstraints() {
    messageImageView.snp.makeConstraints {
      $0.height.equalTo(150)
    }
    stack.snp.makeConstraints {
      $0.leading.bottom.equalToSuperview()
      $0.top.trailing.equalToSuperview().inset(10)
    }
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
