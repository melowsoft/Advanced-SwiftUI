//
//  SigninWithAppleButton.swift
//  SwiftUI Advanced
//
//  Created by Tony on 07/01/2022.
//

import SwiftUI
import AuthenticationServices

struct SigninWithApppleButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}

