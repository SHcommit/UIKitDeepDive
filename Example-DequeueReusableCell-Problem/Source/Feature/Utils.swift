//
//  Utils.swift
//  Example-DequeueReusableCell-Problem
//
//  Created by 양승현 on 2023/07/23.
//

import Foundation

// JK(김정- iOS master!!)님의 dump(with:)
// 이 함수는 UnsafeRawPointer를 타입으로 받아오는데, 이때 Pointer 타입을 이용할 수 있습니다.
// 매개변수로 pointer에 할당되는 인스턴스는 그 주소를 얻어올 수 있습니다. with 자체가 pointer이기 때문입니다.
@inlinable func dump(with: UnsafeRawPointer) -> String {
  let address = Int(bitPattern: with)
  return String(format:"%018p", address)
}
