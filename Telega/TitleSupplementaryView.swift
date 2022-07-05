//
//  MessageFooterView.swift
//  Telega
//
//  Created by Vladimir Fibe on 04.07.2022.
//

import UIKit
import SnapKit

class TitleSupplementaryView: UICollectionReusableView {
  let avatarImageView: UIImageView = {
    $0.layer.cornerRadius = 15.0
    $0.clipsToBounds = true
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
    return $0
  }(UIImageView(image: UIImage(named: "woman")))
  let nameLabel: UILabel = {
    $0.text = "nastya_shuller"
    $0.font = .commissionerMedium12()
    $0.textAlignment = .left
    $0.textColor = .black
    return $0
  }(UILabel())
  
  let distanceLabel: UILabel = {
    $0.text = "500 м"
    $0.font = .commissionerMedium12()
    $0.textAlignment = .right
    $0.textColor = .gray
    return $0
  }(UILabel())
  
  let titleView = UIView()
  
  let content: UILabel = {
    $0.text = "Привет"
    $0.numberOfLines = 0
    $0.font = .commissioner14()
    return $0
  }(UILabel())
  
  let messageImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.masksToBounds = true
    return $0
  }(UIImageView(image: UIImage(named: "woman"))) // image: UIImage(named: "woman")
  
  lazy var stack: UIStackView = {
    $0.axis = .vertical
    $0.spacing = 5
    return $0
  }(UIStackView(arrangedSubviews: [titleView, messageImageView, content]))

  let timeLabel: UILabel = {
    $0.text = "20:00"
    $0.font = .commissionerMedium12()
    $0.textAlignment = .right
    $0.textColor = .gray
    return $0
  }(UILabel())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupFooterViews() {
    addSubview(timeLabel)
    addSubview(avatarImageView)
    setupFooterConstraints()
  }
  func setupHeaderViews() {
    titleView.addSubview(nameLabel)
    titleView.addSubview(distanceLabel)
    addSubview(stack)
    setupHeaderConstraints()
  }
  func setupHeaderConstraints() {
    nameLabel.snp.makeConstraints {
      $0.top.left.bottom.equalToSuperview()
      $0.right.equalTo(distanceLabel.snp.left).inset(10)
    }
    distanceLabel.snp.makeConstraints {
      $0.top.right.bottom.equalToSuperview()
      $0.width.equalTo(50)
    }
    messageImageView.snp.makeConstraints {
      $0.height.equalTo(150)
    }
    stack.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(70)
      $0.bottom.equalToSuperview()
      $0.top.trailing.equalToSuperview().inset(10)
    }
  }
  func setupFooterConstraints() {
    timeLabel.snp.makeConstraints {
      $0.top.right.bottom.equalToSuperview().inset(10)
    }
    avatarImageView.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.left.equalToSuperview().offset(10)
    }
  }
  func configure(with kind: String, message: Message) {
    if kind == ElementKind.sectionHeader {
      setupHeaderViews()
      content.text = message.text
    } else {
      setupFooterViews()
    }
  }
}
