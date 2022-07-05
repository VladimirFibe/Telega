//
//  MessageFooterView.swift
//  Telega
//
//  Created by Vladimir Fibe on 04.07.2022.
//

import UIKit
import SnapKit

class MessageFooterView: UICollectionReusableView {
  static let reuseIdentifier = "footer-reuse-identifier"
  let timeLabel: UILabel = {
    $0.text = "20:00"
    $0.font = .commissionerMedium12()
    $0.textAlignment = .right
    $0.textColor = .black
    return $0
  }(UILabel())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    addSubview(timeLabel)
  }
  func setupConstraints() {
    timeLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
