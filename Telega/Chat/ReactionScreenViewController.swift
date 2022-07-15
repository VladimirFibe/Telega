//
//  ReactionScreenViewController.swift
//  Telega
//
//  Created by Vladimir Fibe on 11.07.2022.
//

import UIKit
import SnapKit

class ReactionScreenViewController: UIViewController {
  let reactions = ["👍", "👎", "❤️", "🔥", "🥰", "👏", "😁", "🤔", "🤯", "😱", "🤬", "😢", "🎉", "🤩", "🤮", "💩", "🙏"]
  let capsuleView: UIView = {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 20
    return $0
  }(UIView(frame: CGRect(x: 20, y: 150, width: 330, height: 40)))
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.showsHorizontalScrollIndicator = false
    
    return collectionView
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  func setupViews() {
    view.backgroundColor = .systemGray
    view.addSubview(capsuleView)
    
    collectionView.dataSource = self
    collectionView.register(ReactionMenuCell.self, forCellWithReuseIdentifier: ReactionMenuCell.reuseIdentifier)
    capsuleView.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

extension ReactionScreenViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReactionMenuCell.reuseIdentifier, for: indexPath) as! ReactionMenuCell
    cell.label.text = reactions[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    reactions.count
  }
  
}

extension ReactionScreenViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: 20, height: collectionView.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    3
  }
}

class ReactionMenuCell: UICollectionViewCell {
  static let reuseIdentifier: String = "ReactionMenuCell"

  let label: UILabel = {
    $0.text = "👍"
    $0.textAlignment = .center
    return $0
  }(UILabel())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
//    contentView.backgroundColor = .blue
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    contentView.addSubview(label)
    label.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
