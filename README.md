#Known Issues

##Compile/Simulator issues
###Updating selectors failed with: Error Domain=NSCocoaErrorDomain Code=4099 "The connection to service named com.apple.commcenter.coretelephony.xpc was invalidated: failed at lookup with error 3 - No such process."
 - this is a known/current issue in the GoogleMaps framework as of 2023-03-02 for specific iOS versions.  The Metal API is used in the AppDelegate before GMS is initiated but does not solve every case.

#Frameworks

##Chruby - Side-loaded Ruby

-cocoapods were installed with a different/separate version of Ruby other than what was included with the Mac
-check for any other ruby managers, make sure all return "command not found"
    rvm help
    rbenv help
    asdf --help
    frum versions
-make sure brew is up to date.  this will install Apple Command Line Tools and will need a terminal restart after
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
-follow any additional instructions post install such as
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/asteiger/.zprofile
    eval "$(/usr/local/bin/brew shellenv)"
-restart terminal and make sure brew is ready with
    brew doctor
-chruby is used to configure this side-loaded ruby and was installed with
    brew install chruby ruby-install
    ruby-install ruby
-switch to the version of ruby you want with
    chruby 3.2.1 //the current version of Ruby installed with the previous command
-to enable chruby command from the bash, had to create the file ~/.zshrc.  this will always use this ruby version from the terminal.  requires terminal restart after.
    ### ~/.zshrc
    # enable chruby
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
    chruby ruby-3.2.1
-check ruby version
    ruby -v

    
##CocoaPods

-use chruby+ruby to install gems DO NOT USE SUDO TO INSTALL GEMS
    gem install cocoapods
-cocoapods are installed by modifying the Podfile in the root and adding required dependencies and the specific iOS target build
-installing is done by navigating to the root folder of the project with the Podfile and running
    pod install
-to resolve any issues with pod git history, reset to the master branch with just a single commit with:
    pod setup
    Ctrl +C
    cd ~/.cocoapods/repos
    git clone --depth 1 https://github.com/CocoaPods/Specs.git master
-the project should only be opened with XCode using the .xcworkspace

