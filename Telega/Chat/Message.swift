//
//  Message.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import Foundation

struct Message: Hashable {
  var text = "Привет!"
  var me = false
  var image: String? = "woman"
  var reactions = [Reaction]()
  let id = UUID()

  static var all = [
    Message(text: "Привет! Ого ты тоже живешь в этом районе? Ни разу тебя не видела! Я Анастасия :) Ищу новые знакомства может и даже вторую половинку. Это я на фото, жду ваши!", me: true), Message(me: true, reactions: [Reaction(name: "🔥"), Reaction(name: "👻", value: 48), Reaction(name: "👏", value: 48), Reaction(name: "👍", value: 48), Reaction(name: "👎", value: 48), Reaction(name: "✌️", value: 948), Reaction(name: "🙀", value: 48), Reaction(name: "😿", value: 48), Reaction(name: "😾", value: 9948), Reaction(name: "✊", value: 98648)]),
    Message(text: "Привет! Ого ты тоже живешь в этом районе? Ни разу тебя не видела! Я Анастасия :) Ищу новые знакомства может и даже вторую половинку. Это я на фото, жду ваши!", reactions: [Reaction(name: "🤡", value: 5), Reaction(name: "🎃", value: 77)]
           ),
    Message(text: "Ну все, здесь я больше не нужна. Фея рассыпанного пшена, голодных голубей и счастливых девочек полетела дальше. Помните: каждую минуту все может измениться к лучшему. Подождите. Или измените сами.", reactions: [Reaction(name: "🔥"), Reaction(name: "👻", value: 48), Reaction(name: "👏", value: 48), Reaction(name: "👍", value: 48), Reaction(name: "👎", value: 48), Reaction(name: "✌️", value: 948), Reaction(name: "🙀", value: 48), Reaction(name: "😿", value: 48), Reaction(name: "😾", value: 9948), Reaction(name: "✊", value: 98648)]
           ),
    Message(text: "Ну все, здесь я больше не нужна. Фея рассыпанного пшена, голодных голубей и счастливых девочек полетела дальше. Помните: каждую минуту все может измениться к лучшему. Подождите. Или измените сами. Ну все, здесь я больше не нужна. Фея рассыпанного пшена, голодных голубей и счастливых девочек полетела дальше. Помните: каждую минуту все может измениться к лучшему. Подождите. Или измените сами.", reactions: [Reaction(name: "🔥"), Reaction(name: "👻", value: 48), Reaction(name: "👏", value: 48), Reaction(name: "👍", value: 48), Reaction(name: "👎", value: 48), Reaction(name: "✌️", value: 948), Reaction(name: "🙀", value: 48), Reaction(name: "😿", value: 48), Reaction(name: "😾", value: 9948), Reaction(name: "✊", value: 98648)]
           ),
    Message(text: "Hi!", me: true, image: nil), Message(text: "Hi!", me: false, image: nil),
  ]
}

struct Reaction: Hashable {
  let id = UUID()
  var name: String = "🔥"
  var value: Int = 7
  var title: String {
    "\(name) \(value)"
  }
}
