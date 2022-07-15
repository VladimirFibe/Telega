import UIKit
import SnapKit
import InputBarAccessoryView

struct ElementKind {
  static let badge = "badge-element-kind"
  static let friendbackground = "background-element-kind"
  static let mebackground = "me-background-element-kind"
  static let sectionHeader = "section-header-element-kind"
  static let sectionFooter = "section-footer-element-kind"
  static let layoutHeader = "layout-header-element-kind"
  static let layoutFooter = "layout-footer-element-kind"
}

class ViewController: UIViewController {
  var messages = Message.all
  var collectionView: UICollectionView! = nil
  var dataSourse: UICollectionViewDiffableDataSource<Message, Reaction>! = nil
  lazy var messageInputBar = InputBarAccessoryView()
  var additionalBottomInset: CGFloat = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureHierarchy()
    configureDataSource()
//    setupLongGestureRecognizerOnCollection()
  }
  
  
}

//extension ViewController: UIGestureRecognizerDelegate {
//  private func setupLongGestureRecognizerOnCollection() {
//    let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
//    longPressedGesture.minimumPressDuration = 0.5
//    longPressedGesture.delegate = self
//    longPressedGesture.delaysTouchesBegan = true
//    collectionView?.addGestureRecognizer(longPressedGesture)
//  }
//
//  @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
//    if (gestureRecognizer.state != .began) {
//      return
//    }
//    let p = gestureRecognizer.location(in: collectionView)
//    print(#function, p)
//
//    if let indexPath = collectionView?.indexPathForItem(at: p) {
//      print("Long press at item: \(indexPath.row)")
//    }
//  }
//}

extension ViewController {
  func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      let leadingPadding = 70.0
      let trailingPadding = 60.0
      let message = self.messages[sectionIndex]
      let me = message.me
      
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .estimated(90),
        heightDimension: .estimated(30))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
        leading: .fixed(0), top: .fixed(5),
        trailing: .fixed(5), bottom: .fixed(0))
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .estimated(60))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      if me {
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: trailingPadding, bottom: 0, trailing: 20)
      } else {
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leadingPadding, bottom: 0, trailing: trailingPadding - 10)
      }
      let section = NSCollectionLayoutSection(group: group)
      let headerSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ElementKind.sectionHeader, alignment: .top)
      if me {
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: trailingPadding - 5, bottom: 0, trailing: leadingPadding - 20)
      } else {
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leadingPadding - 10, bottom: 0, trailing: trailingPadding - 10)
      }
      let footerSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
      let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: ElementKind.sectionFooter, alignment: .bottomTrailing)
      let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
        elementKind: me ? ElementKind.mebackground : ElementKind.friendbackground)
      if me {
        sectionBackgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: trailingPadding - 10, bottom: 0, trailing: leadingPadding - 20)
      } else {
        sectionBackgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leadingPadding - 20, bottom: 0, trailing: trailingPadding - 10)
      }
      section.decorationItems = [sectionBackgroundDecoration]
      section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
      section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
      return section
    }
    layout.register(MeBackgroundDecorationView.self, forDecorationViewOfKind: ElementKind.mebackground)
    layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: ElementKind.friendbackground)
    return layout
  }
}
extension ViewController {
  func configureHierarchy() {
    view.backgroundColor = #colorLiteral(red: 0.9053142667, green: 0.9302254319, blue: 0.9426942468, alpha: 1)
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .clear
    collectionView.delegate = self
    view.addSubview(collectionView)
  }
  func configureDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<MessageCell, Reaction>
    { cell, indexPath, reaction in
      cell.configure(with: reaction)
    }
    
    let headerRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: ElementKind.sectionHeader)
    { supplementaryView, string, indexPath in
      let message = self.messages[indexPath.section]
      supplementaryView.configure(with: string, message: message)
    }
    
    let footerRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: ElementKind.sectionFooter)
    { supplementaryView, string, indexPath in
      let message = self.messages[indexPath.section]
      supplementaryView.configure(with: string, message: message)
    }
    dataSourse = UICollectionViewDiffableDataSource<Message, Reaction>(collectionView: collectionView)
    { collectionView, indexPath, reaction in
      collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: reaction)
    }
    dataSourse.supplementaryViewProvider = {view, kind, index in
      self.collectionView.dequeueConfiguredReusableSupplementary(using: kind == ElementKind.sectionHeader ? headerRegistration : footerRegistration, for: index)
    }
    reloadData()
  }
  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<Message, Reaction>()
    snapshot.appendSections(messages)
    for message in messages {
      snapshot.appendItems(message.reactions, toSection: message)
    }
    dataSourse.apply(snapshot)
  }
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath)
  }
}
