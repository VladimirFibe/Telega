//
//  PlaygroundViewController.swift
//  Telega
//
//  Created by Vladimir Fibe on 12.07.2022.
//

import SwiftUI

class PlaygroundViewController: UIViewController {
  let avatar = Avatar(image: UIImage(systemName: "gear"))
let avatarView = AvatarView()
    override func viewDidLoad() {
        super.viewDidLoad()
      avatarView.frame = CGRect(50, 50, 60, 60)
      avatarView.set(avatar: avatar)
      view.addSubview(avatarView)
        // Do any additional setup after loading the view.
    }
}
struct SwiftUIPlayController: UIViewControllerRepresentable {
  typealias UIViewControllerType = PlaygroundViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
  }
}

struct SwiftUIController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIPlayController()
      .edgesIgnoringSafeArea(.all)
  }
}
