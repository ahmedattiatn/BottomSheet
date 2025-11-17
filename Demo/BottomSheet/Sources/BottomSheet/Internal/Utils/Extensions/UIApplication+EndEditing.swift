//
//  UIApplication+EndEditing.swift
//  BottomSheet
//
//  Created by Hervé Peroteau on 12/09/2025.
//

import UIKit

extension UIApplication {
    func endEditing(_ force: Bool = true) {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .endEditing(force)
    }
}
