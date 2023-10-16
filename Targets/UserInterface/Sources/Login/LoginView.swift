import DependencyInjection
import SwiftUI

public struct LoginView: BaseView {
    @AppStorage(usernameUserDefaultsKey) var username: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @StateObject var viewModel: LoginViewModel
    var didAppear: ((Self) -> Void)?
    var navigationViewModel: NavigationViewModel

    var isSignInButtonDisabled: Bool {
        [username, password].contains(where: \.isEmpty)
    }

    public init(_ navigationViewModel: NavigationViewModel) {
        self.init(navigationViewModel, viewModel: LoginViewModel())
    }

    init(_ navigationViewModel: NavigationViewModel, viewModel: LoginViewModel) {
        self.navigationViewModel = navigationViewModel
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()

            TextField(
                "Name",
                text: $username,
                prompt: Text("Login").foregroundColor(.blue)
            )
            .id(usernameTextFieldId)
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
                        .id(passwordTextFieldId)
                    } else {
                        SecureField(
                            "Password",
                            text: $password,
                            prompt: Text("Password")
                                .foregroundColor(.blue)
                        )
                        .id(passwordSecureFieldId)
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
                .id(eyeButtonId)
            }
            .padding(.horizontal)

            Spacer()

            Button {
                viewModel.isLoading = true
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
            .id(signinButtonId)
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
        }
        .alert(
            isPresented: Binding<Bool>(
                get: { viewModel.error != nil },
                set: { _ in
                    viewModel.error = nil
                    viewModel.isLoading = false
                }
            ),
            error: viewModel.error,
            actions: {}
        )
        .disabled(viewModel.isLoading)
        .overlay(Group {
            if viewModel.isLoading {
                ZStack {
                    Color(white: 0, opacity: 0.75)
                    ProgressView().tint(.white)
                }
                .ignoresSafeArea()
                .id(spinnerViewId)
            }
        })
        .onAppear {
            viewModel.isLoading = true
            showPassword = false
            password = ""

            viewModel.loginWithBiometric(
                username: username,
                navigationViewModel: navigationViewModel
            )
            self.didAppear?(self)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(MockNavigationViewModel())
    }
}
