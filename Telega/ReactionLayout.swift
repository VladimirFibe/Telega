//
//  ReactionLayout.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import UIKit

protocol ReactionLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, itemCacheForItemsInSection section: Int) -> [UICollectionViewLayoutAttributes]
  var reactionsHeight: CGFloat { get set}
}

class ReactionLayout: UICollectionViewLayout {
  weak var delegate: ReactionLayoutDelegate?
  var layoutHeight: CGFloat = 0.0
  private var itemCache: [UICollectionViewLayoutAttributes] = []
  
  override func prepare() {
    itemCache.removeAll()
    guard let collectionView = collectionView else { return }
    itemCache = delegate?.collectionView(collectionView, itemCacheForItemsInSection: 0) ?? []
    layoutHeight = delegate?.reactionsHeight ?? 0
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

