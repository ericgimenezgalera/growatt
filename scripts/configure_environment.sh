
function install_tuist_if_not_exist() {
    if ! [[ -x "$(command -v tuist)" ]]; then
        echo "Tuist has not found. Installing it...";
        mise install tuist@4.26.0
    else
        echo "Tuist already installed";
    fi
}

function install_brew_if_not_exist() {
    if ! [[ -x "$(command -v brew)" ]]; then
        echo "Brew has not found. Installing it...";
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if ! [[ -x "$(command -v brew)" ]]; then
            (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/ericgimenezgalera/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
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
install_brew_command_if_not_exist carthage
install_brew_command_if_not_exist sourcery
install_tuist_if_not_exist
