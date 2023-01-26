# Do everything.
all: init link

# Set initial preference.
init:
	./script/init.sh

link:
	./script/link.sh
