/////  InitializationView.swift//  letsbudget.it////  Created by user267420 on 1/18/25.//import SwiftUIstruct InitializationView: View {    @State private var currentImageIndex: Int = 0    @State private var progress: CGFloat = 0.0    @State private var showOverlay: Bool = false    @State private var overlayOffset: CGFloat = UIScreen.main.bounds.height    @State private var navigateToWelcome: Bool = false        @State private var messages = ["Starting initialization engine...",                                   "Pre-warming data...",                                   "Pre-warming assets...",                                   "Pre-warming user-interface...",                                   "Setting up tasks...",                                  ]    @State private var currentMessageIndex = 0        private let images = ["logo_1", "logo_2", "logo_3"] // Replace with your image names    private let frames = [        CGSize(width: 300, height: 300), // Frame for logo_1        CGSize(width: 750, height: 750), // Frame for logo_2        CGSize(width: 300, height: 300)  // Frame for logo_3    ]        var body: some View {        if navigateToWelcome {            WelcomePageView()        } else {            ZStack {                Color.white                    .edgesIgnoringSafeArea(.all)                                if !showOverlay {                    VStack(spacing: 0) {                        Spacer()                                                ZStack {                            Color.clear                                .frame(height: frames.max(by: { $0.height < $1.height })?.height ?? 300)                                                        if let currentImage = images[safe: currentImageIndex], let frame = frames[safe: currentImageIndex] {                                Image(currentImage)                                    .resizable()                                    .scaledToFit()                                    .frame(width: frame.width, height: frame.height)                            } else {                                EmptyView()                            }                        }                                                Spacer()                                                Text(messages[currentMessageIndex])                            .font(.caption)                            .foregroundColor(.gray)                            .padding(.bottom, 5)                            .onAppear{                                startLoadTime()                            }                                                ZStack(alignment: .leading) {                            Rectangle()                                .fill(Color.gray)                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 10)                                .cornerRadius(5)                                                        Rectangle()                                .fill(Color.black)                                .frame(width: (UIScreen.main.bounds.width * 0.8) * progress, height: 10)                                .cornerRadius(5)                        }                        .padding(.horizontal, 20)                        .padding(.bottom, 30)                    }                }                                Color(hex: "006FFF")                    .edgesIgnoringSafeArea(.all)                    .offset(y: overlayOffset)                    .animation(.easeInOut(duration: 1.0), value: overlayOffset)            }            .onAppear {                startImageTransitionAndProgress()            }        }    }        private func startLoadTime() {        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) {_ in            currentMessageIndex = (currentMessageIndex + 1) % messages.count        }    }    private func startImageTransitionAndProgress() {        let totalDuration: TimeInterval = 15.0        let interval: TimeInterval = 5.0        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in            currentImageIndex = (currentImageIndex + 1) % images.count        }        withAnimation(.linear(duration: totalDuration)) {            progress = 1.0        }        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) {            overlayOffset = 0 // Move the overlay from bottom to top            showOverlay = true // Hide the logos and other elements            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {                navigateToWelcome = true // Navigate to WelcomePageView after overlay animation            }        }    }}// Extend Array for safe index accessextension Array {    subscript(safe index: Int) -> Element? {        return indices.contains(index) ? self[index] : nil    }}struct InitializationView_Previews: PreviewProvider {    static var previews: some View {        InitializationView()    }}