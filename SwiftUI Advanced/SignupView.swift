//
//  ContentView.swift
//  SwiftUI Advanced
//
//  Created by Tony on 05/01/2022.
//

import SwiftUI
import AudioToolbox
import FirebaseAuth

struct SignupView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextfield: Bool = false
    @State private var editingPasswordTextfield: Bool = false
    @State private var emailIconBounce: Bool = false
    @State private var passwordIconBounce: Bool = false
    @State private var showProfileView: Bool = false
    @State private var signupToggle: Bool = true
    @State private var rotationAngle = 0.0
    @State private var signInWithAppleObject = SignInWithAppleObject()
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Image(signupToggle ? "background-3" : "background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text(signupToggle ? "Sign up" : "Sign in")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Text("Access to 120+ hours of courses tutorials, and livestreams")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .opacity(0.7)
                    HStack(spacing: 12.0) {
                        TextfieldIcon(iconName: "envelope.open.fill", currentlyEditing: $editingEmailTextfield)
                            .scaleEffect(emailIconBounce ? 1.2: 1.0)
                            .foregroundColor(.white)
                        TextField("Email", text: $email) { isEditing in
                            editingEmailTextfield = isEditing
                            editingPasswordTextfield = false
                            generator.selectionChanged()
                            if isEditing {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                    emailIconBounce.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                        emailIconBounce.toggle()
                                    }
                                }
                            }
                        }
                        .colorScheme(.dark)
                        .foregroundColor(Color.white.opacity(0.7))
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                    }
                    .frame(height: 52)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1.0)
                                .blendMode(.overlay)
                             
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16.0)
                            .opacity(0.8)
                    )
                    
                    HStack(spacing: 12.0) {
                        TextfieldIcon(iconName: "key.fill", currentlyEditing: $editingPasswordTextfield)
                            .scaleEffect(passwordIconBounce ? 1.2 : 1.0)
                        SecureField("Password", text: $password)
                            .colorScheme(.dark)
                            .foregroundColor(Color.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.password)
                    }
                    .frame(height: 52)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1.0)
                                .blendMode(.overlay)
                             
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16.0)
                            .opacity(0.8)
                    )
                    .onTapGesture {
                        editingPasswordTextfield = true
                        editingEmailTextfield = false
                        generator.selectionChanged()
                        if editingPasswordTextfield {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                passwordIconBounce.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                    passwordIconBounce.toggle()
                                }
                            }
                        }
                    }
                    
                    GradientButton(
                        buttonTitle: signupToggle ? "Create account" : "Sign in") {
                            generator.selectionChanged()
                            signup()
                        }
                        .onAppear {
                            Auth.auth()
                                .addStateDidChangeListener { auth, user in
                                    if user != nil {
                                        showProfileView.toggle()
                                    }
                                }
                        }
                    
                    if signupToggle { Text("By clicking on Sign up, you agree to our Terms of serviceand Privacy policy")
                            .font(.footnote)
                            .foregroundColor(Color.white.opacity(0.7))
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity(0.1))
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Button {
                            withAnimation(
                                .easeInOut(duration: 0.7)) {
                                    signupToggle.toggle()
                                    self.rotationAngle += 180
                                }
                        } label: {
                            HStack(spacing: 4.0) {
                                Text(signupToggle ? "Already have an account?" : "Don't have and account")
                                    .font(.footnote)
                                    .foregroundColor(Color.white.opacity(0.7))
                                GradientText(text: signupToggle ? "Sign in" : "Sign up")
                                    .font(Font.footnote.bold())
                                
                                
                            }
                        }
                        if !signupToggle {
                            Button(action: {print("Send reset password email")}, label: {
                                HStack(spacing: 4) {
                                    Text("Forgot password?")
                                        .font(.footnote)
                                        .foregroundColor(.white.opacity(0.7))
                                    GradientText(text: "Reset password")
                                        .font(.footnote.bold())
                                    
                                }
                            })
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white.opacity(0.1))
                            Button(action: {signInWithAppleObject.signInWithApple()}, label:  {
                                SigninWithApppleButton()
                                    .frame(height: 50)
                                    .cornerRadius(16)
                            })
                        }
                    }
                    
                }
                .padding(20)
            }
            .rotation3DEffect(Angle(degrees: self.rotationAngle), axis: (x: 0.0, y: 1.0, z: 0.0))
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.2))
                    .background(Color("secondaryBackground").opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            .rotation3DEffect(Angle(degrees: self.rotationAngle), axis: (x: 0.0, y: 1.0, z: 0.0))
        }
        //        .fullScreenCover(isPresented: $showProfileView) {
        //            ProfileView()
        //        }
    }
    
    func signup() {
      if signupToggle { Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("User signed up!")
      }} else {
          Auth.auth().signIn(withEmail: email, password: password) { result, error in
              guard error == nil else {
                  print(error!.localizedDescription)
                  return
              }
              print("User is signed in")
          }
      }
    }
    
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}



public var gradient1: [Color] = [
    Color.init(red: 101/225, green: 134/225, blue: 1),
    Color.init(red: 1, green: 64/225, blue: 80/225),
    Color.init(red: 109/225, green: 1, blue: 185/225),
    Color.init(red: 39/225, green: 232/225, blue: 1),
]
