import SwiftUI

struct CreateAccountView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.presentationMode) var presentationMode // Used to dismiss the current view
    
    @EnvironmentObject var viewState : ViewState

    @State private var isPopupVisible: Bool = false
    @State private var PopupTitle: String = ""
    @State private var PopupButtonTxt: String = ""
    @State private var PopupText: String = ""

    var body: some View {
        ZStack {
            Color(hex: "006FFF")
                .edgesIgnoringSafeArea(.all)

            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.55)
                    .overlay(
                        VStack(spacing: 16) {
                            // Header
                            Text("Create your account")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)

                            // First & Last Name Fields
                            HStack(spacing: 10) {
                                TextField("First Name", text: $firstName)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .cornerRadius(10)

                                TextField("Last Name", text: $lastName)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .cornerRadius(10)
                            }

                            // Email Field
                            TextField("Email", text: $email)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .cornerRadius(10)

                            // Password Field
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .cornerRadius(10)

                            // Create Account Button
                            Button(action: {
                                handleCreateAccount()
                            }) {
                                Text("Create Account")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            // Return Back Button
                            Button(action: {
                                // Dismiss the current view to return to the previous view
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("I have an account already")
                                    .fontWeight(.regular)
                                    .foregroundColor(.black)
                            }

                            // Disclaimer Text
                            Text("By creating an account with us, you agree to our terms of service and privacy policy.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.top, 5) // Reduced padding to minimize whitespace
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10) // Reduced vertical padding for less whitespace
                    )
            }
        }
        .navigationBarBackButtonHidden(true) // Hide back button

        .overlay(
            PopupManager(title: PopupTitle, bodyText: PopupText, buttonText: PopupButtonTxt, isPresented: $isPopupVisible)
        )
    }

    // Error Handling Function
    private func handleCreateAccount() {
        if firstName.isEmpty || lastName.isEmpty {
            PopupTitle = "Invalid Name"
            PopupText = "The first or last name is invalid."
            PopupButtonTxt = "Retry"
            isPopupVisible = true
            return
        }
        
        if !isValidEmail(email) {
            PopupTitle = "Invalid Email"
            PopupText = "The email format is invalid."
            PopupButtonTxt = "Retry"
            isPopupVisible = true
            return
        }
        
        if password.count < 6 {
            PopupTitle = "Invalid Password"
            PopupText = "The password must be more than 6 characters long."
            PopupButtonTxt = "Retry"
            isPopupVisible = true
            return
        }
        
        viewState.isAuthenticated = true
    }

    // Email Validation Function
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
