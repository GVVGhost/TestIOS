//
//  Toast.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 07.08.2024.
//

struct Toast: Equatable, Hashable {
    var style: ToastStyle
    var message: String
    var duration: Double = 3
    var width: Double = .infinity
}
