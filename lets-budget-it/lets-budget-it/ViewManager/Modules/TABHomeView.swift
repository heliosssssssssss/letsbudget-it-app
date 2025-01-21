import SwiftUI

struct TABHomeView: View {
    @State private var currentWallet: Wallet = wallets[1] // Tracks the current wallet
    @State private var isWalletChanging = false // Tracks whether a wallet change is happening

    var body: some View {
        ScrollView { // Makes the view scrollable
            VStack(spacing: 16) {
                // Blue box with centered text
                ZStack {
                    Color.blue
                        .frame(height: 250) // Blue box height
                        .frame(maxWidth: .infinity) // Full width

                    // Left and right navigation arrows
                    HStack {
                        // Show left arrow only if there is a previous wallet
                        if let currentIndex = wallets.firstIndex(of: currentWallet), currentIndex > 0 {
                            Button(action: {
                                switchToPreviousWallet()
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                                    .padding()
                                    .offset(y: -10)
                            }
                        }

                        Spacer()

                        // Show right arrow only if there is a next wallet
                        if let currentIndex = wallets.firstIndex(of: currentWallet), currentIndex < wallets.count - 1 {
                            Button(action: {
                                switchToNextWallet()
                            }) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                                    .padding()
                                    .offset(y: -10)
                            }
                        }
                    }

                    // Wallet info and buttons
                    VStack(spacing: 15) {
                        Spacer() // Moves all elements down
                            .frame(height: 25) // Adjust to center content properly

                        // Wallet name and amount
                        VStack(spacing: -1) { // Reduced spacing between elements
                            Text(currentWallet.name)
                                .font(.subheadline)
                                .fontWeight(.light)
                                .foregroundColor(.white)
                                .opacity(isWalletChanging ? 0 : 1) // Fading effect
                                .animation(.easeInOut(duration: 0.3), value: isWalletChanging)

                            Text("€\(String(format: "%.2f", currentWallet.amount))")
                                .font(.system(size: 50)) // Font size for amount
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .opacity(isWalletChanging ? 0 : 1) // Fading effect
                                .animation(.easeInOut(duration: 0.3), value: isWalletChanging)
                        }

                        // Buttons Row
                        HStack(spacing: 20) { // Horizontal spacing between buttons
                            CircularButton(iconName: "arrow.down", label: "Expenses", size: 40) {
                                print("Expenses button clicked")
                            }
                            CircularButton(iconName: "arrow.up", label: "Income", size: 40) {
                                print("Income button clicked")
                            }
                            CircularButton(iconName: "gearshape", label: "Settings", size: 40) {
                                print("Settings button clicked")
                            }
                        }
                    }
                }

                // Grey rectangle with transactions
                let rectangleWidth = UIScreen.main.bounds.width - 32 // Matches screen width with horizontal padding
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: rectangleWidth, height: 180) // Rectangle size
                    .padding(.horizontal, 16) // Padding for horizontal alignment
                    .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2) // Adds shadow
                    .overlay(
                        VStack(alignment: .leading, spacing: 12) {
                            // Transaction 1
                            HStack(spacing: 16) { // Increased spacing for clarity
                                ZStack {
                                    Circle()
                                        .stroke(Color.black, lineWidth: 1)
                                        .background(Circle().fill(Color.white))
                                        .frame(width: 40, height: 40) // Adjusted size
                                    Image(systemName: "cart.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20) // Adjusted size for proper alignment
                                        .foregroundColor(.black)
                                }
                                .padding(.leading, 16) // Increased left padding to push more to the right

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Grocery Shopping")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text("€23.45")
                                        .font(.subheadline)
                                        .foregroundColor(.black) // Number color set to black
                                    Text("Bought some vegetables and fruits.")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }

                            // Separator Line
                            Divider()
                                .background(Color.gray.opacity(0.4))

                            // Transaction 2
                            HStack(spacing: 16) { // Increased spacing for clarity
                                ZStack {
                                    Circle()
                                        .stroke(Color.black, lineWidth: 1)
                                        .background(Circle().fill(Color.white))
                                        .frame(width: 40, height: 40) // Adjusted size
                                    Image(systemName: "cart.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20) // Adjusted size for proper alignment
                                        .foregroundColor(.black)
                                }
                                .padding(.leading, 16) // Increased left padding to push more to the right

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Online Shopping")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text("€54.99")
                                        .font(.subheadline)
                                        .foregroundColor(.black) // Number color set to black
                                    Text("Purchased a pair of headphones.")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(16) // Inner padding for content
                    )

                // View More Button
                Button(action: {
                    print("View More clicked")
                }) {
                    Text("View more")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .frame(alignment: .leading)
                }
                .padding(.horizontal, 16) // Align with the grey rectangle
                .padding(.top, -4) // Slightly reduces top spacing

                // Row of grey buttons
                HStack(spacing: 16) { // Equal spacing between buttons
                    GreyButton(label: "Data Processing API is disabled ", width: (rectangleWidth - 16) / 2) {
                        print("Button 1 clicked")
                    }
                    GreyButton(label: "Data Processing API is disabled", width: (rectangleWidth - 16) / 2) {
                        print("Button 2 clicked")
                    }
                }
                .padding(.horizontal, 16) // Align with the rectangle
                .padding(.top, 0) // Match vertical spacing with horizontal

                Spacer() // Adds some spacing for demonstration
            }
        }
        .background(Color.white) // Sets the background color to white
        .edgesIgnoringSafeArea(.all) // Ensures the background color extends to safe areas
    }

    // Switch to the previous wallet
    private func switchToPreviousWallet() {
        if let currentIndex = wallets.firstIndex(of: currentWallet), currentIndex > 0 {
            withAnimation {
                isWalletChanging = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Delay to match animation
                currentWallet = wallets[currentIndex - 1]
                withAnimation {
                    isWalletChanging = false
                }
            }
        }
    }

    // Switch to the next wallet
    private func switchToNextWallet() {
        if let currentIndex = wallets.firstIndex(of: currentWallet), currentIndex < wallets.count - 1 {
            withAnimation {
                isWalletChanging = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Delay to match animation
                currentWallet = wallets[currentIndex + 1]
                withAnimation {
                    isWalletChanging = false
                }
            }
        }
    }
}

// Wallet Model
struct Wallet: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let amount: Double
}

// Sample Wallet Data
let wallets = [
    Wallet(name: "Savings Wallet", amount: 1958.43),
    Wallet(name: "Main Wallet", amount: 51.75),
    Wallet(name: "Travel Wallet", amount: 540.22)
]

// Circular Button View
struct CircularButton: View {
    let iconName: String
    let label: String
    let size: CGFloat
    let action: () -> Void // Closure for button action

    var body: some View {
        VStack(spacing: 8) { // Vertical spacing between icon and label
            Button(action: action) { // Trigger the provided action
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                    .font(.system(size: size / 2)) // Icon size is proportional to button size
                    .frame(width: size, height: size) // Circle size
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
            }

            Text(label)
                .font(.footnote)
                .foregroundColor(.white)
        }
    }
}

// Grey Button View
struct GreyButton: View {
    let label: String
    let width: CGFloat
    let action: () -> Void // Closure for button action

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.headline)
                .foregroundColor(.black)
                .frame(width: width, height: width) // Square button
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2) // Adds shadow
        }
    }
}

struct TABHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TABHomeView()
    }
}
