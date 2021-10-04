#!/bin/sh

username=admin
password=password

FirstName=Fares
LastName=Boukhezna
Age=22
Email=faresboukhezna@gmail.com

echo "$#"

age() {
    read -p "Entrez votre age : " age

    if [[ $age -gt 17 ]]; then
        echo 'Vous etes majeur'
    else
        echo 'Vous etes mineur'
    fi
}

prompt() {

    read -p ">" cmd

    case $cmd in
        quit)
            exit
        ;;

        ls)
            ls -a
        ;;

        about)
            echo "Ce prompt permet d'executer de simples commandes bash. help pour en savoir +"
        ;;

        version | vers | --v)
            echo "Version : 1.0.0"
        ;;

        age)
            age
        ;;

        pwd)
            pwd
        ;;

        hour)
            date +"%H:%M"
        ;;

        profile)
            echo "$FirstName ; $LastName ; $Age ; $Email"

        *)
            echo 'command not found'
        ;;
    esac

    prompt

}

main() {

    if [[ $1 -ne 2 ]];
    then
        echo "Veuillez entrer l'username et le mot de passe"
        exit
    fi
    
    if [[ "$2" != $username ]]; 
    then
        echo "L'username ne correspond pas"
        exit
    fi

    if [[ "$3" != $password ]];
    then
        echo "Le mot de passe ne correspond pas"
        exit
    fi


    echo "Bienvenue utilisateur"
    prompt
}

main $# $1 $2