import SwiftUI
import AuthenticationServices

struct WelcomePageView: View {
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(hex: "006FFF")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.4)
                        .overlay(
                            VStack(spacing: 12) {
                                Text("Finance with a clear headspace. Start now.")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                
                                // Sign in with Apple button
                                SignInWithAppleButton(.signIn) { request in
                                    request.requestedScopes = [.fullName, .email]
                                } onCompletion: { result in
                                    switch result {
                                    case .success(let authorization):
                                        handleAuthorization(authorization: authorization)
                                    case .failure(let error):
                                        print("Error during Sign in with Apple: \(error.localizedDescription)")
                                    }
                                }
                                .signInWithAppleButtonStyle(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .cornerRadius(10)
                                
                                Button(action: {
                                    // Sign in with Google action
                                }) {
                                    HStack {
                                        Image(systemName: "globe")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 20)
                                        Text("Sign in with Google")
                                            .font(.body)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1.5)
                                    )
                                }
                                
                                Button(action: {
                                    path.append("CreateAccountView")
                                }) {
                                    Text("Create free account")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 2.5)
                                        )
                                        .cornerRadius(10)
                                }
                                
                                Text("By signing in with Apple or Google you agree to letsbudget.its' privacy policy and terms of service")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 10)
                            }
                            .padding()
                        )
                }
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "CreateAccountView" {
                    CreateAccountView()
                }
            }
        }
    }
    
    private func handleAuthorization(authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // Save userIdentifier securely, e.g., Keychain
            print("User ID: \(userIdentifier)")
            print("Full Name: \(fullName?.description ?? "N/A")")
            print("Email: \(email ?? "N/A")")
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
