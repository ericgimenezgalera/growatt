import SwiftUI

public struct LoginView: View {
    @AppStorage("username") var username: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State private var isLoading = false
    var navigationViewModel: NavigationViewModel
    @StateObject private var viewModel = LoginViewModel()

    var isSignInButtonDisabled: Bool {
        [username, password].contains(where: \.isEmpty)
    }

    public init(_ navigationViewModel: NavigationViewModel) {
        self.navigationViewModel = navigationViewModel
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()

            TextField(
                "Name",
                text: $username,
                prompt: Text("Login").foregroundColor(.blue)
            )
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            }
            .padding(.horizontal)
            HStack {
                Group {
                    if showPassword {
                        TextField(
                            "Password",
                            text: $password,
                            prompt: Text("Password")
                                .foregroundColor(.blue)
                        )
                    } else {
                        SecureField(
                            "Password",
                            text: $password,
                            prompt: Text("Password")
                                .foregroundColor(.blue)
                        )
                    }
                }
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.blue)
                }

            }.padding(.horizontal)
            Spacer()

            Button {
                isLoading = true
                viewModel.login(
                    username: username,
                    password: password,
                    navigationViewModel: navigationViewModel
                )
            } label: {
                Text("Sign In")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
            .background(
                isSignInButtonDisabled ? LinearGradient(
                    colors: [.gray],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ) :
                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(20)
            .disabled(isSignInButtonDisabled)
            .padding()
        }.alert(isPresented: Binding<Bool>(
            get: { viewModel.error != nil },
            set: { _ in
                viewModel.error = nil
                isLoading = false
            }
        ), error: viewModel.error) {}
            .disabled(isLoading)
            .overlay(Group {
                if isLoading {
                    ZStack {
                        Color(white: 0, opacity: 0.75)
                        ProgressView().tint(.white)
                    }.ignoresSafeArea()
                }
            }).onAppear {
                isLoading = true
                showPassword = false
                password = ""

                viewModel.loginWithBiometric(
                    username: username,
                    navigationViewModel: navigationViewModel
                )
            }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(MockNavigationViewModel())
    }
}
