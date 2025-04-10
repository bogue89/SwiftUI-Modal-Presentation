//
//  File.swift
//  ModalPresentation
//
//  Created by Jorge Benavides Ojinaga on 09/04/25.
//

import SwiftUI

public enum DragIndicatorSize {
    case regular
    case large
}

extension EnvironmentValues {
    private struct DragIndicatorSizeKey: EnvironmentKey {
        static var defaultValue: DragIndicatorSize = .regular
    }
    public var dragIndicatorSize: DragIndicatorSize {
        get { self[DragIndicatorSizeKey.self] }
        set { self[DragIndicatorSizeKey.self] = newValue }
    }
}
