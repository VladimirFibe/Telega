//
//  ReactionLayout.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import UIKit

protocol ReactionLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, sizeForReactionAtIndexPath indexPath: IndexPath) -> CGSize
  func collectionView(_ collectionView: UICollectionView, insetsForItemsInSection section: Int) -> UIEdgeInsets
  func collectionView(_ collectionView: UICollectionView, itemSpacingInSection section: Int) -> CGFloat
  func configureUI(with height: CGFloat)
}

class ReactionLayout: UICollectionViewLayout {
  weak var delegate: ReactionLayoutDelegate?
  var layoutHeight = 0.0
  private var itemCache: [UICollectionViewLayoutAttributes] = []
  
  override func prepare() {
    itemCache.removeAll()
    guard let collectionView = collectionView else { return }
    var layoutWidthIterator: CGFloat = 0.0
    let insets: UIEdgeInsets = delegate?.collectionView(collectionView, insetsForItemsInSection: 0) ?? UIEdgeInsets.zero
    let interItemSpacing: CGFloat = delegate?.collectionView(collectionView, itemSpacingInSection: 0) ?? 0.0
    var itemSize: CGSize = .zero
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      itemSize = delegate?.collectionView(collectionView, sizeForReactionAtIndexPath: indexPath) ?? .zero
      if (layoutWidthIterator + itemSize.width + insets.left + insets.right) > collectionView.frame.width {
        layoutWidthIterator = 0.0
        layoutHeight += itemSize.height + interItemSpacing
      }
      let frame = CGRect(x: layoutWidthIterator + insets.left, y: layoutHeight, width: itemSize.width, height: itemSize.height)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = frame
      itemCache.append(attributes)
      layoutWidthIterator = layoutWidthIterator + frame.width + interItemSpacing
    }
    layoutHeight += itemSize.height + insets.bottom
    delegate?.configureUI(with: layoutHeight)
  }
  
  override func layoutAttributesForElements(in rect: CGRect)-> [UICollectionViewLayoutAttributes]? {
    super.layoutAttributesForElements(in: rect)
    
    var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    for attributes in itemCache {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      super.layoutAttributesForItem(at: indexPath)
      return itemCache[indexPath.row]
  }
  
  override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: layoutHeight)
  }
  
  private var contentWidth: CGFloat {
      guard let collectionView = collectionView else {
          return 0
      }
      let insets = collectionView.contentInset
      return collectionView.bounds.width - (insets.left + insets.right)
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
      layoutHeight = 0.0
      return true
  }
}

