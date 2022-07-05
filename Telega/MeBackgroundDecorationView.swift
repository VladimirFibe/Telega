//
//  MeBackgroundDecorationView.swift
//  Telega
//
//  Created by Vladimir Fibe on 05.07.2022.
//

import UIKit

class MeBackgroundDecorationView: UICollectionReusableView {
  static let reuseIdentifier = "MeBackgroundDecorationView"

  let bubbleImageView: UIImageView = {
    $0.tintColor = .blue // UIColor(white: 0.9, alpha: 1)
    return $0
  }(UIImageView(image: UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26))
    .withRenderingMode(.alwaysTemplate)))
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(bubbleImageView)

    bubbleImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
