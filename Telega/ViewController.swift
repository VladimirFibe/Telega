//
//  ViewController.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
  var messages = Message.all
  
  let layout: ChatFlowLayout = {
    $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    $0.minimumLineSpacing = 10
    $0.minimumInteritemSpacing = 10
    return $0
  }(ChatFlowLayout())
  
  lazy var collectionView: UICollectionView = {
    $0.backgroundColor = .clear
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentInsetAdjustmentBehavior = .always
    return $0
  }(UICollectionView(frame: .zero, collectionViewLayout: layout))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
  }

  func setupViews() {
    view.addSubview(collectionView)
    view.backgroundColor = .lightGray
    collectionView.dataSource = self
    collectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
    collectionView.reloadData()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
  }
}
// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
    cell.configure(with: messages[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    messages.count
  }
}

// MARK: - ChatFlowLayout
final class ChatFlowLayout: UICollectionViewFlowLayout {
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map{$0.copy()} as? [UICollectionViewLayoutAttributes]
    layoutAttributesObjects?.forEach {
      if $0.representedElementCategory == .cell {
        if let newFrame = layoutAttributesForItem(at: $0.indexPath)?.frame { $0.frame = newFrame}
      }
    }
    return layoutAttributesObjects
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let collectionView = collectionView else { fatalError() }
    guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else { return nil }
    layoutAttributes.frame.origin.x = sectionInset.left
    layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
    return layoutAttributes
  }
}




extension ReactionsView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: 60, height: 30)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    3
  }
}



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
    NSLayoutConstraint.activate([
      labelText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      labelText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    ])
  }
  
  func configure(with reaction: String) {
    labelText.text = reaction
  }
}
