import SwiftUI

struct TABMoreView: View {
    let items: [(icon: String, label: String)] = [
        ("person.fill", "My Profile"),
        ("star.circle.fill", "Premium"),
        ("lock.fill", "App Security"),
        ("building.columns.fill", "Connect Bank"),
        ("message.fill", "Support"),
        ("gearshape.fill", "Settings")
    ]
    
    @State private var profileImage: Image = Image(systemName: "person.crop.circle.fill") // Default profile image
    @State private var isImagePickerPresented: Bool = false // For image picker
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 19)
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 350, height: 200)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                .overlay(
                    VStack(spacing: 16) {
                        HStack {
                            // Profile Image Section
                            ZStack(alignment: .topTrailing) {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                                    .shadow(radius: 3)
                                
                                // Edit Button on top-right of Profile Image
                                Button(action: {
                                    isImagePickerPresented = true
                                }) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.black)
                                        .font(.system(size: 12))
                                        .padding(8)
                                        .background(Circle().fill(Color.white))
                                        .overlay(
                                            Circle().stroke(Color.black, lineWidth: 3) // Adds a black stroke with width 1
                                        )

                                }
                                .offset(x: 6, y: -9) // Adjust the offset for perfect placement
                            }
                            
                            // User Details Section
                            VStack(alignment: .leading, spacing: 1) {
                                Text("Hi, Adam Bell")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.leading, 10) // Moves the text slightly to the right
                                    .padding(.top, 8) // Moves the text down
                                Text("User ID: 9014878")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 10) // Moves subtext slightly to the right
                                    .padding(.top, 4) // Moves subtext slightly down
                            }

                            Spacer()
                        }
                        
                        // Buttons: Edit Profile & Delete Account
                        HStack {
                            // Edit Profile Button
                            Button(action: {
                                print("Edit Profile Tapped")
                            }) {
                                Text("Edit Profile")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black)
                                    .cornerRadius(8)
                            }

                            // Delete Account Button
                            Button(action: {
                                print("Delete Account Tapped")
                            }) {
                                Text("Delete Account")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                            }
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 20)
                )

            Spacer()
                .frame(height: 20)
            
            // Separator Line
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.horizontal, 16)

            Spacer().frame(height: 20)
            
            ScrollView() {
                VStack(spacing: 20) {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 20) {
                        ForEach(items, id: \.label) { item in
                            Button(action: {
                                handleButtonClick(label: item.label)
                            }) {
                                VStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.2))
                                        .stroke(.black, lineWidth: 2)
                                        .frame(width: 150, height: 150)
                                        .overlay(
                                            VStack(spacing: 12) {
                                                Image(systemName: item.icon)
                                                    .font(.system(size: 50))
                                                    .foregroundColor(.black)
                                                
                                                Text(item.label)
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.black)
                                            }
                                        )
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }                    .padding(.horizontal, 16)
                    
                    // Footer text inside ScrollView
                    Text("Version 3f (1.1.4) - Build #6 | Letsbudget.it is affiliated with HISC - Helios International and its partner MARKETING14 LTD. If you have any legal enquiries please contact us.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center) // Centers the text
                        .padding(.horizontal, 16) // Adds padding to avoid text clipping
                        .padding(.top, 20) // Adds spacing between grid and footer
                }
            }
            
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePickerView(selectedImage: $profileImage)
        }
    }
    
    func handleButtonClick(label: String) {
        // Separate handling logic using if statements
        if label == "Favorites" {
            print("Favorites button clicked")
        } else if label == "Likes" {
            print("Likes button clicked")
        } else if label == "Profile" {
            print("Profile button clicked")
        } else if label == "Settings" {
            print("Settings button clicked")
        } else if label == "Notifications" {
            print("Notifications button clicked")
        } else if label == "Calendar" {
            print("Calendar button clicked")
        }
    }
}

// Image Picker Implementation
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: Image

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: uiImage)
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct TABMoreView_Previews: PreviewProvider {
    static var previews: some View {
        TABMoreView()
    }
}
