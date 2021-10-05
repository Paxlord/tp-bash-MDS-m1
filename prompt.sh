#!/bin/sh
source .bash-profile

FirstName=Fares
LastName=Boukhezna
Age=22
Email=faresboukhezna@gmail.com

#Function that checks if a given age counts as major or not
age() {

    #We read the variable age
    read -p "Entrez votre age : " age

    #If the variable is greater than 17
    if [[ $age -gt 17 ]]; then
        echo 'Vous etes majeur'
    else
        echo 'Vous etes mineur'
    fi
}

#Functions that can change the user's password
passw() {

    #We asks for both the new password and a confirmation
    read -p "Entrez votre nouveau mot de passe : " -s passA
    read -p "Confirmez votre nouveau mot de passe : " -s passB

    #If both password are the same we edit the bash profile file where the password is stored
    if [[ "$passA" = "$passB" ]]; then
        sed -i '' "s/$PASSWORD/$passA/" .bash-profile 
        echo "mot de passe changé avec succès"
    else
        echo "Les deux mot de passe ne coincident pas. Merci de réessayer en tapant la commande"
    fi

}

#This function just print the list of available commands
helpCustom() {
    echo 'help : qui indiquera les commandes que vous pouvez utiliser\n'
    echo 'ls : lister des fichiers et les dossiers visible comme caché\n'
    echo 'rm : supprimer un fichier\n'
    echo 'rmd ou rmdir : supprimer un dossier\n'
    echo 'about : une description de votre programme\n'
    echo 'version ou --v ou vers :  affiche la version de votre prompt\n'
    echo 'age : vous demande votre âge et vous dit si vous êtes majeur ou mineur\n'
    echo 'quit : permet de sortir du prompt\n'
    echo 'profile : permet d’afficher toutes les informations sur vous même. First Name, Last name, age, email\n'
    echo 'passw : permet de changer le password avec une demande de confirmation\n'
    echo 'cd : aller dans un dossier que vous venez de créer ou de revenir à un dossier précédent\n'
    echo 'pwd : indique le répertoire actuelle courant\n'
    echo 'hour : permet de donner l’heure actuelle\n'
    echo '* : indiquer une commande inconnu\n'
    echo 'httpget : permet de télécharger le code source html d’une page web et de l’enregistrer dans un fichier spécifique. Votre prompt doit vous demander quel sera le nom du fichier.\n'
    echo 'smtp : vous permet d’envoyer un mail avec une adresse un sujet et le corp du mail\n'
    echo 'open : ouvrir un fichier directement dans l’éditeur VIM même si le fichier n’existe pas\n'

}

#Function that get the code source of an html page and store it in a file
httpget() {

    #We ask for the filename the user want to create
    read -p "Entrez le nom du fichier : " fileName

    #We are doing a curl on the http adress given in the command we then put it in the filename given above
    curl "$1" >> ./$fileName

}

#Function that creates a file and opens it with vim
open() {

    #We test if the file given in parameters exists
    if test -f "$1"; then
        vim $1
    else
        #If not we create it before opening it
        touch $1
        vim $1
    fi 

}

#Main funcion that parse the prompt command
prompt() {

    #We ask for the command and some options when needed
    read -p ">" cmd optns

    case $cmd in
        quit) exit ;;

        ls) ls -a $optns ;;

        about)
            echo "Ce prompt permet d'executer de simples commandes bash. help pour en savoir +"
        ;;

        version | vers | --v) echo "Version : 1.0.0" ;;

        age ) age ;;

        pwd ) pwd ;;

        rps ) . rockpaperscisors.sh;;

        #This command date returns the current time and you can format it using the + and a pattern string
        hour) date +"%H:%M" ;;

        profile)
            echo "$FirstName ; $LastName ; $Age ; $Email"
        ;;

        httpget ) httpget $optns ;;

        cd ) cd $optns ;;

        #We test if the file given in the options exists before removing it
        rm)
            if test -f "$optns"; then
                echo "Deleting $optns"
                rm $optns
            else
                echo "$optns doesn't exists"
            fi
        ;;

        rmd|rmdir)
            if test -d "$optns"; then
                echo "Deleting folder $optns"
                rm -r $optns
            else
                echo "$optns doesn't exists"
            fi
        ;;

        help ) helpCustom ;;

        passw ) passw ;;

        open) open $optns ;;

        echoall) echo "$optns" ;;

        *) echo 'command not found' ;;
    esac

    prompt

}

#Function that ask if the user want to exit the program
askexit() {

    #We ask if the user want to quit
    read -p "Voulez-vous quitter ?(y/n) " resp

    #If the answer is y the we juste exit
    if [[ "$resp" = "y" ]]; then
        exit
    #If the answer is no we ask for the login again
    elif [[ "$resp" = "n" ]]; then
        login
    #else it's a typing mistake and we ask if the user wants to quit againÒ
    else
        echo 'Please enter y for Yes or n for No'
        askexit
    fi

}

#Function that can log the user in
login() {

    #We ask for the user's username and password
    read -p "Nom d'utilisateur : " username
    read -p "Mot de passe : " -s password

    #If one of them doesn't correspond we call the askexit function
    if [[ "$username" != "$USER" ]]; then
        echo "\nUtilisateur non existant"
        askexit
    fi

    if [[ "$password" != "$PASSWORD" ]]; then
        echo "\nMot de passe invalide"
        askexit
    fi
}

#Main function of the script
main() {

    #We login the user before he can use the prompt
    login

    echo "\nBienvenue utilisateur"
    prompt
}

main