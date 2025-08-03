#!/usr/bin/bash

INSTALL_BIN_DIR="$HOME/.local/bin"
TIPS_SHARE_DIR="$HOME/.local/share/linux-tips"
LOCAL_SHARE="./share"
LOCAL_BIN="./bin"


copy_file(){
    cp $1 $2
    if [ $? -eq 0 ]
    then
        echo "Copy file $1 -> $2 SUCESSFULY"
    else
        echo "ERROR::Something wrong to copy $1 -> $2"
        exit 1
    fi
}
copy_folder(){
    cp -r $1 $2
    if [ $? -eq 0 ]
    then
        echo "Copy folder $1 -> $2 SUCCESSFULY"
    else
        echo "ERROR::Something wrong to copy $1 -> $2"
        exit 1
    fi
}

echo "Linux tips intallation..."

if [ -d "$INSTALL_BIN_DIR" ]
then
    echo "The directory $INSTALL_BIN_DIR already exists"
    if [ -d "$TIPS_SHARE_DIR" ]
    then
        echo "The directory $TIPS_SHARE_DIR already exists."
        copy_file "$LOCAL_BIN/tips.bash" $INSTALL_BIN_DIR
        copy_folder "$LOCAL_SHARE/." $TIPS_SHARE_DIR
    else
        echo "The directory $TIPS_SHARE_DIR does not exist. Creating it now..."
        mkdir $TIPS_SHARE_DIR 
        if [ $? -eq 0 ]
        then
            echo "The directoru $TIPS_SHARE_DIR was created."
        else
            echo "ERROR::Something wrong to create the directory $TIPS_SHARE_DIR"
            exit 1
        fi
        copy_file "$LOCAL_BIN/tips.bash" "$INSTALL_BIN_DIR/tips"
        chmod +x "$INSTALL_BIN_DIR/tips"
        copy_folder "$LOCAL_SHARE/." $TIPS_SHARE_DIR
    fi
else
    echo "The directory $INSTALL_BIN_DIR does not exist. Creating it now..."
    mkdir $INSTALL_BIN_DIR
    if [ $? -eq 0 ]
    then
        echo "The directory $INSTALL_BIN_DIR was created."
    else
        echo "Something wrong to create the directory $INSTALL_BIN_DIR"
        exit 1
    fi
    
    echo "The directory $TIPS_SHARE_DIR does not exist. Creating it now..."
    mkdir $TIPS_SHARE_DIR
    if [ $? -eq 0 ]
    then
        echo "The directory $TIPS_SHARE_DIR was created."
    else
        echo "Something wrong to create the directory $TIPS_SHARE_DIR"
        exit 1
    fi
    copy_file "$LOCAL_BIN/tips.bash" $INSTALL_BIN_DIR
    copy_folder "$LOCAL_SHARE/." $TIPS_SHARE_DIR
fi
