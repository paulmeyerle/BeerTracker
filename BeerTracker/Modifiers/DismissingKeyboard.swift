//
//  DismissingKeyboard.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/17/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter { $0.activationState == .foregroundActive }
                        .compactMap { $0 as? UIWindowScene }
                        .first?.windows
                        .filter({ $0.isKeyWindow }).first
                keyWindow?.endEditing(true)
        }
    }
}
