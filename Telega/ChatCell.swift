////
////  ChatCell.swift
////  Telega
////
////  Created by Vladimir Fibe on 27.06.2022.
////
//
//import UIKit
//import SwiftUI
//
//final class ChatCell: UICollectionViewCell {
//  static let identifier = "ChatCell"
//  var message = Message()
//  var layoutHeight: CGFloat = 0.0
//  let cellLeftRightPadding: CGFloat = 32.0
//  enum Section {
//    case main
//  }
//  var dataSource: UICollectionViewDiffableDataSource<Section, String>!
////  lazy var layout: ReactionLayout = {
////    $0.delegate = self
////    return $0
////  }(ReactionLayout())
//  
//  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
//  
//  let nameLabel: UILabel = {
//    $0.text = "nastya_shuller"
//    $0.font = .boldSystemFont(ofSize: 14)
//    $0.textAlignment = .left
//    $0.textColor = .black
//    return $0
//  }(UILabel())
//  
//  let messageImageView: UIImageView = {
//    $0.contentMode = .scaleAspectFill
//    $0.layer.masksToBounds = true
//    return $0
//  }(UIImageView(image: UIImage(named: "woman")))
//  
//  let bubbleImageView: UIImageView = {
//    $0.tintColor = UIColor(white: 0.9, alpha: 1)
//    return $0
//  }(UIImageView(image: UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26))
//    .withRenderingMode(.alwaysTemplate)))
//  
//  let messageLabel: UILabel = {
//    $0.numberOfLines = 0
//    return $0
//  }(UILabel())
//  
//  let containerView: UIView = {
//    return $0
//  }(UIView())
//  
//  lazy var stack: UIStackView = {
//    $0.axis = .vertical
//    $0.distribution = .fill
//    $0.alignment = .fill
//    $0.spacing = 5
//    return $0 } (UIStackView(arrangedSubviews: [nameLabel, messageImageView, messageLabel, collectionView]))
//  
//  func setupView() {
//    collectionView.backgroundColor = .clear
//    collectionView.register(ReactionCell.self, forCellWithReuseIdentifier: ReactionCell.identifier)
//    collectionView.isScrollEnabled = false
//    contentView.addSubview(containerView)
//    containerView.addSubview(bubbleImageView)
//    containerView.addSubview(stack)
//  }
//  
//  func configureLayout() -> UICollectionViewCompositionalLayout {
//    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
//    let item = NSCollectionLayoutItem(layoutSize: itemSize)
//    item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
//    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
//    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//    let section = NSCollectionLayoutSection(group: group)
//    section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//    return UICollectionViewCompositionalLayout(section: section)
//  }
//  
//  func configureDataSource() {
//    dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.collectionView) { (collectionView, indexPath, number) -> UICollectionViewCell? in
//      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReactionCell.identifier, for: indexPath) as? ReactionCell else {
//        fatalError("Cannot create new cell")
//      }
//      cell.reaction = self.message.reactions[indexPath.item]
//      return cell
//    }
//    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()
//    initialSnapshot.appendSections([.main])
//    initialSnapshot.appendItems(message.reactions)
//    dataSource.apply(initialSnapshot, animatingDifferences: false)
//  }
//
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  func setupConstraints() {
//    messageImageView.snp.makeConstraints {
//      $0.height.equalTo(150)
//    }
//    
//    containerView.snp.makeConstraints {
//      $0.top.bottom.leading.trailing.equalToSuperview()
//    }
//    
//    bubbleImageView.snp.makeConstraints {
//      $0.top.bottom.leading.trailing.equalToSuperview()
//    }
//    
////    collectionView.snp.makeConstraints {
////      $0.height.equalTo(30)
////    }
//    stack.snp.makeConstraints {
//      $0.top.equalToSuperview().offset(10)
//      $0.leading.equalToSuperview().offset(20)
//      $0.bottom.equalToSuperview().inset(10)
//      $0.trailing.equalToSuperview().inset(10)
//    }
//  }
//  
//  func configure(with message: Message) {
//    self.message = message
//    messageLabel.text = message.text
//    setupView()
//    setupConstraints()
//    configureDataSource()
//    collectionView.reloadData()
//
//  }
//  
//  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//    let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
//    layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize,
//                                                                      withHorizontalFittingPriority: .required,
//                                                                      verticalFittingPriority: .fittingSizeLevel)
//    return layoutAttributes
//  }
//}
//
//// MARK: - UICollectionViewDataSource
////extension ChatCell: UICollectionViewDataSource {
////  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////    message.reactions.count
////  }
////
////  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReactionCell.identifier, for: indexPath) as! ReactionCell
////    let reaction = message.reactions[indexPath.item]
////    cell.configure(with: reaction)
////    return cell
////  }
////}
//
//// MARK: - ReactionLayoutDelegate
////extension ChatCell: ReactionLayoutDelegate {
////  var reactionsHeight: CGFloat {
////    get { layoutHeight }
////    set { layoutHeight = newValue }
////  }
////
////  func collectionView(_ collectionView: UICollectionView, itemCacheForItemsInSection section: Int) -> [UICollectionViewLayoutAttributes] {
////    var itemCache: [UICollectionViewLayoutAttributes] = []
////    var layoutHeight = 0.0
////    var layoutWidthIterator = 0.0
////    let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
////    let interItemSpacing = 5.0
////    var itemSize: CGSize = .zero
////    for item in 0..<message.reactions.count {
////      let reaction = message.reactions[item]
////      let referenceSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: ReactionCell.height)
////      let calculatedSize = (reaction as NSString).boundingRect(with: referenceSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)], context: nil)
////      let size = CGSize(width: calculatedSize.width + cellLeftRightPadding, height: ReactionCell.height)
////      itemSize = size
////      if (layoutWidthIterator + itemSize.width + insets.left + insets.right) > collectionView.frame.width {
////        layoutWidthIterator = 0.0
////        layoutHeight += itemSize.height + interItemSpacing
////      }
////      let frame = CGRect(x: layoutWidthIterator + insets.left, y: layoutHeight, width: itemSize.width, height: itemSize.height)
////      let indexPath = IndexPath(item: item, section: 0)
////      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
////      attributes.frame = frame
////      itemCache.append(attributes)
////      layoutWidthIterator = layoutWidthIterator + frame.width + interItemSpacing
////    }
////    layoutHeight += itemSize.height + insets.bottom
////    self.layoutHeight = layoutHeight
////    return itemCache
////  }
////}
