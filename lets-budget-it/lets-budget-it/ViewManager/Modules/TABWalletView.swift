import SwiftUI

struct TABWalletView: View {
    @State private var userWallets: [UserWallet] = [
        UserWallet(name: "Savings", balance: 500.00, color: .green),
        UserWallet(name: "Expenses", balance: 200.00, color: .orange),
        UserWallet(name: "Vacation", balance: 1000.00, color: .blue)
    ]
    @State private var showAddWallet = false
    @State private var showEditWallet = false
    @State private var selectedWallet: UserWallet?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("My Wallets")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(userWallets) { wallet in
                            WalletCard(wallet: wallet)
                                .onTapGesture {
                                    selectedWallet = wallet
                                    showEditWallet = true
                                }
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()

                Button(action: {
                    showAddWallet = true
                }) {
                    Text("Add Wallet")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .padding(.bottom) // Adds spacing below the button
            }
            .sheet(isPresented: $showAddWallet) {
                AddWalletView(userWallets: $userWallets)
            }
            .sheet(isPresented: $showEditWallet) {
                if let wallet = selectedWallet {
                    EditWalletView(wallet: wallet, userWallets: $userWallets)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct WalletCard: View {
    var wallet: UserWallet

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(wallet.name)
                    .font(.headline)
                Text("€\(String(format: "%.2f", wallet.balance))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(wallet.color.opacity(0.1))
        .cornerRadius(12)
    }
}

struct AddWalletView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var userWallets: [UserWallet]

    @State private var walletName = ""
    @State private var walletBalance = ""
    @State private var selectedColor = Color.blue

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Wallet Details")) {
                    TextField("Wallet Name", text: $walletName)
                    TextField("Starting Balance", text: $walletBalance)
                        .keyboardType(.decimalPad)
                    ColorPicker("Choose Color", selection: $selectedColor)
                }
            }
            .navigationTitle("Add Wallet")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let balance = Double(walletBalance), !walletName.isEmpty {
                            let newWallet = UserWallet(name: walletName, balance: balance, color: selectedColor)
                            userWallets.append(newWallet)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct EditWalletView: View {
    @Environment(\.dismiss) var dismiss
    var wallet: UserWallet
    @Binding var userWallets: [UserWallet]

    @State private var walletName: String
    @State private var walletBalance: String
    @State private var selectedColor: Color

    init(wallet: UserWallet, userWallets: Binding<[UserWallet]>) {
        self.wallet = wallet
        self._userWallets = userWallets
        _walletName = State(initialValue: wallet.name)
        _walletBalance = State(initialValue: String(format: "%.2f", wallet.balance))
        _selectedColor = State(initialValue: wallet.color)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Wallet")) {
                    TextField("Wallet Name", text: $walletName)
                    TextField("Current Balance", text: $walletBalance)
                        .keyboardType(.decimalPad)
                    ColorPicker("Choose Color", selection: $selectedColor)
                }
            }
            .navigationTitle("Edit Wallet")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let balance = Double(walletBalance), !walletName.isEmpty {
                            if let index = userWallets.firstIndex(where: { $0.id == wallet.id }) {
                                userWallets[index] = UserWallet(name: walletName, balance: balance, color: selectedColor)
                            }
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct UserWallet: Identifiable {
    let id = UUID()
    var name: String
    var balance: Double
    var color: Color
}

struct TABWalletView_Previews: PreviewProvider {
    static var previews: some View {
        TABWalletView()
    }
}
