//
//  ReactionsView.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import UIKit

// MARK: - ReactionsView
class ReactionsView: UIView {
  var reactions = ["🔥 185"]
  let cellLeftRightPadding: CGFloat = 32.0
  var heightView = NSLayoutConstraint()
  lazy var layout: ReactionLayout = {
    $0.delegate = self
    return $0
  }(ReactionLayout())
  
  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    collectionView.backgroundColor = .clear
    addSubview(collectionView)
    collectionView.dataSource = self
    collectionView.register(ReactionCell.self, forCellWithReuseIdentifier: ReactionCell.identifier)
  }
  
  func confirure(with reactions: [String]) {
    self.reactions = reactions
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 200)
    ])

  }
}

extension ReactionsView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    reactions.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReactionCell.identifier, for: indexPath) as! ReactionCell
    let reaction = reactions[indexPath.item]
    cell.configure(with: reaction)
    return cell
  }
}

extension ReactionsView: ReactionLayoutDelegate {
  func configureUI(with height: CGFloat) {
//    collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
    0
  }
  
  func collectionView(_ collectionView: UICollectionView, itemSpacingInSection section: Int) -> CGFloat {
    5
  }
  
  func collectionView(_ collectionView: UICollectionView, sizeForReactionAtIndexPath indexPath: IndexPath) -> CGSize {
    let reaction = reactions[indexPath.item]
    
    let referenceSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: ReactionCell.height)
    let calculatedSize = (reaction as NSString).boundingRect(with: referenceSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)], context: nil)
    let size = CGSize(width: calculatedSize.width + cellLeftRightPadding, height: ReactionCell.height)
    return size
  }
  
  func collectionView(_ collectionView: UICollectionView, insetsForItemsInSection section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
  }
}
