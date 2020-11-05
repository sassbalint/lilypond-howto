F=harp_clarinet_flute

all: info

info:
	@echo "make F=<fájlnév> pdf-mp3"

pdf-mp3: pdf midi2mp3

pdf:
	lilypond $F.ly

view:
	evince $F.pdf &

play:
	timidity $F.midi

# http://ubuntuforums.org/archive/index.php/t-1790563.html
# innen az otlet -- 64k-t javasoltak, de ugy bena volt...
midi2mp3:
	rm -f $F.mp3
	timidity $F.midi -Ow -o - | ffmpeg -i - -acodec libmp3lame -ab 256k $F.mp3

