//
//  Message.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import Foundation

struct Message: Hashable {
  var text = "Привет!"
  var reactions = [Reaction()]
  
  static var all = [
    Message(text: "Привет! Ого ты тоже живешь в этом районе? Ни разу тебя не видела! Я Анастасия :) Ищу новые знакомства может и даже вторую половинку. Это я на фото, жду ваши!", reactions: [Reaction(name: "🤡", value: 5), Reaction(name: "🎃", value: 77)]
           ),
    Message(text: "Ну все, здесь я больше не нужна. Фея рассыпанного пшена, голодных голубей и счастливых девочек полетела дальше. Помните: каждую минуту все может измениться к лучшему. Подождите. Или измените сами.", reactions: [Reaction(name: "🔥"), Reaction(name: "👻", value: 48), Reaction(name: "👏", value: 48), Reaction(name: "👍", value: 48), Reaction(name: "👎", value: 48), Reaction(name: "✌️", value: 948), Reaction(name: "🙀", value: 48), Reaction(name: "😿", value: 48), Reaction(name: "😾", value: 9948), Reaction(name: "✊", value: 98648), Reaction(name: "👊", value: 48)]
           ),
  ]
}

struct Reaction: Hashable {
  var name: String = "🔥"
  var value: Int = 7
  var title: String {
    "\(name) \(value)"
  }
}
