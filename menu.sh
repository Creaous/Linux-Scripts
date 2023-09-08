#!/bin/bash

# Script downloaded from https://github.com/Creaous/Linux-Scripts

whiptail --title "Warning" --msgbox "Some scripts that are included require sudo." 8 78

# Replace with your GitHub username and repository name
github_username="Creaous"
repository_name="Linux-Scripts"

# Function to fetch and execute scripts
fetch_and_execute_script() {
    local script_json
    local script_name
    local script_content

    script_json=$(curl -s "https://api.github.com/repos/$github_username/$repository_name/contents/$1")
    script_content=$(curl -s "$script_url")

    # Execute the script
    if [ -n "$script_content" ]; then
        echo "Executing script: $1"
        echo "$script_content" > "/tmp/$1"
        chmod +x "/tmp/$1"
        "/tmp/$1"
    else
        whiptail --msgbox "Script content not found." 10 40
    fi
}

# Function to fetch and display scripts
fetch_scripts() {
    local scripts_json
    local script_names
    local script_name

    # Use GitHub API to fetch script files (replace 'token' with your personal access token if needed)
    scripts_json=$(curl -s "https://api.github.com/repos/$github_username/$repository_name/contents")

    # Extract and display script names
    script_names=()
    while IFS= read -r line; do
        if [[ "$line" == *"\"name\":"* && "$line" == *".sh\""* ]]; then
            script_name=$(echo "$line" | grep -oP '(?<=name": ").*?(?=",)')
            script_names+=("$script_name")
        fi
    done <<< "$scripts_json"

    if [ "${#script_names[@]}" -eq 0 ]; then
        whiptail --msgbox "No script files found." 10 40
    else
        script_list=()
        for ((i = 0; i < ${#script_names[@]}; i++)); do
            script_list+=("$i" "${script_names[$i]}")
        done

        choice=$(whiptail --menu "Script files in $repository_name:" 20 60 10 "${script_list[@]}" 3>&1 1>&2 2>&3)
        if [ $? -eq 0 ]; then
            script_name="${script_names[$choice]}"
            script_url="https://raw.githubusercontent.com/$github_username/$repository_name/main/${script_name}"
            action=$(whiptail --menu "Choose an action for $script_name:" 15 60 4 \
                "1" "View Script" \
                "2" "Execute Script" \
                "3" "Cancel" \
                3>&1 1>&2 2>&3)

            case $action in
            "1")
                script_content=$(curl -s "$script_url")
                whiptail --msgbox "Script Content:\n\n$script_content" 30 80
                ;;
            "2")
                fetch_and_execute_script "$script_name"
                ;;
            "3")
                # Cancel
                ;;
            *)
                whiptail --msgbox "Invalid option." 10 40
                ;;
            esac
        fi
    fi
}

# Main menu
while true; do
    choice=$(whiptail --title "Creaous' Scripts" --menu "Please choose an option" 15 60 4 \
        "1" "Fetch Scripts" \
        "2" "Exit" \
        3>&1 1>&2 2>&3)

    case $choice in
    "1")
        fetch_scripts
        ;;
    "2")
        exit 0
        ;;
    *)
        exit 1
        ;;
    esac
done
