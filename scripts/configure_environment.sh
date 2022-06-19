
function install_tuist_if_not_exist() {
    if ! [[ -x "$(command -v tuist)" ]]; then
        echo "Tuist has not found. Installing it...";
        curl -Ls https://install.tuist.io | bash
    else
        echo "Tuist already installed";
    fi
}

function install_brew_if_not_exist() {
    if ! [[ -x "$(command -v brew)" ]]; then
        echo "Brew has not found. Installing it...";
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "Brew already installed";
    fi
}

function install_brew_command_if_not_exist() {
    if ! [[ -x "$(command -v $1)" ]]; then
        echo "$1 has not found. Installing it...";
        HOMEBREW_NO_AUTO_UPDATE=1 brew install $1
    else
        echo "$1 already installed";
    fi
}

install_brew_if_not_exist
install_brew_command_if_not_exist swiftlint
install_brew_command_if_not_exist swiftformat
install_tuist_if_not_exist