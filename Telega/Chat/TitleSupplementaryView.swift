//
//  MessageFooterView.swift
//  Telega
//
//  Created by Vladimir Fibe on 04.07.2022.
//

import UIKit
import SnapKit

class TitleSupplementaryView: UICollectionReusableView, UIGestureRecognizerDelegate {
  
  var message: Message? = nil
  
  let friendImageView: UIImageView = {
    $0.layer.cornerRadius = 18.0
    $0.clipsToBounds = true
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.widthAnchor.constraint(equalToConstant: 36).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
    return $0
  }(UIImageView(image: UIImage(named: "woman")))
  
  let meImageView: UIImageView = {
    $0.layer.cornerRadius = 18.0
    $0.clipsToBounds = true
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.widthAnchor.constraint(equalToConstant: 36).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
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
  }(UIImageView())
  
  lazy var stack: UIStackView = {
    $0.axis = .vertical
    $0.alignment = .fill
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
    setupLongGestureRecognizerOnCollection()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func setupLongGestureRecognizerOnCollection() {
    let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
    longPressedGesture.minimumPressDuration = 0.5
    longPressedGesture.delegate = self
    longPressedGesture.delaysTouchesBegan = true
    self.addGestureRecognizer(longPressedGesture)
  }
  
  @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
    print(self.frame)
  }
  
  func setupFooterViews(me: Bool) {
    addSubview(timeLabel)
    addSubview(meImageView)
    addSubview(friendImageView)
    if me {
      meImageView.isHidden = false
      friendImageView.isHidden = true
      timeLabel.snp.makeConstraints {
        $0.right.equalToSuperview().inset(70)
        $0.bottom.equalToSuperview().inset(10)
      }
      meImageView.snp.makeConstraints {
        $0.bottom.equalToSuperview()
        $0.right.equalToSuperview().inset(5)
      }
    } else {
      meImageView.isHidden = true
      friendImageView.isHidden = false
      timeLabel.snp.makeConstraints {
        $0.right.equalToSuperview().inset(70)
        $0.bottom.equalToSuperview().inset(10)
      }

      friendImageView.snp.makeConstraints {
        $0.bottom.equalToSuperview()
        $0.left.equalToSuperview().offset(10)
      }
    }
  }
  func setupHeaderViews(me: Bool) {
    addSubview(stack)
    messageImageView.snp.makeConstraints {
      $0.height.equalTo(150).priority(999)
    }
    stack.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.leading.trailing.top.equalToSuperview().inset(10)
    }
 
  }
  func setupTitleView() {
    titleView.addSubview(nameLabel)
    titleView.addSubview(distanceLabel)
    nameLabel.snp.makeConstraints {
      $0.top.left.bottom.equalToSuperview()
      $0.right.equalTo(distanceLabel.snp.left).inset(10)
    }
    distanceLabel.snp.makeConstraints {
      $0.top.right.bottom.equalToSuperview()
      $0.width.equalTo(50)
    }
  }

  func configure(with kind: String, message: Message) {
    self.message = message
    if kind == ElementKind.sectionHeader {
      if let image = message.image {
        messageImageView.image = UIImage(named: image)
      } else {
        messageImageView.isHidden = true
      }
      setupHeaderViews(me: message.me)
      content.text = message.text
      content.textColor = message.me ? .white : .black
      if !message.me {
        setupTitleView()
        titleView.isHidden = false
      }
      titleView.isHidden = message.me
    } else {
      timeLabel.textColor = message.me ? .white : .lightGray
      setupFooterViews(me: message.me)
    }
  }
}
