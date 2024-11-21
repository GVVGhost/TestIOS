//
//  CustomTextInput.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 07.08.2024.
//

import SwiftUI

struct RoundedStroke: ViewModifier {
  var color: Color = Color.blue

  func body(content: Content) -> some View {
    content
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(Color.blue, lineWidth: 1)
      )
  }
}
