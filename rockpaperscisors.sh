#!/bin/sh

player_one=dummy
player_two=dummy

choice_one=a
choice_two=b

score_one=0
score_two=0

round_scoreOne=0
round_scoreTwo=0
round=1


askPlayerOne() {

    read -p "Please $player_one choose your hand (r/p/s)" -s choice_one

    if [[ "$choice_one" != "r" && "$choice_one" != "s" && "$choice_one" != "p" && "$choice_one" != "SuperKitty" ]]; then
        echo 'Wrong answer please answer correctly (r/s/p)'
        askPlayerOne
    fi


    echo 'Choice registered'

}

askPlayerTwo() {

    read -p "Please $player_two choose your hand (r/p/s)" -s choice_two

    if [[ "$choice_two" != "r" && "$choice_two" != "s" && "$choice_two" != "p" && "$choice_one" != "SuperKitty" ]]; then
        echo '\nWrong answer please answer correctly (r/s/p)'
        askPlayerTwo
    fi


    echo '\nChoice registered'

}

playeronewin() {

    round_scoreOne=$((round_scoreOne + 1))
    round=$((round + 1))

}

playertwowin() {

    round_scoreTwo=$((round_scoreTwo + 1))
    round=$((round + 1))

}

checkforwinner() {

    echo "Choix de $player_one : $choice_one"
    echo "Choix de $player_two : $choice_two"

    if [[ "$choice_one" = "SuperKitty" ]]; then
        playeronewin
    elif [[ "$choice_two" = "SuperKitty" ]]; then
        playertwowin
    elif [[ "$choice_one" = "$choice_two" ]]; then
        echo "egalité"
    elif [[ "$choice_one" = "r" && "$choice_two" = "s" ]]; then
        echo "$player_one a gagné la manche\n"
        playeronewin
    elif [[ "$choice_one" = "p" && "$choice_two" = "r" ]]; then
        echo "$player_one a gagné la manche\n"
        playeronewin
    elif [[ "$choice_one" = "s" && "$choice_two" = "p" ]]; then
        echo "$player_one a gagné la manche\n"
        playeronewin
    elif [[ "$choice_two" = "r" && "$choice_one" = "s" ]]; then
        echo "$player_two a gagné la manche\n"
        playertwowin
    elif [[ "$choice_two" = "p" && "$choice_one" = "r" ]]; then
        echo "$player_two a gagné la manche\n"
        playertwowin
    elif [[ "$choice_two" = "s" && "$choice_one" = "p" ]]; then
        echo "$player_two a gagné la manche\n"
        playertwowin
    fi

}

askReplay() {

    read -p "Voulez-vous relancer une partie ? (y/n)" answer

    if [[ "$answer" = "y" ]]; then
        round_scoreOne=0
        round_scoreTwo=0
        round=1
        playTurn
    else
        echo "Merci d'avoir joué !"
    fi

}

winScreen() {

    if [[ $round_scoreOne -gt $round_scoreTwo ]]; then
        echo "$player_one à gagné avec $round_scoreOne"
        score_one=$((score_one + 1))
    else
        echo "$player_two à gagné avec $round_scoreTwo"
        score_two=$((score_two + 1))
    fi

    echo "SCORE : $player_one : $score_one ::: $player_two : $score_two"
    askReplay

}

playTurn() {

    echo "Round : $round \n"

    askPlayerOne
    askPlayerTwo

    checkforwinner

    if [[ $round -lt 4 ]]; then
        playTurn
    else
        winScreen
    fi

}



intro() {

    read -p "Please enter player one name : " player_one
    read -p "Please enter player two name : " player_two

    playTurn

}

main() {

    intro

    echo $player_one
    echo $player_two

}

main