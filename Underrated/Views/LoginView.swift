//
//  LoginView.swift
//  Underrated
//
//  Created by Cody Martin on 3/2/20.
//  Copyright © 2020 Cody Martin. All rights reserved.
//

//import SwiftUI
//
//struct LoginView: View {
////    static var NotificationDone = NSNotification.Name(rawValue: "Done")
//    var body: some View {
//        VStack {
//            NavigationView{
//                Text("Login Boyeee")
//                    .font(.largeTitle)
//                    .navigationBarTitle("Login View")
//            }
//            Button(action: {
//                NotificationCenter.default.post(name: Constants.UserLoggedInNotification, object: nil)
//            }) {
//                Text("Login")
//                    .fontWeight(.bold)
//                    .font(.title)
//                    .padding()
//                    .background(Color.purple)
//                    .cornerRadius(40)
//                    .foregroundColor(.white)
//                    .padding(10)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 40)
//                            .stroke(Color.purple, lineWidth: 5)
//                    )
//            }
//        }
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}













//
//  ContentView.swift
//  LoginPageSwiftUITutorial
//
//  Created by BLCKBIRDS on 01.07.19.
//  Copyright © 2019 BLCKBIRDS. All rights reserved.
//








//import SwiftUI
//
//let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
//
//let storedUsername = "Myusername"
//let storedPassword = "Mypassword"
//
//struct LoginView : View {
//
//    @State var username: String = ""
//    @State var password: String = ""
//
//    @State var authenticationDidFail: Bool = false
//    @State var authenticationDidSucceed: Bool = false
//
//    @State var editingMode: Bool = false
//
//    var body: some View {
//
//        ZStack {
//            VStack {
//                WelcomeText()
//                UserImage()
//                UsernameTextField(username: $username, editingMode: $editingMode)
//                PasswordSecureField(password: $password)
//                if authenticationDidFail {
//                    Text("Information not correct. Try again.")
//                        .offset(y: -10)
//                        .foregroundColor(.red)
//                }
//                Button(action: {
//                    if self.username == storedUsername && self.password == storedPassword {
//                        self.authenticationDidSucceed = true
//                        self.authenticationDidFail = false
//                    } else {
//                        self.authenticationDidFail = true
//                    }
//                }) {
//                    LoginButtonContent()
//                }
//                }
//                .padding()
//        }
//            .offset(y: editingMode ? -150 : 0)
//    }
//}
//
////#if DEBUG
////struct ContentView_Previews : PreviewProvider {
////    static var previews: some View {
////        ContentView()
////    }
////}
////#endif
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
//
//struct WelcomeText : View {
//    var body: some View {
//        return Text("Welcome!")
//            .font(.largeTitle)
//            .fontWeight(.semibold)
//            .padding(.bottom, 20)
//    }
//}
//
//struct UserImage : View {
//    var body: some View {
//        return Image("userImage")
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: 150, height: 150)
//            .clipped()
//            .cornerRadius(150)
//            .padding(.bottom, 75)
//    }
//}
//
//struct LoginButtonContent : View {
//    var body: some View {
//        return Text("LOGIN")
//            .font(.headline)
//            //change
//            .foregroundColor(.white)
//            .padding()
//            .frame(width: 220, height: 60)
//            .background(Color.green)
//            .cornerRadius(15.0)
//    }
//}
//
//struct UsernameTextField : View {
//
//    @Binding var username: String
//
//    @Binding var editingMode: Bool
//
//    var body: some View {
//        return TextField("Username", text: $username, onEditingChanged: {edit in
//            if edit == true
//            {self.editingMode = true}
//            else
//            {self.editingMode = false}
//        })
//            .padding()
//            .background(lightGreyColor)
//            .cornerRadius(5.0)
//            .padding(.bottom, 20)
//    }
//}
//
//struct PasswordSecureField : View {
//
//    @Binding var password: String
//
//    var body: some View {
//        return SecureField("Password", text: $password)
//            .padding()
//            .background(lightGreyColor)
//            .cornerRadius(5.0)
//            .padding(.bottom, 20)
//    }
//}




import SwiftUI
import GoogleSignIn
import UIKit

struct LoginView: View {
    
    //MARK: Properties
    @State var email: String = ""
    @State var password: String = ""
    @ObservedObject var mdl = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome")
            TextField("Email", text: $email)
            
            SecureField("Password", text: $password)
            Button(action: logIn) {
                Text("Sign In")
            }
            .padding()
            Button(action: logOut) {
                Text("Sign Out")
            }
            go().frame(width: 120, height: 50)
            .onTapGesture { // (1)
              self.link() // (2)
            }
        }
    .padding()
    }
    
    func link() {
//        AccountManager.shared.linkWithGoogle { [unowned self] (result, error) in
        self.mdl.link{ (result, error) in
//              print("User signed in \(user.uid)")
//              self.presentationMode.wrappedValue.dismiss() // (3)
        }
    }
    
    //MARK: Functions
    func logIn() {
//        session.logIn(email: email, password: password) { (result, error) in
//            if error != nil {
//                print("Error")
//            } else {
//                self.email = ""
//                self.password = ""
//            }
//        }
    }
    
    func logOut() {
        self.mdl.logout()
        
//        session.logIn(email: email, password: password) { (result, error) in
//            if error != nil {
//                print("Error")
//            } else {
//                self.email = ""
//                self.password = ""
//            }
//        }
    }
}

struct go: View {
    var socialLogin = SocialLogin()
    var body: some View {
        VStack {
            Text("Or Login with").font(.footnote)
            HStack {
                Button(action: self.socialLogin.attemptLoginGoogle, label: {
                    Image("ic_google").frame(width: 20, height: 20)
                })
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(Color.white)
                        .cornerRadius(8.0)
                        .shadow(radius: 4.0)
            }.padding()
        }.padding(.all, 32)
    }
}

struct google : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        
        let button = GIDSignInButton()
        button.colorScheme = .dark
//        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        
    }
}

struct SocialLogin: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<SocialLogin>) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SocialLogin>) {
    }

    func attemptLoginGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        GIDSignIn.sharedInstance()?.signIn()
    }

//    func attemptLoginFb(completion: @escaping (_ result: FBSDKLoginManagerLoginResult?, _ error: Error?) -> Void) {
//        let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
//        fbLoginManager.logOut()
//        fbLoginManager.logIn(withReadPermissions: ["email"], from: UIApplication.shared.windows.last?.rootViewController) { (result, error) -> Void in
//            completion(result, error)
//        }
//    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
