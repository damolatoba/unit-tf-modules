#!/bin/bash

folders=(vpc nsg-and-rules subnet ec2-instance)
modules_directory_path="/Users/damolatoba/Documents/Project-directories/Personal/source-codes/unit-modules/aws"

create_tf_files_in_all_folders () {
    # change directory to specified directory
    cd $modules_directory_path

    # loop through all folders in modules_directory and create files
    for f in *; do
        if [ -d "$f" ]; then
            # create the following files in each folder in the modules_directory
            cd $f
            # touch main.tf variables.tf outputs.tf terraform.tfvars data.tf providers.tf
            create_tf_files
            # touch terraform.tfvars
            cd ../
        fi
    done
}

create_tf_files () {
    touch main.tf variables.tf outputs.tf
}


create_module_folders () {
    cd $modules_directory_path
    local list=("$@")
    for i in "${folders[@]}"
    do
        echo $i
        printf "Creating\n"

        mkdir $i
        printf "Create module folder\n-------------\n\n"

        cd $i
        printf "Change into new folder\n-------------\n\n"

        create_tf_files

        cd ../
    done
    cd $modules_directory_path
}

# create_tf_files_in_all_folders
create_module_folders "${folders[@]}"