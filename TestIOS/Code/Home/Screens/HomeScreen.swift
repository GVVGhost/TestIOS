//
//  HomeScreen.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 07.08.2024.
//

import SwiftUI

struct HomeScreen: View {
    @State private var toast: Toast?
    @State private var list: [LabelToastModel] = [
        LabelToastModel(
            label: NSLocalizedString("Toast (Success)", comment: ""),
            toast: Toast(style: .success, message: "Saved.")
        ),
        LabelToastModel(
            label: NSLocalizedString("Toast (Info)", comment: ""),
            toast: Toast(style: .info, message: "Btw, you are a good person.")
        ),
        LabelToastModel(
            label: NSLocalizedString("Toast (Warning)", comment: ""),
            toast: Toast(style: .warning, message: "Beware of a dog!")
        ),
        LabelToastModel(
            label: NSLocalizedString("Toast (Error)", comment: ""),
            toast: Toast(style: .error, message: "Fatal error, blue screen level.")
        )
    ]
    
    var body: some View {
        Form {
            Section(header: Text("Try toasts")) {
                ForEach(list, id: \.self) { toastData in
                    Button {
                        toast = toastData.toast
                    } label: {
                        HStack {
                            Text(toastData.label)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .toastView(toast: $toast)
    }
}

#Preview {
    HomeScreen()
}
