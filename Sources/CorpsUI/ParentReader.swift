//
//  ParentReader.swift
//  Created by Shawn Throop on 09.02.25.
//

import UIKit
import SwiftUI

@available(iOS 15.0, *)
@MainActor public extension View {
    
    func onParent(action: @escaping @MainActor (UIViewController?) -> Void) -> some View {
        overlay(alignment: .top) {
            ParentReader(action: action)
        }
    }
}

@available(iOS 14.0, *)
public struct ParentReader: View {
    
    public typealias Action = @MainActor (UIViewController?) -> Void
    
    let action: Action
    
    public init(action: @escaping Action) {
        self.action = action
    }
    
    public var body: some View {
        ParentReaderRepresentation(action: action)
            .accessibilityHidden(true)
    }
}


private struct ParentReaderRepresentation: UIViewControllerRepresentable {
        
    final class UIViewControllerType: UIViewController {
        
        var action: ParentReader.Action = { _ in }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .none
            view.isUserInteractionEnabled = false
        }
        
        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            action(parent)
        }
    }
    
    let action: ParentReader.Action
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        .init()
    }
    
    func updateUIViewController(_ controller: UIViewControllerType, context: Context) {
        controller.action = action
    }
    
    @available(iOS 16.0, *)
    func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: UIViewControllerType, context: Context) -> CGSize? {
        .zero
    }
}
