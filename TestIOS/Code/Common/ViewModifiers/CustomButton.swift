//
//  CustomButton.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import SwiftUI

struct CustomButton: ViewModifier {
  var color: Color = Color.blue

  func body(content: Content) -> some View {
    content
      .font(.system(size: 24, weight: .bold, design: .default))
      .frame(maxWidth: .infinity, maxHeight: 50)
      .foregroundColor(Color.white)
      .background(color)
      .cornerRadius(5)
  }
}
