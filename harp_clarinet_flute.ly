
% hogy lehet kezelni azt, ha van egy transzponáló hangszerünk, esetünkben egy B-klarinét

\version "2.18.2"

% kihagyás a tetején
\paper {
  top-margin = 24
}

% fejléc
\header {

  % cím
  title = \markup \center-column { \vspace #4 "harp, clarinet, flute" \vspace #4 }

  %subtitle = "alcím"
  %composer = "zeneszerző"
  %arranger = "átirat"

  % sor a lap alján
  tagline = "LilyPond 2.18.2 - www.lilypond.org - Sass Bálint - sassbalint kukac gmail pont com - 2020. november 5."
}

% a kotta
\score {

<<

  % 1. sor
  \new Staff <<
    \new Voice \relative c'' {

      % felirat a sor elején
      \set Staff.instrumentName = #"Flute"

      % a midiben ilyen hangon szóljon
      \set midiInstrument = #"flute"

      % kulcs
      \clef treble

      % előjegyzés
      \key es \major

      % ütemmutató
      \time 3/8

      %\tempo "Parlando"

      % a zene
      % r         = szünet
      % 4.        = pontozott negyed
      % r4.       = pontozott negyed hosszúságú szünet
      %           a hosszt csak akkor kell újra kiírni, ha változik
      % \bar "|." = kettősvonal a végén

      r4. r r
      r r r r \bar "|."

    }
  >>

  \new Staff <<
    \new Voice \relative c' {
      \set Staff.instrumentName = #"Clarinet"
      \set midiInstrument = #"clarinet"
      \clef bass

% na itt a nagy transzponálás!
% mivel a B-klarinétünk van, ami 1 hanggal lejjebb szól,
% ezért a kottát egy hanggal (ld. "c d") följebb kell tenni,
% hogy jó legyen. vegyük észre, hogy
% az előjegyzés ("\key") is a transzponáláson belül van
\transpose c d {

% ez meg azt teszi hozzá, hogy a midiben mégis eredetiben szóljon!
\transposition bes

      \key es \major

      r4. r r
      g16. as32 g8 es
      g16. as32 g8 es
      g16. as32 g8 c'
      bes4 as8
}

    }
  >>

  \new PianoStaff <<
    \set PianoStaff.instrumentName = #"Harp"
    \new Staff <<
      \new Voice \relative c' {
        \set midiInstrument = #"orchestral harp"
        \clef treble
        \key es \major

        % <...> = akkord
        r8 <g es'> <g es'>
        r8 <g es'> <g es'>
        r8 <g es'> <g es'>
        r8 <g es'> <g es'>
        r8 <g es'> <g es'>
        r8 <g es'> <g es'>
        r8 <g es'> <g es'>

      }
    >>

    \new Staff <<
      \new Voice \relative c {
        \set midiInstrument = #"orchestral harp"
        \clef bass
        \key es \major

        es8 r r es r r es r r
        es r r es r r es r r es r r

      }
    >>
  >>

>>

  % az alábbiakat most nem tudnám megmondani, hogy mi is... :)
  % -> http://lilypond.org
  \layout {
    \context {
      \Score
      \override SpacingSpanner
        #'base-shortest-duration = #(ly:make-moment 1 80)
    }
    \context {
      \Staff
    }
  } 

  % midi, azaz hang kimenetet is lehet csinálni vele
  \midi {
    \context {
      \Staff
      \remove "Staff_performer"
    }
    \context {
      \Voice
      \consists "Staff_performer"      
    }
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 40 2)
    }
  }
}

