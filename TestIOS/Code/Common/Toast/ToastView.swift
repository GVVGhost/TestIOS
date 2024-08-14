//
//  ToastView.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 07.08.2024.
//

import SwiftUI

struct ToastView: View {
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: (() -> Void)
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: style.iconFileName)
                .foregroundStyle(style.themeColor)
            Text(message)
                .font(.system(size: 14, weight: .none, design: .default))
                .foregroundStyle(style.themeColor)
            Spacer(minLength: 10)
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(style.themeColor)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(style.themeColor, lineWidth: 3)
                .opacity(0.6)
        )
        .padding(.horizontal)
    }
}

#Preview {
    ToastView(
        style: ToastStyle.error,
        message: "Preview mode toast message",
        width: .infinity,
        onCancelTapped: {}
    )
}
