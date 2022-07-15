//
//  SignInViewController.swift
//  Telega
//
//  Created by Vladimir Fibe on 14.07.2022.
//
import UIKit
import SnapKit

final class SignInViewController: UIViewController {
  private let contentViewCornerRadius: CGFloat = 20
  // MARK: - UI Components
  
  private lazy var contentView: UIView = {
    $0.layer.cornerRadius = contentViewCornerRadius
    $0.backgroundColor = .white
    return $0}(UIView())
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    view.addSubview(contentView)
    contentView.snp.makeConstraints {
      $0.left.equalTo(view.snp.left).offset(8)
      $0.right.equalTo(view.snp.right).inset(8)
      $0.bottom.equalTo(view.snp.bottom).inset(50)
      $0.height.equalTo(200)
    }
  }
}
