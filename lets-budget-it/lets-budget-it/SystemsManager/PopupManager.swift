import SwiftUIstruct PopupManager: View {    var title: String    var bodyText: String    var buttonText: String    @Binding var isPresented: Bool // Binding to control the popup visibility    var body: some View {        ZStack {            if isPresented {                // Gray background overlay                Color.black.opacity(0.4)                    .edgesIgnoringSafeArea(.all)                // Popup content                VStack(spacing: 16) {                    Text(title)                        .font(.headline)                        .fontWeight(.bold)                        .foregroundColor(.black)                    Text(bodyText)                        .font(.body)                        .foregroundColor(.black)                        .multilineTextAlignment(.center)                    Button(action: {                        // Dismiss the popup                        isPresented = false                    }) {                        Text(buttonText)                            .fontWeight(.bold)                            .frame(maxWidth: .infinity, minHeight: 44)                            .background(Color.blue)                            .foregroundColor(.white)                            .cornerRadius(8)                    }                }                .padding()                .background(                    RoundedRectangle(cornerRadius: 10)                        .fill(Color.white)                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)                )                .padding(40) // Add padding to center the popup            }        }        .animation(.easeInOut, value: isPresented) // Smooth transition    }}struct PopupManager_Previews: PreviewProvider {    static var previews: some View {        PopupManager(title: "Error", bodyText: "An error has occurred.", buttonText: "Close", isPresented: .constant(true))    }}