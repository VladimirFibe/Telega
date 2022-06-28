//
//  ChatCell.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import UIKit
import SwiftUI

// MARK: - ChatCell
final class ChatCell: UICollectionViewCell {
  var layoutHeight: CGFloat = 0.0
  static let identifier = "ChatCell"
  var message = Message()
  let cellLeftRightPadding: CGFloat = 32.0
  lazy var layout: ReactionLayout = {
    $0.delegate = self
    return $0
  }(ReactionLayout())
  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
  let nameLabel: UILabel = {
    $0.text = "nastya_shuller"
    $0.font = .boldSystemFont(ofSize: 14)
    $0.textAlignment = .left
    $0.textColor = .black
    return $0
  }(UILabel())
  
  let messageImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.layer.masksToBounds = true
    return $0
  }(UIImageView(image: UIImage(named: "woman")))
  
  let bubbleImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.tintColor = UIColor(white: 0.9, alpha: 1)
    return $0
  }(UIImageView(image: UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26))
    .withRenderingMode(.alwaysTemplate)))
  
  let messageLabel: UILabel = {
    $0.numberOfLines = 0
    return $0
  }(UILabel())
  
  let containerView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(UIView())
  
  lazy var stack: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .fill
    $0.spacing = 5
    return $0 } (UIStackView(arrangedSubviews: [nameLabel, messageImageView, messageLabel, collectionView]))
  
  func setupView() {
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    collectionView.register(ReactionCell.self, forCellWithReuseIdentifier: ReactionCell.identifier)
    
    contentView.addSubview(containerView)
    containerView.addSubview(bubbleImageView)
    containerView.addSubview(stack)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      messageImageView.heightAnchor.constraint(equalToConstant: 150),
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

      bubbleImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      bubbleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      bubbleImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      bubbleImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      
      stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
      stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
      stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
      
      collectionView.heightAnchor.constraint(equalToConstant: 30)
    ])
    
  }
  func configure(with message: Message) {
    self.message = message
    messageLabel.text = message.text

  }
  
  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
    layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize,
                                                                      withHorizontalFittingPriority: .required,
                                                                      verticalFittingPriority: .fittingSizeLevel)
    return layoutAttributes
  }
}

// MARK: -
extension ChatCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    message.reactions.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReactionCell.identifier, for: indexPath) as! ReactionCell
    let reaction = message.reactions[indexPath.item]
    cell.configure(with: reaction)
    return cell
  }
}
// MARK: - Preview
struct ViewControllerSUI: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> ViewController {
    ViewController()
  }
  func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerSUI()
        .ignoresSafeArea()
    }
}

extension ChatCell: ReactionLayoutDelegate {
  var reactionsHeight: CGFloat {
    get { layoutHeight }
    set { layoutHeight = newValue }
  }

  func collectionView(_ collectionView: UICollectionView, itemCacheForItemsInSection section: Int) -> [UICollectionViewLayoutAttributes] {
    var itemCache: [UICollectionViewLayoutAttributes] = []
    var layoutHeight = 0.0
    var layoutWidthIterator = 0.0
    let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    let interItemSpacing = 5.0
    var itemSize: CGSize = .zero
    for item in 0..<message.reactions.count {
      let reaction = message.reactions[item]
      let referenceSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: ReactionCell.height)
      let calculatedSize = (reaction as NSString).boundingRect(with: referenceSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)], context: nil)
      let size = CGSize(width: calculatedSize.width + cellLeftRightPadding, height: ReactionCell.height)
      itemSize = size
      if (layoutWidthIterator + itemSize.width + insets.left + insets.right) > collectionView.frame.width {
        layoutWidthIterator = 0.0
        layoutHeight += itemSize.height + interItemSpacing
      }
      let frame = CGRect(x: layoutWidthIterator + insets.left, y: layoutHeight, width: itemSize.width, height: itemSize.height)
      let indexPath = IndexPath(item: item, section: 0)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = frame
      itemCache.append(attributes)
      layoutWidthIterator = layoutWidthIterator + frame.width + interItemSpacing
    }
    layoutHeight += itemSize.height + insets.bottom
    self.layoutHeight = layoutHeight
    return itemCache
  }

}
