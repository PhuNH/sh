all: README

README:
	echo "# sh" > README.md
	date >> README.md
	echo "  " >> README.md
	wc -l guessinggame.sh | egrep -o "[0-9]+" >> README.md
